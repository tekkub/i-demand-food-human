
local Widget = require "lib/gila/widget"


local Class, Button = class(Widget)

local buttons = {}


function Class:MousePressed(...)
  for button in pairs(buttons) do button:MousePressed(...) end
end


function Class:MouseReleased(...)
  for button in pairs(buttons) do button:MouseReleased(...) end
end


local super = Button.Initialize
function Button:Initialize()
  buttons[self] = true

  return super(self)
end


function Button:SetOffset(x, y)
  self._dx = x
  self._dy = y
end


function Button:SetSize(w, h)
  self._width  = w
  self._height = h
end


function Button:OnClick(mouse_button)
  -- override me!
end


function Button:InsideMe(x, y)
  if x < self._dx then return false end
  if y < self._dy then return false end
  if x > (self._dx + self._width) then return false end
  if y > (self._dy + self._height) then return false end
  return true
end


function Button:MousePressed(x, y, mouse_button, is_touch)
  if self:InsideMe(x, y) then self._clicking = mouse_button end
end


function Button:MouseReleased(x, y, mouse_button, is_touch)
  if self._clicking == mouse_button and self:InsideMe(x, y) then
    self:OnClick(mouse_button)
  end

  self._clicking = nil
end


return Class
