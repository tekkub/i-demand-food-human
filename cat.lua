
local Agni = require "lib/agni"
local Gila = require "lib/gila"

local C = require "constants"
local cat_power = require "catpower"
local Room = require "room"


local cat = Gila.Widget()


local ICON = love.graphics.newImage("assets/cat.png")

local row, col


local function moved()
  cat:set_parent(Room:get_room(row, col))
  Agni:send_message("cat_moved", row, col)
end


function cat:randomize(food_row, food_col)
  assert(food_row, "food_row required")
  assert(food_col, "food_col required")
  repeat
    row, col = Room:get_random()
  until row ~= food_row or col ~= food_col
  moved()
end


function cat:draw()
  love.graphics.translate(16, 4)
  love.graphics.scale(0.25)
  love.graphics.setColor(C.COLORS.WHITE)
  love.graphics.draw(ICON, 0, 0)
end


local function move_left()
  if col <= 1 then return end
  col = col - 1
  cat_power:decrement()
  moved()
end


local function move_right()
  if col >= C.NUM_COLS then return end
  col = col + 1
  cat_power:decrement()
  moved()
end


local function move_up()
  if row <= 1 then return end
  row = row - 1
  cat_power:decrement()
  moved()
end


local function move_down()
  if row >= C.NUM_ROWS then return end
  row = row + 1
  cat_power:decrement()
  moved()
end


local keymap = {
  up    = move_up,
  left  = move_left,
  down  = move_down,
  right = move_right,
  w     = move_up,
  a     = move_left,
  s     = move_down,
  d     = move_right,
}
function cat:on_key_pressed(message, key)
  if keymap[key] and cat_power:can_move() then keymap[key]() end
end


local function move_towards(new_row, new_col)
  local d_row = new_row - row
  local d_col = new_col - col
  local move_row = d_row ~= 0
  local move_col = d_col ~= 0

  if move_row and move_col then
    local coin = math.random(2)
    move_row = coin == 1
    move_col = coin == 2
  end

  if move_row then
    row = row + (d_row > 0 and 1 or -1)
  elseif move_col then
    col = col + (d_col > 0 and 1 or -1)
  end

  if move_row or move_col then
    cat_power:decrement()
    moved()
  end
end


function cat:on_room_clicked(message, new_row, new_col)
  local dist = Room:distance(row, col, new_row, new_col)
  if dist == 0 or not cat_power:can_move(dist) then return end

  repeat
    move_towards(new_row, new_col)
  until row == new_row and col == new_col or not cat_power:can_move()
end


Agni:register_callback(cat, "key_pressed")
Agni:register_callback(cat, "room_clicked")


return cat
