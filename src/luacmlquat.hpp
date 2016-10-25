
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlquat.hpp
/// @date   09/26/2016
/// @author ctallman
///
/// @brief  Quat header
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlquat_hpp__
#define luacmlquat_hpp__

#include "luacml.hpp"
#include "luacmlvector.hpp"
#include "luacmlhelperfuncs.hpp"

/******************************************************************************/

struct QuatDef
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4
    };

    typedef cml::quaternion< lua_Number > Type;
    typedef Type*                         Pointer;
};

LUACML_API int luaopen_luacml_quat(lua_State* L);

struct QuatPos
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4
    };

    typedef cml::quaternion< lua_Number, cml::fixed<>, cml::vector_first, cml::positive_cross >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_quatpos(lua_State* L);

struct QuatNeg
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4
    };

    typedef cml::quaternion< lua_Number, cml::fixed<>, cml::vector_first, cml::negative_cross >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_quatneg(lua_State* L);

/******************************************************************************/

namespace Quaternion {

template < typename T >
int New(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;

    // This is here because Lua passes the table to __call as the first
    //  argument, but we don't want it.
    lua_remove(L, 1);

    const int nargs = lua_gettop(L);

    // Temporary vector to create result from.
    TType temp;
    temp.identity();

    // Check for too many arguments.
    luaL_argcheck(L, (nargs <= T::NUM_ELEMENTS), T::NUM_ELEMENTS + 1, "Too many arguments.");

    // Default constructor.
    if (nargs == 0)
    {
    }
    else if (nargs == 1)
    {
        if (lua_istable(L, 1))
        {
            Helper::GetNumbersFromTable(L, 1, temp.data(), T::NUM_ELEMENTS, true, true);
        }
        // From 1 vector4.
        else if (lua_isuserdata(L, 1))
        {
            if (!Helper::AssignFromUserdata< TType, T >(L, 1, &temp) &&
                !Helper::AssignFromUserdata< TType, Vector4 >(L, 1, &temp))
            {
                return luaL_error(L, "Invalid call. Invalid argument.");
            }
        }
        else
        {
            return luaL_error(L, "Invalid call. Invalid argument.");
        }
    }
    else if (nargs == 2)
    {
        if (lua_isnumber(L, 1))
        {
            if (lua_isuserdata(L, 2))
            {
                lua_Number vec[4];
                Helper::GetNumberFromStack(L, 1, vec + 3);
                Helper::GetNumbersFromUserdata(L, 2, vec, 3, true, true);
                temp[TType::X] = vec[0];
                temp[TType::Y] = vec[1];
                temp[TType::Z] = vec[2];
                temp[TType::W] = vec[3];
            }
            else if (lua_istable(L, 2))
            {
                lua_Number vec[4];
                Helper::GetNumberFromStack(L, 1, vec + 3);
                Helper::GetNumbersFromTable(L, 2, vec, 3, true, true);
                temp[TType::X] = vec[0];
                temp[TType::Y] = vec[1];
                temp[TType::Z] = vec[2];
                temp[TType::W] = vec[3];
            }
            else
            {
                return luaL_argerror(L, 2, "expected table, or vector3");
            }
        }
        else if (lua_isuserdata(L, 1))
        {
            if (lua_isnumber(L, 2))
            {
                lua_Number vec[4];
                Helper::GetNumbersFromUserdata(L, 1, vec, 3, true, true);
                Helper::GetNumberFromStack(L, 2, vec + 3);
                temp[TType::X] = vec[0];
                temp[TType::Y] = vec[1];
                temp[TType::Z] = vec[2];
                temp[TType::W] = vec[3];
            }
            else
            {
                return luaL_argerror(L, 2, "expected number");
            }
        }
        else if (lua_istable(L, 1))
        {
            if (lua_isnumber(L, 2))
            {
                lua_Number vec[4];
                Helper::GetNumbersFromTable(L, 1, vec, 3, true, true);
                Helper::GetNumberFromStack(L, 2, vec + 3);
                temp[TType::X] = vec[0];
                temp[TType::Y] = vec[1];
                temp[TType::Z] = vec[2];
                temp[TType::W] = vec[3];
            }
            else
            {
                return luaL_argerror(L, 2, "expected number");
            }
        }
        else
        {
            return luaL_argerror(L, 1, "expected number, table, or vector3");
        }
    }
    else if (nargs == 3)
    {
        return luaL_argerror(L, 3, "missing arguments");
    }
    else if (nargs == 4)
    {
        for (int i = 0; i < T::NUM_ELEMENTS; ++i)
        {
            Helper::GetNumberFromStack(L, i + 1, temp.data() + i);
        }
    }
    else
    {
        return luaL_error(L, "Invalid call.");
    }

    TPointer newvec = (TPointer)lua_newuserdata(L, sizeof(TType));
    (*newvec)       = temp;

    return ::SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Index(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);

    const TPointer vec = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    // Check metatable first.
    lua_getmetatable(L, 1);
    lua_pushvalue(L, 2);
    lua_rawget(L, -2);

    // If metatable included value, then return it.
    if (!lua_isnil(L, -1))
    {
        return 1;
    }
    // Try indexing vector instead.
    else
    {
        // Pop rawget result and metatable.
        lua_pop(L, 2);
    }

    // Check valid types.
    if (lua_isnumber(L, 2))
    {
        int key;
        Helper::GetIntegerFromStack(L, 2, &key);
        luaL_argcheck(L, key > 0 && key <= T::NUM_ELEMENTS, 2, "index out of bounds");
        const lua_Number val = (*vec)[key - 1];
        lua_pushnumber(L, val);
        return 1;
    }
    else if (lua_isstring(L, 2))
    {
        static const char* valid[] = {"x", "y", "z", "w", "X", "Y", "Z", "W", NULL};
        const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
        switch (key)
        {
        case 0:
            lua_pushnumber(L, (*vec)[TType::X]);
            return 1;
        case 1:
            lua_pushnumber(L, (*vec)[TType::Y]);
            return 1;
        case 2:
            lua_pushnumber(L, (*vec)[TType::Z]);
            return 1;
        case 3:
            lua_pushnumber(L, (*vec)[TType::W]);
            return 1;
        default:
            return luaL_error(L, "Invalid call.");
        }
    }
    else
    {
        return luaL_argerror(L, 2, "expected integer index");
    }

    return 0;
}

template < typename T >
int NewIndex(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;

    CHECK_ARG_COUNT(L, 3);

    TPointer vec = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    // Check valid types.
    if (lua_isnumber(L, 2))
    {
        const lua_Number numkey = luaL_checknumber(L, 2);
        const int        key    = static_cast< int >(numkey);
        luaL_argcheck(L, (key >= 1 && key <= T::NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (key == numkey), 2, "index not integer");

        const lua_Number val = luaL_checknumber(L, 3);
        (*vec)[key - 1]      = val;
        return 0;
    }
    else if (lua_isstring(L, 2))
    {
        static const char* valid[] = {"x", "y", "z", "w", "X", "Y", "Z", "W", NULL};
        const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
        const lua_Number   val     = luaL_checknumber(L, 3);

        switch (key)
        {
        case 0:
            (*vec)[TType::X] = val;
            break;
        case 1:
            (*vec)[TType::Y] = val;
            break;
        case 2:
            (*vec)[TType::Z] = val;
            break;
        case 3:
            (*vec)[TType::W] = val;
            break;
        default:
            return luaL_error(L, "Invalid call.");
        }
        return 0;
    }
    else
    {
        return luaL_argerror(L, 2, "expected integer index");
    }

    return 0;
}

template < typename T >
int Set(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;

    const int nargs = lua_gettop(L);

    luaL_argcheck(L, (nargs <= T::NUM_ELEMENTS + 1), T::NUM_ELEMENTS + 2, "Too many arguments.");

    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    switch (nargs)
    {
    default:
        return luaL_error(L, "Invalid call. Bad argument count.");
    case 2:
        // Assignment operator
        if (lua_isuserdata(L, 2))
        {
            const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
            (*A)             = (*B);

            // Pop second userdata off
            lua_pop(L, 1);
            return 1;
        }
        // Set from table
        else if (lua_istable(L, 2))
        {
            lua_Number B[T::NUM_ELEMENTS];
            Helper::GetNumbersFromTable(L, 2, B, T::NUM_ELEMENTS, true, true);
            for (int i = 0; i < T::NUM_ELEMENTS; ++i)
            {
                A->data()[i] = B[i];
            }

            // Pop table off.
            lua_pop(L, 1);
            return 1;
        }
        break;
    case T::NUM_ELEMENTS + 1:
    {
        lua_Number B[T::NUM_ELEMENTS];
        for (int i = 0; i < T::NUM_ELEMENTS; ++i)
        {
            Helper::GetNumberFromStack(L, i + 2, B + i);
        }
        // Don't change A until we get all of B. ^^^
        for (int i = 0; i < T::NUM_ELEMENTS; ++i)
        {
            A->data()[i] = B[i];
        }
        // Pop numbers off.
        lua_pop(L, T::NUM_ELEMENTS);
        return 1;
    }
    }

    return luaL_error(L, "Invalid call.");
}

template < typename T >
int Length(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    lua_pushnumber(L, A->length());
    return 1;
}

template < typename T >
int LengthSquared(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    lua_pushnumber(L, A->length_squared());
    return 1;
}

template < typename T >
int Normalize(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->normalize();
    return 1;
}

template < typename T >
int Inverse(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->inverse();
    return 1;
}

template < typename T >
int Conjugate(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->conjugate();
    return 1;
}

template < typename T >
int Identity(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->identity();
    return 1;
}

template < typename T >
int Random(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 3);
    TPointer         A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const lua_Number B = luaL_checknumber(L, 2);
    const lua_Number C = luaL_checknumber(L, 3);
    (*A).random(B, C);
    return 0;
}

template < typename T >
int Unm(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    TPointer       B = (TPointer)lua_newuserdata(L, sizeof(TType));
    (*B)             = -(*A);
    return ::SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Equ(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    lua_pushboolean(L, (*A) == (*B));
    return 1;
}

template < typename T >
int LessThan(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    lua_pushboolean(L, (*A) < (*B));
    return 1;
}

template < typename T >
int Add(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    TPointer       C = (TPointer)lua_newuserdata(L, sizeof(TType));
    (*C)             = (*A) + (*B);
    return ::SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Sub(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    TPointer       C = (TPointer)lua_newuserdata(L, sizeof(TType));
    (*C)             = (*A) - (*B);
    return ::SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Mul(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);
    if (lua_isuserdata(L, 1))
    {
        const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

        if (lua_isuserdata(L, 2))
        {
            const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
            TPointer       C = (TPointer)lua_newuserdata(L, sizeof(TType));
            (*C)             = (*A) * (*B);
            return ::SetClass(L, T::UDATA_TYPE_NAME);
        }
        else if (lua_isnumber(L, 2))
        {
            const lua_Number B = luaL_checknumber(L, 2);
            TPointer         C = (TPointer)lua_newuserdata(L, sizeof(TType));
            (*C)               = (*A) * B;
            return ::SetClass(L, T::UDATA_TYPE_NAME);
        }
        else
        {
            return luaL_argerror(L, 2, "Invalid call. Bad argument type.");
        }
    }
    else if (lua_isnumber(L, 1))
    {
        const lua_Number A = luaL_checknumber(L, 1);
        const TPointer   B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
        TPointer         C = (TPointer)lua_newuserdata(L, sizeof(TType));
        (*C)               = A * (*B);
        return ::SetClass(L, T::UDATA_TYPE_NAME);
    }
    else
    {
        return luaL_argerror(L, 1, "Invalid call. Bad argument type.");
    }
}

template < typename T >
int Div(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    CHECK_ARG_COUNT(L, 2);
    if (lua_isuserdata(L, 1))
    {
        const TPointer   A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
        const lua_Number B = luaL_checknumber(L, 2);
        TPointer         C = (TPointer)lua_newuserdata(L, sizeof(TType));
        *C                 = (*A) / B;
        return ::SetClass(L, T::UDATA_TYPE_NAME);
    }
    else
    {
        return luaL_argerror(L, 1, "Invalid call. Bad argument type.");
    }
}

template < typename T >
int AddEq(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    TPointer       A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    (*A) += (*B);
    return 1;
}

template < typename T >
int SubEq(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    TPointer       A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    (*A) -= (*B);
    return 1;
}

template < typename T >
int MulEq(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    if (lua_isuserdata(L, 2))
    {
        const TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
        (*A) *= (*B);
        return 1;
    }
    else if (lua_isnumber(L, 1))
    {
        const lua_Number B = luaL_checknumber(L, 1);
        (*A) *= B;
        return 1;
    }
    else
    {
        return luaL_argerror(L, 1, "Invalid call. Bad argument type.");
    }
}

template < typename T >
int DivEq(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 2);
    TPointer         A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const lua_Number B = luaL_checknumber(L, 2);
    (*A) /= B;
    return 1;
}

template < typename T >
int Imaginary(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    const TPointer   A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    Vector3::Pointer B = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
    *B                 = A->imaginary();
    return ::SetClass(L, Vector3::UDATA_TYPE_NAME);
}

template < typename T >
int Real(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    CHECK_ARG_COUNT(L, 1);
    const TPointer A = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    lua_pushnumber(L, A->real());
    return 1;
}
}

#endif // luacmlquat_hpp__
