
local Widget = require "lib/gila/widget"


local Class, Button = class(Widget)


function Class:MousePressed(x, y, mouse_button, is_touch)
  for button in pairs(self._instances) do
    if button:IsInsideMe(x, y) then
      button._clicking = mouse_button
    end
  end
end


function Class:MouseReleased(x, y, mouse_button, is_touch)
  for button in pairs(self._instances) do
    if button._clicking == mouse_button and button:IsInsideMe(x, y) then
      button:OnClick(mouse_button)
    end

    button._clicking = nil
  end
end


local super = Button.Initialize
function Button:Initialize(x, y, w, h)
  self._width  = w
  self._height = h

  return super(self, x, y)
end


function Button:OnClick(mouse_button)
  -- override me!
end


function Button:IsInsideMe(x, y)
  local has_attrs = self._dx and self._dy and self._width and self._height
  if not has_attrs then return false end

  if x < self._dx then return false end
  if y < self._dy then return false end
  if x > (self._dx + self._width) then return false end
  if y > (self._dy + self._height) then return false end
  return true
end


return Class
