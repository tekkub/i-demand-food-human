
local Gila = require "lib/gila"
local Messages = require "lib/messages"

local C = require "constants"
local Room = require "room"


local Class, Cat = class(Gila.Widget)


local CAT_COLOR = C.COLORS.SECONDARY_A3
local TEXT_COLOR = C.COLORS.SECONDARY_B2
local VERTICES = {8, 0, 16, 8, 8, 16, 0, 8}

local row, col, power


local super = Cat.Initialize
function Cat:Initialize()
  Messages:RegisterCallback(self, "KeyPressed")
  Messages:RegisterCallback(self, "Win")
  super(self)
end


function Cat:Randomize(food_row, food_col)
  power = 10
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


local function SendMovedMessage()
  power = power - 1
  Messages:SendMessage("CatMoved", row, col)
end


local function MoveLeft()
  if col <= 1 then return end
  col = col - 1
  SendMovedMessage()
end


local function MoveRight()
  if col >= C.NUM_COLS then return end
  col = col + 1
  SendMovedMessage()
end


local function MoveUp()
  if row <= 1 then return end
  row = row - 1
  SendMovedMessage()
end


local function MoveDown()
  if row >= C.NUM_ROWS then return end
  row = row + 1
  SendMovedMessage()
end


function Cat:OnKeyPressed(message, key)
  if power == 0 then
    if key == "space" then Messages:SendMessage("StartNewGame") end
    return
  end

  if key == "up"    or key == "w" then MoveUp()    end
  if key == "left"  or key == "a" then MoveLeft()  end
  if key == "down"  or key == "s" then MoveDown()  end
  if key == "right" or key == "d" then MoveRight() end
end


function Cat:OnWin()
  power = 0
end


local power_widget = Gila.Widget()


local super_draw = power_widget.Draw
function power_widget:Draw()
  love.graphics.setColor(TEXT_COLOR)

  if power == 0 then
    love.graphics.print("Press space to restart", 30, 600)
  else
    love.graphics.print("Power left: ".. power, 30, 600)
  end

  super_draw(self)
end


local cat_singleton = Class()
return cat_singleton
