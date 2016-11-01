
# Quaternions

## Quaternion types

The following quaternion types are provided by LuaCML:

| Type     | Description                                                       |
|----------|-------------------------------------------------------------------|
| `quat`   | A scalar-first, positive cross quaternion based on `lua_Number`   |
| `quat_p` | A vector-first, positive cross quaternion based on `lua_Number`   |
| `quat_n` | A vector-first, negative cross quaternion based on `lua_Number`   |


### Note:

The `quat` type is a scalar-first quaternion, ie: (w,x,y,z).

The `quat_p` and `quat_n` types are vector-first quaternions, ie: (x,y,z,w).

The `quat_p` (or positive cross) type determines the multiplication order of two
quaternions in "standard" form. A multiplication of `q1*q2` represents the
rotation of `q2` applied first, followed by `q1`.

The `quat_n` (or negative cross) type determines the multiplication order of two
quaternions in "reverse" form. A multiplication of `q1*q2` represents the
rotation of `q1` applied first, followed by `q2`.

## Quaternion functions

### constructor

Quaternions have default constructors initialized with identity:

```lua
local foo = luacml.quat()   -- set to (1,0,0,0)
local bar = luacml.quat_p() -- set to (0,0,0,1)
local baz = luacml.quat_n() -- set to (0,0,0,1)
```

Quaternions can be constructed from individual numbers:

```lua
local foo = luacml.quat(1,2,3,4)   -- set to (1,2,3,4)
local bar = luacml.quat_p(1,2,3,4) -- set to (1,2,3,4)
local baz = luacml.quat_n(1,2,3,4) -- set to (1,2,3,4)
```

Or from a table of numbers:

```lua
local foo = luacml.quat({1,2,3,4})   -- set to (1,2,3,4)
local bar = luacml.quat_p({1,2,3,4}) -- set to (1,2,3,4)
local baz = luacml.quat_n({1,2,3,4}) -- set to (1,2,3,4)
```

Or from a `vector4`:

```lua
local foo = luacml.quat(luacml.vector4(1,2,3,4))   -- set to (1,2,3,4)
local bar = luacml.quat_p(luacml.vector4(1,2,3,4)) -- set to (1,2,3,4)
local baz = luacml.quat_n(luacml.vector4(1,2,3,4)) -- set to (1,2,3,4)
```

Or from a table and a number (or a number and a table):

```lua
local foo = luacml.quat(1, {2,3,4}) -- set to (1,2,3,4)
local bar = luacml.quat({2,3,4}, 1) -- set to (1,2,3,4)
```

Or from a `vector3` and a number (or a number and a `vector3`):

```lua
local foo = luacml.quat(luacml.vector3(2,3,4), 1) -- set to (1,2,3,4)
local bar = luacml.quat(1, luacml.vector3(2,3,4)) -- set to (1,2,3,4)
```

Or from another quaternion of same type:

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(foo) -- set to (1,2,3,4)
```

#### Parameters

-   4 numbers.
-   or 1 table of 4 numbers.
-   or 1 `vector4`.
-   or 1 table of 3 numbers and 1 number.
-   or 1 number and a table of 3 numbers.
-   or 1 `vector3` and 1 number.
-   or 1 number and 1 `vector3`.
-   or 1 quaternion of same type.

#### Returns

The newly constructed quaternion.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### set()

Quaternions can be set from individual numbers:

```lua
local foo = luacml.quat()
foo:set(1,2,3,4) -- set to (1,2,3,4)
```

Or from a table of numbers:

```lua
local foo = luacml.quat()
foo:set({1,2,3,4}) -- set to (1,2,3,4)
```

Or from a `vector4`:

```lua
local foo = luacml.quat_p()
foo:set(luacml.vector4(1,2,3,4)) -- set to (1,2,3,4)
```

Or from a table and a number (or a number and a table):

```lua
local foo = luacml.quat_p()
foo:set({2,3,4}, 1) -- set to (2,3,4,1)
foo:set(1, {2,3,4}) -- set to (2,3,4,1)
```

Or from a `vector3` and a number (or a number and a `vector3`):

```lua
local foo = luacml.quat_n()
foo:set(luacml.vector3(1,2,3), 4) -- set to (1,2,3,4)
foo:set(4, luacml.vector3(1,2,3)) -- set to (1,2,3,4)
```

Or from another quaternion of same type:

```lua
local foo = luacml.quat_n()
foo:set(luacml.quat_n(1,2,3,4)) -- set to (1,2,3,4)
```

#### Parameters

-   4 numbers.
-   or 1 table of 4 numbers.
-   or 1 `vector4`.
-   or 1 table of 3 numbers and 1 number.
-   or 1 number and a table of 3 numbers.
-   or 1 `vector3` and 1 number.
-   or 1 number and 1 `vector3`.
-   or 1 quaternion of same type.

#### Returns

The quaternion, after it has been set.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### totable()

Quaternions can be converted to a table:

```lua
local foo = luacml.quat_p(1,2,3,4)
local bar = foo:totable()
print(bar[1], bar[2], bar[3], bar[4]) -- prints: 1 2 3 4
```

#### Parameters

(None)

#### Returns

An array containing the quaternion's elements.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### length()

The length of a quaternion can be found:

```lua
local foo = luacml.quat_p(1,2,3,4)
print(foo:length()) -- prints: 5.4772255750517
```

#### Parameters

(None)

#### Returns

The quaternion's length as a number.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### length_squared()

The squared-length of a quaternion can be found:

```lua
local foo = luacml.quat_p(1,2,3,4)
print(foo:length_squared()) -- prints: 30
```

#### Parameters

(None)

#### Returns

The quaternion's squared length as a number.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### normalize()

A quaternion can be normalized in-place:

```lua
local foo = luacml.quat_p(1,1,1,1)
foo:normalize() -- set to (0.5,0.5,0.5,0.5)
```

#### Parameters

(None)

#### Returns

The quaternion, after it has been normalized.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### inverse()

A quaternion can be set to its inverse:

```lua
local foo = luacml.quat_p(1,1,1,1)
foo:inverse() -- set to (-0.25,-0.25,-0.25,0.25)
```

#### Parameters

(None)

#### Returns

The quaternion, after it has been inverted.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### conjugate()

A quaternion can be set to its conjugate:

```lua
local foo = luacml.quat_p(1,1,1,1)
foo:conjugate() -- set to (-1,-1,-1,1)
```

#### Parameters

(None)

#### Returns

The quaternion, after it has been set to its conjugate.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### identity()

A quaternion can be set to its identity:

```lua
local foo = luacml.quat_p(1,2,3,4)
foo:identity() -- set to (0,0,0,1)

local bar = luacml.quat(1,2,3,4)
bar:identity() -- set to (1,0,0,0)
```

#### Parameters

(None)

#### Returns

The quaternion, after it has been set to its identity.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### random()

A quaternion can be set to a random quaternion with elements between specified
minimum and maximum values.

```lua
local foo = luacml.quat()
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

### imaginary()

A quaternion's imaginary/vector part can be retrieved.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat_p(1,2,3,4)
print(foo:imaginary()) -- prints: vector3:<2,3,4>
print(bar:imaginary()) -- prints: vector3:<1,2,3>
```

#### Parameters

(None)

#### Returns

Returns a `vector3` representing the imaginary (**i,j,k**) or (**x,y,z**)
components.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### real()

A quaternion's real/scalar part can be retrieved.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat_p(1,2,3,4)
print(foo:real()) -- prints: 1
print(bar:real()) -- prints: 4
```

#### Parameters

(None)

#### Returns

Returns a number representing the real (**w**) component.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### add()

A quaternion can be added with another quaternion of same type.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(1,2,3,4)
print(foo:add(bar)) -- prints: quat:<2,4,6,8>
print(foo)          -- prints: quat:<1,2,3,4>
```

#### Note

The original quaternions are unchanged.

Internally, this equivalent to the [__add](#__add) metamethod.

#### Parameters

A quaternion of same type.

#### Returns

A new quaternion representing the element-wise sum.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### sub()

A quaternion can be subtracted from another quaternion.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(1,2,3,4)
print(foo:sub(bar)) -- prints: quat:<0,0,0,0>
print(foo)          -- prints: quat:<1,2,3,4>
```

#### Note

The original quaternions are unchanged.

Internally, this function is equivalent to the [__sub](#__sub) metamethod.

#### Parameters

A quaternion of same type.

#### Returns

A new quaternion representing the element-wise difference.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### mul()

A quaternion can multiplied with another quaternion or with a number.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(4,3,2,1)
print(foo:mul(bar)) -- prints: quat:<-12,6,24,12>
```

```lua
local foo = luacml.quat_p(1,2,3,4)
local bar = luacml.quat_p(4,3,2,1)
print(foo:mul(bar)) -- prints: quat_p:<12,24,6,-12>
```

```lua
local foo = luacml.quat_n(1,2,3,4)
local bar = luacml.quat_n(4,3,2,1)
print(foo:mul(bar)) -- prints: quat_n:<22,4,16,-12>
```

```lua
local foo = luacml.quat_p(1,2,3,4)
print(foo:mul(2)) -- prints: quat_p:<2,4,6,8>
```

#### Note

The original quaternion(s) are unchanged.

Internally, this function is equivalent to the [__mul](#__mul) metamethod.

#### Parameters

-   1 scalar number.
-   or 1 quaternion of same type.

#### Returns

A new quaternion representing the multiplication result.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### div()

A quaternion can be can be divided by a number.

```lua
local foo = luacml.quat_n(2,4,6,8)
print(foo:div(2)) -- prints: quat_n:<1,2,3,4>
print(foo)        -- prints: quat_n:<2,4,6,8>
```

#### Note

The original quaternion is unchanged.

Internally, this function is equivalent to the [__div](#__div) metamethod.

#### Parameters

-   1 scalar number.

#### Returns

A new quaternion representing the element-wise division.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### addeq()

A quaternion can be incremented in-place with another quaternion.

```lua
local foo = luacml.quat_n(1,2,3,4)
local bar = luacml.quat_n(1,2,3,4)
print(foo:addeq(bar)) -- prints: quat_n:<2,4,6,8>
print(foo)            -- prints: quat_n:<2,4,6,8>
```

#### Note

The original quaternion (but not the input parameter) is updated.

#### Parameters

-   1 quaternion of same type.

#### Returns

The updated quaternion after the element-wise sum.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### subeq()

A quaternion can be subtracted in-place with another quaternion.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(1,2,3,4)
print(foo:subeq(bar)) -- prints: quat:<0,0,0,0>
print(foo)            -- prints: quat:<0,0,0,0>
```

#### Note

The original quaternion (but not the parameter) is updated.

#### Parameters

-   1 quaternion of same type.

#### Returns

The updated quaternion after the element-wise subtraction.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### muleq()

A quaternion can be multiplied in-place with another quaternion or a number.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(4,3,2,1)
print(foo:muleq(bar)) -- prints: quat:<-12,6,24,12>
print(foo)            -- prints: quat:<-12,6,24,12>
```

```lua
local foo = luacml.quat_p(1,2,3,4)
local bar = luacml.quat_p(4,3,2,1)
print(foo:muleq(bar)) -- prints: quat_p:<12,24,6,-12>
print(foo)            -- prints: quat_p:<12,24,6,-12>
```

```lua
local foo = luacml.quat_n(1,2,3,4)
local bar = luacml.quat_n(4,3,2,1)
print(foo:muleq(bar)) -- prints: quat_n:<22,4,16,-12>
print(foo)            -- prints: quat_n:<22,4,16,-12>
```

```lua
local foo = luacml.quat_p(1,2,3,4)
print(foo:muleq(2)) -- prints: quat_p:<2,4,6,8>
print(foo)          -- prints: quat_p:<2,4,6,8>
```

#### Note

The original quaternion (not the parameter) is updated.

#### Parameters

-   1 quaternion of same type.
-   or 1 scalar number.

#### Returns

The updated quaternion after the multiplication.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### div()

A quaternion can be can be divided in-place by a number.

```lua
local foo = luacml.quat_n(2,4,6,8)
print(foo:diveq(2)) -- prints: quat_n:<1,2,3,4>
print(foo)          -- prints: quat_n:<1,2,3,4>
```

#### Note

The original quaternion is updated.

#### Parameters

-   1 scalar number.

#### Returns

A new quaternion representing the element-wise division.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

## Quaternion metamethods

All vector types have a set of
[metamethods](http://www.lua.org/manual/5.3/manual.html#2.4) that allow them to
be used with several operators.

--------------------------------------------------------------------------------

### __index

The __index metamethod permits quaternion element access.

Quaternions can be indexed with 1-based integer keys:

```lua
local foo = luacml.quat(10,20,30,40)
local bar = luacml.quat_p(10,20,30,40)
print(foo[1]) -- prints: 10
print(bar[1]) -- prints: 10
```

Or with case-insensitive "x", "y", "z", or "w" string keys:

```lua
local foo = luacml.quat(10,20,30,40)
local bar = luacml.quat_p(10,20,30,40)
print(foo.x)    -- prints: 20
print(foo.W)    -- prints: 10
print(bar["w"]) -- prints: 40
print(bar["Z"]) -- prints: 30
```

#### Parameters

-   An integer from 1 to 4.
-   or one of {x, y, z, w}.

#### Returns

The quaternion's element as a number.

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.

--------------------------------------------------------------------------------

### __newindex

The __newindex metamethod permits vector element setting.

Quaternions can be indexed with 1-based integer keys:

```lua
local foo = luacml.quat(0,0,0,0)
local bar = luacml.quat_p(0,0,0,0)
foo[1] = 10 -- Set to (1,0,0,0)
bar[1] = 10 -- Set to (1,0,0,0)
```

Or with case-insensitive "x", "y", "z", or "w" string keys:

```lua
local foo = luacml.quat(0,0,0,0)
foo.x = 10
foo.Y = 20
foo["z"] = 30
-- Set to (0,10,20,30)
```

#### Parameters

-   An integer from 1 to 4.
-   or one of {x, y, z, w}.

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.

--------------------------------------------------------------------------------

### __tostring

Quaternions can be converted to strings for easy printing.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat_p(1,2,3,4)
local baz = luacml.quat_n(1,2,3,4)
print(foo) -- prints: quat:<1,2,3,4>
print(bar) -- prints: quat_p:<1,2,3,4>
print(baz) -- prints: quat_n:<1,2,3,4>
```

#### Note

This function internally uses `lua_pushfstring` to format the output, so be
aware of different formatting across versions of Lua.

#### Parameters

-   1 quaternion.

#### Returns

The quaternion formatted as a string.

#### Errors

(None)

--------------------------------------------------------------------------------

### __unm

The negative of a quaternion can be generated.

```lua
local foo = luacml.quat(1,2,-3,-4)
print(-foo) -- prints: quat:<-1,-2,3,4>
```

#### Note

The original quaternion is unchanged.

#### Parameters

-   1 quaternion.

#### Returns

A new quaternion representing the negative of the original.

#### Errors

(None)

--------------------------------------------------------------------------------

### __add

Two quaternions can be added together.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(4,3,2,1)
print(foo + bar) -- prints: quat<5,5,5,5>
```

#### Note

The original quaternions are unchanged.

#### Parameters

-   2 quaternions of same type.

#### Returns

A new quaternion representing the element-wise sum.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __sub

Two quaternions can be subtracted.

```lua
local foo = luacml.quat(1,2,3,4)
local bar = luacml.quat(4,3,2,1)
print(foo - bar) -- prints: quat<-3,-1,1,3>
```

#### Note

The original quaternions are unchanged.

#### Parameters

-   2 quaternions of same type.

#### Returns

A new quaternion representing the element-wise difference.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __mul

Quaternions can be scaled.

```lua
local foo = luacml.quat_p(1,2,3,4)
print(2.0 * foo) -- prints: quat_p<2,4,6,8>
print(foo * 3.0) -- prints: quat_p<3,6,9,12>
```

#### Note

The original quaternion is unchanged.

#### Parameters

-   1 quaternion and 1 number.
-   or 1 number and 1 quaternion.

#### Returns

A new quaternion representing the element-wise scale.

#### Errors

-   Invalid types.

--------------------------------------------------------------------------------

### __div

Quaternions can be inverse divided.

```lua
local foo = luacml.quat_p(2,4,6,8)
print(foo / 2.0) -- prints: quat_p<1,2,3,4>
```

#### Note

The original quaternion is unchanged.

#### Parameters

-   1 quaternion and 1 number.

#### Returns

A new quaternion representing the element-wise division.

#### Errors

-   Invalid types.


--------------------------------------------------------------------------------

### __eq

Quaternions can be compared.

```lua
local foo = luacml.quat_p(2,4,6)
local bar = luacml.quat_p(2,4,6)
local baz = luacml.quat_p(1,2,3)
print(foo == bar) -- prints: true
print(foo ~= baz) -- prints: false
```

#### Note

The original quaternions are unchanged.

#### Parameters

-   2 quaternions of same type.

#### Returns

Boolean representing element-wise equality.

#### Errors

-   Invalid types.
