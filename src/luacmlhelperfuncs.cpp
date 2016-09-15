
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlhelperfuncs.hpp
/// @date   09/15/2016
/// @author ctallman
///
/// @brief  Misc helper functions.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacmlhelperfuncs.hpp"
#include "luacmlvector.hpp"
#include "luacmlquaternion.hpp"

namespace Helper {

LUACML_API int ToTable(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);

    static const int MAX_LEN = Vector4::NUM_ELEMENTS;
    lua_Number       vec[MAX_LEN];
    const int        len = GetNumbersFromAnyUserdata(L, 1, vec, MAX_LEN);

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

LUACML_API int GetNumbersFromTable(lua_State* L, const int tab, lua_Number* vec, const int len,
                                   bool need_same_len)
{
    // Verify it's a table.
    luaL_checktype(L, tab, LUA_TTABLE);

    // Verify length of table.
    const int count = lua_rawlen(L, tab);
    if (count > len)
    {
        return luaL_error(L, "Invalid call. Too many arguments.");
    }
    else if (need_same_len && count != len)
    {
        return luaL_error(L, "Invalid call. Missing arguments.");
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

LUACML_API int GetNumbersFromAnyUserdata(lua_State* L, const int ud, lua_Number* vec, const int len)
{
    if (lua_isuserdata(L, ud))
    {
        int result = 0;
        if ((result = Vector4::GetNumbersFromUserdata(L, ud, vec, len)) ||
            (result = Vector3::GetNumbersFromUserdata(L, ud, vec, len)) ||
            (result = Vector2::GetNumbersFromUserdata(L, ud, vec, len)) ||
            (result = QuatNeg::GetNumbersFromUserdata(L, ud, vec, len)) ||
            (result = QuatPos::GetNumbersFromUserdata(L, ud, vec, len)))
        {
            return result;
        }
    }

    return luaL_error(L, "Invalid call. Bad argument type.");
}
}
