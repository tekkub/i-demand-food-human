
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local CatPower = require "catpower"
local Room = require "room"


local Cat = Gila.Widget()


local CAT_COLOR = C.COLORS.SECONDARY_A3
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col, food_row, food_col


local function Moved()
  Cat:SetParent(Room:GetRoom(row, col))
  Agni:SendMessage("CatMoved", row, col)
end


function Cat:Randomize()
  assert(food_row and food_col, "food row and column not set")
  repeat
    row, col = Room:GetRandom()
  until row ~= food_row or col ~= food_col
  Moved()
end


function Cat:Draw()
  love.graphics.translate(32-8, 48-8)
  love.graphics.setColor(CAT_COLOR)
  love.graphics.polygon("fill", VERTICES)
end


function Cat:OnFoodMoved(message, row, col)
  food_row, food_col = row, col
end


local function MoveLeft()
  if col <= 1 then return end
  col = col - 1
  CatPower:Decrement()
  Moved()
end


local function MoveRight()
  if col >= C.NUM_COLS then return end
  col = col + 1
  CatPower:Decrement()
  Moved()
end


local function MoveUp()
  if row <= 1 then return end
  row = row - 1
  CatPower:Decrement()
  Moved()
end


local function MoveDown()
  if row >= C.NUM_ROWS then return end
  row = row + 1
  CatPower:Decrement()
  Moved()
end


local keymap = {
  up    = MoveUp,
  left  = MoveLeft,
  down  = MoveDown,
  right = MoveRight,
  w     = MoveUp,
  a     = MoveLeft,
  s     = MoveDown,
  d     = MoveRight,
}
function Cat:OnKeyPressed(message, key)
  if keymap[key] and CatPower:CanMove() then keymap[key]() end
end


Agni:RegisterCallback(Cat, "FoodMoved")
Agni:RegisterCallback(Cat, "KeyPressed")


return Cat
