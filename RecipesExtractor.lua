-- RecipesExtractor Main File
-- Addon for World of Warcraft Classic Era
-- Purpose: Extract and manage profession recipes data

RecipesExtractor = {}
RecipesExtractor.version = "0.1.0-alpha"
RecipesExtractor.addonName = "RecipesExtractor"

-- Initialize addon
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("TRADE_SKILL_SHOW")
frame:RegisterEvent("CRAFT_SHOW")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == RecipesExtractor.addonName then
            RecipesExtractor:OnAddonLoaded()
        end
    elseif event == "PLAYER_LOGIN" then
        RecipesExtractor:OnPlayerLogin()
    elseif event == "TRADE_SKILL_SHOW" then
        RecipesExtractor:OnTradeSkillShow()
    elseif event == "CRAFT_SHOW" then
        RecipesExtractor:OnCraftShow()
    end
end)

function RecipesExtractor:OnAddonLoaded()
    -- Initialize database
    RecipesExtractorDatabase:Initialize()
    
    -- Initialize UI
    RecipesExtractorUI:Initialize()
    
    -- Initialize minimap button
    RecipesExtractorMinimapButton:Initialize()
    
    print("|cff00ff00RecipesExtractor|r v" .. self.version .. " loaded!")
end

function RecipesExtractor:OnPlayerLogin()
    -- Get current character info
    local playerName = UnitName("player")
    local realmName = GetRealmName()
    local playerGUID = UnitGUID("player")
    
    -- Initialize character data
    RecipesExtractorDatabase:InitializeCharacter(playerName, realmName, playerGUID)
    
    -- Load minimap button position and visibility
    RecipesExtractorMinimapButton:LoadPosition()
    
    -- Check if minimap button should be hidden
    local settings = RecipesExtractorDatabase:GetSettings()
    if settings.minimapButtonHidden then
        RecipesExtractorMinimapButton:SetVisibility(false)
    end
    
    -- Auto-scan professions if enabled
    C_Timer.After(2, function()
        RecipesExtractorDataCollector:ScanAllProfessions()
    end)
end

function RecipesExtractor:OnTradeSkillShow()
    -- Auto-collect data when trade skill window opens
    C_Timer.After(0.5, function()
        RecipesExtractorDataCollector:CollectTradeSkillData()
    end)
end

function RecipesExtractor:OnCraftShow()
    -- Auto-collect data when craft window opens (for Enchanting)
    C_Timer.After(0.5, function()
        RecipesExtractorDataCollector:CollectCraftData()
    end)
end

-- Slash commands
SLASH_RECIPESEXTRACTOR1 = "/recipes"
SLASH_RECIPESEXTRACTOR2 = "/rex"

SlashCmdList["RECIPESEXTRACTOR"] = function(msg)
    local command = string.lower(msg or "")
    
    if command == "show" or command == "" then
        RecipesExtractorUI:ToggleMainFrame()
    elseif command == "scan" then
        RecipesExtractorDataCollector:ScanAllProfessions()
        print("|cff00ff00RecipesExtractor:|r Scanning all professions...")
    elseif command == "reset" then
        RecipesExtractorDatabase:ResetData()
        print("|cff00ff00RecipesExtractor:|r All data has been reset!")
    elseif command == "export" then
        RecipesExtractorUI:ShowExportFrame()
    elseif string.find(command, "minimap") then
        local subcommand = string.match(command, "minimap%s+(%w+)")
        if subcommand == "show" then
            RecipesExtractorMinimapButton:SetVisibility(true)
            print("|cff00ff00RecipesExtractor:|r Minimap button shown.")
        elseif subcommand == "hide" then
            RecipesExtractorMinimapButton:SetVisibility(false)
            print("|cff00ff00RecipesExtractor:|r Minimap button hidden.")
        elseif subcommand == "toggle" then
            RecipesExtractorMinimapButton:ToggleVisibility()
        elseif subcommand == "reset" then
            RecipesExtractorMinimapButton:SetPosition(0)
            RecipesExtractorMinimapButton:SavePosition()
            print("|cff00ff00RecipesExtractor:|r Minimap button position reset.")
        else
            print("|cff00ff00RecipesExtractor Minimap:|r")
            print("  /recipes minimap show - Show minimap button")
            print("  /recipes minimap hide - Hide minimap button") 
            print("  /recipes minimap toggle - Toggle minimap button")
            print("  /recipes minimap reset - Reset button position")
        end
    elseif command == "help" then
        print("|cff00ff00RecipesExtractor Commands:|r")
        print("  /recipes show - Toggle main interface")
        print("  /recipes scan - Scan all professions")
        print("  /recipes export - Show export interface")
        print("  /recipes reset - Reset all data")
        print("  /recipes minimap - Minimap button options")
        print("  /recipes help - Show this help")
        print(" ")
        print("|cff00ff00Minimap Button:|r")
        print("  Left click - Open interface")
        print("  Right click - Context menu")
        print("  Drag - Move button position")
    else
        print("|cffff0000RecipesExtractor:|r Unknown command. Use '/recipes help' for available commands.")
    end
end
