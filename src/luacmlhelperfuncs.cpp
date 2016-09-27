
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

namespace Helper {

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

LUACML_API int GetIntegerFromStack(lua_State* L, const int index, int* num)
{
    luaL_checktype(L, index, LUA_TNUMBER);

    const lua_Number temp = lua_tonumber(L, index);

    if (!lua_rawequal(L, index, index) || (temp != (int)temp))
    {
        return luaL_error(L, "Invalid call. Bad value #%d.", index);
    }
    else
    {
        *num = (int)temp;
    }

    return 1;
}

LUACML_API int GetNumbersFromTable(lua_State* L, const int tab, lua_Number* vec, const int len,
                                   bool err_less, bool err_more)
{
    // Verify it's a table.
    luaL_checktype(L, tab, LUA_TTABLE);

    // Verify length of table.
    const int tablen = lua_rawlen(L, tab);

    if (err_less && tablen < len)
        return luaL_error(L, "Invalid call. Missing arguments.");
    else if (err_more && tablen > len)
        return luaL_error(L, "Invalid call. Too many arguments.");

    // Extract data.
    const int count = tablen < len ? tablen : len;
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

LUACML_API int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len,
                                      bool err_less, bool err_more)
{
    luaL_checktype(L, ud, LUA_TUSERDATA);
    lua_getfield(L, ud, "totable");
    luaL_checktype(L, -1, LUA_TFUNCTION);
    lua_pushvalue(L, ud);
    lua_call(L, 1, 1);
    luaL_checktype(L, -1, LUA_TTABLE);
    int count = Helper::GetNumbersFromTable(L, -1, vec, len, err_less, err_more);
    lua_pop(L, 1);
    return count;
}
}
