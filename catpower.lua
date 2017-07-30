
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"


local CatPower = Gila.Button(30, 600, 354, 50)


local TEXT_COLOR = C.COLORS.SECONDARY_B2

local power


function CatPower:Reset()
  power = 10
end


function CatPower:Decrement()
  power = power - 1
end


function CatPower:CanMove(dist)
  dist = dist or 1
  return power >= dist
end


function CatPower:OnKeyPressed(message, key)
  if power > 0 then return end
  if key == "space" then Agni:SendMessage("StartNewGame") end
end


function CatPower:OnWin()
  power = 0
end


function CatPower:OnClick()
  if power > 0 then return end
  Agni:SendMessage("StartNewGame")
end


function CatPower:Draw()
  love.graphics.setColor(TEXT_COLOR)

  if power == 0 then
    love.graphics.print("Click here\nor press space to restart", 0, 0)
  else
    love.graphics.print("CatPower left: ".. power, 0, 0)
  end
end


Agni:RegisterCallback(CatPower, "KeyPressed")
Agni:RegisterCallback(CatPower, "Win")


return CatPower
