
describe("vector4", function()
    local cml = require("luacml")

    describe("constructor", function()
        it("default", function()
            assert.matches("<0,0,0,0>", cml.vector4())
        end)

        it("with 1 number", function()
            assert.matches("<0,0,0,0>", cml.vector4(0))
            assert.matches("<123,0,0,0>", cml.vector4(123))
            assert.matches("<1.23,0,0,0>", cml.vector4(1.23))
            assert.matches("<"..-math.pi..",0,0,0>", cml.vector4(-math.pi))
            assert.matches("<"..math.huge..",0,0,0>", cml.vector4(math.huge))
        end)

        it("with 2 numbers", function()
            assert.matches("<0,0,0,0>", cml.vector4(0, 0))
            assert.matches("<0,1,0,0>", cml.vector4(0, 1))
            assert.matches("<123,456,0,0>", cml.vector4(123, 456))
            assert.matches("<1.23,4.56,0,0>", cml.vector4(1.23, 4.56))
            assert.matches("<"..-math.pi..",1,0,0>", cml.vector4(-math.pi, 1))
            assert.matches("<"..math.huge..",1,0,0>", cml.vector4(math.huge, 1))
        end)

        it("with 3 numbers", function()
            assert.matches("<0,0,0,0>", cml.vector4(0, 0, 0))
            assert.matches("<0,1,2,0>", cml.vector4(0, 1, 2))
            assert.matches("<123,456,789,0>", cml.vector4(123, 456, 789))
            assert.matches("<1.23,4.56,7.89,0>", cml.vector4(1.23, 4.56, 7.89))
            assert.matches("<"..-math.pi..",1,2,0>", cml.vector4(-math.pi, 1, 2))
            assert.matches("<"..math.huge..",1,2,0>", cml.vector4(math.huge, 1, 2))
        end)

        it("with 4 numbers", function()
            assert.matches("<0,0,0,0>", cml.vector4(0, 0, 0, 0))
            assert.matches("<0,1,2,3>", cml.vector4(0, 1, 2, 3))
            assert.matches("<123,456,789,12>", cml.vector4(123, 456, 789, 012))
            assert.matches("<1.23,4.56,7.89,0.12>", cml.vector4(1.23, 4.56, 7.89, 0.12))
            assert.matches("<"..-math.pi..",1,2,3>", cml.vector4(-math.pi, 1, 2, 3))
            assert.matches("<"..math.huge..",1,2,3>", cml.vector4(math.huge, 1, 2, 3))
        end)

        it("with array of numbers", function()
            assert.matches("<0,0,0,0>", cml.vector4{0,0,0,0})
            assert.matches("<1,2,3,4>", cml.vector4{1,2,3,4})
            assert.matches("<1,2,3,0>", cml.vector4{1,2,3})
            assert.matches("<1,2,0,0>", cml.vector4{1,2})
            assert.matches("<1,0,0,0>", cml.vector4{1})
            assert.matches("<0,0,0,0>", cml.vector4{})
        end)

        it("with vector4", function()
            assert.matches("<4,3,2,1>", cml.vector4(cml.vector4(4,3,2,1)))
            assert.matches("<1,2,3,4>", cml.vector4(cml.vector4(cml.vector4(1,2,3,4))))
        end)

        it("with vector3", function()
            assert.matches("<4,3,2,0>", cml.vector4(cml.vector3(4,3,2)))
            assert.matches("<1,2,3,0>", cml.vector4(cml.vector3(cml.vector4(1,2,3,4))))
        end)

        it("with vector2", function()
            assert.matches("<4,3,0,0>", cml.vector4(cml.vector2(4,3)))
            assert.matches("<1,2,0,0>", cml.vector4(cml.vector2(cml.vector4(1,2,3,4))))
        end)

        describe("throws #error due to", function()
            it("too many arguments", function()
                assert.error.matches(function() cml.vector4(1,2,3,4,5) end, "Too many arguments")
                assert.error.matches(function() cml.vector4{1,2,3,4,5} end, "Too many arguments")
            end)

            it("bad argument", function()
                assert.error.matches(function() cml.vector4(0/0) end, "Bad value #1")
                assert.error.matches(function() cml.vector4(0, 0/0) end, "Bad value #2")
                assert.error.matches(function() cml.vector4(0, 0, 0/0) end, "Bad value #3")
                assert.error.matches(function() cml.vector4("one", 2, 3, 4) end, "bad argument #1")
                assert.error.matches(function() cml.vector4(1, true, 3, 4) end, "bad argument #2")
                assert.error.matches(function() cml.vector4(1, 2, {}, 4) end, "bad argument #3")
                assert.error.matches(function() cml.vector4(1, 2, 3, nil) end, "bad argument #4")
            end)
        end)
    end)

    describe("index", function()
        local v4 = cml.vector4(10,20,30,40)

        it("with integer key", function()
            assert.equals(10, v4[1])
            assert.equals(20, v4[2])
            assert.equals(30, v4[3])
            assert.equals(40, v4[4])
        end)

        it("with lowercase key", function()
            assert.equals(10, v4.x)
            assert.equals(20, v4.y)
            assert.equals(30, v4.z)
            assert.equals(40, v4.w)
        end)

        it("with uppercase key", function()
            assert.equals(10, v4.X)
            assert.equals(20, v4.Y)
            assert.equals(30, v4.Z)
            assert.equals(40, v4.W)
        end)

        describe("throws #error due to", function()
            it("float key", function()
                assert.error.matches(function() print(v4[1.1]) end, "index not integer")
            end)

            it("string key", function()
                assert.error.matches(function() print(v4["1.1"]) end, "index not integer")
            end)

            it("bool key", function()
                assert.error.matches(function() print(v4[true]) end, "Bad argument type")
            end)

            it("table key", function()
                assert.error.matches(function() print(v4[{}]) end, "Bad argument type")
            end)

            it("function key", function()
                assert.error.matches(function() print(v4[print]) end, "Bad argument type")
            end)

            it("userdata key", function()
                assert.error.matches(function() print(v4[v4]) end, "Bad argument type")
            end)
        end)
    end)

    describe("newindex", function()
        it("with integer key", function()
            local v4 = cml.vector4(0,0,0,0)
            assert.matches("<0,0,0,0>", v4)
            v4[1] = 10
            assert.matches("<10,0,0,0>", v4)
            v4[2] = 20
            assert.matches("<10,20,0,0>", v4)
            v4[3] = 30
            assert.matches("<10,20,30,0>", v4)
            v4[4] = 40
            assert.matches("<10,20,30,40>", v4)
        end)

        it("with lowercase key", function()
            local v4 = cml.vector4(0,0,0,0)
            assert.matches("<0,0,0,0>", v4)
            v4.x = 10
            assert.matches("<10,0,0,0>", v4)
            v4.y = 20
            assert.matches("<10,20,0,0>", v4)
            v4.z = 30
            assert.matches("<10,20,30,0>", v4)
            v4.w = 40
            assert.matches("<10,20,30,40>", v4)
        end)

        it("with uppercase key", function()
            local v4 = cml.vector4(0,0,0,0)
            assert.matches("<0,0,0,0>", v4)
            v4.X = 10
            assert.matches("<10,0,0,0>", v4)
            v4.Y = 20
            assert.matches("<10,20,0,0>", v4)
            v4.Z = 30
            assert.matches("<10,20,30,0>", v4)
            v4.W = 40
            assert.matches("<10,20,30,40>", v4)
        end)

        describe("throws #error due to", function()
            local v4 = cml.vector4(0,0,0,0)
            it("float key", function()
                assert.error.matches(function() v4[1.1] = 10 end, "index not integer")
            end)

            it("string key", function()
                assert.error.matches(function() v4["1.1"] = 10 end, "index not integer")
            end)

            it("bool key", function()
                assert.error.matches(function() v4[true] = 10 end, "Bad argument type")
            end)

            it("table key", function()
                assert.error.matches(function() v4[{}] = 10 end, "Bad argument type")
            end)

            it("function key", function()
                assert.error.matches(function() v4[print] = 10 end, "Bad argument type")
            end)

            it("userdata key", function()
                assert.error.matches(function() v4[v4] = 10 end, "Bad argument type")
            end)
        end)
    end)
end)
