
require "lib/class"


-- Test __call metamethod
local Class, Instance = class()
local called = false
function Instance.initialize()
  called = true
end

local x = Class()
assert(called)


print("All tests passed")
