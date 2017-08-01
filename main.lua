
math.randomseed(os.time())


require "lib/class"
local Agni = require "lib/agni"
local Gila = require "lib/gila"

require "house"
local C = require "constants"


function love.load()
  love.graphics.setNewFont(C.FONT_SIZE)
  love.graphics.setBackgroundColor(C.COLORS.SECONDARY_A4)
end


function love.draw()
  Gila:draw()
end


function love.keypressed(key)
  Agni:send_message("key_pressed", key)
end


function love.mousepressed(...)
  Gila:on_mouse_pressed(...)
end


function love.mousereleased(...)
  Gila:on_mouse_released(...)
end
