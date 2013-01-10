function TokensCounter_OnLoad()
  SlashCmdList["TokensCounter"] = TokensCounter_SlashCommand;
  SLASH_TokensCounter1= "/htc";
  this:RegisterEvent("VARIABLES_LOADED")
end