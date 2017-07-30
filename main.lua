
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
  Gila:Draw()
end


function love.keypressed(key)
  Agni:SendMessage("KeyPressed", key)
end


function love.mousepressed(...)
  Gila:MousePressed(...)
end


function love.mousereleased(...)
  Gila:MouseReleased(...)
end
