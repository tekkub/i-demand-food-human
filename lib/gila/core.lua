
local Gila = {
  Widget = require "lib/gila/widget",
  Button = require "lib/gila/button",
}


function Gila:draw()
  self.Widget:draw()
end

function Gila:on_mouse_pressed(...)
  self.Button:on_mouse_pressed(...)
end


function Gila:on_mouse_released(...)
  self.Button:on_mouse_released(...)
end


return Gila
