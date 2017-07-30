
local Gila = {
  Widget = require "lib/gila/widget",
  Button = require "lib/gila/button",
}


function Gila:Draw()
  self.Widget:Draw()
end

function Gila:MousePressed(...)
  self.Button:MousePressed(...)
end


function Gila:MouseReleased(...)
  self.Button:MouseReleased(...)
end


return Gila
