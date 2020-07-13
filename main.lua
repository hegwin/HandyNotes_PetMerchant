local _, PetMerchant = ...
PetMerchant.points = {}

local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

local GameTooltip = GameTooltip
local LibStub = LibStub
local next = next
local UIParent = UIParent

local points = PetMerchant.points

local data = {
  --[[ structure:
  [uiMapID] = {
    [coord] = {
      npc=[id], -- related npc id, used to display names in tooltip
      pets = {
        label=[string], -- label: text that'll be the label, optional
        item=[id], -- itemID
        species=[id], -- speciesID
        quest=[id], -- will be checked, for whether character already has it
        currency=[id], -- currencyid
        achievement=[id], -- will be shown in the tooltip
        note=[string], -- some text which might be helpful
      }
    },
  },
  --]]

  -- Silithus
  [1377] = {
    [42204420] = {
      npc = 130216, -- Magni Bronzebeard <The Speaker>
      pets = {
        {
          item = 163515,
          species = 2439, -- https://wow.gamepedia.com/API_C_PetJournal.GetPetStats
          price = { unitID = 163036, cost = 200 }, -- https://wow.gamepedia.com/API_GetItemIcon
          -- ICON interface/icons/inv_currency_petbattle.blp
          -- https://wow.tools/files/#search=2004597&page=1&sort=0&desc=asc
        }
      }
    }
  }
}

-- plugin handler for HandyNotes
function PetMerchant:OnEnter(mapFile, coord)
  HandyNotes:Print("PetMerchant:OnEnter")
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local point = points[mapFile] and points[mapFile][coord]
	local text

  text = "This is a pet vendor"

	GameTooltip:SetText(text)

	GameTooltip:AddLine(" ")

	GameTooltip:Show()
end

function PetMerchant:OnLeave()
  HandyNotes:Print("PetMerchant:OnLeave")
	GameTooltip:Hide()
end

function PetMerchant:OnEnable()
  HandyNotes:Print("PetMerchant Initialized!")
end

-- activate
LibStub("AceAddon-3.0"):NewAddon(PetMerchant, "HandyNotes_PetMerchant", "AceEvent-3.0")
