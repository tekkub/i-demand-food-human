
require "lib/class"


local Class1, Instance1 = class()
local Class2, Instance2 = class(Class1)
local Class3, Instance3 = class(Class2)

local v1, v2
function Instance1:test(v) v1 = v end
function Instance2:test(v) v2 = v end
function Instance3:test(v) v3 = v end

local x = Class1()
local y = Class2()
local z = Class3()

v1, v2, v3 = nil
x:super("test", 1)
assert(not v1)
assert(not v2)
assert(not v3)

v1, v2, v3 = nil
y:super("test", 1)
assert(v1 == 1)
assert(not v2)
assert(not v3)

v1, v2, v3 = nil
z:super("test", 1)
assert(not v1)
assert(v2 == 1)
assert(not v3)


print("All tests passed")
