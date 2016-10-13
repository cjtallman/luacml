
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlmatrix.cpp
/// @date   09/27/2016
/// @author ctallman
///
/// @brief  Lua CML Matrix.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacmlmatrix.hpp"

const char* Matrix22::UDATA_TYPE_NAME   = "matrix22";
const char* Matrix22_r::UDATA_TYPE_NAME = "matrix22_r";
const char* Matrix22_c::UDATA_TYPE_NAME = "matrix22_c";
const char* Matrix33::UDATA_TYPE_NAME   = "matrix33";
const char* Matrix33_r::UDATA_TYPE_NAME = "matrix33_r";
const char* Matrix33_c::UDATA_TYPE_NAME = "matrix33_c";
const char* Matrix44::UDATA_TYPE_NAME   = "matrix44";
const char* Matrix44_r::UDATA_TYPE_NAME = "matrix44_r";
const char* Matrix44_c::UDATA_TYPE_NAME = "matrix44_c";
const char* Matrix32_r::UDATA_TYPE_NAME = "matrix32_r";
const char* Matrix23_c::UDATA_TYPE_NAME = "matrix23_c";
const char* Matrix43_r::UDATA_TYPE_NAME = "matrix43_r";
const char* Matrix34_c::UDATA_TYPE_NAME = "matrix34_c";

template < typename T >
static int Print(lua_State* L)
{
    typedef typename T::Pointer TPointer;

    const TPointer    vec  = (TPointer)luaL_checkudata(L, -1, T::UDATA_TYPE_NAME);
    const lua_Number* data = vec->data();
    const char*       name = T::UDATA_TYPE_NAME;

    switch (T::NUM_ELEMENTS)
    {
    case 4: // 2x2
        lua_pushfstring(L, "%s:|%f,%f|%f,%f|", name, data[0], data[1], data[2], data[3]);
        return 1;

    case 6:               // 2x3 or 3x2
        if (T::ROWS == 3) // 3x2
        {
            lua_pushfstring(L,
                            "%s:|%f,%f|%f,%f|%f,%f|",
                            name,
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4],
                            data[5]);
            return 1;
        }
        else // 2x3
        {
            lua_pushfstring(L,
                            "%s:|%f,%f,%f|%f,%f,%f|",
                            name,
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4],
                            data[5]);
            return 1;
        }

    case 9: // 3x3
        lua_pushfstring(L,
                        "%s:|%f,%f,%f|%f,%f,%f|%f,%f,%f|",
                        name,
                        data[0],
                        data[1],
                        data[2],
                        data[3],
                        data[4],
                        data[5],
                        data[6],
                        data[7],
                        data[8]);
        return 1;

    case 12:              // 3x4 or 4x3
        if (T::ROWS == 4) // 4x3
        {
            lua_pushfstring(L,
                            "%s:|%f,%f,%f|%f,%f,%f|%f,%f,%f|%f,%f,%f",
                            name,
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4],
                            data[5],
                            data[6],
                            data[7],
                            data[8],
                            data[9],
                            data[10],
                            data[11]);
            return 1;
        }
        else // 3x4
        {
            lua_pushfstring(L,
                            "%s:|%f,%f,%f,%f|%f,%f,%f,%f|%f,%f,%f,%f",
                            name,
                            data[0],
                            data[1],
                            data[2],
                            data[3],
                            data[4],
                            data[5],
                            data[6],
                            data[7],
                            data[8],
                            data[9],
                            data[10],
                            data[11]);
            return 1;
        }

    case 16: // 4x4
        lua_pushfstring(L,
                        "%s:|%f,%f,%f,%f|%f,%f,%f,%f|%f,%f,%f,%f|%f,%f,%f,%f|",
                        name,
                        data[0],
                        data[1],
                        data[2],
                        data[3],
                        data[4],
                        data[5],
                        data[6],
                        data[7],
                        data[8],
                        data[9],
                        data[10],
                        data[11],
                        data[12],
                        data[13],
                        data[14],
                        data[15]);
        return 1;

    default: // Invalid
        return 0;
    }
}

template < typename T >
static int ToTable(lua_State* L)
{
    typedef typename T::Pointer TPointer;

    CHECK_ARG_COUNT(L, 1);

    const TPointer mat = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    lua_newtable(L);
    for (int row = 0, i = 0; row < T::ROWS; ++row)
    {
        for (int col = 0; col < T::COLS; ++col, ++i)
        {
            const lua_Number& val = (*mat)(row, col);
            lua_pushinteger(L, i + 1);
            lua_pushnumber(L, val);
            lua_rawset(L, -3);
        }
    }
    return 1;
}

template < typename T >
static int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print< T >},
        {"__index", Matrix::Index< T >},
        {"__newindex", Matrix::NewIndex< T >},

        // Methods
        {"totable", ToTable< T >},
        {"set", Matrix::Set< T >},
        {"rows", Matrix::Rows< T >},
        {"cols", Matrix::Cols< T >},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, T::UDATA_TYPE_NAME, funcs);
}

/******************************************************************************/

LUACML_API int luaopen_luacml_matrix22(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix22 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix22 >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix22_r(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix22_r >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix22_r >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix22_c(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix22_c >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix22_c >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix33(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix33 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix33 >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix33_r(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix33_r >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix33_r >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix33_c(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix33_c >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix33_c >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix44(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix44 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix44 >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix44_r(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix44_r >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix44_r >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix44_c(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix44_c >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix44_c >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix32_r(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix32_r >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix32_r >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix23_c(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix23_c >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix23_c >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix43_r(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix43_r >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix43_r >(L);

    return 1;
}

LUACML_API int luaopen_luacml_matrix34_c(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Matrix::New< Matrix34_c >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Matrix34_c >(L);

    return 1;
}
