
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Chris Tallman. All rights reserved.
///
/// @file   luacmlvector2.cpp
/// @date   09/12/2016
/// @author ctallman
///
/// @brief  Lua CML Vector2.
///
////////////////////////////////////////////////////////////////////////////////

#include "luacml.h"

namespace Vector2 {
const char* UDATA_TYPE_NAME = "vector2";

int Print(lua_State* L)
{
    Pointer                 vec  = (Pointer)luaL_checkudata(L, -1, UDATA_TYPE_NAME);
    const Type::value_type* data = vec->data();

    lua_pushfstring(L, "%s:<%f,%f>", UDATA_TYPE_NAME, data[0], data[1]);
    return 1;
}

int New(lua_State* L)
{
    // Temporary vector to create result from.
    Type temp;
    temp.zero();

    // Construct new vector based on input arguments.
    switch (lua_gettop(L))
    {
    // Only 3 arguments allowed.
    default:
        return luaL_error(L, "Invalid call. Too many arguments.");

    // Default constructor:
    case 0:
        break;

    case 1:
        // From 1 number.
        if (lua_isnumber(L, 1))
        {
            // cml.vector2(1) --> vector2:<1,0>
            temp[0] = lua_tonumber(L, 1);
        }
        // From 1 array of numbers.
        else if (lua_istable(L, 1))
        {
            // Note: fall-through case statements below.
            switch (lua_rawlen(L, 1))
            {
            default:
                return luaL_error(L, "Invalid call. Too many arguments.");

            // cml.vector2({1,2}) --> vector2:<1,2>
            case 2:
                lua_rawgeti(L, 1, 2);
                temp[1] = luaL_checknumber(L, -1);
                lua_pop(L, 1);

            // cml.vector2({1}) --> vector2:<1,0>
            case 1:
                lua_rawgeti(L, 1, 1);
                temp[0] = luaL_checknumber(L, -1);
                lua_pop(L, 1);
                break;

            // cml.vector2({}) --> vector2:<0,0>
            case 0:
                break;
            }
        }
        // From 1 vector2, vector3, or vector4.
        else if (lua_isuserdata(L, 1))
        {
            // cml.vector2(cml.vector4(1,2,3,4)) --> vector2:<1,2>
            if (const Vector4::Pointer v4 =
                    (Vector4::Pointer)luaL_testudata(L, -1, Vector4::UDATA_TYPE_NAME))
            {
                temp[0] = (*v4)[0];
                temp[1] = (*v4)[1];
            }

            // cml.vector2(cml.vector3(1,2,3)) --> vector2:<1,2>
            else if (const Vector3::Pointer v3 =
                         (Vector3::Pointer)luaL_testudata(L, -1, Vector3::UDATA_TYPE_NAME))
            {
                temp[0] = (*v3)[0];
                temp[1] = (*v3)[1];
            }

            // cml.vector2(cml.vector2(1,2)) --> vector2:<1,2,0>
            else if (const Vector2::Pointer v2 =
                         (Vector2::Pointer)luaL_testudata(L, -1, Vector2::UDATA_TYPE_NAME))
            {
                temp[0] = (*v2)[0];
                temp[1] = (*v2)[1];
            }
        }
        break;

    case 2:
        // cml.vector2(1.0, 2.0) --> {1,2}
        if (lua_isnumber(L, 1) && lua_isnumber(L, 2))
        {
            temp[0] = lua_tonumber(L, 1);
            temp[1] = lua_tonumber(L, 2);
        }
        break;
    }

    Type* newvec = (Type*)lua_newuserdata(L, sizeof(Type));
    newvec->set(temp[0], temp[1]);

    return SetClass(L, UDATA_TYPE_NAME);
}

int Register(lua_State* L)
{
    static const luaL_Reg funcs[] = {
        // Metamethods
        {"__tostring", Print},

        // Sentinel
        {NULL, NULL},
    };

    return NewClass(L, UDATA_TYPE_NAME, funcs);
}
}
