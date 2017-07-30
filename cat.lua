
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local CatPower = require "catpower"
local Room = require "room"


local Cat = Gila.Widget()


local ICON = love.graphics.newImage("assets/cat.png")

local row, col


local function Moved()
  Cat:SetParent(Room:GetRoom(row, col))
  Agni:SendMessage("CatMoved", row, col)
end


function Cat:Randomize(food_row, food_col)
  assert(food_row, "food_row required")
  assert(food_col, "food_col required")
  repeat
    row, col = Room:GetRandom()
  until row ~= food_row or col ~= food_col
  Moved()
end


function Cat:Draw()
  love.graphics.translate(16, 4)
  love.graphics.scale(0.25)
  love.graphics.setColor(C.COLORS.WHITE)
  love.graphics.draw(ICON, 0, 0)
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


local function MoveTowards(new_row, new_col)
  local d_row = new_row - row
  local d_col = new_col - col
  local move_row = d_row ~= 0
  local move_col = d_col ~= 0

  if move_row and move_col then
    local coin = math.random(2)
    move_row = coin == 1
    move_col = coin == 2
  end

  if move_row then
    row = row + (d_row > 0 and 1 or -1)
  elseif move_col then
    col = col + (d_col > 0 and 1 or -1)
  end

  if move_row or move_col then
    CatPower:Decrement()
    Moved()
  end
end


function Cat:OnRoomClicked(message, new_row, new_col)
  local dist = Room:Distance(row, col, new_row, new_col)
  if dist == 0 or not CatPower:CanMove(dist) then return end

  repeat
    MoveTowards(new_row, new_col)
  until row == new_row and col == new_col or not CatPower:CanMove()
end


Agni:RegisterCallback(Cat, "KeyPressed")
Agni:RegisterCallback(Cat, "RoomClicked")


return Cat
