
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlmatrix.hpp
/// @date   09/26/2016
/// @author ctallman
///
/// @brief  Matrix header
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlmatrix_hpp__
#define luacmlmatrix_hpp__

#include "luacml.hpp"
#include "luacmlvector.hpp"

/******************************************************************************/

struct Matrix22
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4,
        ROWS         = 2,
        COLS         = 2,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix22(lua_State* L);

struct Matrix22_r
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4,
        ROWS         = 2,
        COLS         = 2,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::row_basis, cml::row_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix22_r(lua_State* L);

struct Matrix22_c
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 4,
        ROWS         = 2,
        COLS         = 2,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::col_basis, cml::col_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix22_c(lua_State* L);

struct Matrix33
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 9,
        ROWS         = 3,
        COLS         = 3,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix33(lua_State* L);

struct Matrix33_r
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 9,
        ROWS         = 3,
        COLS         = 3,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::row_basis, cml::row_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix33_r(lua_State* L);

struct Matrix33_c
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 9,
        ROWS         = 3,
        COLS         = 3,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::col_basis, cml::col_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix33_c(lua_State* L);

struct Matrix44
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 16,
        ROWS         = 4,
        COLS         = 4,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS > > Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix44(lua_State* L);

struct Matrix44_r
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 16,
        ROWS         = 4,
        COLS         = 4,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::row_basis, cml::row_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix44_r(lua_State* L);

struct Matrix44_c
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 16,
        ROWS         = 4,
        COLS         = 4,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::col_basis, cml::col_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix44_c(lua_State* L);

struct Matrix32_r
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 6,
        ROWS         = 3,
        COLS         = 2,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::row_basis, cml::row_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix32_r(lua_State* L);

struct Matrix23_c
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 6,
        ROWS         = 2,
        COLS         = 3,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::col_basis, cml::col_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix23_c(lua_State* L);

struct Matrix43_r
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 12,
        ROWS         = 4,
        COLS         = 3,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::row_basis, cml::row_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix43_r(lua_State* L);

struct Matrix34_c
{
    static const char* UDATA_TYPE_NAME;
    enum
    {
        NUM_ELEMENTS = 12,
        ROWS         = 3,
        COLS         = 4,
    };

    typedef cml::matrix< lua_Number, cml::fixed< ROWS, COLS >, cml::col_basis, cml::col_major >
                  Type;
    typedef Type* Pointer;
};

LUACML_API int luaopen_luacml_matrix34_c(lua_State* L);

/******************************************************************************/

namespace Matrix {

template < typename T >
int New(lua_State* L)
{
    // This is here because Lua passes the table to __call as the first
    //  argument, but we don't want it.
    lua_remove(L, 1);

    const int nargs = lua_gettop(L);

    // Temporary vector to create result from.
    T::Type temp;
    temp.identity();

    // Check for too many arguments.
    luaL_argcheck(L, (nargs <= T::NUM_ELEMENTS), T::NUM_ELEMENTS + 1, "Too many arguments.");

    switch (nargs)
    {
    case 0:
        break;
    case 1:
        if (lua_istable(L, 1))
        {
            Helper::GetNumbersFromTable(L, 1, temp.data(), T::NUM_ELEMENTS, true, true);
        }
        else if (lua_isuserdata(L, 1))
        {
            Helper::GetNumbersFromUserdata(L, 1, temp.data(), T::NUM_ELEMENTS, true, true);
        }
        else
        {
            return luaL_argerror(L, 1, "expected table or matrix");
        }
        break;
    case T::NUM_ELEMENTS:
        for (int i = 0; i < T::NUM_ELEMENTS && i < nargs; ++i)
        {
            Helper::GetNumberFromStack(L, i + 1, temp.data() + i);
        }
        break;
    default:
        return luaL_error(L, "Invalid call.");
    }

    T::Pointer newvec = (T::Pointer)lua_newuserdata(L, sizeof(T::Type));
    (*newvec)         = temp;

    return ::SetClass(L, T::UDATA_TYPE_NAME);
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

template < typename T >
int Index(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    const T::Pointer obj = (T::Pointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

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
        const lua_Number val = obj->data()[key - 1];
        lua_pushnumber(L, val);
        return 1;
    }
    else if (lua_isstring(L, 2))
    {
        switch (T::NUM_ELEMENTS)
        {
        case 4: // 2x2
        {
            static const char* valid[] = {"m11", "m12", "m21", "m22", NULL};
            const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number   val     = obj->data()[key];
            lua_pushnumber(L, val);
            return 1;
        }
        case 6: // 2x3 or 3x2
        {
            if (T::ROWS == 3) // 3x2
            {
                static const char* valid[] = {"m11", "m12", "m21", "m22", "m31", "m32", NULL};
                const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
                const lua_Number   val     = obj->data()[key];
                lua_pushnumber(L, val);
                return 1;
            }
            else // 2x3
            {
                static const char* valid[] = {"m11", "m12", "m13", "m21", "m22", "m23", NULL};
                const int          key     = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
                const lua_Number   val     = obj->data()[key];
                lua_pushnumber(L, val);
                return 1;
            }
        }
        case 9: // 3x3
        {
            static const char* valid[] = {
                "m11", "m12", "m13", "m21", "m22", "m23", "m31", "m32", "m33", NULL};
            const int        key = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number val = obj->data()[key];
            lua_pushnumber(L, val);
            return 1;
        }
        case 12: // 3x4 or 4x3
        {
            if (T::ROWS == 4) // 4x3
            {
                static const char* valid[] = {"m11",
                                              "m12",
                                              "m13",
                                              "m21",
                                              "m22",
                                              "m23",
                                              "m31",
                                              "m32",
                                              "m33",
                                              "m41",
                                              "m42",
                                              "m43",
                                              NULL};
                const int        key = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
                const lua_Number val = obj->data()[key];
                lua_pushnumber(L, val);
                return 1;
            }
            else // 3x4
            {
                static const char* valid[] = {"m11",
                                              "m12",
                                              "m13",
                                              "m14",
                                              "m21",
                                              "m22",
                                              "m23",
                                              "m24",
                                              "m31",
                                              "m32",
                                              "m33",
                                              "m34",
                                              NULL};
                const int        key = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
                const lua_Number val = obj->data()[key];
                lua_pushnumber(L, val);
                return 1;
            }
        }
        case 16: // 4x4
        {
            static const char* valid[] = {"m11",
                                          "m12",
                                          "m13",
                                          "m14",
                                          "m21",
                                          "m22",
                                          "m23",
                                          "m24",
                                          "m31",
                                          "m32",
                                          "m33",
                                          "m34",
                                          "m41",
                                          "m42",
                                          "m43",
                                          "m44",
                                          NULL};
            const int        key = luaL_checkoption(L, 2, NULL, valid) % T::NUM_ELEMENTS;
            const lua_Number val = obj->data()[key];
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

} // namespace Matrix

#endif // luacmlmatrix_hpp__
