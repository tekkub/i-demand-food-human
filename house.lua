
local Messages = require "lib/messages"

local C = require "constants"
local Cat = require "cat"
local Room = require "room"


local House = {}


local food_row, food_col
local rooms = {}
local flat_rooms = {}


local function Initialize()
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

  Messages:RegisterCallback(House, "CatMoved")
end


function House:Randomize()
  food_row, food_col = Room:GetRandom()
  local cat_row, cat_col = Cat:Randomize(food_row, food_col)

  for room in pairs(flat_rooms) do
    room:Reset(food_row, food_col)
  end

  local cat_room = rooms[cat_row][cat_col]
  cat_room:Light()
  Cat:SetParent(cat_room)
end


function House:OnCatMoved(message, row, col)
  local cat_room = rooms[row][col]
  Cat:SetParent(cat_room)
end


Initialize()
return House
