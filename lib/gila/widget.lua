
local Class, Widget = class()

local widgets = {}
local parents = {}


local function Draw(widget)
  love.graphics.push()

  widget:Draw()

  for child,parent in pairs(parents) do
    if parent == widget then Draw(child) end
  end

  love.graphics.pop()
end


function Class:Draw()
  for widget in pairs(widgets) do
    if not parents[widget] then Draw(widget) end
  end
end


function Widget:Initialize()
  widgets[self] = true
end


function Widget:SetParent(parent)
  parents[self] = parent
end


function Widget:Draw()
  error("Widget:Draw() not implemented")
end


return Class
