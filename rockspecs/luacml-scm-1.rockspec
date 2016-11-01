package = "luacml"
version = "scm-1"

source =
{
   url = "git://github.com/cjtallman/luacml.git",
   branch = "master",
}

description =
{
   summary = "## Lua bindings for the CML math library.",
   detailed = "## luacml is a math library built upon [CML](http://cmldev.net).",
   homepage = "https://github.com/cjtallman/luacml",
   license = "MIT"
}

dependencies =
{
    "lua >= 5.1, < 5.4",
}

build =
{
   type = "builtin",
   modules =
   {
       luacml =
       {
           sources =
           {
               "src/luacml.cpp",
               "src/luacompat.cpp",
               "src/luacmlhelperfuncs.cpp",
               "src/luacmlvector.cpp",
               "src/luacmlquat.cpp",
               "src/luacmlmatrix.cpp",
           },
           incdirs =
           {
               "lib/cml_1_0_4",
           },
       },
   },
   platforms =
   {
       linux =
       {
           modules =
           {
               luacml =
               {
                   libraries =
                   {
                       "stdc++",
                   },
                   defines =
                   {
                       "LUACML_API=extern \"C\" __attribute__((visibility(\"default\")))",
                   },
               },
           },
       },
       win32 =
       {
           modules =
           {
               luacml =
               {
                   defines =
                   {
                       "LUACML_API=extern \"C\" __declspec(dllexport)",
                   },
               },
           },
       }
   }
}
