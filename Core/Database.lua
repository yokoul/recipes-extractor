-- Database management for RecipesExtractor
RecipesExtractorDatabase = {}

function RecipesExtractorDatabase:Initialize()
    -- Initialize the saved variables structure
    if not RecipesExtractorDB then
        RecipesExtractorDB = {
            version = "0.1.0-alpha",
            characters = {},
            settings = {
                autoScan = true,
                shareData = true,
                exportFormat = "json",
                minimapButtonAngle = 0,
                minimapButtonHidden = false
            }
        }
    end
    
    -- Migrate data if needed
    self:MigrateData()
end

function RecipesExtractorDatabase:MigrateData()
    -- Handle version migrations if needed
    if RecipesExtractorDB.version ~= "0.1.0-alpha" then
        -- Migration logic would go here
        RecipesExtractorDB.version = "0.1.0-alpha"
    end
end

function RecipesExtractorDatabase:InitializeCharacter(playerName, realmName, playerGUID)
    local charKey = playerName .. "-" .. realmName
    
    if not RecipesExtractorDB.characters[charKey] then
        RecipesExtractorDB.characters[charKey] = {
            name = playerName,
            realm = realmName,
            guid = playerGUID,
            lastUpdate = time(),
            professions = {},
            level = UnitLevel("player"),
            class = UnitClass("player"),
            race = UnitRace("player")
        }
    else
        -- Update character info
        RecipesExtractorDB.characters[charKey].lastUpdate = time()
        RecipesExtractorDB.characters[charKey].level = UnitLevel("player")
        RecipesExtractorDB.characters[charKey].guid = playerGUID
    end
    
    self.currentCharacter = charKey
end

function RecipesExtractorDatabase:GetCurrentCharacter()
    return self.currentCharacter and RecipesExtractorDB.characters[self.currentCharacter]
end

function RecipesExtractorDatabase:SaveProfessionData(professionName, professionData)
    local character = self:GetCurrentCharacter()
    if not character then return end
    
    character.professions[professionName] = {
        name = professionName,
        level = professionData.level or 0,
        maxLevel = professionData.maxLevel or 300,
        recipes = professionData.recipes or {},
        lastScan = time()
    }
    
    character.lastUpdate = time()
end

function RecipesExtractorDatabase:GetAllCharacters()
    return RecipesExtractorDB.characters
end

function RecipesExtractorDatabase:GetCharacterProfessions(charKey)
    local character = RecipesExtractorDB.characters[charKey]
    return character and character.professions or {}
end

function RecipesExtractorDatabase:GetAllRecipes()
    local allRecipes = {}
    
    for charKey, character in pairs(RecipesExtractorDB.characters) do
        allRecipes[charKey] = {
            character = {
                name = character.name,
                realm = character.realm,
                level = character.level,
                class = character.class,
                race = character.race,
                lastUpdate = character.lastUpdate
            },
            professions = character.professions
        }
    end
    
    return allRecipes
end

function RecipesExtractorDatabase:ResetData()
    RecipesExtractorDB.characters = {}
    print("|cff00ff00RecipesExtractor:|r All character data has been reset!")
end

function RecipesExtractorDatabase:ResetCharacterData(charKey)
    if RecipesExtractorDB.characters[charKey] then
        RecipesExtractorDB.characters[charKey].professions = {}
        RecipesExtractorDB.characters[charKey].lastUpdate = time()
        print("|cff00ff00RecipesExtractor:|r Data reset for " .. charKey)
    end
end

function RecipesExtractorDatabase:GetSettings()
    return RecipesExtractorDB.settings
end

function RecipesExtractorDatabase:SetSetting(key, value)
    RecipesExtractorDB.settings[key] = value
end
