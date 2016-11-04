
describe("cml", function()
    local cml = require("luacml")

    --local eps = 1e-5

    local classes =
    {
        vector2 = cml.vector2,
        vector3 = cml.vector3,
        vector4 = cml.vector4,
        quat = cml.quat,
        quat_p = cml.quat_p,
        quat_n = cml.quat_n,
    }

    describe("dot", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = nil, B = nil, expected = 0 },
                { A = {-1,2}, B = {3,-4}, expected = -11 },
            },
            vector3 =
            {
                { A = nil, B = nil, expected = 0 },
                { A = {-1,2,3}, B = {4,-5,6}, expected = 4 },
            },
            vector4 =
            {
                { A = nil, B = nil, expected = 0 },
                { A = {-1,2,3,4}, B = {5,-6,7,8}, expected = 36 },
            },
            quat =
            {
                { A = nil, B = nil, expected = 1 },
                { A = {-1,2,3,4}, B = {5,-6,7,8}, expected = 36 },
            },
            quat_p =
            {
                { A = nil, B = nil, expected = 1 },
                { A = {-1,2,3,4}, B = {5,-6,7,8}, expected = 36 },
            },
            quat_n =
            {
                { A = nil, B = nil, expected = 1 },
                { A = {-1,2,3,4}, B = {5,-6,7,8}, expected = 36 },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.dot(A, B), seed.expected
                    assert.same(expected, input)
                end)
            end
        end

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
        local test_seeds =
        {
            vector3 =
            {
                { A = nil, B = nil, expected = {0,0,0} },
                { A = {1,2,3}, B = {4,5,6}, expected = {-3,6,-3} },
                { A = {1,0,0}, B = {0,-1,0}, expected = {0,0,-1} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.cross(A, B), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end

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
        local test_seeds =
        {
            vector2 =
            {
                { A = nil, B = nil, expected = {0,0,0,0} },
                { A = {1, 2}, B = {3, 4}, expected = {3,4,6,8} },
            },
            vector3 =
            {
                { A = nil, B = nil, expected = {0,0,0,0,0,0,0,0,0} },
                { A = {1,2,3}, B = {3,4,5}, expected = {3,4,5,6,8,10,9,12,15} },
            },
            vector4 =
            {
                { A = nil, B = nil, expected = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0} },
                { A = {1,2,3,4}, B = {4,5,6,7}, expected = {4,5,6,7,8,10,12,14,12,15,18,21,16,20,24,28} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.outer(A, B), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end
    end)

    describe("perp_dot", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = nil, B = nil, expected = 0 },
                { A = {1, 2}, B = {3, 4}, expected = -2 },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.perp_dot(A, B), seed.expected
                    assert.same(expected, input)
                end)
            end
        end
    end)

    describe("triple_product", function()
        local test_seeds =
        {
            vector3 =
            {
                { A = nil, B = nil, C = nil, expected = 0 },
                { A = {1,2,3}, B = {4,5,6}, C = {7,8,9}, expected = 0 },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local C = (seed.C ~= nil) and ctor(seed.C) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B), tostring(C))
                it(testname, function()
                    local input, expected = cml.triple_product(A, B, C), seed.expected
                    assert.same(expected, input)
                end)
            end
        end
    end)

    describe("unit_cross", function()
        local test_seeds =
        {
            vector3 =
            {
                { A = {1,2,3}, B = {4,5,6}, expected = {-3/math.sqrt(54),6/math.sqrt(54),-3/math.sqrt(54)} },
                { A = {10,0,0}, B = {0,-10,0}, expected = {0,0,-1} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = (seed.A ~= nil) and ctor(seed.A) or ctor()
                local B = (seed.B ~= nil) and ctor(seed.B) or ctor()
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.unit_cross(A, B), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end
    end)

    describe("cross_cardinal", function()
        local test_seeds =
        {
            vector3 =
            {
                { A = {1,2,3}, B = 1, expected = {0,3,-2} },
                { A = {1,2,3}, B = 2, expected = {-3,0,1} },
                { A = {1,2,3}, B = 3, expected = {2,-1,0} },
                { A = 1, B = {1,2,3}, expected = {0,-3,2} },
                { A = 2, B = {1,2,3}, expected = {3,0,-1} },
                { A = 3, B = {1,2,3}, expected = {-2,1,0} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s , %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = type(seed.A) == "table" and ctor(seed.A) or type(seed.A) == "nil" and ctor() or seed.A
                local B = type(seed.B) == "table" and ctor(seed.B) or type(seed.B) == "nil" and ctor() or seed.B
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.cross_cardinal(A, B), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end
    end)

    describe("length", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = nil, expected = 0 },
                { A = {1,2}, expected = math.sqrt(5) },
            },
            vector3 =
            {
                { A = nil, expected = 0 },
                { A = {1,2,3}, expected = math.sqrt(14) },
            },
            vector4 =
            {
                { A = nil, expected = 0 },
                { A = {1,2,3,4}, expected = math.sqrt(30) },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = type(seed.A) == "table" and ctor(seed.A) or type(seed.A) == "nil" and ctor() or seed.A
                local testname = testfmt:format(tostring(A))
                it(testname, function()
                    local input, expected = cml.length(A), seed.expected
                    assert.same(expected, input)
                end)
            end
        end
    end)

    describe("length_squared", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = nil, expected = 0 },
                { A = {1,2}, expected = 5 },
            },
            vector3 =
            {
                { A = nil, expected = 0 },
                { A = {1,2,3}, expected = 14 },
            },
            vector4 =
            {
                { A = nil, expected = 0 },
                { A = {1,2,3,4}, expected = 30 },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = type(seed.A) == "table" and ctor(seed.A) or type(seed.A) == "nil" and ctor() or seed.A
                local testname = testfmt:format(tostring(A))
                it(testname, function()
                    local input, expected = cml.length_squared(A), seed.expected
                    assert.same(expected, input)
                end)
            end
        end
    end)

    describe("normalize", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = {1,2}, expected = {1/math.sqrt(5), 2/math.sqrt(5)} },
            },
            vector3 =
            {
                { A = {1,2,3}, expected = {1/math.sqrt(14),2/math.sqrt(14),3/math.sqrt(14)} },
            },
            vector4 =
            {
                { A = {1,2,3,4}, expected = {1/math.sqrt(30),2/math.sqrt(30),3/math.sqrt(30),4/math.sqrt(30)} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = type(seed.A) == "table" and ctor(seed.A) or type(seed.A) == "nil" and ctor() or seed.A
                local testname = testfmt:format(tostring(A))
                it(testname, function()
                    local input, expected = cml.normalize(A), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end
    end)

    describe("project_to_hplane", function()
        local test_seeds =
        {
            vector2 =
            {
                { A = {1,2}, B = {1,0}, expected = {0,2} },
            },
            vector3 =
            {
                { A = {1,2,3}, B = {0,1,0}, expected = {1,0,3}},
            },
            vector4 =
            {
                { A = {1,2,3,4}, B = {0,0,1,0}, expected = {1,2,0,4} },
            },
        }

        for name, seeds in pairs(test_seeds) do
            local testfmt = "( %s )"
            local ctor = classes[name]
            for _, seed in ipairs(seeds) do
                local A = type(seed.A) == "table" and ctor(seed.A) or type(seed.A) == "nil" and ctor() or seed.A
                local B = type(seed.B) == "table" and ctor(seed.B) or type(seed.B) == "nil" and ctor() or seed.B
                local testname = testfmt:format(tostring(A), tostring(B))
                it(testname, function()
                    local input, expected = cml.project_to_hplane(A,B), seed.expected
                    assert.same(expected, input:totable())
                end)
            end
        end
    end)
end)
