
# Library Functions

--------------------------------------------------------------------------------

## dot()

The dot product can be performed for vector and quaternion types.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(1,2,3)
print(luacml.dot(foo, bar)) -- prints: 14
```

### Note

Only the following types are supported:

**Vectors**: `vector2`, `vector3`, `vector4`
**Quaternions**: `quat`, `quat_p`, `quat_n`

### Parameters

-   2 vectors of same type.
-   or 2 quaternions of same type.

### Returns

Returns the dot product as a number.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## cross()

The cross product can be performed for the `vector3` type.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(3,2,1)
print(luacml.cross(foo, bar)) -- prints: vector3:<-4,8,-4>
```
### Note

Only the `vector3` type supports cross product.

### Parameters

-   2 vectors of type `vector3`.

### Returns

Returns the cross product as a `vector3`.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## outer()

The outer product can be performed for vector types.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(3,2,1)
print(luacml.outer(foo, bar)) -- prints: matrix33:|3,2,1|6,4,2|9,6,3|
```

### Note

Only the following types are supported:

**Vectors**: `vector2`, `vector3`, `vector4`

### Parameters

-   2 vectors of same type.

### Returns

Returns the outer product as a matrix of size *NxN* for vectors of size *N*.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## perp_dot()

The perpendicular dot product can be performed for Vector2.

```lua
local left = luacml.vector2(1,2)
local right = luacml.vector2(3,4)
print(luacml.perp_dot(left, right)) -- prints: -2
```

### Note

Only the `vector2` type is supported.

The result is the dot product of `right` and the perpendicular vector to `left`.

### Parameters

-   2 `vector2`.

### Returns

Returns the perpendicular dot product of the two input vectors.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## triple_product()

The triple product can be performed for three `vector3` objects.

```lua
local A = luacml.vector3(1,2,3)
local B = luacml.vector3(4,5,6)
local C = luacml.vector3(7,8,9)
print(luacml.triple_product(A, B, C)) -- prints: 0
```

### Note

Only the `vector3` type is supported.

The result is equivalent to

```lua
luacml.dot(A, luacml.cross(B,C))
```

### Parameters

-   3 `vector3`.

### Returns

Returns the triple product of the three input vectors.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## unit_cross()

The normalized cross product between two `vector3`.

```lua
local A = luacml.vector3(10,0,0)
local B = luacml.vector3(0,10,0)
print(luacml.unit_cross(A, B)) -- prints: vector3:<0,0,1>
```

### Note

Only the `vector3` type is supported.

The result is equivalent to

```lua
luacml.cross(B,C):normalize()
```

### Parameters

-   2 `vector3`.

### Returns

Returns the normalized cross product of the two input vectors.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## cross_cardinal()

The cross product between a `vector3` and a cardinal axis.

```lua
local foo = luacml.vector3(1,2,3)
-- A cross X
print(luacml.cross_cardinal(A, 1)) -- prints: vector3:<0,3,-2>

-- A cross Y
print(luacml.cross_cardinal(A, 2)) -- prints: vector3:<-3,0,1>

-- A cross Z
print(luacml.cross_cardinal(A, 3)) -- prints: vector3:<2,-1,0>

-- X cross A
print(luacml.cross_cardinal(1, A)) -- prints: vector3:<0,-3,2>

-- Y cross A
print(luacml.cross_cardinal(2, A)) -- prints: vector3:<3,0,-1>

-- Z cross A
print(luacml.cross_cardinal(3, A)) -- prints: vector3:<-2,1,0>
```

### Note

Only the `vector3` type is supported.

Only the indices `1,2,3` are valid for cardinal axes.

### Parameters

-   1 `vector3`, and 1 integer between 1 and 3.
-   or 1 integer between 1 and 3, and 1 `vector3`.

### Returns

Returns the cross product between the input `vector3` and the cardinal axis that
corresponds to the input index.

### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------
