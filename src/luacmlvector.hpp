
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlvector.hpp
/// @date   09/15/2016
/// @author ctallman
///
/// @brief  Helper functions for vector2, vector3, and vector4.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlvector_hpp__
#define luacmlvector_hpp__

#include "luacml.hpp"

/******************************************************************************/

struct Vector2
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 2
    };

    typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_vector2(lua_State* L);

struct Vector3
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 3
    };

    typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_vector3(lua_State* L);

struct Vector4
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4
    };

    typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_vector4(lua_State* L);

/******************************************************************************/

namespace Vector {

template < typename T >
int New(lua_State* L)
{
    // This is here because Lua passes the table to __call as the first
    //  argument, but we don't want it.
    lua_remove(L, 1);

    const int nargs = lua_gettop(L);

    // Temporary vector to create result from.
    T::Type temp;
    temp.zero();

    // Check for too many arguments.
    luaL_argcheck(L, (nargs <= T::NUM_ELEMENTS), T::NUM_ELEMENTS + 1, "Too many arguments.");

    if (nargs == 0)
    {
    }
    else if (nargs == 1)
    {
        if (lua_isnumber(L, 1))
        {
            // cml.vector4(1) --> vector4:<1,0,0,0>
            Helper::GetNumberFromStack(L, 1, temp.data());
        }
        else if (lua_istable(L, 1))
        {
            Helper::GetNumbersFromTable(L, 1, temp.data(), T::NUM_ELEMENTS, false, true);
        }
        // From 1 vector2, vector3, or vector4.
        else if (lua_isuserdata(L, 1))
        {
            Helper::GetNumbersFromUserdata(L, 1, temp.data(), T::NUM_ELEMENTS, false, false);
        }
        else
        {
            return luaL_error(L, "Invalid call. Invalid argument.");
        }
    }
    else if (nargs > 1)
    {
        for (int i = 0; i < T::NUM_ELEMENTS && i < nargs; ++i)
        {
            Helper::GetNumberFromStack(L, i + 1, temp.data() + i);
        }
    }
    else
    {
        return luaL_error(L, "Invalid call.");
    }

    T::Pointer newvec = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
    (*newvec)         = temp;

    return ::SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Index(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    const T::Pointer vec = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

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
        const lua_Number val = (*vec)[key - 1];
        lua_pushnumber(L, val);
        return 1;
    }
    else if (lua_isstring(L, 2))
    {
        switch (T::NUM_ELEMENTS)
        {
        case 2:
        {
            static const char* valid[] = {"x", "y", "X", "Y", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = (*vec)[key];
            lua_pushnumber(L, val);
            return 1;
        }

        case 3:
        {
            static const char* valid[] = {"x", "y", "z", "X", "Y", "Z", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = (*vec)[key];
            lua_pushnumber(L, val);
            return 1;
        }

        case 4:
        {
            static const char* valid[] = {"x", "y", "z", "w", "X", "Y", "Z", "W", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = (*vec)[key];
            lua_pushnumber(L, val);
            return 1;
        }

        default:
            return luaL_error(L, "Invalid call.");
        }
    }
    else
    {
        return luaL_error(L, "Invalid call. Bad argument type.");
    }

    return 0;
}

template < typename T >
int NewIndex(lua_State* L)
{
    CHECK_ARG_COUNT(L, 3);

    T::Pointer vec = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

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
        switch (T::NUM_ELEMENTS)
        {
        case 2:
        {
            static const char* valid[] = {"x", "y", "X", "Y", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = luaL_checknumber(L, 3);
            (*vec)[key]                = val;
            return 0;
        }

        case 3:
        {
            static const char* valid[] = {"x", "y", "z", "X", "Y", "Z", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = luaL_checknumber(L, 3);
            (*vec)[key]                = val;
            return 0;
        }

        case 4:
        {
            static const char* valid[] = {"x", "y", "z", "w", "X", "Y", "Z", "W", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = luaL_checknumber(L, 3);
            (*vec)[key]                = val;
            return 0;
        }

        default:
            return luaL_error(L, "Invalid call.");
        }
    }
    else
    {
        return luaL_error(L, "Invalid call. Bad argument type.");
    }

    return 0;
}

template < typename T >
int Length(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    lua_pushnumber(L, A->length());
    return 1;
}

template < typename T >
int LengthSquared(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    lua_pushnumber(L, A->length_squared());
    return 1;
}

template < typename T >
int Normalize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->normalize();
    return 1;
}

template < typename T >
int Zero(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    A->zero();
    return 1;
}

template < typename T >
int Cardinal(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer A     = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    int        index = 0;
    Helper::GetIntegerFromStack(L, 2, &index);
    luaL_argcheck(L, (index > 0) && (index <= T::NUM_ELEMENTS), 2, "Index (1-based) out of range.");
    A->cardinal(index);
    lua_pop(L, 1); // Pop index, leave vector.
    return 1;
}

template < typename T >
int Minimize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    A->minimize(*B);
    return 0;
}

template < typename T >
int Maximize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    A->maximize(*B);
    return 0;
}

template < typename T >
int Random(lua_State* L)
{
    CHECK_ARG_COUNT(L, 3);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const lua_Number B = luaL_checknumber(L, 2);
    const lua_Number C = luaL_checknumber(L, 3);
    (*A).random(B, C);
    return 0;
}

template < typename T >
int Unm(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    T::Pointer       B = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
    *B                 = -(*A);
    return SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Equ(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    lua_pushboolean(L, (*A) == (*B));
    return 1;
}

template < typename T >
int LessThan(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    lua_pushboolean(L, (*A) < (*B));
    return 1;
}

template < typename T >
int Add(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    T::Pointer       C = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
    *C                 = (*A) + (*B);
    return SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Sub(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    T::Pointer       C = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
    *C                 = (*A) - (*B);
    return SetClass(L, T::UDATA_TYPE_NAME);
}

template < typename T >
int Mul(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    if (lua_isuserdata(L, 1))
    {
        const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
        const lua_Number B = luaL_checknumber(L, 2);
        T::Pointer       C = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
        *C                 = (*A) * B;
        return SetClass(L, T::UDATA_TYPE_NAME);
    }
    else if (lua_isnumber(L, 1))
    {
        const lua_Number A = luaL_checknumber(L, 1);
        const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
        T::Pointer       C = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
        *C                 = A * (*B);
        return SetClass(L, T::UDATA_TYPE_NAME);
    }
    else
    {
        return luaL_argerror(L, 1, "Invalid call. Bad argument type.");
    }
}

template < typename T >
int Div(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    if (lua_isuserdata(L, 1))
    {
        const T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
        const lua_Number B = luaL_checknumber(L, 2);
        T::Pointer       C = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
        *C                 = (*A) / B;
        return SetClass(L, T::UDATA_TYPE_NAME);
    }
    else
    {
        return luaL_argerror(L, 1, "Invalid call. Bad argument type.");
    }
}

template < typename T >
int AddEq(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    (*A) += (*B);
    return 1;
}

template < typename T >
int SubEq(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
    (*A) -= (*B);
    return 1;
}

template < typename T >
int MulEq(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const lua_Number B = luaL_checknumber(L, 2);
    (*A) *= B;
    return 1;
}

template < typename T >
int DivEq(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    T::Pointer       A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);
    const lua_Number B = luaL_checknumber(L, 2);
    (*A) /= B;
    return 1;
}

template < typename T >
int Set(lua_State* L)
{
    const int nargs = lua_gettop(L);

    luaL_argcheck(L, (nargs <= T::NUM_ELEMENTS + 1), T::NUM_ELEMENTS + 2, "Too many arguments.");

    T::Pointer A = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    switch (nargs)
    {
    default:
        return luaL_error(L, "Invalid call. Bad argument count.");
    case 2:
        // Assignment operator
        if (lua_isuserdata(L, 2))
        {
            const T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
            (*A)               = (*B);

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
}

#endif // luacmlvector_hpp__
