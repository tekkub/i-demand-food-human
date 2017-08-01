
local Class, Widget = class()


Class._orphans = {}


function Class:draw()
  for widget in pairs(Class._orphans) do widget:_draw() end
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


-- Internal method for drawing the widget and its children
-- To implement the actual rendering, override `draw()` instead
function Widget:_draw()
  love.graphics.push()

  if self._dx and self._dy then
    love.graphics.translate(self._dx, self._dy)
  end

  self:draw()
  for child in pairs(self._children) do child:_draw() end

  love.graphics.pop()
end


function Widget:draw()
  error("Widget:draw() not implemented")
end


return Class
