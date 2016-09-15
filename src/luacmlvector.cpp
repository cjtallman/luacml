
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlvector.cpp
/// @date   09/15/2016
/// @author ctallman
///
/// @brief  description
///
////////////////////////////////////////////////////////////////////////////////

#include "luacmlvector.hpp"

namespace Vector {

LUACML_API int ToTable(lua_State* L)
{
    static const int MAX_LEN = Vector4::NUM_ELEMENTS;
    lua_Number       vec[MAX_LEN];
    const int        len = Vector::GetNumbersFromUserdata(L, 1, vec, MAX_LEN);

    lua_newtable(L);
    for (int i = 0; i < len; ++i)
    {
        lua_pushinteger(L, i + 1);
        lua_pushnumber(L, vec[i]);
        lua_rawset(L, -3);
    }
    return 1;
}

LUACML_API int GetNumberFromStack(lua_State* L, const int index, lua_Number* num)
{
    luaL_checktype(L, index, LUA_TNUMBER);

    *num = lua_tonumber(L, index);
    if (!lua_rawequal(L, index, index))
    {
        return luaL_error(L, "Invalid call. Bad value #%d.", index);
    }

    return 1;
}

LUACML_API int GetNumbersFromTable(lua_State* L, const int tab, lua_Number* vec, const int len)
{
    // Verify it's a table.
    luaL_checktype(L, tab, LUA_TTABLE);

    // Verify length of table.
    const int count = lua_rawlen(L, tab);
    if (count > len)
    {
        return luaL_error(L, "Invalid call. Too many arguments.");
    }

    // Extract data.
    for (int i = 0; i < count; ++i)
    {
        lua_rawgeti(L, tab, i + 1);
        vec[i] = luaL_checknumber(L, -1);
        if (!lua_rawequal(L, -1, -1))
        {
            return luaL_error(L, "Invalid call. Bad value #%d.", i + 1);
        }
        lua_pop(L, 1);
    }

    return count;
}

LUACML_API int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len)
{
    if (lua_isuserdata(L, ud))
    {
        if (const Vector4::Pointer v4 =
                (Vector4::Pointer)luaL_testudata(L, ud, Vector4::UDATA_TYPE_NAME))
        {
            // Copy as much as possible.
            const int count = std::min< int >(len, Vector4::NUM_ELEMENTS);
            for (int i = 0; i < count; ++i)
            {
                vec[i] = (*v4)[i];
            }
            lua_pop(L, 1);
            return count;
        }

        else if (const Vector3::Pointer v3 =
                     (Vector3::Pointer)luaL_testudata(L, ud, Vector3::UDATA_TYPE_NAME))
        {
            // Copy as much as possible.
            const int count = std::min< int >(len, Vector3::NUM_ELEMENTS);
            for (int i = 0; i < count; ++i)
            {
                vec[i] = (*v3)[i];
            }
            lua_pop(L, 1);
            return count;
        }

        else if (const Vector2::Pointer v2 =
                     (Vector2::Pointer)luaL_testudata(L, -1, Vector2::UDATA_TYPE_NAME))
        {
            // Copy as much as possible.
            const int count = std::min< int >(len, Vector2::NUM_ELEMENTS);
            for (int i = 0; i < count; ++i)
            {
                vec[i] = (*v2)[i];
            }
            lua_pop(L, 1);
            return count;
        }
    }

    return luaL_error(L, "Invalid call. Bad argument type.");
}
}
