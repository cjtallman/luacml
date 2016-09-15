
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacml.cpp
/// @date   09/12/2016
/// @author ctallman
///
/// @brief  Lua bindings for the CML math library.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacml.hpp"
#include "luacmlvector.hpp"
#include <lua.hpp>
#include <cml/cml.h>

int NewClass(lua_State* L, const char* TYPE_NAME, const luaL_Reg* funcs)
{
    // Create udata metatable
    luaL_newmetatable(L, TYPE_NAME);

    // Make metatable index into itself.
    lua_pushstring(L, "__index");
    lua_pushvalue(L, -2);
    lua_rawset(L, -3);

    // Store __type in metatable.
    lua_pushstring(L, "__type");
    lua_pushstring(L, TYPE_NAME);
    lua_rawset(L, -3);

    // Loop over each func and store in metatable.
    for (const luaL_Reg* func = funcs; func->name; ++func)
    {
        lua_pushstring(L, func->name);
        lua_pushcfunction(L, func->func);
        lua_rawset(L, -3);
    }

    lua_pop(L, 1); // Pop here, since it's already stored in the global registry.

    return 0;
}

int SetClass(lua_State* L, const char* TYPE_NAME)
{
    luaL_getmetatable(L, TYPE_NAME);
    lua_setmetatable(L, -2);
    return 1;
}

int PrintClass(lua_State* L)
{
    char buf[256];
    if (!lua_getmetatable(L, 1))
        goto error;
    lua_pushstring(L, "__index");
    lua_gettable(L, -2);
    if (!lua_istable(L, -1))
        goto error;
    lua_pushstring(L, "__type");
    lua_gettable(L, -2);
    if (!lua_isstring(L, -1))
        goto error;
    sprintf(buf, "%p", lua_touserdata(L, 1));
    lua_pushfstring(L, "%s: %s", lua_tostring(L, -1), buf);
    return 1;
error:
    lua_pushstring(L, "invalid object passed to '__tostring'");
    lua_error(L);
    return 1;
}

LUACML_API int luaopen_luacml(lua_State* L)
{
    static luaL_Reg funcs[] = {{"vector2", &Vector2::New},
                               {"vector3", &Vector3::New},
                               {"vector4", &Vector4::New},
                               {NULL, NULL}};

    lua_newtable(L);
    luaL_setfuncs(L, funcs, 0);

    Vector2::Register(L);
    Vector3::Register(L);
    Vector4::Register(L);

    return 1;
}
