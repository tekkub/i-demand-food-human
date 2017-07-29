
local Agni = require "lib/agni"

local C = require "constants"
local Cat = require "cat"
local Room = require "room"


local House = {}


local food_row, food_col
local rooms = {}


local function Initialize()
  local y_offset = C.HOUSE_MARGIN

  for row=1,C.NUM_ROWS do
    local x_offset = C.HOUSE_MARGIN
    rooms[row] = {}

    for col=1,C.NUM_COLS do
      local room = Room(x_offset, y_offset, row, col)
      room.row, room.col = row, col
      rooms[row][col] = room

      x_offset = x_offset + C.ROOM_SIZE + C.ROOM_MARGIN
    end

    y_offset = y_offset + C.ROOM_SIZE + C.ROOM_MARGIN
  end

  Agni:RegisterCallback(House, "CatMoved")
  Agni:RegisterCallback(House, "StartNewGame", "Randomize")

  House:Randomize()
end


function House:Randomize()
  food_row, food_col = Room:GetRandom()
  Agni:SendMessage("FoodMoved", food_row, food_col)
  Cat:Randomize(food_row, food_col)
end


function House:OnCatMoved(message, row, col)
  local cat_room = rooms[row][col]
  Cat:SetParent(cat_room)

  if row ~= food_row or col ~= food_col then return end
  Agni:SendMessage("Win")
end


Initialize()
return House
