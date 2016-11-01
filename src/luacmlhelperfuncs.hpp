
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
int GetNumberFromStack(lua_State* L, const int index, lua_Number* num);
int GetIntegerFromStack(lua_State* L, const int index, int* num);
int GetNumbersFromTable(lua_State* L, const int tab, lua_Number* vec, const int len, bool err_less,
                        bool err_more);
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len,
                           bool err_less, bool err_more);

template < typename T, typename U >
int AssignFromUserdata(lua_State* L, const int ud, T* to)
{
    typedef typename U::Pointer UPointer;

    luaL_checktype(L, ud, LUA_TUSERDATA);
    if (const UPointer from = (UPointer)luaL_testudata(L, ud, U::UDATA_TYPE_NAME))
    {
        (*to) = (*from);
        return 1;
    }
    else
    {
        return 0;
    }
}

template < typename T >
int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len)
{
    typedef typename T::Pointer TPointer;

    if (lua_isuserdata(L, ud))
    {
        if (const TPointer v = (TPointer)luaL_testudata(L, ud, T::UDATA_TYPE_NAME))
        {
            // Copy as much as possible.
            const int count = std::min< int >(len, T::NUM_ELEMENTS);
            for (int i = 0; i < count; ++i)
            {
                vec[i] = (v->data())[i];
            }
            return count;
        }
        else
            return 0;
    }
    else
    {
        return luaL_error(L, "Expected quaternion userdata type.");
    }
}

template < typename T >
int ToTable(lua_State* L)
{
    typedef typename T::Pointer TPointer;

    CHECK_ARG_COUNT(L, 1);

    const TPointer v = (TPointer)luaL_checkudata(L, 1, T::UDATA_TYPE_NAME);

    lua_newtable(L);
    for (int i = 0; i < T::NUM_ELEMENTS; ++i)
    {
        lua_pushinteger(L, i + 1);
        lua_pushnumber(L, v->data()[i]);
        lua_rawset(L, -3);
    }
    return 1;
}
}

#endif // luacmlhelperfuncs_h__
