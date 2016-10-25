
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlvector.cpp
/// @date   09/27/2016
/// @author ctallman
///
/// @brief  Lua CML Vector.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacmlvector.hpp"

const char* Vector2::UDATA_TYPE_NAME = "vector2";
const char* Vector3::UDATA_TYPE_NAME = "vector3";
const char* Vector4::UDATA_TYPE_NAME = "vector4";

template < typename T >
static int Print(lua_State* L)
{
    typedef typename T::Pointer TPointer;

    const TPointer    vec  = (TPointer)luaL_checkudata(L, -1, T::UDATA_TYPE_NAME);
    const lua_Number* data = vec->data();
    const char*       name = T::UDATA_TYPE_NAME;

    switch (T::NUM_ELEMENTS)
    {
    case 2:
        lua_pushfstring(L, "%s:<%f,%f>", name, data[0], data[1]);
        return 1;
    case 3:
        lua_pushfstring(L, "%s:<%f,%f,%f>", name, data[0], data[1], data[2]);
        return 1;
    case 4:
        lua_pushfstring(L, "%s:<%f,%f,%f,%f>", name, data[0], data[1], data[2], data[3]);
        return 1;
    default:
        return 0;
    }
}

template < typename T >
static int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print< T >},
        {"__index", Vector::Index< T >},
        {"__newindex", Vector::NewIndex< T >},
        {"__unm", Vector::Unm< T >},
        {"__add", Vector::Add< T >},
        {"__sub", Vector::Sub< T >},
        {"__mul", Vector::Mul< T >},
        {"__div", Vector::Div< T >},
        {"__eq", Vector::Equ< T >},

        // Methods
        {"totable", Helper::ToTable< T >},
        {"set", Vector::Set< T >},
        {"length", Vector::Length< T >},
        {"length_squared", Vector::LengthSquared< T >},
        {"normalize", Vector::Normalize< T >},
        {"zero", Vector::Zero< T >},
        {"cardinal", Vector::Cardinal< T >},
        {"minimize", Vector::Minimize< T >},
        {"maximize", Vector::Maximize< T >},
        {"add", Vector::Add< T >},
        {"sub", Vector::Sub< T >},
        {"mul", Vector::Mul< T >},
        {"div", Vector::Div< T >},
        {"add_eq", Vector::AddEq< T >},
        {"sub_eq", Vector::SubEq< T >},
        {"mul_eq", Vector::MulEq< T >},
        {"div_eq", Vector::DivEq< T >},
        {"random", Vector::Random< T >},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, T::UDATA_TYPE_NAME, funcs);
}

template < typename T >
int WrapNew(lua_State* L)
{
    lua_pushcfunction(L, Vector::New< T >);
    lua_replace(L, 1);
    lua_call(L, lua_gettop(L) - 1, LUA_MULTRET);
    return lua_gettop(L);
}

/******************************************************************************/

LUACML_API int luaopen_luacml_vector2(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Vector::New< Vector2 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Vector2 >(L);

    return 1;
}

LUACML_API int luaopen_luacml_vector3(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Vector::New< Vector3 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Vector3 >(L);

    return 1;
}

LUACML_API int luaopen_luacml_vector4(lua_State* L)
{
    static luaL_Reg lib_funcs[] = {{"__call", Vector::New< Vector4 >}, {NULL, NULL}};

    lua_newtable(L); // library table
    lua_newtable(L); // metatable
    luaL_setfuncs(L, lib_funcs, 0);
    lua_setmetatable(L, -2);

    Register< Vector4 >(L);

    return 1;
}
