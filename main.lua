
require "lib/class"

math.randomseed(os.time())

local Gila = require "lib/gila"
local House = require "house"


function love.load()
  love.graphics.setNewFont(24)
  love.graphics.setBackgroundColor(46, 69, 57)

  House()
end


function love.draw()
  Gila:Draw()
end
