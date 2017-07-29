
local Class, Widget = class()

local widgets = {}


function Class:Draw()
  for widget in pairs(widgets) do widget:Draw() end
end


function Widget:Initialize()
  widgets[self] = true
end


function Widget:Draw()
  assert(false, "Draw not implemented")
end


return Class
