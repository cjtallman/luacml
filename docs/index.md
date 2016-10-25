
# LuaCML

## Overview

LuaCML is an implementation of the CML library to be used in Lua applications.
It works as a Lua module that can be loaded using the `require` function:

```lua
-- Load the LuaCML library.
local luacml = require("luacml")
```

## Features

There are a number of predefined types available:

- [Vector types](./vector-docs.md)
- [Quaternion types](./quaternion-docs.md)
- [Matrix types](./matrix-types.md)

## Design decisions

Since CML is a library based on C++ templates, LuaCML is unable to provide the
same configurability and instead aims to provide only the most common types.

LuaCML also chooses to base the floating point math types around the built-in
`lua_Number` type.

Integer types *(See Lua 5.3)* is not currently supported, nor planned.

Dynamic types (vectors, matrices) are not currently supported, not planned.

## Compatibility

| Lua Version                                              | Supported |
|----------------------------------------------------------|-----------|
| [PUC-Rio Lua 5.1](https://www.lua.org/versions.html#5.1) | yes       |
| [PUC-Rio Lua 5.2](https://www.lua.org/versions.html#5.2) | yes       |
| [PUC-Rio Lua 5.3](https://www.lua.org/versions.html#5.3) | yes       |
| [LuaJit 2.0](http://luajit.org/download.html)            | yes       |
| [LuaJit 2.1](http://luajit.org/download.html)            | yes       |
