
local Agni = require "lib/agni"

local C = require "constants"
local cat = require "cat"
local cat_power = require "catpower"
local food = require "food"
local Room = require "room"


local house = {}


local function initialize()
  local y_offset = C.HOUSE_MARGIN

  for row=1,C.NUM_ROWS do
    local x_offset = C.HOUSE_MARGIN

    for col=1,C.NUM_COLS do
      Room(x_offset, y_offset, row, col)
      x_offset = x_offset + C.ROOM_SIZE + C.ROOM_MARGIN
    end

    y_offset = y_offset + C.ROOM_SIZE + C.ROOM_MARGIN
  end

  Agni:register_callback(house, "start_new_game")

  house:on_start_new_game()
end


function house:on_start_new_game()
  local row, col = food:randomize()
  Room:reset(row, col)
  cat:randomize(row, col)
  cat_power:reset()
end


initialize()
