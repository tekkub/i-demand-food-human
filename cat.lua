
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local Room = require "room"


local Cat = Gila.Widget()


local CAT_COLOR = C.COLORS.SECONDARY_A3
local TEXT_COLOR = C.COLORS.SECONDARY_B2
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col, power


local function Moved()
  Cat:SetParent(Room:GetRoom(row, col))
  Agni:SendMessage("CatMoved", row, col)
end


function Cat:Randomize(food_row, food_col)
  power = 10
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


local function MoveLeft()
  if col <= 1 then return end
  col = col - 1
  power = power - 1
  Moved()
end


local function MoveRight()
  if col >= C.NUM_COLS then return end
  col = col + 1
  power = power - 1
  Moved()
end


local function MoveUp()
  if row <= 1 then return end
  row = row - 1
  power = power - 1
  Moved()
end


local function MoveDown()
  if row >= C.NUM_ROWS then return end
  row = row + 1
  power = power - 1
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
  if power == 0 then
    if key == "space" then Agni:SendMessage("StartNewGame") end
    return
  end

  if keymap[key] then keymap[key]() end
end


function Cat:OnWin()
  power = 0
end


local power_widget = Gila.Widget()


function power_widget:Draw()
  love.graphics.setColor(TEXT_COLOR)

  if power == 0 then
    love.graphics.print("Press space to restart", 30, 600)
  else
    love.graphics.print("Power left: ".. power, 30, 600)
  end
end


Agni:RegisterCallback(Cat, "KeyPressed")
Agni:RegisterCallback(Cat, "Win")


return Cat
