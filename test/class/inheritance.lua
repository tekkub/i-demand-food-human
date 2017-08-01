
require "lib/class"


local function a1() end
local function a2() end
local function a3() end
local function b1() end
local function b2() end
local function c1() end
local function d1() end
local function d2() end
local function d3() end
local function e1() end
local function e2() end
local function f1() end


local Class1, Instance1 = class()
Class1.a = a1
Class1.b = b1
Class1.c = c1
Instance1.d = d1
Instance1.e = e1
Instance1.f = f1

local Class2, Instance2 = class(Class1)
Class2.a = a2
Class2.b = b2
Instance2.d = d2
Instance2.e = e2

local Class3, Instance3 = class(Class2)
Class3.a = a3
Instance3.d = d3


-- Test base class behaviour
local x = Class1()
assert(Class1.a == a1)
assert(Class1.b == b1)
assert(Class1.c == c1)
assert(x.d == d1)
assert(x.e == e1)
assert(x.f == f1)


-- Test inheritance
local y = Class2()
assert(Class2.a == a2)
assert(Class2.b == b2)
assert(Class2.c == c1)
assert(y.d == d2)
assert(y.e == e2)
assert(y.f == f1)


-- Test multiple inheritance
local z = Class3()
assert(Class3.a == a3)
assert(Class3.b == b2)
assert(Class3.c == c1)
assert(z.d == d3)
assert(z.e == e2)
assert(z.f == f1)


print("All tests passed")
