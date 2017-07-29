
local C = require "constants"
local Cat = {}


local CAT_COLOR = C.COLORS.SECONDARY_A3
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col


local function Randomize()
  row = math.random(C.NUM_ROWS)
  col = math.random(C.NUM_COLS)
end


function Cat:Randomize(food_row, food_col)
  repeat
    Randomize()
  until row ~= food_row or col ~= food_col
  return row, col
end


function Cat:IsInRoom(_row, _col)
  return row == _row and col == _col
end


function Cat:Draw()
  love.graphics.push()
  love.graphics.translate(32-8, 48-8)

  love.graphics.setColor(CAT_COLOR)
  love.graphics.polygon("fill", VERTICES)

  love.graphics.pop()
end


return Cat
