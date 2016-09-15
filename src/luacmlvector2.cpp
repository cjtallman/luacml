
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

#include "luacmlvector.hpp"
#include "luacmlhelperfuncs.hpp"

namespace Vector2 {
const char* UDATA_TYPE_NAME = "vector2";

int GetNumbersFromUserdata(lua_State* L, const int ud, lua_Number* vec, const int len)
{
    if (lua_isuserdata(L, ud))
    {
        if (const Pointer v = (Pointer)luaL_testudata(L, ud, UDATA_TYPE_NAME))
        {
            // Copy as much as possible.
            const int count = std::min< int >(len, NUM_ELEMENTS);
            for (int i = 0; i < count; ++i)
            {
                vec[i] = (*v)[i];
            }
            return count;
        }
        else
            return 0;
    }
    else
    {
        return luaL_error(L, "Expected userdata type.");
    }
}

int Print(lua_State* L)
{
    Pointer           vec  = (Pointer)luaL_checkudata(L, -1, UDATA_TYPE_NAME);
    const lua_Number* data = vec->data();

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
            Helper::GetNumberFromStack(L, 1, temp.data());
        }
        // From 1 array of numbers.
        else if (lua_istable(L, 1))
        {
            Helper::GetNumbersFromTable(L, 1, temp.data(), NUM_ELEMENTS, false);
        }
        // From 1 vector2, vector3, or vector4.
        else if (lua_isuserdata(L, 1))
        {
            const int result = Vector2::GetNumbersFromUserdata(L, 1, temp.data(), NUM_ELEMENTS) ||
                               Vector3::GetNumbersFromUserdata(L, 1, temp.data(), NUM_ELEMENTS) ||
                               Vector4::GetNumbersFromUserdata(L, 1, temp.data(), NUM_ELEMENTS);
            luaL_argcheck(L, result, 1, "Invalid call. Bad argument type.");
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
            Helper::GetNumberFromStack(L, 1, temp.data());
            Helper::GetNumberFromStack(L, 2, temp.data() + 1);
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

    // Check metatable first.
    lua_getmetatable(L, 1);
    lua_pushvalue(L, 2);
    lua_rawget(L, -2);

    // If metatable included value, then return it.
    if (!lua_isnil(L, -1))
    {
        return 1;
    }
    // Try indexing vector instead.
    else
    {
        // Pop rawget result and metatable.
        lua_pop(L, 2);
    }

    // Check valid types.
    if (lua_isnumber(L, 2))
    {
        const lua_Number numkey = luaL_checknumber(L, 2);
        const int        key    = static_cast< int >(numkey);
        luaL_argcheck(L, (key >= 1 && key <= NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (key == numkey), 2, "index not integer");

        const lua_Number val = (*vec)[key - 1];
        lua_pushnumber(L, val);
        return 1;
    }
    else if (lua_isstring(L, 2))
    {
        static const char* valid[] = {"x", "y", "X", "Y", NULL};
        const int          key     = luaL_checkoption(L, 2, NULL, valid) % NUM_ELEMENTS;
        const lua_Number   val     = (*vec)[key];
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
        const int        key    = static_cast< int >(numkey);
        luaL_argcheck(L, (key >= 1 && key <= NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (key == numkey), 2, "index not integer");

        const lua_Number val = luaL_checknumber(L, 3);
        (*vec)[key - 1]      = val;
        return 0;
    }
    else if (lua_isstring(L, 2))
    {
        static const char* valid[] = {"x", "y", "X", "Y", NULL};
        const int          key     = luaL_checkoption(L, 2, NULL, valid) % NUM_ELEMENTS;
        const lua_Number   val     = luaL_checknumber(L, 3);
        (*vec)[key]                = val;
        return 0;
    }
    else
    {
        return luaL_error(L, "Invalid call. Bad argument type.");
    }

    return 0;
}

int Length(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    lua_pushnumber(L, vec->length());
    return 1;
}

int LengthSquared(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    lua_pushnumber(L, vec->length_squared());
    return 1;
}

int Normalize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    vec->normalize();
    return 1;
}

int Zero(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    vec->zero();
    return 1;
}

int Cardinal(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    Pointer   vec   = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    const int num   = luaL_checknumber(L, 2);
    const int index = static_cast< int >(num);
    luaL_argcheck(L, (index > 0) && (index <= NUM_ELEMENTS), 2, "Index (1-based) out of range.");
    vec->cardinal(index);
    lua_pop(L, 1); // Pop index, leave vector.
    return 1;
}

int Minimize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec1 = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    Pointer vec2 = (Pointer)luaL_checkudata(L, 2, UDATA_TYPE_NAME);
    vec1->minimize(*vec2);
    return 0;
}

int Maximize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    Pointer vec1 = (Pointer)luaL_checkudata(L, 1, UDATA_TYPE_NAME);
    Pointer vec2 = (Pointer)luaL_checkudata(L, 2, UDATA_TYPE_NAME);
    vec1->maximize(*vec2);
    return 0;
}

int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print},
        {"__index", Index},
        {"__newindex", NewIndex},

        // Methods
        {"totable", Helper::ToTable},
        {"length", Length},
        {"length_squared", LengthSquared},
        {"normalize", Normalize},
        {"zero", Zero},
        {"cardinal", Cardinal},
        {"minimize", Minimize},
        {"maximize", Maximize},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, UDATA_TYPE_NAME, funcs);
}
}
