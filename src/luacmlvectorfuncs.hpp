
////////////////////////////////////////////////////////////////////////////////
///
/// @copyright Copyright (c) 2016 Mimic Technologies Inc. All rights reserved.
///
/// @file   luacmlvectorfuncs.hpp
/// @date   11/03/2016
/// @author ctallman
///
/// @brief  Non-member vector functions.
///
////////////////////////////////////////////////////////////////////////////////

#ifndef luacmlvectorfuncs_hpp__
#define luacmlvectorfuncs_hpp__

#include "luacml.hpp"
#include "luacmlhelperfuncs.hpp"

int Cross(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    Vector3::Pointer A = (Vector3::Pointer)luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME);
    Vector3::Pointer B = (Vector3::Pointer)luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME);
    Vector3::Pointer C = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
    *C                 = cml::cross(*A, *B);
    SetClass(L, Vector3::UDATA_TYPE_NAME);
    return 1;
}

template < typename T, typename U >
int TOuter(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename U::Pointer UPointer;
    typedef typename U::Type    UType;
    if (const TPointer A = (TPointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        TPointer B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
        UPointer C = (UPointer)lua_newuserdata(L, sizeof(UType));
        *C         = cml::outer(*A, *B);
        return SetClass(L, U::UDATA_TYPE_NAME);
    }
    return 0;
}

int Outer(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    if (TOuter< Vector4, Matrix44 >(L) || TOuter< Vector3, Matrix33 >(L) ||
        TOuter< Vector2, Matrix22 >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

int PerpDot(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const Vector2::Pointer A = (Vector2::Pointer)(luaL_checkudata(L, 1, Vector2::UDATA_TYPE_NAME));
    const Vector2::Pointer B = (Vector2::Pointer)(luaL_checkudata(L, 2, Vector2::UDATA_TYPE_NAME));
    lua_pushnumber(L, cml::perp_dot(*A, *B));
    return 1;
}

int TripleProduct(lua_State* L)
{
    CHECK_ARG_COUNT(L, 3);
    const Vector3::Pointer A = (Vector3::Pointer)(luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME));
    const Vector3::Pointer B = (Vector3::Pointer)(luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME));
    const Vector3::Pointer C = (Vector3::Pointer)(luaL_checkudata(L, 3, Vector3::UDATA_TYPE_NAME));
    lua_pushnumber(L, cml::triple_product(*A, *B, *C));
    return 1;
}

int UnitCross(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const Vector3::Pointer A = (Vector3::Pointer)(luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME));
    const Vector3::Pointer B = (Vector3::Pointer)(luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME));
    Vector3::Pointer       C = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
    *C                       = cml::unit_cross(*A, *B);
    SetClass(L, Vector3::UDATA_TYPE_NAME);
    return 1;
}

int CrossCardinal(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    if (lua_isuserdata(L, 1) && lua_isnumber(L, 2))
    {
        const Vector3::Pointer A =
            (Vector3::Pointer)(luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME));
        const lua_Number numaxis = luaL_checknumber(L, 2);
        const int        B       = static_cast< int >(numaxis);
        luaL_argcheck(L, (B >= 1 && B <= Vector3::NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (B == numaxis), 2, "not an integer");
        Vector3::Pointer C = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
        *C                 = cml::cross_cardinal(*A, B - 1);
        SetClass(L, Vector3::UDATA_TYPE_NAME);
        return 1;
    }
    else if (lua_isnumber(L, 1) && lua_isuserdata(L, 2))
    {
        const lua_Number numaxis = luaL_checknumber(L, 1);
        const int        A       = static_cast< int >(numaxis);
        luaL_argcheck(L, (A >= 1 && A <= Vector3::NUM_ELEMENTS), 2, NULL);
        luaL_argcheck(L, (A == numaxis), 2, "not an integer");
        const Vector3::Pointer B =
            (Vector3::Pointer)(luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME));
        Vector3::Pointer C = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
        *C                 = cml::cross_cardinal(A - 1, *B);
        SetClass(L, Vector3::UDATA_TYPE_NAME);
        return 1;
    }
    else
    {
        return luaL_argerror(L, 1, "Expected vector3 or number");
    }
}

template < typename T >
int TLengthSquared(lua_State* L)
{
    typedef typename T::Pointer Pointer;
    if (const Pointer A = (Pointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        lua_pushnumber(L, cml::length_squared(*A));
        return 1;
    }
    return 0;
}

int LengthSquared(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    if (TLengthSquared< Vector4 >(L) || TLengthSquared< Vector3 >(L) ||
        TLengthSquared< Vector2 >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

template < typename T >
int TLength(lua_State* L)
{
    typedef typename T::Pointer Pointer;
    if (const Pointer A = (Pointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        lua_pushnumber(L, cml::length(*A));
        return 1;
    }
    return 0;
}

int Length(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    if (TLength< Vector4 >(L) || TLength< Vector3 >(L) || TLength< Vector2 >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

template < typename T >
int TNormalize(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    if (const TPointer A = (TPointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        TPointer B = (TPointer)lua_newuserdata(L, sizeof(TType));
        *B         = cml::normalize(*A);
        return SetClass(L, T::UDATA_TYPE_NAME);
    }
    return 0;
}

int Normalize(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    if (TNormalize< Vector4 >(L) || TNormalize< Vector3 >(L) || TNormalize< Vector2 >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

template < typename T >
int TProjectToHPlane(lua_State* L)
{
    typedef typename T::Pointer TPointer;
    typedef typename T::Type    TType;
    if (const TPointer A = (TPointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        const TPointer B = (TPointer)(luaL_checkudata(L, 2, T::UDATA_TYPE_NAME));
        TPointer       C = (TPointer)lua_newuserdata(L, sizeof(TType));
        *C               = cml::project_to_hplane(*A, *B);
        return SetClass(L, T::UDATA_TYPE_NAME);
    }
    return 0;
}

int ProjectToHPlane(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    if (TProjectToHPlane< Vector4 >(L) || TProjectToHPlane< Vector3 >(L) ||
        TProjectToHPlane< Vector2 >(L))
        return 1;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

int Perp(lua_State* L)
{
    CHECK_ARG_COUNT(L, 1);
    const Vector2::Pointer A = (Vector2::Pointer)(luaL_checkudata(L, 1, Vector2::UDATA_TYPE_NAME));
    Vector2::Pointer       B = (Vector2::Pointer)lua_newuserdata(L, sizeof(Vector2::Type));
    *B                       = cml::perp(*A);
    SetClass(L, Vector2::UDATA_TYPE_NAME);
    return 1;
}

int RotateVector(lua_State* L)
{
    CHECK_ARG_COUNT(L, 3);
    const Vector3::Pointer A = (Vector3::Pointer)(luaL_checkudata(L, 1, Vector3::UDATA_TYPE_NAME));
    const Vector3::Pointer B = (Vector3::Pointer)(luaL_checkudata(L, 2, Vector3::UDATA_TYPE_NAME));
    const lua_Number       C = luaL_checknumber(L, 3);
    Vector3::Pointer       D = (Vector3::Pointer)lua_newuserdata(L, sizeof(Vector3::Type));
    *D                       = cml::rotate_vector(*A, *B, C);
    SetClass(L, Vector3::UDATA_TYPE_NAME);
    return 1;
}

int RotateVector2D(lua_State* L)
{
    CHECK_ARG_COUNT(L, 2);
    const Vector2::Pointer A = (Vector2::Pointer)(luaL_checkudata(L, 1, Vector2::UDATA_TYPE_NAME));
    const lua_Number       B = luaL_checknumber(L, 2);
    Vector2::Pointer       C = (Vector2::Pointer)lua_newuserdata(L, sizeof(Vector2::Type));
    *C                       = cml::rotate_vector_2D(*A, B);
    SetClass(L, Vector2::UDATA_TYPE_NAME);
    return 1;
}

template < typename T >
int TRandomUnit(lua_State* L)
{
    typedef typename T::Pointer TPointer;

    if (TPointer A = (TPointer)luaL_testudata(L, 1, T::UDATA_TYPE_NAME))
    {
        if (lua_gettop(L) == 1)
        {
            cml::random_unit(*A);
            return 1;
        }
        else if (lua_gettop(L) == 3)
        {
            const TPointer   B = (TPointer)luaL_checkudata(L, 2, T::UDATA_TYPE_NAME);
            const lua_Number C = luaL_checknumber(L, 3);
            cml::random_unit(*A, *B, C);
            return 1;
        }
        else
            return luaL_argerror(L, 2, "Expected (none) or same vector type as argument 1.");
    }
    else
        return 0;
}

int RandomUnit(lua_State* L)
{
    if (TRandomUnit< Vector2 >(L) || TRandomUnit< Vector3 >(L))
        return 0;
    else
        return luaL_argerror(L, 1, "Expected vector2, vector3, vector4");
}

#endif // luacmlvectorfuncs_hpp__
