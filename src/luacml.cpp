
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
#include "luacmlquat.hpp"
#include "luacmlmatrix.hpp"
#include "luacmlhelperfuncs.hpp"
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

int Cross(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    Vector3::Pointer A = (Vector3::Pointer)luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME);
    Vector3::Pointer B = (Vector3::Pointer)luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME);
    Vector3::Pointer C = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));

    *C = cml::cross(*A, *B);

    return SetClass(L, Vector3::UDATA_TYPE_NAME);
}

template < typename T >
int TDot(lua_State* L)
{
    if (const T::Pointer A = (T::Pointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        T::Pointer B = (T::Pointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
        lua_pushnumber(L, cml::dot(*A, *B));
        return 1;
    }
    return 0;
}

int Dot(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    if (TDot< Vector4 >(L) || TDot< Vector3 >(L) || TDot< Vector2 >(L) || TDot< QuatDef >(L) ||
        TDot< QuatPos >(L) || TDot< QuatNeg >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4, quat, quat_p, quat_n");
}

#define REGISTER_LIB(L, name, func)                                                                \
    do                                                                                             \
    {                                                                                              \
        lua_pushliteral(L, name);                                                                  \
        lua_pushcfunction(L, func);                                                                \
        lua_call(L, 0, 1);                                                                         \
        lua_rawset(L, -3);                                                                         \
    } while (0)

LUACML_API int luaopen_luacml(lua_State* L)
{
    static luaL_Reg funcs[] = {{"cross", Cross}, {"dot", Dot}, {NULL, NULL}};

    lua_newtable(L);
    luaL_setfuncs(L, funcs, 0);

    REGISTER_LIB(L, "vector2", luaopen_luacml_vector2);
    REGISTER_LIB(L, "vector3", luaopen_luacml_vector3);
    REGISTER_LIB(L, "vector4", luaopen_luacml_vector4);
    REGISTER_LIB(L, "quat", luaopen_luacml_quat);
    REGISTER_LIB(L, "quat_p", luaopen_luacml_quatpos);
    REGISTER_LIB(L, "quat_n", luaopen_luacml_quatneg);
    REGISTER_LIB(L, "matrix22", luaopen_luacml_matrix22);
    REGISTER_LIB(L, "matrix22_r", luaopen_luacml_matrix22_r);
    REGISTER_LIB(L, "matrix22_c", luaopen_luacml_matrix22_c);
    REGISTER_LIB(L, "matrix33", luaopen_luacml_matrix33);
    REGISTER_LIB(L, "matrix33_r", luaopen_luacml_matrix33_r);
    REGISTER_LIB(L, "matrix33_c", luaopen_luacml_matrix33_c);
    REGISTER_LIB(L, "matrix44", luaopen_luacml_matrix44);
    REGISTER_LIB(L, "matrix44_r", luaopen_luacml_matrix44_r);
    REGISTER_LIB(L, "matrix44_c", luaopen_luacml_matrix44_c);
    REGISTER_LIB(L, "matrix32_r", luaopen_luacml_matrix32_r);
    REGISTER_LIB(L, "matrix23_c", luaopen_luacml_matrix23_c);
    REGISTER_LIB(L, "matrix43_r", luaopen_luacml_matrix43_r);
    REGISTER_LIB(L, "matrix34_c", luaopen_luacml_matrix34_c);

    return 1;
}
