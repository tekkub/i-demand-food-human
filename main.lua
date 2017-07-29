
require "lib/class"

local Gila = require "lib/gila"


function love.load()
  love.graphics.setBackgroundColor(46, 69, 57)
end


function love.draw()
  Gila:Draw()
end
