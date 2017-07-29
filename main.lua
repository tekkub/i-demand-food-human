
math.randomseed(os.time())


require "lib/class"
local C = require "constants"
local Gila = require "lib/gila"
local House = require "house"


function love.load()

  House()
  love.graphics.setNewFont(C.FONT_SIZE)
  love.graphics.setBackgroundColor(C.COLORS.SECONDARY_A4)
end


function love.draw()
  Gila:Draw()
end
