
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"


local Class, Room = class(Gila.Widget)


local LIT_COLOR = C.COLORS.PRIMARY_4
local DARK_COLOR = C.COLORS.COMPLEMENT_5
local TEXT_COLOR = C.COLORS.SECONDARY_B2

local rooms = {}


function Class:GetRandom()
  return math.random(C.NUM_ROWS), math.random(C.NUM_COLS)
end


function Class:GetRoom(row, col)
  return rooms[row][col]
end


local super = Room.Initialize
function Room:Initialize(x, y, row, col, ...)
  self._x = x
  self._y = y
  self._row = row
  self._col = col

  rooms[row] = rooms[row] or {}
  rooms[row][col] = self

  Agni:RegisterCallback(self, "CatMoved")
  Agni:RegisterCallback(self, "FoodMoved")

  return super(self, x, y, row, col, ...)
end


function Room:Reset(food_row, food_col)
  self._dist = math.abs(self._row - food_row) + math.abs(self._col - food_col)
  self._lit = false
end


function Room:Draw()
  love.graphics.translate(self._x, self._y)

  local color = self._lit and LIT_COLOR or DARK_COLOR
  love.graphics.setColor(color)
  love.graphics.rectangle("fill", 0, 0, C.ROOM_SIZE, C.ROOM_SIZE)

  if self._lit then
    love.graphics.setColor(TEXT_COLOR)
    love.graphics.print(self._dist, 4, 4)
  end
end


function Room:Light()
  self._lit = true
end


function Room:OnFoodMoved(message, row, col)
  self:Reset(row, col)
end


function Room:OnCatMoved(message, row, col)
  if row ~= self._row or col ~= self._col then return end
  self:Light()
end


return Class
