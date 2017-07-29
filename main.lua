
math.randomseed(os.time())


require "lib/class"
local Gila = require "lib/gila"
local Messages = require "lib/messages"

local C = require "constants"
local House = require "house"


function love.load()
  love.graphics.setNewFont(C.FONT_SIZE)
  love.graphics.setBackgroundColor(C.COLORS.SECONDARY_A4)
end


function love.keypressed(key)
  Messages:SendMessage("KeyPressed", key)
end


function love.draw()
  Gila:Draw()
end
