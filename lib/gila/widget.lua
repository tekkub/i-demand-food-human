
local Class, Widget = class()

local widgets = {}
local parents = {}


function Class:Draw()
  for widget in pairs(widgets) do
    if not parents[widget] then
      love.graphics.push()
      widget:Draw()
      for child,parent in pairs(parents) do
        if parent == widget then child:Draw() end
      end
      love.graphics.pop()
    end
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
