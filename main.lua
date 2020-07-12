local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")

local data = {
    --[[ structure:
    [uiMapID] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            label=[string], -- label: text that'll be the label, optional
            item=[id], -- itemid
            quest=[id], -- will be checked, for whether character already has it
            currency=[id], -- currencyid
            achievement=[id], -- will be shown in the tooltip
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, used to display names in tooltip
            note=[string], -- some text which might be helpful
            hide_before=[id], -- hide if quest not completed
            requires_buff=[id], -- hide if player does not have buff, mostly useful for buff-based zone phasing
            requires_no_buff=[id] -- hide if player has buff, mostly useful for buff-based zone phasing
        },
    },
    --]]
  -- Silithus
  ['map_id'] = {
    -- Magni Bronzebeard <The Speaker>
    [42204420] = {
      {
        npcID = 130216,
        itemID = 163515,
        speciesID = 2439, -- https://wow.gamepedia.com/API_C_PetJournal.GetPetStats
        price = { unitID = 163036, cost = 200 }, -- https://wow.gamepedia.com/API_GetItemIcon
        -- ICON interface/icons/inv_currency_petbattle.blp
        -- https://wow.tools/files/#search=2004597&page=1&sort=0&desc=asc
      }
    }
  }
}