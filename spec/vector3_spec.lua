

describe("vector3", function()
    local cml = require("luacml")
    local eps = 1e-5
    local constructor = cml.vector3

    describe("constructor", function()
        it("default", function()
            local input = constructor()
            local expected = {0,0,0}
            assert.same(expected, input:totable())
        end)

        describe("with 1 number", function()
            it("test 1", function()
                local input = constructor(1)
                local expected = {1,0,0}
                assert.same(expected, input:totable())
            end)

            it("test 123", function()
                local input = constructor(123)
                local expected = {123,0,0}
                assert.same(expected, input:totable())
            end)

            it("test 1.23", function()
                local input = constructor(1.23)
                local expected = {1.23,0,0}
                assert.same(expected, input:totable())
            end)

            it("test math.huge", function()
                local input = constructor(math.huge)
                local expected = {math.huge,0,0}
                assert.same(expected, input:totable())
            end)

            it("test -math.pi", function()
                local input = constructor(-math.pi)
                local expected = {-math.pi,0,0}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with 2 numbers", function()
            it("test 0,1", function()
                local input = constructor(0,1)
                local expected = {0,1,0}
                assert.same(expected, input:totable())
            end)

            it("test 123,456", function()
                local input = constructor(123,456)
                local expected = {123,456,0}
                assert.same(expected, input:totable())
            end)

            it("test 1.23,4.56", function()
                local input = constructor(1.23,4.56)
                local expected = {1.23,4.56,0}
                assert.same(expected, input:totable())
            end)

            it("test 1,math.huge", function()
                local input = constructor(1,math.huge)
                local expected = {1,math.huge,0}
                assert.same(expected, input:totable())
            end)

            it("test 1,-math.pi", function()
                local input = constructor(1,-math.pi)
                local expected = {1,-math.pi,0}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with 3 numbers", function()
            it("test 0,1,2", function()
                local input = constructor(0,1,2)
                local expected = {0,1,2}
                assert.same(expected, input:totable())
            end)

            it("test 123,456,789", function()
                local input = constructor(123,456,789)
                local expected = {123,456,789}
                assert.same(expected, input:totable())
            end)

            it("test 1.23,4.56,7.89", function()
                local input = constructor(1.23,4.56,7.89)
                local expected = {1.23,4.56,7.89}
                assert.same(expected, input:totable())
            end)

            it("test 1,2,math.huge", function()
                local input = constructor(1,2,math.huge)
                local expected = {1,2,math.huge}
                assert.same(expected, input:totable())
            end)

            it("test 1,2,-math.pi", function()
                local input = constructor(1,2,-math.pi)
                local expected = {1,2,-math.pi}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with array of numbers", function()
            it("test {1,2,3}", function()
                local input = constructor{1,2,3}
                local expected = {1,2,3}
                assert.same(expected, input:totable())
            end)

            it("test {1,2}", function()
                local input = constructor{1,2}
                local expected = {1,2,0}
                assert.same(expected, input:totable())
            end)

            it("test {1}", function()
                local input = constructor{1}
                local expected = {1,0,0}
                assert.same(expected, input:totable())
            end)

            it("test {}", function()
                local input = constructor{}
                local expected = {0,0,0}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with vector4", function()
            it("test cml.vector4(1,2,3,4)", function()
                local input = constructor(cml.vector4(1,2,3,4))
                local expected = {1,2,3}
                assert.same(expected, input:totable())
            end)

            it("test cml.vector4(constructor(1,2,3))", function()
                local input = constructor(cml.vector4(constructor(1,2,3)))
                local expected = {1,2,3}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with vector3", function()
            it("test cml.vector3(1,2,3)", function()
                local input = constructor(cml.vector3(1,2,3))
                local expected = {1,2,3}
                assert.same(expected, input:totable())
            end)

            it("test cml.vector3(constructor(1,2,3))", function()
                local input = constructor(cml.vector3(constructor(1,2,3)))
                local expected = {1,2,3}
                assert.same(expected, input:totable())
            end)
        end)

        describe("with vector2", function()
            it("test cml.vector2(1,2)", function()
                local input = constructor(cml.vector2(1,2))
                local expected = {1,2,0}
                assert.same(expected, input:totable())
            end)

            it("test cml.vector2(constructor(1,2,3))", function()
                local input = constructor(cml.vector2(constructor(1,2,3)))
                local expected = {1,2,0}
                assert.same(expected, input:totable())
            end)
        end)

        describe("throws #error due to", function()
            it("too many arguments", function()
                assert.error.matches(function() constructor(1,2,3,4) end, "Too many arguments")
                assert.error.matches(function() constructor{1,2,3,4} end, "Too many arguments")
            end)

            it("bad argument", function()
                assert.error.matches(function() constructor(0/0) end, "Bad value #1")
                assert.error.matches(function() constructor(0, 0/0) end, "Bad value #2")
                assert.error.matches(function() constructor(0, 0, 0/0) end, "Bad value #3")
                assert.error.matches(function() constructor("one", 2, 4) end, "bad argument #1")
                assert.error.matches(function() constructor(1, true, 4) end, "bad argument #2")
                assert.error.matches(function() constructor(1, 2, {}) end, "bad argument #3")
                assert.error.matches(function() constructor(1, 2, nil) end, "bad argument #3")
            end)
        end)
    end)

    describe("index", function()
        local vec = constructor(10,20,30)

        it("with integer key", function()
            assert.equals(10, vec[1])
            assert.equals(20, vec[2])
            assert.equals(30, vec[3])
        end)

        it("with lowercase key", function()
            assert.equals(10, vec.x)
            assert.equals(20, vec.y)
            assert.equals(30, vec.z)
        end)

        it("with uppercase key", function()
            assert.equals(10, vec.X)
            assert.equals(20, vec.Y)
            assert.equals(30, vec.Z)
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
            local vec = constructor(0,0,0)
            assert.same({0,0,0}, vec:totable())
            vec[1] = 10
            assert.same({10,0,0}, vec:totable())
            vec[2] = 20
            assert.same({10,20,0}, vec:totable())
            vec[3] = 30
            assert.same({10,20,30}, vec:totable())
        end)

        it("with lowercase key", function()
            local vec = constructor(0,0,0)
            assert.same({0,0,0}, vec:totable())
            vec.x = 10
            assert.same({10,0,0}, vec:totable())
            vec.y = 20
            assert.same({10,20,0}, vec:totable())
            vec.z = 30
            assert.same({10,20,30}, vec:totable())
        end)

        it("with uppercase key", function()
            local vec = constructor(0,0,0)
            assert.same({0,0,0}, vec:totable())
            vec.X = 10
            assert.same({10,0,0}, vec:totable())
            vec.Y = 20
            assert.same({10,20,0}, vec:totable())
            vec.Z = 30
            assert.same({10,20,30}, vec:totable())
        end)

        describe("throws #error due to", function()
            local vec = constructor(0,0,0)
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

    describe("length", function()
        it("test 0", function()
            local input = constructor(0)
            local expected = 0
            assert.near(expected, input:length(), eps)
        end)

        it("test -1", function()
            local input = constructor(-1)
            local expected = 1
            assert.near(expected, input:length(), eps)
        end)

        it("test 100", function()
            local input = constructor(100)
            local expected = 100
            assert.near(expected, input:length(), eps)
        end)

        it("test 1,1,1", function()
            local input = constructor(1,1,1)
            local expected = math.sqrt(3)
            assert.near(expected, input:length(), eps)
        end)

        it("test 3,2,1", function()
            local input = constructor(3,2,1)
            local expected = math.sqrt(14)
            assert.near(expected, input:length(), eps)
        end)
    end)

    describe("length_squared", function()
        it("test 0", function()
            local input = constructor(0)
            local expected = 0
            assert.near(expected, input:length_squared(), eps)
        end)

        it("test -1", function()
            local input = constructor(-1)
            local expected = 1
            assert.near(expected, input:length_squared(), eps)
        end)

        it("test 100", function()
            local input = constructor(100)
            local expected = 10000
            assert.near(expected, input:length_squared(), eps)
        end)

        it("test 1,1,1", function()
            local input = constructor(1,1,1)
            local expected = 3
            assert.near(expected, input:length_squared(), eps)
        end)

        it("test 3,2,1", function()
            local input = constructor(3,2,1)
            local expected = 14
            assert.near(expected, input:length_squared(), eps)
        end)
    end)
end)
