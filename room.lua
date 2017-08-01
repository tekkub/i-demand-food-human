
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"


local Class, Room = class(Gila.Button)


local CARPET = love.graphics.newImage("assets/carpet.png")
local DARK_COLOR = C.COLORS.GREY_60
local LIT_COLOR = C.COLORS.PRIMARY_4
local TEXT_COLOR = C.COLORS.WHITE

local rooms = {}


function Class:distance(r1, c1, r2, c2)
  return math.abs(r1 - r2) + math.abs(c1 - c2)
end


function Class:get_random()
  return math.random(C.NUM_ROWS), math.random(C.NUM_COLS)
end


function Class:get_room(row, col)
  return rooms[row][col]
end


function Class:reset(row, col)
  for room in pairs(self._instances) do room:reset(row, col) end
end


function Room:initialize(x, y, row, col)
  self._row = row
  self._col = col

  rooms[row] = rooms[row] or {}
  rooms[row][col] = self

  Agni:register_callback(self, "cat_moved")

  return Room._super(self, "initialize", x, y, C.ROOM_SIZE, C.ROOM_SIZE)
end


function Room:reset(food_row, food_col)
  self._dist = Class:distance(self._row, self._col, food_row, food_col)
  self._lit = false
end


function Room:draw()
  love.graphics.push()
  love.graphics.scale(0.5)
  love.graphics.setColor(C.COLORS.WHITE)
  love.graphics.draw(CARPET, 0, 0)
  love.graphics.pop()

  if self._lit then
    love.graphics.setColor(TEXT_COLOR)
    love.graphics.print(self._dist, 4, 18)
  else
    love.graphics.setColor(DARK_COLOR)
    love.graphics.rectangle("fill", 0, 0, C.ROOM_SIZE, C.ROOM_SIZE)
  end
end


function Room:on_click()
  Agni:send_message("room_clicked", self._row, self._col)
end


function Room:on_cat_moved(message, row, col)
  if row ~= self._row or col ~= self._col then return end
  self._lit = true
end


return Class
