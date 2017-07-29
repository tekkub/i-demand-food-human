
local C = require "constants"
local Cat = require "cat"
local Room = require "room"

local House = {}


local food_row, food_col
local rooms = {}
local flat_rooms = {}


local function Initialize()
  Room:SetSize(C.ROOM_SIZE)
  local y_offset = C.HOUSE_MARGIN

  for row=1,C.NUM_ROWS do
    local x_offset = C.HOUSE_MARGIN
    rooms[row] = {}

    for col=1,C.NUM_COLS do
      local room = Room(x_offset, y_offset, row, col)
      room.row, room.col = row, col
      rooms[row][col] = room
      flat_rooms[room] = true

      x_offset = x_offset + C.ROOM_SIZE + C.ROOM_MARGIN
    end

    y_offset = y_offset + C.ROOM_SIZE + C.ROOM_MARGIN
  end

  House:Randomize()
end


function House:Randomize()
  food_row = math.random(C.NUM_ROWS)
  food_col = math.random(C.NUM_COLS)
  local cat_row, cat_col = Cat:Randomize(food_row, food_col, C.NUM_ROWS, C.NUM_COLS)

  for room in pairs(flat_rooms) do
    room:Reset(food_row, food_col)
  end

  rooms[cat_row][cat_col]:Light()
end


Initialize()
return House
