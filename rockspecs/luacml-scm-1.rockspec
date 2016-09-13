package = "luacml"
version = "scm-1"

source =
{
   url = "*** please add URL for source tarball, zip or repository here ***"
}

description =
{
   summary = "## Description",
   detailed = "## Description",
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
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
           sources = { "src/luacml.cpp", "src/luacompat.cpp", "src/luacmlvector2.cpp", "src/luacmlvector3.cpp", "src/luacmlvector4.cpp" },
           incdirs = { "lib/cml_1_0_4" },
       },
   },
}
