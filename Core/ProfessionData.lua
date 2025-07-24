-- Profession data and constants for RecipesExtractor
RecipesExtractorProfessionData = {}

-- Profession mappings for Classic Era
RecipesExtractorProfessionData.PROFESSIONS = {
    -- Primary Professions
    [164] = { name = "Blacksmithing", type = "tradeskill", icon = "Interface\\Icons\\Trade_BlackSmithing" },
    [165] = { name = "Leatherworking", type = "tradeskill", icon = "Interface\\Icons\\Trade_LeatherWorking" },
    [171] = { name = "Alchemy", type = "tradeskill", icon = "Interface\\Icons\\Trade_Alchemy" },
    [182] = { name = "Herbalism", type = "tradeskill", icon = "Interface\\Icons\\Trade_Herbalism" },
    [186] = { name = "Mining", type = "tradeskill", icon = "Interface\\Icons\\Trade_Mining" },
    [197] = { name = "Tailoring", type = "tradeskill", icon = "Interface\\Icons\\Trade_Tailoring" },
    [202] = { name = "Engineering", type = "tradeskill", icon = "Interface\\Icons\\Trade_Engineering" },
    [333] = { name = "Enchanting", type = "craft", icon = "Interface\\Icons\\Trade_Engraving" },
    
    -- Secondary Professions
    [129] = { name = "First Aid", type = "tradeskill", icon = "Interface\\Icons\\Spell_Holy_SealOfSacrifice" },
    [185] = { name = "Cooking", type = "tradeskill", icon = "Interface\\Icons\\INV_Misc_Food_15" },
    [356] = { name = "Fishing", type = "tradeskill", icon = "Interface\\Icons\\Trade_Fishing" }
}

-- Recipe difficulty colors
RecipesExtractorProfessionData.DIFFICULTY_COLORS = {
    trivial = { r = 0.5, g = 0.5, b = 0.5 },    -- Gray
    easy = { r = 0.25, g = 0.75, b = 0.25 },    -- Green
    medium = { r = 1.0, g = 1.0, b = 0.0 },     -- Yellow
    optimal = { r = 1.0, g = 0.5, b = 0.25 },   -- Orange
    impossible = { r = 1.0, g = 0.25, b = 0.25 } -- Red
}

function RecipesExtractorProfessionData:GetProfessionInfo(professionID)
    return self.PROFESSIONS[professionID]
end

function RecipesExtractorProfessionData:GetAllProfessions()
    return self.PROFESSIONS
end

function RecipesExtractorProfessionData:IsPrimaryProfession(professionID)
    local primaryProfessions = { 164, 165, 171, 182, 186, 197, 202, 333 }
    for _, id in ipairs(primaryProfessions) do
        if id == professionID then
            return true
        end
    end
    return false
end

function RecipesExtractorProfessionData:IsSecondaryProfession(professionID)
    local secondaryProfessions = { 129, 185, 356 }
    for _, id in ipairs(secondaryProfessions) do
        if id == professionID then
            return true
        end
    end
    return false
end

function RecipesExtractorProfessionData:GetDifficultyColor(difficulty)
    return self.DIFFICULTY_COLORS[difficulty] or self.DIFFICULTY_COLORS.medium
end

function RecipesExtractorProfessionData:ParseRecipeDifficulty(colorCode)
    -- Parse the difficulty based on color codes from the game
    if not colorCode then return "medium" end
    
    if colorCode:find("ff9d9d9d") then -- Gray
        return "trivial"
    elseif colorCode:find("ff40bf40") then -- Green
        return "easy"
    elseif colorCode:find("ffffff00") then -- Yellow
        return "medium"
    elseif colorCode:find("ffff8040") then -- Orange
        return "optimal"
    elseif colorCode:find("ffff4040") then -- Red
        return "impossible"
    else
        return "medium"
    end
end

-- Helper function to format recipe data
function RecipesExtractorProfessionData:FormatRecipeData(recipeName, recipeType, difficulty, reagents, icon)
    return {
        name = recipeName,
        type = recipeType or "unknown",
        difficulty = difficulty or "medium",
        reagents = reagents or {},
        icon = icon,
        timestamp = time()
    }
end

-- Helper function to get profession name by ID
function RecipesExtractorProfessionData:GetProfessionName(professionID)
    local prof = self.PROFESSIONS[professionID]
    return prof and prof.name or "Unknown"
end

-- Helper function to get profession icon by ID
function RecipesExtractorProfessionData:GetProfessionIcon(professionID)
    local prof = self.PROFESSIONS[professionID]
    return prof and prof.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
end
