

describe("vector4", function()
    local cml = require("luacml")

    local function table_same(expected, vec)
        assert.same(expected, vec:totable())
    end

    describe("constructor", function()
        it("default", function()
            table_same({0,0,0,0}, cml.vector4())
        end)

        it("with 1 number", function()
            table_same({1,0,0,0}, cml.vector4(1))
            table_same({123,0,0,0}, cml.vector4(123))
            table_same({1.23,0,0,0}, cml.vector4(1.23))
            table_same({math.huge,0,0,0}, cml.vector4(math.huge))
            table_same({-math.pi,0,0,0}, cml.vector4(-math.pi))
        end)

        it("with 2 numbers", function()
            table_same({0,1,0,0}, cml.vector4(0, 1))
            table_same({123,456,0,0}, cml.vector4(123, 456))
            table_same({1.23,4.56,0,0}, cml.vector4(1.23, 4.56))
            table_same({1,math.huge,0,0}, cml.vector4(1, math.huge))
            table_same({1,-math.pi,0,0}, cml.vector4(1, -math.pi))
        end)

        it("with 3 numbers", function()
            table_same({0,1,2,0}, cml.vector4(0, 1, 2))
            table_same({123,456,789,0}, cml.vector4(123, 456, 789))
            table_same({1.23,4.56,7.89,0}, cml.vector4(1.23, 4.56, 7.89))
            table_same({1,2,math.huge,0}, cml.vector4(1, 2, math.huge))
            table_same({1,2,-math.pi,0}, cml.vector4(1, 2, -math.pi))
        end)

        it("with 4 numbers", function()
            table_same({0,1,2,3}, cml.vector4(0, 1, 2, 3))
            table_same({123,456,789,012}, cml.vector4(123, 456, 789, 012))
            table_same({1.23,4.56,7.89,0.12}, cml.vector4(1.23, 4.56, 7.89, 0.12))
            table_same({1,2,3,math.huge}, cml.vector4(1, 2, 3, math.huge))
            table_same({1,2,3,-math.pi}, cml.vector4(1, 2, 3, -math.pi))
        end)

        it("with array of numbers", function()
            table_same({1,2,3,4}, cml.vector4{1, 2, 3, 4})
            table_same({1,2,3,0}, cml.vector4{1, 2, 3})
            table_same({1,2,0,0}, cml.vector4{1, 2})
            table_same({1,0,0,0}, cml.vector4{1})
            table_same({0,0,0,0}, cml.vector4{})
        end)

        it("with vector4", function()
            table_same({4,3,2,1}, cml.vector4(cml.vector4(4,3,2,1)))
            table_same({1,2,3,4}, cml.vector4(cml.vector4(cml.vector4(1,2,3,4))))
        end)

        it("with vector3", function()
            table_same({4,3,2,0}, cml.vector4(cml.vector3(4,3,2)))
            table_same({1,2,3,0}, cml.vector4(cml.vector3(cml.vector4(1,2,3,4))))
        end)

        it("with vector2", function()
            table_same({4,3,0,0}, cml.vector4(cml.vector2(4,3)))
            table_same({1,2,0,0}, cml.vector4(cml.vector2(cml.vector4(1,2,3,4))))
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
        local vec = cml.vector4(10,20,30,40)

        it("with integer key", function()
            assert.equals(10, vec[1])
            assert.equals(20, vec[2])
            assert.equals(30, vec[3])
            assert.equals(40, vec[4])
        end)

        it("with lowercase key", function()
            assert.equals(10, vec.x)
            assert.equals(20, vec.y)
            assert.equals(30, vec.z)
            assert.equals(40, vec.w)
        end)

        it("with uppercase key", function()
            assert.equals(10, vec.X)
            assert.equals(20, vec.Y)
            assert.equals(30, vec.Z)
            assert.equals(40, vec.W)
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
            local vec = cml.vector4(0,0,0,0)
            table_same({0,0,0,0}, vec)
            vec[1] = 10
            table_same({10,0,0,0}, vec)
            vec[2] = 20
            table_same({10,20,0,0}, vec)
            vec[3] = 30
            table_same({10,20,30,0}, vec)
            vec[4] = 40
            table_same({10,20,30,40}, vec)
        end)

        it("with lowercase key", function()
            local vec = cml.vector4(0,0,0,0)
            table_same({0,0,0,0}, vec)
            vec.x = 10
            table_same({10,0,0,0}, vec)
            vec.y = 20
            table_same({10,20,0,0}, vec)
            vec.z = 30
            table_same({10,20,30,0}, vec)
            vec.w = 40
            table_same({10,20,30,40}, vec)
        end)

        it("with uppercase key", function()
            local vec = cml.vector4(0,0,0,0)
            table_same({0,0,0,0}, vec)
            vec.X = 10
            table_same({10,0,0,0}, vec)
            vec.Y = 20
            table_same({10,20,0,0}, vec)
            vec.Z = 30
            table_same({10,20,30,0}, vec)
            vec.W = 40
            table_same({10,20,30,40}, vec)
        end)

        describe("throws #error due to", function()
            local vec = cml.vector4(0,0,0,0)
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
        local function is_near(expected, vec)
            assert.near(expected, vec:length(), 1e-5)
        end

        it("returns correct result", function()
            is_near(0, cml.vector4())
            is_near(1, cml.vector4(-1))
            is_near(100, cml.vector4(100))
            is_near(2, cml.vector4(1,1,1,1))
            is_near(math.sqrt(14), cml.vector4(3,2,1,0))
        end)
    end)

    describe("length_squared", function()
        local function is_near(expected, vec)
            assert.near(expected, vec:length_squared(), 1e-5)
        end

        it("returns correct result", function()
            is_near(0, cml.vector4())
            is_near(1, cml.vector4(-1))
            is_near(10000, cml.vector4(100))
            is_near(4, cml.vector4(1,1,1,1))
            is_near(14, cml.vector4(3,2,1,0))
        end)
    end)
end)
