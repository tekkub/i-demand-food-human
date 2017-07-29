
local C = require "constants"
local Cat = {}


local CAT_COLOR = C.COLORS.SECONDARY_A3
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col


local function Randomize(num_rows, num_cols)
  row = math.random(num_rows)
  col = math.random(num_cols)
end


function Cat:Randomize(food_row, food_col, num_rows, num_cols)
  repeat
    Randomize(num_rows, num_cols)
  until row ~= food_row or col ~= food_col
  print(row, col)
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
