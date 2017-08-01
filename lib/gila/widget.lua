
local Class, Widget = class()


Class._orphans = {}


local function Draw(widget)
  love.graphics.push()

  if widget._dx and widget._dy then
    love.graphics.translate(widget._dx, widget._dy)
  end

  widget:Draw()
  for child in pairs(widget._children) do Draw(child) end

  love.graphics.pop()
end


function Class:Draw()
  for widget in pairs(Class._orphans) do Draw(widget) end
end


function Widget:Initialize(x, y)
  self._children = {}
  self._dx = x
  self._dy = y

  Class._orphans[self] = true
end


function Widget:SetParent(parent)
  if self._parent then self._parent._children[self] = nil end
  Class._orphans[self] = nil

  self._parent = parent
  if parent then
    parent._children[self] = true
  else
    Class._orphans[self] = true
  end
end


function Widget:Draw()
  error("Widget:Draw() not implemented")
end


return Class
