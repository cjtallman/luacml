
describe("matrix", function()
    local cml = require("luacml")
    --local eps = 1e-5
    local testfmt = "(%s)"

    local classes_2x2 =
    {
        matrix22 = cml.matrix22,
        matrix22_r = cml.matrix22_r,
        matrix22_c = cml.matrix22_c,
    }

    local classes_3x3 =
    {
        matrix33 = cml.matrix33,
        matrix33_r = cml.matrix33_r,
        matrix33_c = cml.matrix33_c,
    }

    local classes_4x4 =
    {
        matrix44 = cml.matrix44,
        matrix44_r = cml.matrix44_r,
        matrix44_c = cml.matrix44_c,
    }

    describe("constructor", function()
        for name, ctor in pairs(classes_2x2) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input, expected = ctor(), {1,0,0,1}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 4 floats", function()
                it(testname, function()
                    local input, expected = ctor(1,2,3,4), {1,2,3,4}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 4 floats", function()
                it(testname, function()
                    local input, expected = ctor{1,2,3,4}, {1,2,3,4}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(1,2,3,4)
                    local input, expected = ctor(A), {1,2,3,4}
                    assert.same(expected, input:totable())
                end)
            end)
        end

        for name, ctor in pairs(classes_3x3) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input, expected = ctor(), {1,0,0,0,1,0,0,0,1}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 9 floats", function()
                it(testname, function()
                    local input, expected = ctor(1,2,3,4,5,6,7,8,9), {1,2,3,4,5,6,7,8,9}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 9 floats", function()
                it(testname, function()
                    local input, expected = ctor{1,2,3,4,5,6,7,8,9}, {1,2,3,4,5,6,7,8,9}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(1,2,3,4,5,6,7,8,9)
                    local input, expected = ctor(A), {1,2,3,4,5,6,7,8,9}
                    assert.same(expected, input:totable())
                end)
            end)
        end

        for name, ctor in pairs(classes_4x4) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input, expected = ctor(), {1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 16 floats", function()
                it(testname, function()
                    local input, expected = ctor(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16), {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 16 floats", function()
                it(testname, function()
                    local input, expected = ctor{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}, {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
                    local input, expected = ctor(A), {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
                    assert.same(expected, input:totable())
                end)
            end)
        end

        -- Test 3x2 matrix
        do
            local name = "matrix32_r"
            local ctor = cml.matrix32_r
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input = ctor()
                    local expected =
                    {
                        1,0,
                        0,1,
                        0,0,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 6 floats", function()
                it(testname, function()
                    local input = ctor(11,12,21,22,31,32)
                    local expected =
                    {
                        11,12,
                        21,22,
                        31,32,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 6 floats", function()
                it(testname, function()
                    local input = ctor{11,12,21,22,31,32}
                    local expected =
                    {
                        11,12,
                        21,22,
                        31,32,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(11,12,21,22,31,32)
                    local input = ctor(A)
                    local expected =
                    {
                        11,12,
                        21,22,
                        31,32,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
        end

        -- Test 2x3 matrix
        do
            local name = "matrix23_c"
            local ctor = cml.matrix23_c
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input = ctor()
                    local expected =
                    {
                        1,0,0,
                        0,1,0,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 6 floats", function()
                it(testname, function()
                    local input = ctor(11,12,13,21,22,23)
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 6 floats", function()
                it(testname, function()
                    local input = ctor{11,12,13,21,22,23}
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(11,12,13,21,22,23)
                    local input = ctor(A)
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
        end

        -- Test 4x3 matrix
        do
            local name = "matrix43_r"
            local ctor = cml.matrix43_r
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input = ctor()
                    local expected =
                    {
                        1,0,0,
                        0,1,0,
                        0,0,1,
                        0,0,0,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 6 floats", function()
                it(testname, function()
                    local input = ctor(11,12,13,21,22,23,31,32,33,41,42,43)
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                        31,32,33,
                        41,42,43,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 6 floats", function()
                it(testname, function()
                    local input = ctor{11,12,13,21,22,23,31,32,33,41,42,43}
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                        31,32,33,
                        41,42,43,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(11,12,13,21,22,23,31,32,33,41,42,43)
                    local input = ctor(A)
                    local expected =
                    {
                        11,12,13,
                        21,22,23,
                        31,32,33,
                        41,42,43,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
        end

        -- Test 3x4 matrix
        do
            local name = "matrix34_c"
            local ctor = cml.matrix34_c
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            describe("default", function()
                it(testname, function()
                    local input = ctor()
                    local expected =
                    {
                        1,0,0,0,
                        0,1,0,0,
                        0,0,1,0,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with 6 floats", function()
                it(testname, function()
                    local input = ctor(11,12,13,14,21,22,23,24,31,32,33,34)
                    local expected =
                    {
                        11,12,13,14,
                        21,22,23,24,
                        31,32,33,34,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with array of 6 floats", function()
                it(testname, function()
                    local input = ctor{11,12,13,14,21,22,23,24,31,32,33,34}
                    local expected =
                    {
                        11,12,13,14,
                        21,22,23,24,
                        31,32,33,34,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
            describe("with matrix", function()
                it(testname, function()
                    local A = ctor(11,12,13,14,21,22,23,24,31,32,33,34)
                    local input = ctor(A)
                    local expected =
                    {
                        11,12,13,14,
                        21,22,23,24,
                        31,32,33,34,
                    }
                    assert.same(expected, input:totable())
                end)
            end)
        end
    end)

    describe("index", function()
        -- Test 2x2 matrices
        for name, ctor in pairs(classes_2x2) do
            local testname = testfmt:format(name)
            describe("with integer", function()
                local keys = {1,2,3,4}
                local input = {11,22,33,44}
                local expected =
                {
                    [1] = 11, [2] = 22,
                    [3] = 33, [4] = 44
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys = {"m11","m12","m21","m22"}
                local input = {11,22,33,44}
                local expected =
                {
                    m11 = 11, m12 = 22,
                    m21 = 33, m22 = 44
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x3 matrices
        for name, ctor in pairs(classes_3x3) do
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9}
                local input = {11,22,33,44,55,66,77,88,99}
                local expected =
                {
                    [1] = 11, [2] = 22, [3] = 33,
                    [4] = 44, [5] = 55, [6] = 66,
                    [7] = 77, [8] = 88, [9] = 99,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys = {"m11","m12","m13","m21","m22","m23","m31","m32","m33"}
                local input = {11,22,33,44,55,66,77,88,99}
                local expected =
                {
                    m11 = 11, m12 = 22, m13 = 33,
                    m21 = 44, m22 = 55, m23 = 66,
                    m31 = 77, m32 = 88, m33 = 99,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 4x4 matrices
        for name, ctor in pairs(classes_4x4) do
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
                local input = {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44}
                local expected =
                {
                    11, 12, 13, 14,
                    21, 22, 23, 24,
                    31, 32, 33, 34,
                    41, 42, 43, 44,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13","m14",
                    "m21","m22","m23","m24",
                    "m31","m32","m33","m34",
                    "m41","m42","m43","m44",
                }
                local input = {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44}
                local expected =
                {
                    m11 = 11, m12 = 12, m13 = 13, m14 = 14,
                    m21 = 21, m22 = 22, m23 = 23, m24 = 24,
                    m31 = 31, m32 = 32, m33 = 33, m34 = 34,
                    m41 = 41, m42 = 42, m43 = 43, m44 = 44,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x2 matrices
        do
            local name, ctor = "matrix32_r", cml.matrix32_r
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6}
                local input = {11,12,21,22,31,32}
                local expected =
                {
                    11, 12,
                    21, 22,
                    31, 32,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12",
                    "m21","m22",
                    "m31","m32",
                }
                local input = {11,12,21,22,31,32}
                local expected =
                {
                    m11 = 11, m12 = 12,
                    m21 = 21, m22 = 22,
                    m31 = 31, m32 = 32,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 2x3 matrices
        do
            local name, ctor = "matrix23_c", cml.matrix23_c
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6}
                local input = {11,12,13,21,22,23}
                local expected =
                {
                    11, 12, 13,
                    21, 22, 23,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13",
                    "m21","m22","m23",
                }
                local input = {11,12,13,21,22,23}
                local expected =
                {
                    m11 = 11, m12 = 12, m13 = 13,
                    m21 = 21, m22 = 22, m23 = 23,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 4x3 matrices
        do
            local name, ctor = "matrix43_r", cml.matrix43_r
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12}
                local input = {11,12,13,21,22,23,31,32,33,41,42,43}
                local expected =
                {
                    11, 12, 13,
                    21, 22, 23,
                    31, 32, 33,
                    41, 42, 43,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13",
                    "m21","m22","m23",
                    "m31","m32","m33",
                    "m41","m42","m43",
                }
                local input = {11,12,13,21,22,23,31,32,33,41,42,43}
                local expected =
                {
                    m11 = 11, m12 = 12, m13 = 13,
                    m21 = 21, m22 = 22, m23 = 23,
                    m31 = 31, m32 = 32, m33 = 33,
                    m41 = 41, m42 = 42, m43 = 43,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x4 matrices
        do
            local name, ctor = "matrix34_c", cml.matrix34_c
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12}
                local input = {11,12,13,14,21,22,23,24,31,32,33,34}
                local expected =
                {
                    11,12,13,14,
                    21,22,23,24,
                    31,32,33,34,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13","m14",
                    "m21","m22","m23","m24",
                    "m31","m32","m33","m34",
                }
                local input = {11,12,13,14,21,22,23,24,31,32,33,34}
                local expected =
                {
                    m11 = 11, m12 = 12, m13 = 13, m14 = 14,
                    m21 = 21, m22 = 22, m23 = 23, m24 = 24,
                    m31 = 31, m32 = 32, m33 = 33, m34 = 34,
                }
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            assert.same(expected[k], obj[k])
                        end)
                    end)
                end
            end)
        end
    end)

    describe("newindex", function()
        -- Test 2x2 matrices
        for name, ctor in pairs(classes_2x2) do
            local testname = testfmt:format(name)
            describe("with integer", function()
                local keys = {1,2,3,4,}
                local input = {11,12,21,22,}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys = {"m11","m12","m21","m22"}
                local input = {11,12,21,22,}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x3 matrices
        for name, ctor in pairs(classes_3x3) do
            local testname = testfmt:format(name)
            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,}
                local input = {11,12,13,21,22,23,31,32,33}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys = {"m11","m12","m13","m21","m22","m23","m31","m32","m33"}
                local input = {11,12,13,21,22,23,31,32,33}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 4x4 matrices
        for name, ctor in pairs(classes_4x4) do
            local testname = testfmt:format(name)
            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}
                local input = {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13","m14",
                    "m21","m22","m23","m24",
                    "m31","m32","m33","m34",
                    "m41","m42","m43","m44",
                }
                local input = {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x2 matrices
        do
            local name, ctor = "matrix32_r", cml.matrix32_r
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6}
                local input = {11,12,21,22,31,32}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12",
                    "m21","m22",
                    "m31","m32",
                }
                local input = {11,12,21,22,31,32}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 2x3 matrices
        do
            local name, ctor = "matrix23_c", cml.matrix23_c
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6}
                local input = {11,12,13,21,22,23}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13",
                    "m21","m22","m23",
                }
                local input = {11,12,13,21,22,23}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 4x3 matrices
        do
            local name, ctor = "matrix43_r", cml.matrix43_r
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12}
                local input = {11,12,13,21,22,23,31,32,33,41,42,43}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13",
                    "m21","m22","m23",
                    "m31","m32","m33",
                    "m41","m42","m43",
                }
                local input = {11,12,13,21,22,23,31,32,33,41,42,43}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end

        -- Test 3x4 matrices
        do
            local name, ctor = "matrix34_c", cml.matrix34_c
            local testname = testfmt:format(name)

            describe("with integer", function()
                local keys = {1,2,3,4,5,6,7,8,9,10,11,12}
                local input = {11,12,13,14,21,22,23,24,31,32,33,34}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)

            describe("with string", function()
                local keys =
                {
                    "m11","m12","m13","m14",
                    "m21","m22","m23","m24",
                    "m31","m32","m33","m34",
                }
                local input = {11,12,13,14,21,22,23,24,31,32,33,34}
                local expected = 100
                for _, k in ipairs(keys) do
                    describe(tostring(k), function()
                        it(testname, function()
                            local obj = ctor(input)
                            assert.is_userdata(obj)
                            obj[k] = 100
                            assert.same(expected, obj[k])
                        end)
                    end)
                end
            end)
        end
    end)

    describe("set", function()
        -- Test 2x2 matrices
        for name, ctor in pairs(classes_2x2) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)

            local input = {11,12,21,22}
            local expected = {1,2,3,4}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 3x3 matrices
        for name, ctor in pairs(classes_3x3) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)

            local input = {11,12,13,21,22,23,31,32,33}
            local expected = {1,2,3,4,5,6,7,8,9}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6,7,8,9})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6,7,8,9)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6,7,8,9))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 4x4 matrices
        for name, ctor in pairs(classes_4x4) do
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)

            local input = {11,12,13,14,21,22,23,24,31,32,33,34,41,42,43,44}
            local expected = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 2x3 matrices
        do
            local name, ctor = "matrix23_c", cml.matrix23_c
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            local input = {11,12,13,21,22,23}
            local expected = {1,2,3,4,5,6}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 3x2 matrices
        do
            local name, ctor = "matrix32_r", cml.matrix32_r
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            local input = {11,12,21,22,31,32}
            local expected = {1,2,3,4,5,6}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 3x4 matrices
        do
            local name, ctor = "matrix34_c", cml.matrix34_c
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            local input = {11,12,13,14,21,22,23,24,31,32,33,34}
            local expected = {1,2,3,4,5,6,7,8,9,10,11,12}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6,7,8,9,10,11,12})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6,7,8,9,10,11,12)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6,7,8,9,10,11,12))
                    assert.same(expected, obj:totable())
                end)
            end)
        end

        -- Test 4x3 matrices
        do
            local name, ctor = "matrix43_r", cml.matrix43_r
            local testname = testfmt:format(name)
            assert.is_table(ctor)
            assert.is_function((getmetatable(ctor) or {}).__call)
            local input = {11,12,13,21,22,23,31,32,33,41,42,43}
            local expected = {1,2,3,4,5,6,7,8,9,10,11,12}

            describe("by table", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set({1,2,3,4,5,6,7,8,9,10,11,12})
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by numbers", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(1,2,3,4,5,6,7,8,9,10,11,12)
                    assert.same(expected, obj:totable())
                end)
            end)

            describe("by matrix", function()
                it(testname, function()
                    local obj = ctor(input)
                    obj:set(ctor(1,2,3,4,5,6,7,8,9,10,11,12))
                    assert.same(expected, obj:totable())
                end)
            end)
        end
    end)
end)
