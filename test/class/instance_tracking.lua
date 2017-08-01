
require "lib/class"


local Class1 = class()
local Class2 = class(Class1)
local Class3 = class(Class2)

local x = Class1()
local y = Class2()
local z = Class3()

assert(Class1._instances[x])
assert(Class1._instances[y])
assert(Class1._instances[z])
assert(not Class2._instances[x])
assert(Class2._instances[y])
assert(Class2._instances[z])
assert(not Class3._instances[x])
assert(not Class3._instances[y])
assert(Class3._instances[z])


print("All tests passed")
