SLASH_TOKENSCOUNTER1 = "/htc"
SlashCmdList["TOKENSCOUNTER"] = function(self, txt)
  if UnitExists("target") then
    SendChatMessage("Hello "..UnitName("target"), "SAY")
    
  else
    --SendChatMessage("Hello, World of Warcraft")
    t = initialUserTokenTable()
    sendTokenInfoToChat(t)
  end
end

string.split = function(s, p)
  local t = {}
  string.gsub(s, '[^'..p..']+', function(w) table.insert(t, w) end )
  return t
end

--[[
Currencies list
391 Tol Barad Commendation
241 Champion's Seal
515 Darkmoon Prize Ticket
]]--

tokensTable = { { index = 391, adequacy = 500 }, 
                { index = 241, adequacy = 450 },
                { index = 515, adequacy = 300 }
}

userTokensTable = {}

initialUserTokenTable = function()
  wipe(userTokensTable)
  for k, v in pairs(tokensTable) do
    v.label, v.amount = GetCurrencyInfo(v.index)
    table.insert(userTokensTable, v)
  end
  return userTokensTable
end

sendTokenInfoToChat = function(t)
  str = "Label | ID | Adequacy | Amount\n"
  for i,record in pairs(t) do
    for k, value in pairs(record) do
      str = str..value.." | "
    end
    str = str.."\n"
  end
  print(str)
end
