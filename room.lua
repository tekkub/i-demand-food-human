
local Colors = require "colors"
local Gila = require "lib/gila"
local Class, Room = class(Gila.Widget)


local LIT_COLOR = Colors.primary_4
local DARK_COLOR = Colors.complement_5

function Class:SetSize(size)
  self._size = size
end


local super = Room.Initialize
function Room:Initialize(x, y, row, col, ...)
  self._x = x
  self._y = y
  self._row = row
  self._col = col

  return super(self, x, y, row, col, ...)
end


function Room:Reset(food_row, food_col)
  self._dist = math.abs(self.row - food_row) + math.abs(self.col - food_col)
  self._lit = false
end


function Room:Draw()
  love.graphics.push()
  love.graphics.translate(self._x, self._y)

  local color = self._lit and LIT_COLOR or DARK_COLOR
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", 0, 0, Class._size, Class._size)

  love.graphics.pop()
end


return Class
