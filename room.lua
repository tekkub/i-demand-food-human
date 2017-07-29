
local Gila = require "lib/gila"
local Class, Room = class(Gila.Widget)


local LIT_COLOR = {40, 26, 60}
local DARK_COLOR = {40, 26, 60}

function Class:SetSize(size)
  self._size = size
end


local super = Room.Initialize
function Room:Initialize(x, y, row, col, ...)
  self._x = x or 20
  self._y = y or 20
  self._row = row
  self._col = col

  return super(self, x, y, row, col, ...)
end


function Room:Draw()
  local color = self._lit and LIT_COLOR or DARK_COLOR
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", self._x, self._y, Class._size, Class._size)
end


return Class
