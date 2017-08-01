
local Class, Widget = class()


Class._orphans = {}


local function draw(widget)
  love.graphics.push()

  if widget._dx and widget._dy then
    love.graphics.translate(widget._dx, widget._dy)
  end

  widget:draw()
  for child in pairs(widget._children) do draw(child) end

  love.graphics.pop()
end


function Class:draw()
  for widget in pairs(Class._orphans) do draw(widget) end
end


function Widget:initialize(x, y)
  self._children = {}
  self._dx = x
  self._dy = y

  Class._orphans[self] = true
end


function Widget:set_parent(parent)
  if self._parent then self._parent._children[self] = nil end
  Class._orphans[self] = nil

  self._parent = parent
  if parent then
    parent._children[self] = true
  else
    Class._orphans[self] = true
  end
end


function Widget:draw()
  error("Widget:draw() not implemented")
end


return Class
