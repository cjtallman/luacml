
describe("quaternion", function()
    local cml = require("luacml")
    local eps = 1e-5

    describe("construct default", function()
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

    describe("construct with 4 integers", function()
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

    describe("construct with 4 floats", function()
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

    describe("construct with math.huge", function()
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

    describe("construct with -math.pi", function()
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

    describe("construct with array of numbers", function()
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

    describe("construct with vector4", function()
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

    describe("construct with vector3 and number", function()
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

    describe("construct with number and vector3", function()
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
end)
