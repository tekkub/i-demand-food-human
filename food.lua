
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local Room = require "room"


local Food = Gila.Widget()


local FOOD_COLOR = C.COLORS.SECONDARY_B5

local row, col, shown


function Food:Draw()
  if not shown then return end

  local offset = C.ROOM_SIZE/2
  local radius = C.ROOM_SIZE/8
  love.graphics.setColor(FOOD_COLOR)
  love.graphics.circle("fill", offset, offset, radius, 50)
end


function Food:Randomize()
  shown = false
  row, col = Room:GetRandom()
  self:SetParent(Room:GetRoom(row, col))
  Agni:SendMessage("FoodMoved", row, col)
end


function Food:OnCatMoved(message, cat_row, cat_col)
  shown = (cat_row == row and cat_col == col)
  if shown then Agni:SendMessage("Win") end
end


Agni:RegisterCallback(Food, "CatMoved")

return Food
