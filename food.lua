
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local Room = require "room"


local food = Gila.Widget()


local ICON = love.graphics.newImage("assets/food.png")

local row, col, shown


function food:draw()
  if not shown then return end

  love.graphics.translate(16, 28)
  love.graphics.scale(0.25)
  love.graphics.setColor(C.COLORS.WHITE)
  love.graphics.draw(ICON, 0, 0)
end


function food:randomize()
  shown = false
  row, col = Room:get_random()
  self:set_parent(Room:get_room(row, col))
  return row, col
end


function food:on_cat_moved(message, cat_row, cat_col)
  shown = (cat_row == row and cat_col == col)
  if shown then Agni:send_message("win") end
end


Agni:register_callback(food, "cat_moved")

return food
