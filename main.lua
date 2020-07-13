local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

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
