
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
