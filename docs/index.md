
# LuaCML

## Overview

LuaCML is an implementation of the CML library to be used in Lua applications.
It works as a Lua module that can be loaded using the `require` function:

```lua
-- Load the LuaCML library.
local luacml = require("luacml")
```

or

```lua
-- Only load portions of the LuaCML library.
local vec2 = require("luacml.vector2")
local vec3 = require("luacml.vector3")
local vec4 = require("luacml.vector4")
local quat = require("luacml.quat_p")
```

## Features

There are a number of predefined types available:

-   [Vector types](./vector-docs.md)
-   [Quaternion types](./quaternion-docs.md)
-   [Matrix types](./matrix-docs.md)

More detailed documentation exists for various [library functions](./library-docs.md).

## Design decisions

Since CML is a library based on C++ templates, LuaCML is unable to provide the
same configurability and instead aims to provide only the most common types.

LuaCML also chooses to base the floating point math types around the built-in
`lua_Number` type.

Integer types *(See Lua 5.3)* is not currently supported, nor planned.

Dynamic types (vectors of size > 4, matrices > 4x4) are not currently supported,
nor planned.

## Compatibility

| Lua Version                                              | Supported |
|----------------------------------------------------------|-----------|
| [PUC-Rio Lua 5.1](https://www.lua.org/versions.html#5.1) | yes       |
| [PUC-Rio Lua 5.2](https://www.lua.org/versions.html#5.2) | yes       |
| [PUC-Rio Lua 5.3](https://www.lua.org/versions.html#5.3) | yes       |
| [LuaJit 2.0](http://luajit.org/download.html)            | yes       |
| [LuaJit 2.1](http://luajit.org/download.html)            | yes       |
