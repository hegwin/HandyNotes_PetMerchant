SLASH_TOKENSCOUNTER1 = "/htc"
SlashCmdList["TOKENSCOUNTER"] = function(self, txt)
  if UnitExists("target") then
    SendChatMessage("Hello "..UnitName("target"), "SAY")
  else
    SendChatMessage("Hello, World of Warcraft")
  end
end