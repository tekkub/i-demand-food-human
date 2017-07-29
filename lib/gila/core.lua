
require "lib/class"


local Gila = class()
Gila.Widget = require "lib/gila/widget"


function Gila:Draw()
  self.Widget:Draw()
end


return Gila
