
local Agni = {}

local callbacks = {}


function Agni:RegisterCallback(context, message, func)
	assert(context, "`context` must not be nil")
	assert(type(context) == "table", "`context` must be a table")
	assert(message, "`message` must not be nil")
	if not callbacks[message] then callbacks[message] = {} end
  if not func then func = "On".. message end
	callbacks[message][context] = func
end


function Agni:SendMessage(message, ...)
	assert(message, "`message` must not be nil")
	if not callbacks[message] then return end

	for context,func in pairs(callbacks[message]) do
    local f = context[func] or func
		f(context, message, ...)
	end
end


return Agni
