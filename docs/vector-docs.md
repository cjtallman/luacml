
# Vectors

## Vector types

The following vector types are provided by LuaCML:

| Type      | Description                                  |
|-----------|----------------------------------------------|
| `vector2` | A two-element vector based on `lua_Number`   |
| `vector3` | A three-element vector based on `lua_Number` |
| `vector4` | A four-element vector based on `lua_Number`  |

## Vector functions

### constructor

Vectors have default constructors initialized with zeros:

```lua
local foo = luacml.vector3() -- set to (0,0,0)
```

Vectors can be constructed from individual numbers:

```lua
local foo = luacml.vector4(1,2,3,4)
```

Or from a table of numbers:

```lua
local foo = luacml.vector2({1,2})
```

Or from another vector:

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(foo) -- set to (1,2,3)
```

#### Parameters

-   ***N*** numbers.
-   or table of ***N*** numbers.
-   or a vector of size ***N***.

#### Returns

The newly constructed vector.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### set()

Vectors can be set from individual numbers:

```lua
local foo = luacml.vector3()
foo:set(1,2,3)
```

Or from a table of numbers:

```lua
local foo = luacml.vector3()
foo:set({1,2,3})
```

Or from another vector:

```lua
local foo = luacml.vector3()
foo:set(luacml.vector3(1,2,3))
```

#### Parameters

-   ***N*** numbers.
-   or table of ***N*** numbers.
-   or a vector of size ***N***.

#### Returns

The vector, after it has been set.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### totable()

Vectors can be converted to a table:

```lua
local foo = luacml.vector3(1,2,3)
local bar = foo:totable()
print(bar[1], bar[2], bar[3]) -- prints: 1 2 3
```

#### Parameters

(None)

#### Returns

An array containing the vector's elements.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### length()

The length of a vector can be found:

```lua
local foo = luacml.vector3(1,2,3)
print(foo:length())
```

#### Parameters

(None)

#### Returns

The vector's length as a number.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### length_squared()

The squared-length of a vector can be found:

```lua
local foo = luacml.vector3(1,2,3)
print(foo:length_squared())
```

#### Parameters

(None)

#### Returns

The vector's squared length as a number.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### normalize()

A vector can be normalized in-place:

```lua
local foo = luacml.vector3(1,2,3)
foo:normalize()
```

#### Parameters

(None)

#### Returns

The vector, after it has been normalized.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### zero()

A vector can be zeroed in-place:

```lua
local foo = luacml.vector3(1,2,3)
foo:zero()
```

#### Parameters

(None)

#### Returns

The vector, after it has been zeroed.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### cardinal()

A vector can be set to a cardinal axis:

```lua
local foo = luacml.vector3(1,2,3)
foo:cardinal(1) -- sets to <1,0,0>
foo:cardinal(2) -- sets to <0,1,0>
foo:cardinal(3) -- sets to <0,0,1>
```

#### Parameters

An integer from 1 to **N** for a vector of size **N**.

#### Returns

The vector, after it has been set.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### minimize()

A vector can be set to the element-wise minimum of itself and another vector.

```lua
local foo = luacml.vector3(10,20,30)
local bar = luacml.vector3(1,200,29)
foo:minimize(bar) -- sets to <1,20,29>
```

#### Parameters

A vector of same size.

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### maximize()

A vector can be set to the element-wise maximum of itself and another vector.

```lua
local foo = luacml.vector3(10,20,30)
local bar = luacml.vector3(1,200,29)
foo:maximize(bar) -- sets to <10,200,30>
```

#### Parameters

A vector of same size.

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### random()

A vector can be set to a random vector with elements between specified minimum
and maximum values.

```lua
local foo = luacml.vector3()
foo:random(-1,1) -- sets each element to a random value between -1 and 1.
```

#### Parameters

-   The minimum number.
-   The maximum number.

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### add()

A vector can be added with another vector.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(1,2,3)
print(foo:add(bar)) -- prints: vector3:<2,4,6>
print(foo)          -- prints: vector3:<1,2,3>
```

#### Note

The original vectors are unchanged.

Internally, this equivalent to the [__add](#__add) metamethod.

#### Parameters

A vector of same type.

#### Returns

A new vector representing the element-wise sum.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### sub()

A vector can be added with another vector.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(1,2,3)
print(foo:sub(bar)) -- prints: vector3:<0,0,0>
print(foo)          -- prints: vector3:<1,2,3>
```

#### Note

The original vectors are unchanged.

Internally, this function is equivalent to the [__sub](#__sub) metamethod.

#### Parameters

A vector of same type.

#### Returns

A new vector representing the element-wise difference.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### mul()

A vector can be scaled with a number.

```lua
local foo = luacml.vector3(1,2,3)
print(foo:mul(2)) -- prints: vector3:<2,4,6>
print(foo)        -- prints: vector3:<1,2,3>
```

#### Note

The original vector is unchanged.

Internally, this function is equivalent to the [__mul](#__mul) metamethod.

#### Parameters

A scalar number.

#### Returns

A new vector representing the element-wise scale.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### div()

A vector can be inverse-scaled with a number.

```lua
local foo = luacml.vector3(2,4,6)
print(foo:div(2)) -- prints: vector3:<1,2,3>
print(foo)        -- prints: vector3:<2,4,6>
```

#### Note

The original vector is unchanged.

Internally, this function is equivalent to the [__div](#__div) metamethod.

#### Parameters

A scalar number.

#### Returns

A new vector representing the element-wise division.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### addeq()

A vector can be incremented in-place with another vector.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(1,2,3)
print(foo:addeq(bar)) -- prints: vector3:<2,4,6>
print(foo)            -- prints: vector3:<2,4,6>
```

#### Note

The original vector (not the parameter) is updated.

#### Parameters

A vector of same type.

#### Returns

The updated vector after the element-wise sum.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### subeq()

A vector can be subtracted in-place with another vector.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(1,2,3)
print(foo:subeq(bar)) -- prints: vector3:<0,0,0>
print(foo)            -- prints: vector3:<0,0,0>
```

#### Note

The original vector (not the parameter) is updated.

#### Parameters

A vector of same type.

#### Returns

The updated vector after the element-wise subtraction.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### muleq()

A vector can be scaled in-place with a number.

```lua
local foo = luacml.vector3(1,2,3)
print(foo:muleq(2)) -- prints: vector3:<2,4,6>
print(foo)          -- prints: vector3:<2,4,6>
```

#### Note

The original vector (not the parameter) is updated.

#### Parameters

A scalar number.

#### Returns

The updated vector after the element-wise multiplication.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### diveq()

A vector can be inverse-scaled with a number.

```lua
local foo = luacml.vector3(2,4,6)
print(foo:diveq(2)) -- prints: vector3:<1,2,3>
print(foo)          -- prints: vector3:<1,2,3>
```

#### Note

The original vector (not the parameter) is updated.

#### Parameters

A scalar number.

#### Returns

The updated vector after the element-wise division.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## Vector metamethods

All vector types have a set of
[metamethods](http://www.lua.org/manual/5.3/manual.html#2.4) that allow them to
be used with several operators.

--------------------------------------------------------------------------------

### __index

The __index metamethod permits vector element access.

Vectors can be indexed with 1-based integer keys:

```lua
local foo = luacml.vector2(10,20)
print(foo[1]) -- prints: 10
```

Or with case-insensitive "x", "y", "z", or "w" string keys:

```lua
local foo = luacml.vector3(10,20,30)
print(foo.x)    -- prints: 10
print(foo.Y)    -- prints: 20
print(foo["z"]) -- prints: 30
```

#### Note

For the following vector types, only the following keys are valid:

| Vector Type | Valid Keys             |
|-------------|------------------------|
| `vector2`   | 1, 2, x, y             |
| `vector3`   | 1, 2, 3, x, y, z       |
| `vector4`   | 1, 2, 3, 4, x, y, z, w |

#### Parameters

-   An integer from 1 to ***N***
-   or one of {x, y, z, w}, depending on vector size. See note above.

#### Returns

The vector's element as a number.

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.

--------------------------------------------------------------------------------

### __newindex

The __newindex metamethod permits vector element setting.

Vectors can be indexed with 1-based integer keys:

```lua
local foo = luacml.vector2()
foo[1] = 10
```

Or with case-insensitive "x", "y", "z", or "w" string keys:

```lua
local foo = luacml.vector3()
foo.x = 10
foo.Y = 20
foo["z"] = 30
```

#### Note

For the following vector types, only the following keys are valid:

| Vector Type | Valid Keys             |
|-------------|------------------------|
| `vector2`   | 1, 2, x, y             |
| `vector3`   | 1, 2, 3, x, y, z       |
| `vector4`   | 1, 2, 3, 4, x, y, z, w |

#### Parameters

-   An integer from 1 to ***N***
-   or one of {x, y, z, w}, depending on vector size. See note above.

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.

--------------------------------------------------------------------------------

### __tostring

Vectors can be converted to strings for easy printing.

```lua
local foo = luacml.vector2(1,2)
print(foo) -- prints: vector2:<1,2>
```

```lua
local foo = luacml.vector4(1,2,3,4)
print(foo) -- prints: vector4:<1,2,3,4>
```

#### Note

This function internally uses `lua_pushfstring` to format the output, so be
aware of different formatting across versions of Lua.

#### Parameters

A vector.

#### Returns

The vector formatted as a string.

#### Errors

(None)

--------------------------------------------------------------------------------

### __unm

The negative of a vector can be generated.

```lua
local foo = luacml.vector3(1,2,-3)
print(-foo) -- prints: vector3:<-1,-2,3>
```

#### Note

The original vector is unchanged.

#### Parameters

A vector.

#### Returns

A new vector representing the negative of the original.

#### Errors

(None)

--------------------------------------------------------------------------------

### __add

Two vectors can be added together.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(3,2,1)
print(foo + bar) -- prints: vector3<4,4,4>
```

#### Note

The original vectors are unchanged.

#### Parameters

Two vectors of same type.

#### Returns

A new vector representing the element-wise sum.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __sub

Two vectors can be subtracted.

```lua
local foo = luacml.vector3(1,2,3)
local bar = luacml.vector3(3,2,1)
print(foo - bar) -- prints: vector3<-2,0,2>
```

#### Note

The original vectors are unchanged.

#### Parameters

Two vectors of same type.

#### Returns

A new vector representing the element-wise difference.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __mul

Vectors can be scaled.

```lua
local foo = luacml.vector3(1,2,3)
print(2.0 * foo) -- prints: vector3<2,4,6>
print(foo * 3.0) -- prints: vector3<3,6,9>
```

#### Note

The original vector is unchanged.

#### Parameters

A vector and a number, in either order.

#### Returns

A new vector representing the element-wise scale.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __div

Vectors can be inverse divided.

```lua
local foo = luacml.vector3(2,4,6)
print(foo / 2.0) -- prints: vector3<1,2,3>
```

#### Note

The original vector is unchanged.

#### Parameters

A vector and a number.

#### Returns

A new vector representing the element-wise division.

#### Errors

-   Invalid types.


--------------------------------------------------------------------------------

### __eq

Vectors can be compared.

```lua
local foo = luacml.vector3(2,4,6)
local bar = luacml.vector3(2,4,6)
print(foo == bar) -- prints: true
```

#### Note

The original vectors are unchanged.

#### Parameters

Two vectors of same type.

#### Returns

Boolean represent element-wise equality.

#### Errors

-   Invalid types.
