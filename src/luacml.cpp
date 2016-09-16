
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
#include "luacmlquaternion.hpp"
#include "luacmlhelperfuncs.hpp"
#include <lua.hpp>
#include <cml/cml.h>

typedef Vector4::Type Vec4;
typedef Vector3::Type Vec3;
typedef Vector2::Type Vec2;
typedef QuatNeg::Type QNeg;
typedef QuatPos::Type QPos;

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

int Cross(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    Vec3* A = (Vec3*)luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME);
    Vec3* B = (Vec3*)luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME);
    Vec3* C = (Vec3*)lua_newuserdata(L, sizeof(Vector3::Type));

    *C = cml::cross(*A, *B);

    return SetClass(L, Vector3::UDATA_TYPE_NAME);
}

int Dot(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    if (const Vec4* A = (Vec4*)luaL_testudata(L, 1, Vector4::UDATA_TYPE_NAME))
    {
        Vec4* B = (Vec4*)luaL_checkudata(L, 2, Vector4::UDATA_TYPE_NAME);
        lua_pushnumber(L, cml::dot(*A, *B));
        return 1;
    }
    else if (const Vec3* A = (Vec3*)luaL_testudata(L, 1, Vector3::UDATA_TYPE_NAME))
    {
        Vec3* B = (Vec3*)luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME);
        lua_pushnumber(L, cml::dot(*A, *B));
        return 1;
    }
    else if (const Vec2* A = (Vec2*)luaL_testudata(L, 1, Vector2::UDATA_TYPE_NAME))
    {
        Vec2* B = (Vec2*)luaL_checkudata(L, 2, Vector2::UDATA_TYPE_NAME);
        lua_pushnumber(L, cml::dot(*A, *B));
        return 1;
    }
    else if (const QNeg* A = (QNeg*)luaL_testudata(L, 1, QuatNeg::UDATA_TYPE_NAME))
    {
        if (const QNeg* B = (QNeg*)luaL_checkudata(L, 2, QuatNeg::UDATA_TYPE_NAME))
        {
            lua_pushnumber(L, cml::dot(*A, *B));
            return 1;
        }
    }
    else if (const QPos* A = (QPos*)luaL_testudata(L, 1, QuatPos::UDATA_TYPE_NAME))
    {
        if (const QPos* B = (QPos*)luaL_checkudata(L, 2, QuatPos::UDATA_TYPE_NAME))
        {
            lua_pushnumber(L, cml::dot(*A, *B));
            return 1;
        }
    }

    return luaL_argerror(L, 1, "Expected vector2, vector3, vector4, quat_p, quat_n");
}

LUACML_API int luaopen_luacml(lua_State* L)
{
    static luaL_Reg funcs[] = {{"vector2", Vector2::New},
                               {"vector3", Vector3::New},
                               {"vector4", Vector4::New},
                               {"quat_n", QuatNeg::New},
                               {"quat_p", QuatPos::New},
                               {"cross", Cross},
                               {"dot", Dot},
                               {NULL, NULL}};

    lua_newtable(L);
    luaL_setfuncs(L, funcs, 0);

    Vector2::Register(L);
    Vector3::Register(L);
    Vector4::Register(L);
    QuatPos::Register(L);
    QuatNeg::Register(L);

    return 1;
}
