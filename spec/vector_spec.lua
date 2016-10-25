
describe("vector", function()
    local cml = require("luacml")
    --local eps = 1e-5

    describe("constructor", function()
        describe("default", function()
            it("(vector2)", function()
                local input, expected = cml.vector2(), {0,0}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(), {0,0,0}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(), {0,0,0,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 1 float", function()
            it("(vector2)", function()
                local input, expected = cml.vector2(1.2), {1.2,0}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(1.2), {1.2,0,0}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(1.2), {1.2,0,0,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 2 floats", function()
            it("(vector2)", function()
                local input, expected = cml.vector2(1.2,3.4), {1.2,3.4}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(1.2,3.4), {1.2,3.4,0}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(1.2,3.4), {1.2,3.4,0,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 3 floats", function()
            it("(vector2)", function()
                assert.error.matches(function()
                    local input, expected = cml.vector2(1.2,3.4,5.6), {1.2,3.4}
                    assert.same(expected, input:totable())
                end, "bad argument #%-?%d")
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(1.2,3.4,5.6), {1.2,3.4,5.6}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(1.2,3.4,5.6), {1.2,3.4,5.6,0}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with 4 floats", function()
            it("(vector2)", function()
                assert.error.matches(function()
                    local input, expected = cml.vector2(1.2,3.4,5.6,7.8), {1.2,3.4}
                    assert.same(expected, input:totable())
                end, "bad argument #%-?%d")
            end)
            it("(vector3)", function()
                assert.error.matches(function()
                    local input, expected = cml.vector3(1.2,3.4,5.6,7.8), {1.2,3.4,5.6}
                    assert.same(expected, input:totable())
                end, "bad argument #%-?%d")
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(1.2,3.4,5.6,7.8), {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with math.huge", function()
            it("(vector2)", function()
                local input, expected = cml.vector2(math.huge,3.4), {math.huge,3.4}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(math.huge,3.4,5.6), {math.huge,3.4,5.6}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(math.huge,3.4,5.6,7.8), {math.huge,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with -math.pi", function()
            it("(vector2)", function()
                local input, expected = cml.vector2(-math.pi,3.4), {-math.pi,3.4}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3(-math.pi,3.4,5.6), {-math.pi,3.4,5.6}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4(-math.pi,3.4,5.6,7.8), {-math.pi,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
        describe("with array of numbers", function()
            it("(vector2)", function()
                local input, expected = cml.vector2{1.2,3.4}, {1.2,3.4}
                assert.same(expected, input:totable())
            end)
            it("(vector3)", function()
                local input, expected = cml.vector3{1.2,3.4,5.6}, {1.2,3.4,5.6}
                assert.same(expected, input:totable())
            end)
            it("(vector4)", function()
                local input, expected = cml.vector4{1.2,3.4,5.6,7.8}, {1.2,3.4,5.6,7.8}
                assert.same(expected, input:totable())
            end)
        end)
    end)
end)
