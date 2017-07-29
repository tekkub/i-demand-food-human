
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"


local CatPower = Gila.Widget()


local TEXT_COLOR = C.COLORS.SECONDARY_B2

local power


function CatPower:Reset()
  power = 10
end


function CatPower:Decrement()
  power = power - 1
end


function CatPower:CanMove()
  return power > 0
end


function CatPower:OnKeyPressed(message, key)
  if power > 0 then return end
  if key == "space" then Agni:SendMessage("StartNewGame") end
end


function CatPower:OnWin()
  power = 0
end


function CatPower:Draw()
  love.graphics.setColor(TEXT_COLOR)

  if power == 0 then
    love.graphics.print("Press space to restart", 30, 600)
  else
    love.graphics.print("CatPower left: ".. power, 30, 600)
  end
end


Agni:RegisterCallback(CatPower, "KeyPressed")
Agni:RegisterCallback(CatPower, "Win")


return CatPower
