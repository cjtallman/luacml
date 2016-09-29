
describe("quaternion", function()
    local cml = require("luacml")
    local eps = 1e-5

    describe("constructor", function()
        describe("default", function()
            it("quat()", function()
                local input, expected = cml.quat(), {1,0,0,0}
                assert.same(expected, input:totable())
            end)
            it("quat_n()", function()
                local input, expected = cml.quat_n(), {0,0,0,1}
                assert.same(expected, input:totable())
            end)
            it("quat_p()", function()
                local input, expected = cml.quat_p(), {0,0,0,1}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 4 integers", function()
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 4 floats", function()
            it("(quat)", function()
                local input, expected = cml.quat(1.2,3.4,5.6,7.8), {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1.2,3.4,5.6,7.8), {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1.2,3.4,5.6,7.8), {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with math.huge", function()
            it("(quat)", function()
                local input, expected = cml.quat(math.huge,2,3,4), {math.huge,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(math.huge,2,3,4), {math.huge,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(math.huge,2,3,4), {math.huge,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with -math.pi", function()
            it("(quat)", function()
                local input, expected = cml.quat(-math.pi,2,3,4), {-math.pi,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(-math.pi,2,3,4), {-math.pi,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(-math.pi,2,3,4), {-math.pi,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with array of numbers", function()
            it("(quat)", function()
                local input, expected = cml.quat{1.2,3.4,5.6,7.8}, {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n{1.2,3.4,5.6,7.8}, {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p{1.2,3.4,5.6,7.8}, {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with vector4", function()
            it("(quat)", function()
                local input, expected = cml.quat(cml.vector4(1,2,3,4)), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(cml.vector4(1,2,3,4)), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(cml.vector4(1,2,3,4)), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with vector3 and number", function()
            it("(quat)", function()
                local input, expected = cml.quat(cml.vector3(1,2,3), 4), {4,1,2,3}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(cml.vector3(1,2,3), 4), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(cml.vector3(1,2,3), 4), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with number and vector3", function()
            it("(quat)", function()
                local input, expected = cml.quat(4, cml.vector3(1,2,3)), {4,1,2,3}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(4, cml.vector3(1,2,3)), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(4, cml.vector3(1,2,3)), {1,2,3,4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("#error", function()
            describe("too many arguments", function()
                it("(quat)", function()
                    assert.error.matches(function() cml.quat(1,2,3,4,5) end, "Too many arguments")
                    assert.error.matches(function() cml.quat{1,2,3,4,5} end, "Too many arguments")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n(1,2,3,4,5) end, "Too many arguments")
                    assert.error.matches(function() cml.quat_n{1,2,3,4,5} end, "Too many arguments")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p(1,2,3,4,5) end, "Too many arguments")
                    assert.error.matches(function() cml.quat_p{1,2,3,4,5} end, "Too many arguments")
                end)
            end)
            describe("bad argument", function()
                describe("INF", function()
                    local val = 0/0
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                end)
                describe("string", function()
                    local val = "one"
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                end)
                describe("boolean", function()
                    local val = true
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                end)
                describe("nil", function()
                    local val = nil
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "Missing arguments")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "Missing arguments")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "Missing arguments")
                    end)
                end)
                describe("table", function()
                    local val = {}
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                end)
                describe("function", function()
                    local val = assert.is_function(print)
                    it("(quat)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_n)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_n(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_n{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_n{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                    it("(quat_p)", function()
                        -- individual args
                        assert.error.matches(function() cml.quat_p(val, 2, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, val, 3, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, val, 4) end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p(1, 2, 3, val) end, "bad argument #%-?%d")
                        -- table args
                        assert.error.matches(function() cml.quat_p{val, 2, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, val, 3, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, val, 4} end, "bad argument #%-?%d")
                        assert.error.matches(function() cml.quat_p{1, 2, 3, val} end, "bad argument #%-?%d")
                    end)
                end)
            end)
        end)
    end)

    describe("index", function()
        describe("1", function()
            local i = 1
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
        end)
        describe("2", function()
            local i = 2
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
        end)
        describe("3", function()
            local i = 3
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
        end)
        describe("4", function()
            local i = 4
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
        end)
        describe("x", function()
            local i = "x"
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
        end)
        describe("y", function()
            local i = "y"
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 22
                assert.same(expected, input)
            end)
        end)
        describe("z", function()
            local i = "z"
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 33
                assert.same(expected, input)
            end)
        end)
        describe("w", function()
            local i = "w"
            it("(quat)", function()
                local input, expected = cml.quat(11,22,33,44)[i], 11
                assert.same(expected, input)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(11,22,33,44)[i], 44
                assert.same(expected, input)
            end)
        end)
        describe("#error", function()
            describe("float key", function()
                local key = 1.1
                it("(quat)", function()
                    assert.error.matches(function() print(cml.quat()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() print(cml.quat_n()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() print(cml.quat_p()[key]) end, "bad argument #%-?%d")
                end)
            end)
            describe("string key", function()
                local key = "1.1"
                it("(quat)", function()
                    assert.error.matches(function() print(cml.quat()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() print(cml.quat_n()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() print(cml.quat_p()[key]) end, "bad argument #%-?%d")
                end)
            end)
            describe("boolean key", function()
                local key = true
                it("(quat)", function()
                    assert.error.matches(function() print(cml.quat()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() print(cml.quat_n()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() print(cml.quat_p()[key]) end, "bad argument #%-?%d")
                end)
            end)
            describe("table key", function()
                local key = {}
                it("(quat)", function()
                    assert.error.matches(function() print(cml.quat()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() print(cml.quat_n()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() print(cml.quat_p()[key]) end, "bad argument #%-?%d")
                end)
            end)
            describe("function key", function()
                local key = print
                it("(quat)", function()
                    assert.error.matches(function() print(cml.quat()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() print(cml.quat_n()[key]) end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() print(cml.quat_p()[key]) end, "bad argument #%-?%d")
                end)
            end)
        end)
    end)

    describe("newindex", function()
        describe("1", function()
            local i = 1
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {100,2,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {100,2,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {100,2,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("2", function()
            local i = 2
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,100,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,100,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,100,3,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("3", function()
            local i = 3
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,2,100,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,2,100,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,2,100,4}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("4", function()
            local i = 4
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,2,3,100}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,2,3,100}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,2,3,100}
                input[i] = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("x", function()
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,100,3,4}
                input.x = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {100,2,3,4}
                input.x = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {100,2,3,4}
                input.x = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("y", function()
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,2,100,4}
                input.y = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,100,3,4}
                input.y = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,100,3,4}
                input.y = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("z", function()
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {1,2,3,100}
                input.z = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,2,100,4}
                input.z = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,2,100,4}
                input.z = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("w", function()
            it("(quat)", function()
                local input, expected = cml.quat(1,2,3,4), {100,2,3,4}
                input.w = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(1,2,3,4), {1,2,3,100}
                input.w = 100
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(1,2,3,4), {1,2,3,100}
                input.w = 100
                assert.same(expected, input:totable())
            end)
        end)
        describe("#error", function()
            describe("float key", function()
                local key = 1.1
                it("(quat)", function()
                    assert.error.matches(function() cml.quat()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p()[key] = 1 end, "bad argument #%-?%d")
                end)
            end)
            describe("string key", function()
                local key = "1.1"
                it("(quat)", function()
                    assert.error.matches(function() cml.quat()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p()[key] = 1 end, "bad argument #%-?%d")
                end)
            end)
            describe("boolean key", function()
                local key = true
                it("(quat)", function()
                    assert.error.matches(function() cml.quat()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p()[key] = 1 end, "bad argument #%-?%d")
                end)
            end)
            describe("table key", function()
                local key = {}
                it("(quat)", function()
                    assert.error.matches(function() cml.quat()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p()[key] = 1 end, "bad argument #%-?%d")
                end)
            end)
            describe("function key", function()
                local key = print
                it("(quat)", function()
                    assert.error.matches(function() cml.quat()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_n)", function()
                    assert.error.matches(function() cml.quat_n()[key] = 1 end, "bad argument #%-?%d")
                end)
                it("(quat_p)", function()
                    assert.error.matches(function() cml.quat_p()[key] = 1 end, "bad argument #%-?%d")
                end)
            end)
        end)
    end)

    describe("identity", function()
        it("(quat)", function()
            local original = cml.quat(11,22,33,44)
            local input = cml.quat(original)
            local expected = {1,0,0,0}
            -- Test equivalence
            assert.same(original:totable(), input:totable())
            input:identity();
            -- Test non-equivalence
            assert.is_not.same(original:totable(), input:totable())
            -- Test expected
            assert.same(expected, input:totable())
        end)
        it("(quat_n)", function()
            local original = cml.quat_n(11,22,33,44)
            local input = cml.quat_n(original)
            local expected = {0,0,0,1}
            -- Test equivalence
            assert.same(original:totable(), input:totable())
            input:identity();
            -- Test non-equivalence
            assert.is_not.same(original:totable(), input:totable())
            -- Test expected
            assert.same(expected, input:totable())
        end)
        it("(quat_p)", function()
            local original = cml.quat_p(11,22,33,44)
            local input = cml.quat_p(original)
            local expected = {0,0,0,1}
            -- Test equivalence
            assert.same(original:totable(), input:totable())
            input:identity();
            -- Test non-equivalence
            assert.is_not.same(original:totable(), input:totable())
            -- Test expected
            assert.same(expected, input:totable())
        end)
        describe("#error", function()
            it("(quat)", function()
                assert.error.matches(function() cml.quat():identity(1) end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat().identity() end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat().identity(1) end, "bad argument #%-?%d")
            end)
            it("(quat_n)", function()
                assert.error.matches(function() cml.quat_n():identity(1) end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat_n().identity() end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat_n().identity(1) end, "bad argument #%-?%d")
            end)
            it("(quat_p)", function()
                assert.error.matches(function() cml.quat_p():identity(1) end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat_p().identity() end, "bad argument #%-?%d")
                assert.error.matches(function() cml.quat_p().identity(1) end, "bad argument #%-?%d")
            end)
        end)
    end)

    describe("length", function()
        describe("default", function()
            it("(quat)", function()
                local input, expected = cml.quat(), 1
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(), 1
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(), 1
                assert.near(expected, input:length(), eps)
            end)
        end)
        describe("{3,2,1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(3,2,1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(3,2,1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(3,2,1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
        end)
        describe("{-3,2,-1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(-3,2,-1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(-3,2,-1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(-3,2,-1,0), math.sqrt(14)
                assert.near(expected, input:length(), eps)
            end)
        end)
    end)

    describe("length_squared", function()
        describe("default", function()
            it("(quat)", function()
                local input, expected = cml.quat(), 1
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(), 1
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(), 1
                assert.near(expected, input:length_squared(), eps)
            end)
        end)
        describe("{3,2,1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(3,2,1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(3,2,1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(3,2,1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
        end)
        describe("{-3,2,-1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(-3,2,-1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(-3,2,-1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(-3,2,-1,0), 14
                assert.near(expected, input:length_squared(), eps)
            end)
        end)
    end)

    describe("conjugate", function()
        describe("default", function()
            it("(quat)", function()
                local input, expected = cml.quat():conjugate(), {1,0,0,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n():conjugate(), {0,0,0,1}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p():conjugate(), {0,0,0,1}
                assert.same(expected, input:totable())
            end)
        end)
        describe("{3,2,1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(3,2,1,0):conjugate(), {3,-2,-1,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(3,2,1,0):conjugate(), {-3,-2,-1,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(3,2,1,0):conjugate(), {-3,-2,-1,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("{-3,2,-1,0}", function()
            it("(quat)", function()
                local input, expected = cml.quat(-3,2,-1,0):conjugate(), {-3,-2,1,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local input, expected = cml.quat_n(-3,2,-1,0):conjugate(), {3,-2,1,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local input, expected = cml.quat_p(-3,2,-1,0):conjugate(), {3,-2,1,0}
                assert.same(expected, input:totable())
            end)
        end)
    end)

    describe("operator", function()
        describe("+", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = cml.quat(2,3,4,5)
                local input, expected = A + B, {3,5,7,9}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = cml.quat_n(2,3,4,5)
                local input, expected = A + B, {3,5,7,9}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = cml.quat_p(2,3,4,5)
                local input, expected = A + B, {3,5,7,9}
                assert.same(expected, input:totable())
            end)
        end)
        describe("-", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = cml.quat(2,3,4,5)
                local input, expected = A - B, {-1,-1,-1,-1}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = cml.quat_n(2,3,4,5)
                local input, expected = A - B, {-1,-1,-1,-1}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = cml.quat_p(2,3,4,5)
                local input, expected = A - B, {-1,-1,-1,-1}
                assert.same(expected, input:totable())
            end)
        end)
        describe("- unary", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local input, expected = -A, {-1,-2,-3,-4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local input, expected = -A, {-1,-2,-3,-4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local input, expected = -A, {-1,-2,-3,-4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("* quaternion", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = cml.quat(2,3,4,5)
                local input, expected = A * B, {-36,6,12,12}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = cml.quat_n(2,3,4,5)
                local input, expected = A * B, {14,20,32,0}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = cml.quat_p(2,3,4,5)
                local input, expected = A * B, {12,24,30,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("* scalar first", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = 10
                local input, expected = B * A, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = 10
                local input, expected = B * A, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = 10
                local input, expected = B * A, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
        end)
        describe("* scalar second", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = 10
                local input, expected = A * B, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = 10
                local input, expected = A * B, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = 10
                local input, expected = A * B, {10,20,30,40}
                assert.same(expected, input:totable())
            end)
        end)
        describe("/", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = 10
                local input, expected = A / B, {0.1,0.2,0.3,0.4}
                assert.same(expected, input:totable())
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = 10
                local input, expected = A / B, {0.1,0.2,0.3,0.4}
                assert.same(expected, input:totable())
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = 10
                local input, expected = A / B, {0.1,0.2,0.3,0.4}
                assert.same(expected, input:totable())
            end)
        end)
        describe("==", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = cml.quat(2,3,4,5)
                assert.is_false(A == B)
                assert.is_true(A == A)
                assert.is_true(A == cml.quat(1,2,3,4))
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = cml.quat_n(2,3,4,5)
                assert.is_false(A == B)
                assert.is_true(A == A)
                assert.is_true(A == cml.quat_n(1,2,3,4))
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = cml.quat_p(2,3,4,5)
                assert.is_false(A == B)
                assert.is_true(A == A)
                assert.is_true(A == cml.quat_p(1,2,3,4))
            end)
        end)
        describe("~=", function()
            it("(quat)", function()
                local A = cml.quat(1,2,3,4)
                local B = cml.quat(2,3,4,5)
                assert.is_true(A ~= B)
                assert.is_false(A ~= A)
                assert.is_false(A ~= cml.quat(1,2,3,4))
            end)
            it("(quat_n)", function()
                local A = cml.quat_n(1,2,3,4)
                local B = cml.quat_n(2,3,4,5)
                assert.is_true(A ~= B)
                assert.is_false(A ~= A)
                assert.is_false(A ~= cml.quat_n(1,2,3,4))
            end)
            it("(quat_p)", function()
                local A = cml.quat_p(1,2,3,4)
                local B = cml.quat_p(2,3,4,5)
                assert.is_true(A ~= B)
                assert.is_false(A ~= A)
                assert.is_false(A ~= cml.quat_p(1,2,3,4))
            end)
        end)
    end)
end)
