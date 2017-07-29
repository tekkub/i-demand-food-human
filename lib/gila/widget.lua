
local Class, Widget = class()

local widgets = {}
local parents = {}


function Class:Draw()
  for widget in pairs(widgets) do
    if not parents[widget] then widget:Draw() end
  end
end


function Widget:Initialize()
  widgets[self] = true
end


function Widget:SetParent(parent)
  parents[self] = parent
end


function Widget:Draw()
  self:DrawChildren()
end


function Widget:DrawChildren()
  for widget,parent in pairs(parents) do
    if parent == self then widget:Draw() end
  end
end


return Class
