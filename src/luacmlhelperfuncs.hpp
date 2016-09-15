
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

#ifndef luacmlhelperfuncs_h__
#define luacmlhelperfuncs_h__

#include "luacml.hpp"

namespace Helper {
LUACML_API int ToTable(lua_State* L);
LUACML_API int GetNumberFromStack(lua_State* L, const int index, lua_Number* num);
LUACML_API int GetNumbersFromTable(lua_State* L, const int tab, lua_Number* vec, const int len,
                                   bool need_same_len);
LUACML_API int GetNumbersFromAnyUserdata(lua_State* L, const int ud, lua_Number* vec,
                                         const int len);
}

#endif // luacmlhelperfuncs_h__
