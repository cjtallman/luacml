
# Matrices

## Matrix types

The following vector types are provided by LuaCML:

| Type         | Description                                                   |
|--------------|---------------------------------------------------------------|
| `matrix22`   | A 2x2 row major, column basis matrix based on `lua_Number`    |
| `matrix22_c` | A 2x2 column major, column basis matrix based on `lua_Number` |
| `matrix22_r` | A 2x2 row major, row basis matrix based on `lua_Number`       |
| `matrix33`   | A 3x3 row major, column basis matrix based on `lua_Number`    |
| `matrix33_c` | A 3x3 column major, column basis matrix based on `lua_Number` |
| `matrix33_r` | A 3x3 row major, row basis matrix based on `lua_Number`       |
| `matrix44`   | A 4x4 row major, column basis matrix based on `lua_Number`    |
| `matrix44_c` | A 4x4 column major, column basis matrix based on `lua_Number` |
| `matrix44_r` | A 4x4 row major, row basis matrix based on `lua_Number`       |
| `matrix23_c` | A 2x3 column major, column basis matrix based on `lua_Number` |
| `matrix32_r` | A 3x2 row major, row basis matrix based on `lua_Number`       |
| `matrix34_c` | A 3x4 column major, column basis matrix based on `lua_Number` |
| `matrix43_r` | A 4x3 row major, row basis matrix based on `lua_Number`       |

## Matrix functions

### constructor

Matrices have default constructors, initialized with identity:

```lua
local foo = luacml.matrix22()
-- Set to: |1 0|
--         |0 1|
```

Matrices can be constructed from individual numbers:

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
-- Set to: |1 2 3|
--         |4 5 6|
--         |7 8 9|
```

Or from a table of numbers:

```lua
local foo = luacml.matrix22({1,2,3,4})
-- Set to: |1 2|
--         |3 4|
```

Or from another matrix:

```lua
local foo = luacml.matrix22(1,2,3,4)
local bar = luacml.matrix22(foo)
-- Set to: |1 2|
--         |3 4|
```

#### Parameters

-   ***M\*N*** numbers.
-   or table of ***M\*N*** numbers.
-   or a matrix of same type.

#### Returns

The newly constructed matrix.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### totable()

Matrices can be converted to a table:

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
local bar = foo:totable()
print(bar[1], bar[2], bar[3]) -- prints: 1 2 3
```

#### Parameters

(None)

#### Returns

An array containing the matrix's elements.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### set()

Matrices can be set from individual numbers:

```lua
local foo = luacml.matrix33()
foo:set(1,2,3,4,5,6,7,8,9)
```

Or from a table of numbers:

```lua
local foo = luacml.matrix33()
foo:set({1,2,3,4,5,6,7,8,9})
```

Or from another matrix:

```lua
local foo = luacml.matrix33()
foo:set(luacml.matrix33(1,2,3,4,5,6,7,8,9))
```

#### Parameters

-   ***M\*N*** numbers.
-   or table of ***M\*N*** numbers.
-   or a matrix of same type.

#### Returns

The matrix, after it has been set.

#### Errors

-   Missing arguments.
-   Extra arguments.
-   Invalid argument type.

--------------------------------------------------------------------------------

### identity()

A matrix can be set to identity in-place:

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
foo:identity()
-- Set to: |1 0 0|
--         |0 1 0|
--         |0 0 1|
```

```lua
local foo = luacml.matrix23_c(1,2,3,4,5,6)
foo:identity()
-- Set to: |1 0 0|
--         |0 1 0|
```

#### Parameters

(None)

#### Returns

The matrix, after it has been set.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### zero()

A matrix can be set to zero in-place:

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
foo:zero()
-- Set to: |0 0 0|
--         |0 0 0|
--         |0 0 0|
```

```lua
local foo = luacml.matrix23_c(1,2,3,4,5,6)
foo:zero()
-- Set to: |0 0 0|
--         |0 0 0|
```

#### Parameters

(None)

#### Returns

The matrix, after it has been zeroed.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### rows()

The number of rows for a matrix can be read:

```lua
local foo = luacml.matrix33()
print(foo:rows()) -- Prints: 3
```

```lua
local foo = luacml.matrix23_c()
print(foo:rows()) -- Prints: 2
```

#### Parameters

(None)

#### Returns

The number of matrix rows, as an integer.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### cols()

The number of columns for a matrix can be read:

```lua
local foo = luacml.matrix33()
print(foo:cols()) -- Prints: 3
```

```lua
local foo = luacml.matrix23_c()
print(foo:cols()) -- Prints: 3
```

#### Parameters

(None)

#### Returns

The number of matrix columns, as an integer.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

### transpose()

A square matrix can be transposed:

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
foo:transpose()
-- Set to: |1 4 7|
--         |2 5 8|
--         |3 6 9|
```

#### Note

Only square matrices have this function. Calling it with a non-square matrix
will throw an error.

#### Parameters

(None)

#### Returns

The matrix after it has been transposed.

#### Errors

-   Extra arguments.

--------------------------------------------------------------------------------

## Matrix metamethods

All matrix types have a set of
[metamethods](http://www.lua.org/manual/5.3/manual.html#2.4) that allow them to
be used with several operators.

--------------------------------------------------------------------------------

### __tostring

Matrices can be converted to strings for easy printing.

```lua
local foo = luacml.matrix33(1,2,3,4,5,6,7,8,9)
print(foo) -- prints: matrix33:|1,2,3|4,5,6|7,8,9|
```

```lua
local foo = luacml.matrix23_c(1,2,3,4,5,6)
print(foo) -- prints: matrix23_c:|1,2,3|4,5,6|
```

#### Note

This function internally uses `lua_pushfstring` to format the output, so be
aware of slightly different formatting across versions of Lua.

#### Parameters

A matrix.

#### Returns

The matrix formatted as a string.

#### Errors

(None)

--------------------------------------------------------------------------------

### __index

The __index metamethod permits vector element access.

Matrices can be indexed with 1-based integer keys (1 through ***M\*N***):

```lua
local foo = luacml.matrix22(10,20,30,40)
print(foo[1],foo[2],foo[3],foo[4]) -- prints: 10 20 30 40
```

Or with case-insensitive "m\<row>\<col>" string keys:

```lua
local foo = luacml.matrix22(10,20,30,40)
print(foo.m11, foo.m12, foo.m21, foo.m22) -- prints: 10 20 30 40
```

#### Note

The `matrix22`, `matrix22_c` and `matrix22_r` types use the following indices
and mappings:

```
| 1 | 2 |
| 3 | 4 |
```
or

```
| m11 | m12 |
| m21 | m22 |
```

The `matrix33`, `matrix33_c` and `matrix33_r` types use the following indices
and mappings:

```
| 1 | 2 | 3 |
| 4 | 5 | 6 |
| 7 | 8 | 9 |
```
or

```
| m11 | m12 | m13 |
| m21 | m22 | m23 |
| m31 | m32 | m33 |
```

The `matrix44`, `matrix44_c` and `matrix44_r` types use the following indices
and mappings:

```
|  1 |  2 |  3 |  4 |
|  5 |  6 |  7 |  8 |
|  9 | 10 | 11 | 12 |
| 13 | 14 | 15 | 16 |
```
or

```
| m11 | m12 | m13 | m14 |
| m21 | m22 | m23 | m24 |
| m31 | m32 | m33 | m34 |
| m41 | m42 | m43 | m44 |
```

The `matrix23_c` type uses the following indices and map:

```
| 1 | 2 | 3 |
| 4 | 5 | 6 |
```
or

```
| m11 | m12 | m13 |
| m21 | m22 | m23 |
```

The `matrix32_r` type uses the following indices and map:

```
| 1 | 2 |
| 3 | 4 |
| 5 | 6 |
```
or

```
| m11 | m12 |
| m21 | m22 |
| m31 | m32 |
```

The `matrix34_c` type uses the following indices and map:

```
|  1 |  2 |  3 |  4 |
|  5 |  6 |  7 |  8 |
|  9 | 10 | 11 | 12 |
```
or

```
| m11 | m12 | m13 | m14 |
| m21 | m22 | m23 | m24 |
| m31 | m32 | m33 | m34 |
```

The `matrix43_r` type uses the following indices and map:

```
|  1 |  2 |  3 |
|  4 |  5 |  6 |
|  7 |  8 |  9 |
| 10 | 11 | 12 |
```
or

```
| m11 | m12 | m13 |
| m21 | m22 | m23 |
| m31 | m32 | m33 |
| m41 | m42 | m43 |
```

#### Parameters

-   An integer from 1 to ***M\*N***, where M is rows, N is columns.
-   or one of the string keys following the "m\<row>\<col>" convention (ie "m12"
    for the element in the first row, second column).

#### Returns

The matrix's element as a number.

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.

--------------------------------------------------------------------------------

### __newindex

The __newindex metamethod permits matrix element setting.

Matrices can be indexed with 1-based integer keys:

```lua
local foo = luacml.matrix22()
foo[1] = 10
foo[2] = 20
foo[3] = 30
foo[4] = 40
-- Sets to: | 10 20 |
--          | 30 40 |
```

Or with case-insensitive "m\<row>\<col>" string keys:

```lua
local foo = luacml.matrix22()
foo.m11 = 10
foo.m12 = 20
foo.m21 = 30
foo.m22 = 40
-- Sets to: | 10 20 |
--          | 30 40 |
```

#### Note

See Note for [__index](#__index) about valid keys for each type of matrix.

#### Parameters

-   An integer from 1 to ***M\*N***, where M is rows, N is columns.
-   or one of the string keys following the "m\<row>\<col>" convention (ie "m12"
    for the element in the first row, second column).

#### Returns

(None)

#### Errors

-   Missing arguments.
-   Invalid index value.
-   Invalid index type.
