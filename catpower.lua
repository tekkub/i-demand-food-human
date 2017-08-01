
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"


local cat_power = Gila.Button(30, 600, 354, 80)


local TEXT_COLOR = C.COLORS.SECONDARY_B2

local power


function cat_power:reset()
  power = 10
end


function cat_power:decrement()
  power = power - 1
end


function cat_power:can_move(dist)
  dist = dist or 1
  return power >= dist
end


function cat_power:on_key_pressed(message, key)
  if power > 0 then return end
  if key == "space" then Agni:send_message("start_new_game") end
end


function cat_power:on_win()
  power = 0
end


function cat_power:on_click()
  if power > 0 then return end
  Agni:send_message("start_new_game")
end


function cat_power:draw()
  love.graphics.setColor(TEXT_COLOR)

  if power == 0 then
    love.graphics.print("Click here\nor press space to restart", 0, 0)
  else
    love.graphics.print("CatPower left: ".. power, 0, 0)
  end
end


Agni:register_callback(cat_power, "key_pressed")
Agni:register_callback(cat_power, "win")


return cat_power
