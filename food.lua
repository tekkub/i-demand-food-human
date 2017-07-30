
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local Room = require "room"


local Food = Gila.Widget()


local ICON = love.graphics.newImage("assets/food.png")

local row, col, shown


function Food:Draw()
  if not shown then return end

  love.graphics.translate(16, 28)
  love.graphics.scale(0.25)
  love.graphics.setColor(C.COLORS.WHITE)
  love.graphics.draw(ICON, 0, 0)
end


function Food:Randomize()
  shown = false
  row, col = Room:GetRandom()
  self:SetParent(Room:GetRoom(row, col))
  return row, col
end


function Food:OnCatMoved(message, cat_row, cat_col)
  shown = (cat_row == row and cat_col == col)
  if shown then Agni:SendMessage("Win") end
end


Agni:RegisterCallback(Food, "CatMoved")

return Food
