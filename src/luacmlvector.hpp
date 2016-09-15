
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlvector.hpp
/// @date   09/15/2016
/// @author ctallman
///
/// @brief  Helper functions for vector2, vector3, and vector4.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlvector_hpp__
#define luacmlvector_hpp__

#include "luacml.hpp"

namespace Vector2 {
extern const char* UDATA_TYPE_NAME;
enum
{
    NUM_ELEMENTS = 2
};
typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
typedef Type  vector2;
typedef Type* Pointer;

int New(lua_State* L);
int Register(lua_State* L);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len);
}

namespace Vector3 {
extern const char* UDATA_TYPE_NAME;
enum
{
    NUM_ELEMENTS = 3
};
typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
typedef Type  vector3;
typedef Type* Pointer;

int New(lua_State* L);
int Register(lua_State* L);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len);
}

namespace Vector4 {
extern const char* UDATA_TYPE_NAME;
enum
{
    NUM_ELEMENTS = 4
};
typedef cml::vector< lua_Number, cml::fixed< NUM_ELEMENTS > > Type;
typedef Type  vector4;
typedef Type* Pointer;

int New(lua_State* L);
int Register(lua_State* L);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len);
}

#endif // luacmlvector_hpp__
