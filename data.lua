local _, PetMerchant = ...

PetMerchant.data =  {
  --[[ structure:
  [uiMapID] = {
    [coord] = {
      npc=[id], -- related npc id, used to display names in tooltip
      pets = {
        label=[string], -- label: text that'll be the label, optional
        item=[id], -- itemID
        species=[id], -- speciesID
        exchangable=[typeString:id], -- currency or item with id
        note=[string], -- some text which might be helpful
      }
    },
  },
  --]]

  [81] = { -- Silithus
    [42204420] = {
      npc = 130216, -- Magni Bronzebeard <The Speaker>
      pets = {
        {
          item = 163515,
          species = 2439, -- https://wow.gamepedia.com/API_C_PetJournal.GetPetStats
          exchangable = 'item:163036',
          cost = 200 -- https://wow.gamepedia.com/API_GetItemIcon
        },
        {
          item = 163555,
          species = 2429,
          exchangable = 'item:163036',
          cost = 100
        }
      }
    }
  },
  [1165] = { -- Dazar'alor
    [44609440] = {
      npc = 148923, -- Captain Zen'taga <Dubloons Trader>
      pets = {
        { item = 166500, species = 2562 },
        { item = 166491, species = 2555 }
      }
    },
    [48608700] = {
      npc = 125879,
      pets = {
        { item = 163568, species = 2430 }
      }
    },
    [51209520] = {
      npc = 148924,
      pets = {
        { item = 166347, species = 2540, exchangable = 'currency:1716', cost = 100 }
      }
    }
  }
}
