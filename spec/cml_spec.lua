
describe("cml", function()
    local cml = require("luacml")
    local testfmt = "(%s)"
    --local eps = 1e-5

    describe("dot", function()
        it("vector2(), vector2()", function()
            local input = cml.dot(cml.vector2(), cml.vector2())
            local expected = 0
            assert.same(expected, input)
        end)

        it("vector3(), vector3()", function()
            local input = cml.dot(cml.vector3(), cml.vector3())
            local expected = 0
            assert.same(expected, input)
        end)

        it("vector4(), vector4()", function()
            local input = cml.dot(cml.vector4(), cml.vector4())
            local expected = 0
            assert.same(expected, input)
        end)

        it("quat_p(), quat_p()", function()
            local input = cml.dot(cml.quat_p(), cml.quat_p())
            local expected = 1
            assert.same(expected, input)
        end)

        it("quat_n(), quat_n()", function()
            local input = cml.dot(cml.quat_n(), cml.quat_n())
            local expected = 1
            assert.same(expected, input)
        end)

        it("vector2(-1,2), vector2(3,-4)", function()
            local input = cml.dot(cml.vector2(-1,2),cml.vector2(3,-4))
            local expected = -11
            assert.same(expected, input)
        end)

        it("vector3(-1,2,3), vector3(4,-5,6)", function()
            local input = cml.dot(cml.vector3(-1,2,3), cml.vector3(4,-5,6))
            local expected = 4
            assert.same(expected, input)
        end)

        it("vector4(-1,2,3,4), vector4(5,-6,7,8)", function()
            local input = cml.dot(cml.vector4(-1,2,3,4), cml.vector4(5,-6,7,8))
            local expected = 36
            assert.same(expected, input)
        end)

        it("quat_p(-1,2,3,4), quat_p(5,-6,7,8)", function()
            local input = cml.dot(cml.quat_p(-1,2,3,4), cml.quat_p(5,-6,7,8))
            local expected = 36
            assert.same(expected, input)
        end)

        it("quat_n(-1,2,3,4), quat_n(5,-6,7,8)", function()
            local input = cml.dot(cml.quat_n(-1,2,3,4), cml.quat_n(5,-6,7,8))
            local expected = 36
            assert.same(expected, input)
        end)

        describe("throws #error for", function()
            -- vector2 errors
            it("vector2()", function()
                assert.error(function() cml.dot(cml.vector2()) end)
            end)

            it("vector2(), vector3()", function()
                assert.error(function() cml.dot(cml.vector2(), cml.vector3()) end)
            end)

            it("vector2(), vector4()", function()
                assert.error(function() cml.dot(cml.vector2(), cml.vector4()) end)
            end)

            it("vector2(), vector2(), vector2()", function()
                assert.error(function() cml.dot(cml.vector2(), cml.vector2(), cml.vector2()) end)
            end)

            it("vector2(), 0", function()
                assert.error(function() cml.dot(cml.vector2(), 0) end)
            end)

            it("vector2(), {0,0}", function()
                assert.error(function() cml.dot(cml.vector2(), {0,0}) end)
            end)

            -- vector3 errors
            it("vector3()", function()
                assert.error(function() cml.dot(cml.vector3()) end)
            end)

            it("vector3(), vector2()", function()
                assert.error(function() cml.dot(cml.vector3(), cml.vector2()) end)
            end)

            it("vector3(), vector4()", function()
                assert.error(function() cml.dot(cml.vector3(), cml.vector4()) end)
            end)

            it("vector3(), vector3(), vector3()", function()
                assert.error(function() cml.dot(cml.vector3(), cml.vector3(), cml.vector3()) end)
            end)

            it("vector3(), 0", function()
                assert.error(function() cml.dot(cml.vector3(), 0) end)
            end)

            it("vector3(), {0,0,0}", function()
                assert.error(function() cml.dot(cml.vector3(), {0,0,0}) end)
            end)

            -- vector4 errors
            it("vector4()", function()
                assert.error(function() cml.dot(cml.vector4()) end)
            end)

            it("vector4(), vector2()", function()
                assert.error(function() cml.dot(cml.vector4(), cml.vector2()) end)
            end)

            it("vector4(), vector3()", function()
                assert.error(function() cml.dot(cml.vector4(), cml.vector3()) end)
            end)

            it("vector4(), vector4(), vector4()", function()
                assert.error(function() cml.dot(cml.vector4(), cml.vector4(), cml.vector4()) end)
            end)

            it("vector4(), 0", function()
                assert.error(function() cml.dot(cml.vector4(), 0) end)
            end)

            it("vector4(), {0,0,0,0}", function()
                assert.error(function() cml.dot(cml.vector4(), {0,0,0,0}) end)
            end)

            -- quat_p errors
            it("quat_p()", function()
                assert.error(function() cml.dot(cml.quat_p()) end)
            end)

            it("quat_p(), quat_n()", function()
                assert.error(function() cml.dot(cml.quat_p(), cml.quat_n()) end)
            end)

            it("quat_p(), vector4()", function()
                assert.error(function() cml.dot(cml.quat_p(), cml.vector4()) end)
            end)

            it("quat_p(), quat_p(), quat_p()", function()
                assert.error(function() cml.dot(cml.quat_p(), cml.quat_p(), cml.quat_p()) end)
            end)

            it("quat_p(), 0", function()
                assert.error(function() cml.dot(cml.quat_p(), 0) end)
            end)

            it("quat_p(), {0,0,0,0}", function()
                assert.error(function() cml.dot(cml.quat_p(), {0,0,0,0}) end)
            end)

            -- quat_n errors
            it("quat_n()", function()
                assert.error(function() cml.dot(cml.quat_n()) end)
            end)

            it("quat_n(), quat_p()", function()
                assert.error(function() cml.dot(cml.quat_n(), cml.quat_p()) end)
            end)

            it("quat_n(), vector4()", function()
                assert.error(function() cml.dot(cml.quat_n(), cml.vector4()) end)
            end)

            it("quat_n(), quat_n(), quat_n()", function()
                assert.error(function() cml.dot(cml.quat_n(), cml.quat_n(), cml.quat_n()) end)
            end)

            it("quat_n(), 0", function()
                assert.error(function() cml.dot(cml.quat_n(), 0) end)
            end)

            it("quat_n(), {0,0,0,0}", function()
                assert.error(function() cml.dot(cml.quat_n(), {0,0,0,0}) end)
            end)
        end)
    end)

    describe("cross", function()
        it("vector3(), vector3()", function()
            local input = cml.cross(cml.vector3(), cml.vector3())
            local expected = {0,0,0}
            assert.same(expected, input:totable())
        end)

        it("vector3(1,2,3), vector3(4,5,6)", function()
            local input = cml.cross(cml.vector3(1,2,3), cml.vector3(4,5,6))
            local expected = {-3,6,-3}
            assert.same(expected, input:totable())
        end)

        it("vector3(1,0,0), vector3(0,-1,0)", function()
            local input = cml.cross(cml.vector3(1,0,0), cml.vector3(0,-1,0))
            local expected = {0,0,-1}
            assert.same(expected, input:totable())
        end)

        describe("throws #error for", function()
            it("(no args)", function()
                assert.error(function() cml.cross() end)
            end)

            it("vector3()", function()
                assert.error(function() cml.cross(cml.vector3()) end)
            end)

            it("vector3(), vector3(), vector3()", function()
                assert.error(function() cml.cross(cml.vector3(), cml.vector3(), cml.vector3()) end)
            end)

            it("vector2(), vector2()", function()
                assert.error(function() cml.cross(cml.vector2(), cml.vector2()) end)
            end)

            it("vector4(), vector4()", function()
                assert.error(function() cml.cross(cml.vector4(), cml.vector4()) end)
            end)

            it("quat_p(), quat_p()", function()
                assert.error(function() cml.cross(cml.quat_p(), cml.quat_p()) end)
            end)

            it("quat_n(), quat_n()", function()
                assert.error(function() cml.cross(cml.quat_n(), cml.quat_n()) end)
            end)

            it("{1,0,0}, {0,-1,0}", function()
                assert.error(function() cml.cross({1,0,0}, {0,-1,0}) end)
            end)

            it("vector3(), vector2()", function()
                assert.error(function() cml.cross(cml.vector3(), cml.vector2()) end)
            end)

            it("vector3(), vector4()", function()
                assert.error(function() cml.cross(cml.vector3(), cml.vector4()) end)
            end)

            it("vector3(), quat_p()", function()
                assert.error(function() cml.cross(cml.vector3(), cml.quat_p()) end)
            end)

            it("vector3(), quat_n()", function()
                assert.error(function() cml.cross(cml.vector3(), cml.quat_n()) end)
            end)
        end)
    end)

    describe("outer", function()
        describe(testfmt:format("vector2"), function()
            it("(0,0), (0,0)", function()
                local A = cml.vector2(0,0)
                local B = cml.vector2(0,0)
                local input, expected = cml.outer(A,B), cml.matrix22(0,0,0,0)
                assert.same(expected:totable(), input:totable())
            end)

            it("(1,2), (2,3)", function()
                local A = cml.vector2(1,2)
                local B = cml.vector2(2,3)
                local input, expected = cml.outer(A,B), cml.matrix22(2,3,4,6)
                assert.same(expected:totable(), input:totable())
            end)
        end)

        describe(testfmt:format("vector3"), function()
            it("(0,0,0), (0,0,0)", function()
                local A = cml.vector3(0,0,0)
                local B = cml.vector3(0,0,0)
                local input, expected = cml.outer(A,B), cml.matrix33(0,0,0,0,0,0,0,0,0)
                assert.same(expected:totable(), input:totable())
            end)

            it("(1,2,3), (3,4,5)", function()
                local A = cml.vector3(1,2,3)
                local B = cml.vector3(3,4,5)
                local input, expected = cml.outer(A,B), cml.matrix33(3,4,5,6,8,10,9,12,15)
                assert.same(expected:totable(), input:totable())
            end)
        end)

        describe(testfmt:format("vector4"), function()
            it("(0,0,0), (0,0,0)", function()
                local A = cml.vector4(0,0,0)
                local B = cml.vector4(0,0,0)
                local input, expected = cml.outer(A,B), cml.matrix44(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
                assert.same(expected:totable(), input:totable())
            end)

            it("(1,2,3,4), (4,5,6,7)", function()
                local A = cml.vector4(1,2,3,4)
                local B = cml.vector4(4,5,6,7)
                local input, expected = cml.outer(A,B), cml.matrix44(4,5,6,7,8,10,12,14,12,15,18,21,16,20,24,28)
                assert.same(expected:totable(), input:totable())
            end)
        end)
    end)
end)
