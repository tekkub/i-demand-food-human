
local C = require "constants"
local Room = require "room"
local Gila = require "lib/gila"
local Class, Cat = class(Gila.Widget)


local CAT_COLOR = C.COLORS.SECONDARY_A3
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col


function Cat:Randomize(food_row, food_col)
  repeat
    row, col = Room:GetRandom()
  until row ~= food_row or col ~= food_col
  return row, col
end


function Cat:Draw()
  love.graphics.push()
  love.graphics.translate(32-8, 48-8)

  love.graphics.setColor(CAT_COLOR)
  love.graphics.polygon("fill", VERTICES)

  love.graphics.pop()
end


local cat_singleton = Class()
return cat_singleton
