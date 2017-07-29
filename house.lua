
local Agni = require "lib/agni"

local C = require "constants"
local Cat = require "cat"
local Food = require "food"
local Room = require "room"


local House = {}


local food_row, food_col


local function Initialize()
  local y_offset = C.HOUSE_MARGIN

  for row=1,C.NUM_ROWS do
    local x_offset = C.HOUSE_MARGIN

    for col=1,C.NUM_COLS do
      Room(x_offset, y_offset, row, col)
      x_offset = x_offset + C.ROOM_SIZE + C.ROOM_MARGIN
    end

    y_offset = y_offset + C.ROOM_SIZE + C.ROOM_MARGIN
  end

  Agni:RegisterCallback(House, "StartNewGame", "Randomize")

  House:Randomize()
end


function House:Randomize()
  Food:Randomize()
  Cat:Randomize()
end


Initialize()
return House
