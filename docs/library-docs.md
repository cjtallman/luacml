
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
