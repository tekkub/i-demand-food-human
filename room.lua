
local C = require "constants"
local Cat = require "cat"
local Gila = require "lib/gila"
local Class, Room = class(Gila.Widget)


local LIT_COLOR = C.COLORS.PRIMARY_4
local DARK_COLOR = C.COLORS.COMPLEMENT_5
local TEXT_COLOR = C.COLORS.SECONDARY_B2
local FOOD_COLOR = C.COLORS.SECONDARY_B5


function Class:GetRandom()
  return math.random(C.NUM_ROWS), math.random(C.NUM_COLS)
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
  love.graphics.rectangle("fill", 0, 0, C.ROOM_SIZE, C.ROOM_SIZE)

  if Cat:IsInRoom(self._row, self._col) then Cat:Draw() end

  if self._lit then
    -- Distance text
    love.graphics.setColor(TEXT_COLOR)
    love.graphics.print(self._dist, 4, 4)

    -- Draw the food
    if self._dist == 0 then
      local offset = C.ROOM_SIZE/2
      local radius = C.ROOM_SIZE/8
      love.graphics.setColor(FOOD_COLOR)
      love.graphics.circle("fill", offset, offset, radius, 50)
    end
  end

  love.graphics.pop()
end


function Room:Light()
  self._lit = true
end


return Class
