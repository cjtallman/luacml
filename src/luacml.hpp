
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacml.h
/// @date   09/12/2016
/// @author ctallman
///
/// @brief  Lua bindings for the CML math library.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacml_h__
#define luacml_h__

#include "luacompat.h"
#include <cml/cml.h>

#define STRINGIFY(x) #x
#define EXP_ARG_STR(N) "expected exactly " STRINGIFY(N) " arguments(s)."
#define CHECK_ARG_COUNT(L, N) luaL_argcheck(L, (lua_gettop(L) == N), lua_gettop(L), EXP_ARG_STR(N))
#define LUACML_API extern "C"

int NewClass(lua_State* L, const char* TYPE_NAME, const luaL_Reg* funcs);
int SetClass(lua_State* L, const char* TYPE_NAME);
int PrintClass(lua_State* L);

#endif // luacml_h__
