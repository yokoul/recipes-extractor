-- Data collection system for RecipesExtractor
RecipesExtractorDataCollector = {}

function RecipesExtractorDataCollector:ScanAllProfessions()
    local scannedCount = 0
    
    -- Scan all learned professions
    for professionID, professionInfo in pairs(RecipesExtractorProfessionData:GetAllProfessions()) do
        if self:HasProfession(professionID) then
            -- Note: In Classic, we can't automatically open profession windows
            -- So we'll check what's currently open or provide instructions
            scannedCount = scannedCount + 1
        end
    end
    
    if scannedCount == 0 then
        print("|cff00ff00RecipesExtractor:|r No professions found. Open your profession windows to scan recipes.")
    else
        print("|cff00ff00RecipesExtractor:|r Found " .. scannedCount .. " professions. Open each profession window to scan recipes.")
    end
end

function RecipesExtractorDataCollector:HasProfession(professionID)
    -- Check if player has this profession
    local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
    local professions = { prof1, prof2, archaeology, fishing, cooking, firstAid }
    
    for _, profIndex in ipairs(professions) do
        if profIndex then
            local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine = GetProfessionInfo(profIndex)
            if skillLine == professionID then
                return true, skillLevel, maxSkillLevel
            end
        end
    end
    
    return false
end

function RecipesExtractorDataCollector:CollectTradeSkillData()
    if not IsTradeSkillReady() then
        print("|cffff0000RecipesExtractor:|r Trade skill window is not ready!")
        return
    end
    
    local professionName = GetTradeSkillLine()
    if not professionName or professionName == "UNKNOWN" then
        print("|cffff0000RecipesExtractor:|r Could not determine profession name!")
        return
    end
    
    local numTradeSkills = GetNumTradeSkills()
    local recipes = {}
    local professionLevel = 0
    local maxLevel = 300
    
    -- Get profession level info
    local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions()
    local professions = { prof1, prof2, archaeology, fishing, cooking, firstAid }
    
    for _, profIndex in ipairs(professions) do
        if profIndex then
            local name, icon, skillLevel, maxSkillLevel = GetProfessionInfo(profIndex)
            if name == professionName then
                professionLevel = skillLevel
                maxLevel = maxSkillLevel
                break
            end
        end
    end
    
    -- Collect all recipes
    for i = 1, numTradeSkills do
        local skillName, skillType, numAvailable, isExpanded = GetTradeSkillInfo(i)
        
        if skillType ~= "header" and skillName then
            local reagents = {}
            local numReagents = GetTradeSkillNumReagents(i)
            
            -- Collect reagents
            for j = 1, numReagents do
                local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(i, j)
                if reagentName then
                    table.insert(reagents, {
                        name = reagentName,
                        icon = reagentTexture,
                        required = reagentCount,
                        have = playerReagentCount
                    })
                end
            end
            
            -- Get recipe icon
            local icon = GetTradeSkillIcon(i)
            
            -- Determine difficulty
            local difficulty = "medium"
            if skillType == "trivial" then
                difficulty = "trivial"
            elseif skillType == "easy" then
                difficulty = "easy"
            elseif skillType == "medium" then
                difficulty = "medium"
            elseif skillType == "optimal" then
                difficulty = "optimal"
            elseif skillType == "difficult" then
                difficulty = "impossible"
            end
            
            recipes[skillName] = RecipesExtractorProfessionData:FormatRecipeData(
                skillName,
                skillType,
                difficulty,
                reagents,
                icon
            )
        end
    end
    
    -- Save the data
    local professionData = {
        level = professionLevel,
        maxLevel = maxLevel,
        recipes = recipes
    }
    
    RecipesExtractorDatabase:SaveProfessionData(professionName, professionData)
    
    print("|cff00ff00RecipesExtractor:|r Scanned " .. professionName .. " - " .. table.getn(recipes) .. " recipes found!")
    
    -- Notify minimap button
    if RecipesExtractorMinimapButton and RecipesExtractorMinimapButton.OnRecipesScanned then
        RecipesExtractorMinimapButton:OnRecipesScanned()
    end
end

function RecipesExtractorDataCollector:CollectCraftData()
    -- Handle Enchanting (uses Craft API instead of TradeSkill API)
    if not DoesCraftHaveReagents then
        print("|cffff0000RecipesExtractor:|r Craft window is not ready!")
        return
    end
    
    local professionName = GetCraftName()
    if not professionName or professionName == "UNKNOWN" then
        print("|cffff0000RecipesExtractor:|r Could not determine craft name!")
        return
    end
    
    local numCrafts = GetNumCrafts()
    local recipes = {}
    local professionLevel = 0
    local maxLevel = 300
    
    -- Get Enchanting skill level
    local prof1, prof2 = GetProfessions()
    local professions = { prof1, prof2 }
    
    for _, profIndex in ipairs(professions) do
        if profIndex then
            local name, icon, skillLevel, maxSkillLevel = GetProfessionInfo(profIndex)
            if name == "Enchanting" then
                professionLevel = skillLevel
                maxLevel = maxSkillLevel
                break
            end
        end
    end
    
    -- Collect all crafts/enchantments
    for i = 1, numCrafts do
        local craftName, craftSubSpellName, craftType, numAvailable, isExpanded = GetCraftInfo(i)
        
        if craftType ~= "header" and craftName then
            local reagents = {}
            local numReagents = GetCraftNumReagents(i)
            
            -- Collect reagents
            for j = 1, numReagents do
                local reagentName, reagentTexture, reagentCount, playerReagentCount = GetCraftReagentInfo(i, j)
                if reagentName then
                    table.insert(reagents, {
                        name = reagentName,
                        icon = reagentTexture,
                        required = reagentCount,
                        have = playerReagentCount
                    })
                end
            end
            
            -- Get craft icon
            local icon = GetCraftIcon(i)
            
            -- Determine difficulty
            local difficulty = "medium"
            if craftType == "trivial" then
                difficulty = "trivial"
            elseif craftType == "easy" then
                difficulty = "easy"
            elseif craftType == "medium" then
                difficulty = "medium"
            elseif craftType == "optimal" then
                difficulty = "optimal"
            elseif craftType == "difficult" then
                difficulty = "impossible"
            end
            
            local fullName = craftName
            if craftSubSpellName and craftSubSpellName ~= "" then
                fullName = craftName .. " (" .. craftSubSpellName .. ")"
            end
            
            recipes[fullName] = RecipesExtractorProfessionData:FormatRecipeData(
                fullName,
                craftType,
                difficulty,
                reagents,
                icon
            )
        end
    end
    
    -- Save the data
    local professionData = {
        level = professionLevel,
        maxLevel = maxLevel,
        recipes = recipes
    }
    
    RecipesExtractorDatabase:SaveProfessionData(professionName, professionData)
    
    print("|cff00ff00RecipesExtractor:|r Scanned " .. professionName .. " - " .. table.getn(recipes) .. " recipes found!")
    
    -- Notify minimap button
    if RecipesExtractorMinimapButton and RecipesExtractorMinimapButton.OnRecipesScanned then
        RecipesExtractorMinimapButton:OnRecipesScanned()
    end
end

function RecipesExtractorDataCollector:GetCurrentProfessionData()
    -- Return data about currently open profession window
    if IsTradeSkillReady() then
        return {
            type = "tradeskill",
            name = GetTradeSkillLine(),
            numRecipes = GetNumTradeSkills()
        }
    elseif DoesCraftHaveReagents then
        return {
            type = "craft",
            name = GetCraftName(),
            numRecipes = GetNumCrafts()
        }
    end
    
    return nil
end
