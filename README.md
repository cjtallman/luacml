# LuaCML

[![Build status](https://ci.appveyor.com/api/projects/status/a40yja3ah8frl9w8/branch/master?svg=true)](https://ci.appveyor.com/project/cjtallman/luacml/branch/master) [![Build Status](https://travis-ci.org/cjtallman/luacml.svg?branch=master)](https://travis-ci.org/cjtallman/luacml)

## Overview

**LuaCML** is a Lua module that implements the CML math library. It's primary
purpose is to provide access to common math operations for game and graphical
applications.

## Compatibility

**LuaCML** is compatible with the following Lua versions:

-   [x] Lua 5.1
-   [x] Lua 5.2
-   [x] Lua 5.3
-   [x] LuaJit 2.0
-   [x] LuaJit 2.1

## Installation

The best way to build/install **LuaCML** is to use [LuaRocks](https://luarocks.org/).

~~~
git clone git@github.com:cjtallman/luacml.git
cd luacml
luarocks make rockspecs/luacml-scm-1.rockspec
~~~

## Tests

Tests are implemented with [Busted](http://olivinelabs.com/busted). If Busted
is not already installed, install it using LuaRocks.

Build/install **LuaCML** as described above and run `busted` from the repo root:

~~~
busted --verbose
~~~

## Example Usage

~~~lua
-- Load CML module
local cml = require("luacml")

-- Alias CML types
local vec2 = cml.vector2
local vec3 = cml.vector3
local vec4 = cml.vector4
local quat = cml.quat_p

-- Create a 3-D vector
local foo = vec3(1,2,3)

-- Print it
print(foo) --> "vector3:<1,2,3>"

-- Set elements
foo[1] = 10; foo.x = 10;
foo[2] = 20; foo.y = 20;
foo[3] = 30; foo.z = 30;

print(foo) --> "vector3:<10,20,30>"

-- Convert to a 3-element array
local foo_arr = foo:totable() --> {10,20,30}

-- Create a 4-D vector from a 3-D vector
local bar = vec4(foo)
print(bar) --> "vector4:<10,20,30,0>"

-- Get elements
print(bar[1], bar[2], bar[3], bar[4])
print(bar.x, bar.y, bar.z, bar.w)

-- Add
foo = vec3(1,2,3) + vec3(1,2,3)

-- Subtract
foo = vec3(1,2,3) - vec3(1,2,3)

-- Multiply
foo = vec3(1,2,3) * 10
foo = 10 * vec3(1,2,3)

-- Divide
foo = vec3(1,2,3) / 10

-- Dot
local magsqr = cml.dot(vec3(1,2,3), vec3(1,2,3))

-- Cross
foo = cml.cross(vec3(1,0,0), vec3(0,1,0))
~~~

## References

-   [CML site](http://cmldev.net)
-   [CML GitHub](https://github.com/demianmnave/CML)
-   [LuaRocks](https://luarocks.org/)
