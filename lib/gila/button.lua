
local Widget = require "lib/gila/widget"


local Class, Button = class(Widget)


function Class:on_mouse_pressed(x, y, mouse_button, is_touch)
  for button in pairs(self._instances) do
    if button:is_inside_me(x, y) then
      button._clicking = mouse_button
    end
  end
end


function Class:on_mouse_released(x, y, mouse_button, is_touch)
  for button in pairs(self._instances) do
    if button._clicking == mouse_button and button:is_inside_me(x, y) then
      button:on_click(mouse_button)
    end

    button._clicking = nil
  end
end


function Button:initialize(x, y, w, h)
  self._width  = w
  self._height = h

  return Button._super(self, "initialize", x, y)
end


function Button:on_click(mouse_button)
  -- override me!
end


function Button:is_inside_me(x, y)
  local has_attrs = self._dx and self._dy and self._width and self._height
  if not has_attrs then return false end

  if x < self._dx then return false end
  if y < self._dy then return false end
  if x > (self._dx + self._width) then return false end
  if y > (self._dy + self._height) then return false end
  return true
end


return Class
