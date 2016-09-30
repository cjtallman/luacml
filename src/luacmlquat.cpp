
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlquat.cpp
/// @date   09/27/2016
/// @author ctallman
///
/// @brief  Lua CML Quaternion.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacmlquat.hpp"
#include "luacmlhelperfuncs.hpp"

const char* QuatDef::UDATA_TYPE_NAME = "quat";
const char* QuatPos::UDATA_TYPE_NAME = "quat_p";
const char* QuatNeg::UDATA_TYPE_NAME = "quat_n";

template < typename T >
static int Print(lua_State* L)
{
    const T::Pointer  vec  = (T::Pointer)luaL_checkudata(L, -1, T::UDATA_TYPE_NAME);
    const lua_Number* data = vec->data();

    lua_pushfstring(L, "%s:<%f,%f,%f,%f>", T::UDATA_TYPE_NAME, data[0], data[1], data[2], data[3]);
    return 1;
}

template < typename T >
static int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print< T >},
        {"__index", Quaternion::Index< T >},
        {"__newindex", Quaternion::NewIndex< T >},
        {"__unm", Quaternion::Unm< T >},
        {"__add", Quaternion::Add< T >},
        {"__sub", Quaternion::Sub< T >},
        {"__mul", Quaternion::Mul< T >},
        {"__div", Quaternion::Div< T >},
        {"__eq", Quaternion::Equ< T >},

        // Methods
        {"totable", Helper::ToTable< T >},
        {"set", Quaternion::Set< T >},
        {"length", Quaternion::Length< T >},
        {"length_squared", Quaternion::LengthSquared< T >},
        {"normalize", Quaternion::Normalize< T >},
        {"inverse", Quaternion::Inverse< T >},
        {"conjugate", Quaternion::Conjugate< T >},
        {"identity", Quaternion::Identity< T >},
        {"add", Quaternion::Add< T >},
        {"sub", Quaternion::Sub< T >},
        {"mul", Quaternion::Mul< T >},
        {"div", Quaternion::Div< T >},
        {"add_eq", Quaternion::AddEq< T >},
        {"sub_eq", Quaternion::SubEq< T >},
        {"mul_eq", Quaternion::MulEq< T >},
        {"div_eq", Quaternion::DivEq< T >},
        {"random", Quaternion::Random< T >},
        {"imaginary", Quaternion::Imaginary< T >},
        {"real", Quaternion::Real< T >},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, T::UDATA_TYPE_NAME, funcs);
}

LUACML_API int luaopen_luacml_quat(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Quaternion::New< QuatDef >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< QuatDef >(L);

    return 1;
}

LUACML_API int luaopen_luacml_quatpos(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Quaternion::New< QuatPos >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< QuatPos >(L);

    return 1;
}

LUACML_API int luaopen_luacml_quatneg(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Quaternion::New< QuatNeg >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< QuatNeg >(L);

    return 1;
}
