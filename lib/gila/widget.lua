
local Class, Widget = class()


local function Draw(widget)
  love.graphics.push()

  if widget._dx and widget._dy then
    love.graphics.translate(widget._dx, widget._dy)
  end

  widget:Draw()

  for child,parent in pairs(Class._parents) do
    if parent == widget then Draw(child) end
  end

  love.graphics.pop()
end


function Class:Draw()
  for widget in pairs(self._instances) do
    if not self._parents[widget] then Draw(widget) end
  end
end


function Widget:Initialize(x, y)
  self._dx = x
  self._dy = y
end


function Widget:SetParent(parent)
  Class._parents[self] = parent
end


function Widget:Draw()
  error("Widget:Draw() not implemented")
end


return Class
