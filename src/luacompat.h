
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacompat.h
/// @date   09/02/2016
/// @author ctallman
///
/// @brief  Lua version compatibility functions.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacompat_h__
#define luacompat_h__

#include <lua.hpp>

#if LUA_VERSION_NUM == 501
void luaL_setfuncs(lua_State* L, const luaL_Reg* l, int nup);
void* luaL_testudata(lua_State* L, int ud, const char* tname);
#define lua_rawlen lua_objlen
#endif

#endif // luacompat_h__
