
describe("vector2", function()
    local cml = require("luacml")

    describe("constructor", function()
        it("default", function()
            assert.matches("<0,0>", cml.vector2())
        end)

        it("with 1 number", function()
            assert.matches("<0,0>", cml.vector2(0))
            assert.matches("<123,0>", cml.vector2(123))
            assert.matches("<1.23,0>", cml.vector2(1.23))
            assert.matches("<"..-math.pi..",0>", cml.vector2(-math.pi))
            assert.matches("<"..math.huge..",0>", cml.vector2(math.huge))
        end)

        it("with 2 numbers", function()
            assert.matches("<0,0>", cml.vector2(0, 0))
            assert.matches("<0,1>", cml.vector2(0, 1))
            assert.matches("<123,456>", cml.vector2(123, 456))
            assert.matches("<1.23,4.56>", cml.vector2(1.23, 4.56))
            assert.matches("<"..-math.pi..",1>", cml.vector2(-math.pi, 1))
            assert.matches("<"..math.huge..",1>", cml.vector2(math.huge, 1))
        end)

        it("with array of numbers", function()
            assert.matches("<0,0>", cml.vector2{0,0})
            assert.matches("<1,2>", cml.vector2{1,2})
            assert.matches("<1,0>", cml.vector2{1})
            assert.matches("<0,0>", cml.vector2{})
        end)

        it("with vector4", function()
            assert.matches("<4,3>", cml.vector2(cml.vector4(4,3,2,1)))
            assert.matches("<1,2>", cml.vector2(cml.vector4(cml.vector2(1,2))))
        end)

        it("with vector3", function()
            assert.matches("<4,3>", cml.vector2(cml.vector3(4,3,2)))
            assert.matches("<1,2>", cml.vector2(cml.vector3(cml.vector2(1,2))))
        end)

        it("with vector2", function()
            assert.matches("<4,3>", cml.vector2(cml.vector2(4,3)))
            assert.matches("<1,2>", cml.vector2(cml.vector2(cml.vector2(1,2))))
        end)

        describe("throws #error due to", function()
            it("too many arguments", function()
                assert.error.matches(function() cml.vector2(1,2,3) end, "Too many arguments")
                assert.error.matches(function() cml.vector2{1,2,3} end, "Too many arguments")
            end)

            it("bad argument", function()
                assert.error.matches(function() cml.vector2(0/0) end, "Bad value #1")
                assert.error.matches(function() cml.vector2(0, 0/0) end, "Bad value #2")
                assert.error.matches(function() cml.vector2("one", 2) end, "bad argument #1")
                assert.error.matches(function() cml.vector2(1, true) end, "bad argument #2")
                assert.error.matches(function() cml.vector2({}, 1) end, "bad argument #1")
                assert.error.matches(function() cml.vector2(1, nil) end, "bad argument #2")
            end)
        end)
    end)

    describe("index", function()
        local vec = cml.vector2(10,20)

        it("with integer key", function()
            assert.equals(10, vec[1])
            assert.equals(20, vec[2])
        end)

        it("with lowercase key", function()
            assert.equals(10, vec.x)
            assert.equals(20, vec.y)
        end)

        it("with uppercase key", function()
            assert.equals(10, vec.X)
            assert.equals(20, vec.Y)
        end)

        describe("throws #error due to", function()
            it("float key", function()
                assert.error.matches(function() print(vec[1.1]) end, "index not integer")
            end)

            it("string key", function()
                assert.error.matches(function() print(vec["1.1"]) end, "index not integer")
            end)

            it("bool key", function()
                assert.error.matches(function() print(vec[true]) end, "Bad argument type")
            end)

            it("table key", function()
                assert.error.matches(function() print(vec[{}]) end, "Bad argument type")
            end)

            it("function key", function()
                assert.error.matches(function() print(vec[print]) end, "Bad argument type")
            end)

            it("userdata key", function()
                assert.error.matches(function() print(vec[vec]) end, "Bad argument type")
            end)
        end)
    end)

    describe("newindex", function()
        it("with integer key", function()
            local vec = cml.vector2(0,0)
            assert.matches("<0,0>", vec)
            vec[1] = 10
            assert.matches("<10,0>", vec)
            vec[2] = 20
            assert.matches("<10,20>", vec)
        end)

        it("with lowercase key", function()
            local vec = cml.vector2(0,0)
            assert.matches("<0,0>", vec)
            vec.x = 10
            assert.matches("<10,0>", vec)
            vec.y = 20
            assert.matches("<10,20>", vec)
        end)

        it("with uppercase key", function()
            local vec = cml.vector2(0,0)
            assert.matches("<0,0>", vec)
            vec.X = 10
            assert.matches("<10,0>", vec)
            vec.Y = 20
            assert.matches("<10,20>", vec)
        end)

        describe("throws #error due to", function()
            local vec = cml.vector2(0,0)
            it("float key", function()
                assert.error.matches(function() vec[1.1] = 10 end, "index not integer")
            end)

            it("string key", function()
                assert.error.matches(function() vec["1.1"] = 10 end, "index not integer")
            end)

            it("bool key", function()
                assert.error.matches(function() vec[true] = 10 end, "Bad argument type")
            end)

            it("table key", function()
                assert.error.matches(function() vec[{}] = 10 end, "Bad argument type")
            end)

            it("function key", function()
                assert.error.matches(function() vec[print] = 10 end, "Bad argument type")
            end)

            it("userdata key", function()
                assert.error.matches(function() vec[vec] = 10 end, "Bad argument type")
            end)
        end)
    end)
end)
