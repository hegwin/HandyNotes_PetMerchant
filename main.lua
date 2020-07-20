local _, PetMerchant = ...
PetMerchant.points = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
local GameTooltip = GameTooltip
local LibStub = LibStub
local next = next
local UIParent = UIParent

local data = PetMerchant.data
local points = PetMerchant.points

-- local PetMerchantIcon = 'interface\\icons\\inv_misc_firekitty.blp'
local PetMerchantIcon = 'interface\\icons\\inv_corgi2.blp'
local ContinentMapIDs = { 12, 862, 875 }

-- Get currency/item icons from
-- https://wow.tools/files/#search=2004597&page=1&sort=0&desc=asc
local ExchangableIcons = {
  ['currency:1716'] = 'interface\\icons\\ui_horde_honorboundmedal.blp',
  ['item:163036'] = 'interface\\icons\\inv_currency_petbattle.blp'
}

local defaults = { profile = { icon_scale = 1.4, icon_alpha = 0.8 } }
local options = {}
local db

do
  -- custom iterator we use to iterate over every node in a given zone
  local function iterator(t, prev)
    if not t then return end

    local coord, value = next(t, prev)
    while coord do
      -- local icon = "interface\\icons\\inv_currency_petbattle.blp"

      if value then
        return coord, nil, PetMerchantIcon, 1.2, 0.8
      end

      coord, value = next(t, coord)
    end
  end

  function PetMerchant:GetNodes2(mapID, minimap)
    return iterator, points[mapID]
  end
end

local PetItem = {}

function PetItem:new(itemID)
  local pet = { itemLink = 'retrieving', itemIcon = 'Interface\\Icons\\Inv_misc_questionmark' }
  local petItem = Item:CreateFromItemID(itemID)

  petItem:ContinueOnItemLoad(function()
    pet.itemLink = petItem:GetItemLink()
    pet.itemIcon = petItem:GetItemIcon()
  end)

  return pet
end

function getNPCNameByID(npcID)
  local NPC_TOOLTIP = CreateFrame("GameTooltip", 'PetMerchantName', UIParent, "GameTooltipTemplate")
  NPC_TOOLTIP:SetOwner(UIParent, "ANCHOR_NONE")
  NPC_TOOLTIP:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(npcID))
  local name = _G['PetMerchantNameTextLeft1']:GetText()

  return name
end

-- plugin handler for HandyNotes
function PetMerchant:OnEnter(mapFile, coord)
  HandyNotes:Print("PetMerchant:OnEnter")
  if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
  else
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
  end

  local info = points[mapFile] and points[mapFile][coord]
  local merchant = info.npc
  local pets = info.pets

  local merchantName = getNPCNameByID(merchant)

  GameTooltip:SetText(merchantName)

  for _, pet in ipairs(pets) do
    local speciesID = pet.species
    -- https://wow.gamepedia.com/API_C_PetJournal.GetPetInfoBySpeciesID
    local speciesName = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
    -- https://wow.gamepedia.com/API_C_PetJournal.GetOwnedBattlePetString
    local ownedString = C_PetJournal.GetOwnedBattlePetString(speciesID)

    -- https://wow.gamepedia.com/ItemMixin#ItemMixin:ContinueOnItemLoad
    local petItem = PetItem:new(pet.item)

    -- https://wow.gamepedia.com/API_GameTooltip_AddDoubleLine
    GameTooltip:AddDoubleLine(petItem.itemLink, ownedString)
    GameTooltip:AddTexture(petItem.itemIcon, {margin={right=2}})

    local exchangable = pet.exchangable
    if exchangable then
      GameTooltip:AddLine(pet.cost)
      GameTooltip:AddTexture(ExchangableIcons[exchangable], {margin={left=16, right=4}})
    end
  end

  GameTooltip:Show()
end

function PetMerchant:OnLeave()
  HandyNotes:Print("PetMerchant:OnLeave")
  GameTooltip:Hide()
end

function PetMerchant:OnEnable()
  HandyNotes:Print("PetMerchant:OnEnable")

  local HereBeDragons = LibStub("HereBeDragons-2.0", true)
  if not HereBeDragons then
    HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Summer Festival plug-in will not work correctly. Please update HandyNotes to version 1.5.0 or newer.")
    return
  end

  --  Copy data for continent maps and normal maps
  for _, continentMapID in ipairs(ContinentMapIDs) do
    local maps = C_Map.GetMapChildrenInfo(continentMapID)

    for _, map in ipairs(maps) do
      local coords = data[map.mapID]
      if coords then
        for coord, info in pairs(coords) do
          local mapID = map.mapID
          points[mapID] = points[mapID] or {}
          points[mapID][coord] = info

          local mx, my = HandyNotes:getXY(coord)
          local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, mapID, continentMapID)
          print(mx, my, cx, cy)
          if cx and cy then
            points[continentMapID] = points[continentMapID] or {}
            points[continentMapID][HandyNotes:getCoord(cx, cy)] = info
          end
        end
      end
    end
  end
  -- Copy data end

  HandyNotes:RegisterPluginDB("PetMerchant", self, options)
  db = LibStub("AceDB-3.0"):New("HandyNotes_PetMerchantDB", defaults, "Default").profile
end

-- activate
LibStub("AceAddon-3.0"):NewAddon(PetMerchant, "HandyNotes_PetMerchant", "AceEvent-3.0")
