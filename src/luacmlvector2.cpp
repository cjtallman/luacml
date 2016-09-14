
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlvector2.cpp
/// @date   09/12/2016
/// @author ctallman
///
/// @brief  Lua CML vector2.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacml.h"

namespace Vector2 {
const char* UDATA_TYPE_NAME = "vector2";

int GetNumberFromStack(lua_State* L, const int index, lua_Number& num)
{
    luaL_checktype(L, index, LUA_TNUMBER);

    num = lua_tonumber(L, index);
    if (!lua_rawequal(L, index, index))
    {
        return luaL_error(L, "Invalid call. Bad value #%d.", index);
    }

    return 1;
}

int GetNumbersFromStack(lua_State* L, const int start, const int num, Type& vec)
{
    int count = 0;
    for (int i = 0; i < num; ++i)
    {
        count += GetNumberFromStack(L, start + i, vec[i]);
    }
    return count;
}

int GetNumbersFromTable(lua_State* L, const int tab, Type& vec)
{
    // Verify it's a table.
    luaL_checktype(L, tab, LUA_TTABLE);

    // Verify length of table.
    const int len = lua_rawlen(L, tab);
    if (len > NUM_ELEMENTS)
    {
        return luaL_error(L, "Invalid call. Too many arguments.");
    }

    // Extract data.
    for (int i = 0; i < len; ++i)
    {
        lua_rawgeti(L, tab, i + 1);
        vec[i] = luaL_checknumber(L, -1);
        if (!lua_rawequal(L, -1, -1))
        {
            return luaL_error(L, "Invalid call. Bad value #%d.", i + 1);
        }
        lua_pop(L, 1);
    }

    return len;
}

int GetNumbersFromUserdata(lua_State* L, int ud, Type& vec)
{
    if (lua_isuserdata(L, ud))
    {
        // cml.vector2(cml.vector4(1,2,3,4)) --> vector2:<1,2>
        if (const Vector4::Pointer v4 =
                (Vector4::Pointer)luaL_testudata(L, ud, Vector4::UDATA_TYPE_NAME))
        {
            vec[0] = (*v4)[0];
            vec[1] = (*v4)[1];
            lua_pop(L, 1);
            return std::min<int>(NUM_ELEMENTS, Vector4::NUM_ELEMENTS);
        }

        // cml.vector2(cml.vector3(1,2,3)) --> vector2:<1,2>
        else if (const Vector3::Pointer v3 =
                     (Vector3::Pointer)luaL_testudata(L, ud, Vector3::UDATA_TYPE_NAME))
        {
            vec[0] = (*v3)[0];
            vec[1] = (*v3)[1];
            lua_pop(L, 1);
            return std::min<int>(NUM_ELEMENTS, Vector3::NUM_ELEMENTS);
        }

        // cml.vector2(cml.vector2(1,2)) --> vector2:<1,2>
        else if (const Vector2::Pointer v2 =
                     (Vector2::Pointer)luaL_testudata(L, -1, Vector2::UDATA_TYPE_NAME))
        {
            vec[0] = (*v2)[0];
            vec[1] = (*v2)[1];
            lua_pop(L, 1);
            return std::min<int>(NUM_ELEMENTS, Vector2::NUM_ELEMENTS);
        }
    }

    return luaL_error(L, "Invalid call. Bad argument type.");
}

int Print(lua_State* L)
{
    Pointer                 vec  = (Pointer)luaL_checkudata(L, -1, UDATA_TYPE_NAME);
    const Type::value_type* data = vec->data();

    lua_pushfstring(L, "%s:<%f,%f>", UDATA_TYPE_NAME, data[0], data[1]);
    return 1;
}

int New(lua_State* L)
{
    const int nargs = lua_gettop(L);

    // Temporary vector to create result from.
    Type temp;
    temp.zero();

    luaL_argcheck(L, (nargs <= NUM_ELEMENTS), NUM_ELEMENTS + 1, "Too many arguments.");

    // Construct new vector based on input arguments.
    switch (nargs)
    {
    // Only 2 arguments allowed.
    default:
        return luaL_error(L, "Invalid call.");

    // Default constructor:
    case 0:
        break;

    case 1:
        // From 1 number.
        if (lua_isnumber(L, 1))
        {
            // cml.vector2(1) --> vector2:<1,0>
            GetNumbersFromStack(L, 1, 1, temp);
        }
        // From 1 array of numbers.
        else if (lua_istable(L, 1))
        {
            GetNumbersFromTable(L, 1, temp);
        }
        // From 1 vector2, vector3, or vector4.
        else if (lua_isuserdata(L, 1))
        {
            GetNumbersFromUserdata(L, 1, temp);
        }
        // Not one of the supported input types.
        else
        {
            return luaL_error(L, "Invalid call. Invalid argument.");
        }
        break;

    case 2:
        // cml.vector2(1.0, 2.0) --> vector2:<1,2>
        if (lua_isnumber(L, 1) && lua_isnumber(L, 2))
        {
            GetNumbersFromStack(L, 1, 2, temp);
        }
        else
        {
            // Generate error message.
            luaL_checknumber(L, 1);
            luaL_checknumber(L, 2);
            return luaL_error(L, "Invalid call. Bad argument type.");
        }
        break;
    }

    Pointer newvec = (Pointer)lua_newuserdata(L, sizeof(Type));
    (*newvec)      = temp;

    return SetClass(L, UDATA_TYPE_NAME);
}

int Index(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);

    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);

    // Check valid types.
    if (lua_isnumber(L, 2))
    {
        const lua_Number numkey = luaL_checknumber(L, 2);
        const int        key    = static_cast<int>(numkey);
        luaL_argcheck(L, (key >= 1 && key <= NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (key == numkey), 2, "index not integer");

        const Type::value_type& val = (*vec)[key - 1];
        lua_pushnumber(L, val);
        return 1;
    }
    else if (lua_isstring(L, 2))
    {
        static const char*      valid[] = {"x", "y", "X", "Y", NULL};
        const int               key     = luaL_checkoption(L, 2, NULL, valid) % NUM_ELEMENTS;
        const Type::value_type& val     = (*vec)[key];
        lua_pushnumber(L, val);
        return 1;
    }
    else
    {
        return luaL_error(L, "Invalid call. Bad argument type.");
    }

    return 0;
}

int NewIndex(lua_State* L)
{
    CHECK_ARG_COUNT(L, 3);

    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);

    // Check valid types.
    if (lua_isnumber(L, 2))
    {
        const lua_Number numkey = luaL_checknumber(L, 2);
        const int        key    = static_cast<int>(numkey);
        luaL_argcheck(L, (key >= 1 && key <= NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (key == numkey), 2, "index not integer");

        const Type::value_type val = luaL_checknumber(L, 3);
        (*vec)[key - 1]            = val;
        return 0;
    }
    else if (lua_isstring(L, 2))
    {
        static const char*     valid[] = {"x", "y", "X", "Y", NULL};
        const int              key     = luaL_checkoption(L, 2, NULL, valid) % NUM_ELEMENTS;
        const Type::value_type val     = luaL_checknumber(L, 3);
        (*vec)[key]                    = val;
        return 0;
    }
    else
    {
        return luaL_error(L, "Invalid call. Bad argument type.");
    }

    return 0;
}

int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print},
        {"__index", Index},
        {"__newindex", NewIndex},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, UDATA_TYPE_NAME, funcs);
}
}
