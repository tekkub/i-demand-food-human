
local Room = require "room"

local Class, House = class()


local NUM_ROWS = 6
local NUM_COLS = 4
local ROOM_SIZE = 80
local HOUSE_MARGIN = 28
local ROOM_MARGIN = 14

local rooms = {}


function House:Initialize()
  Room:SetSize(ROOM_SIZE)
  local y_offset = HOUSE_MARGIN

  for row=1,NUM_ROWS do
    local x_offset = HOUSE_MARGIN
    rooms[row] = {}

    for col=1,NUM_COLS do
      local room = Room(x_offset, y_offset)
      room.row, room.col = row, col
      rooms[row][col] = room

      x_offset = x_offset + ROOM_SIZE + ROOM_MARGIN
    end

    y_offset = y_offset + ROOM_SIZE + ROOM_MARGIN
  end
end


return Class
