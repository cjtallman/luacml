
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlquaternion.hpp
/// @date   09/15/2016
/// @author ctallman
///
/// @brief  Lua CML quaternion.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlquaternion_hpp__
#define luacmlquaternion_hpp__

#include "luacml.hpp"

namespace QuatPos {
extern const char* UDATA_TYPE_NAME;
enum
{
    NUM_ELEMENTS = 4
};
typedef cml::quaternion< lua_Number, cml::fixed<>, cml::vector_first, cml::positive_cross > Type;
typedef Type  quat_p;
typedef Type* Pointer;

int New(lua_State* L);
int Register(lua_State* L);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len);
}

namespace QuatNeg {
extern const char* UDATA_TYPE_NAME;
enum
{
    NUM_ELEMENTS = 4
};
typedef cml::quaternion< lua_Number, cml::fixed<>, cml::vector_first, cml::negative_cross > Type;
typedef Type  quat_n;
typedef Type* Pointer;

int New(lua_State* L);
int Register(lua_State* L);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len);
}

#endif // luacmlquaternion_hpp__
