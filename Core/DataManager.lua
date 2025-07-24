-- Data management and export functionality for RecipesExtractor
RecipesExtractorDataManager = {}

function RecipesExtractorDataManager:GenerateExportData()
    local allRecipes = RecipesExtractorDatabase:GetAllRecipes()
    local exportData = {
        addon = "RecipesExtractor",
        version = "1.0.0",
        timestamp = time(),
        exportDate = date("%Y-%m-%d %H:%M:%S"),
        realm = GetRealmName(),
        characters = {}
    }
    
    for charKey, characterData in pairs(allRecipes) do
        local charExport = {
            name = characterData.character.name,
            realm = characterData.character.realm,
            level = characterData.character.level,
            class = characterData.character.class,
            race = characterData.character.race,
            lastUpdate = characterData.character.lastUpdate,
            lastUpdateDate = date("%Y-%m-%d %H:%M:%S", characterData.character.lastUpdate),
            professions = {}
        }
        
        for profName, profData in pairs(characterData.professions) do
            local profExport = {
                name = profName,
                level = profData.level,
                maxLevel = profData.maxLevel,
                lastScan = profData.lastScan,
                lastScanDate = date("%Y-%m-%d %H:%M:%S", profData.lastScan),
                recipes = {}
            }
            
            for recipeName, recipeData in pairs(profData.recipes) do
                local recipeExport = {
                    name = recipeName,
                    type = recipeData.type,
                    difficulty = recipeData.difficulty,
                    reagents = recipeData.reagents,
                    icon = recipeData.icon,
                    timestamp = recipeData.timestamp
                }
                
                table.insert(profExport.recipes, recipeExport)
            end
            
            table.insert(charExport.professions, profExport)
        end
        
        table.insert(exportData.characters, charExport)
    end
    
    return exportData
end

function RecipesExtractorDataManager:GenerateJSONExport()
    local exportData = self:GenerateExportData()
    return self:TableToJSON(exportData)
end

function RecipesExtractorDataManager:GenerateCSVExport()
    local allRecipes = RecipesExtractorDatabase:GetAllRecipes()
    local csvLines = {
        "Character,Realm,Class,Level,Profession,ProfessionLevel,MaxLevel,Recipe,Type,Difficulty,Reagents"
    }
    
    for charKey, characterData in pairs(allRecipes) do
        local char = characterData.character
        
        for profName, profData in pairs(characterData.professions) do
            for recipeName, recipeData in pairs(profData.recipes) do
                local reagentsList = ""
                if recipeData.reagents and table.getn(recipeData.reagents) > 0 then
                    local reagentNames = {}
                    for _, reagent in ipairs(recipeData.reagents) do
                        table.insert(reagentNames, reagent.name .. " (" .. reagent.required .. ")")
                    end
                    reagentsList = table.concat(reagentNames, "; ")
                end
                
                local csvLine = string.format('"%s","%s","%s",%d,"%s",%d,%d,"%s","%s","%s","%s"',
                    char.name,
                    char.realm,
                    char.class,
                    char.level,
                    profName,
                    profData.level,
                    profData.maxLevel,
                    recipeName,
                    recipeData.type,
                    recipeData.difficulty,
                    reagentsList
                )
                
                table.insert(csvLines, csvLine)
            end
        end
    end
    
    return table.concat(csvLines, "\n")
end

function RecipesExtractorDataManager:GenerateWebExport()
    -- Format optimized for web integration
    local exportData = self:GenerateExportData()
    
    local webData = {
        source = "RecipesExtractor",
        version = exportData.version,
        realm = exportData.realm,
        timestamp = exportData.timestamp,
        data = {}
    }
    
    for _, character in ipairs(exportData.characters) do
        local charData = {
            character = {
                name = character.name,
                realm = character.realm,
                level = character.level,
                class = character.class,
                race = character.race
            },
            professions = {}
        }
        
        for _, profession in ipairs(character.professions) do
            local profData = {
                name = profession.name,
                level = profession.level,
                maxLevel = profession.maxLevel,
                recipes = {}
            }
            
            for _, recipe in ipairs(profession.recipes) do
                table.insert(profData.recipes, {
                    name = recipe.name,
                    difficulty = recipe.difficulty,
                    reagents = recipe.reagents
                })
            end
            
            table.insert(charData.professions, profData)
        end
        
        table.insert(webData.data, charData)
    end
    
    return self:TableToJSON(webData)
end

function RecipesExtractorDataManager:TableToJSON(tbl, indent)
    indent = indent or 0
    local indentStr = string.rep("  ", indent)
    local result = {}
    
    if type(tbl) ~= "table" then
        if type(tbl) == "string" then
            return '"' .. string.gsub(tbl, '"', '\\"') .. '"'
        else
            return tostring(tbl)
        end
    end
    
    local isArray = true
    local count = 0
    for k, v in pairs(tbl) do
        count = count + 1
        if type(k) ~= "number" or k ~= count then
            isArray = false
            break
        end
    end
    
    if isArray then
        table.insert(result, "[\n")
        for i, v in ipairs(tbl) do
            table.insert(result, indentStr .. "  ")
            table.insert(result, self:TableToJSON(v, indent + 1))
            if i < table.getn(tbl) then
                table.insert(result, ",")
            end
            table.insert(result, "\n")
        end
        table.insert(result, indentStr .. "]")
    else
        table.insert(result, "{\n")
        local keys = {}
        for k in pairs(tbl) do
            table.insert(keys, k)
        end
        table.sort(keys)
        
        for i, k in ipairs(keys) do
            local v = tbl[k]
            table.insert(result, indentStr .. '  "' .. tostring(k) .. '": ')
            table.insert(result, self:TableToJSON(v, indent + 1))
            if i < table.getn(keys) then
                table.insert(result, ",")
            end
            table.insert(result, "\n")
        end
        table.insert(result, indentStr .. "}")
    end
    
    return table.concat(result)
end

function RecipesExtractorDataManager:GetStatistics()
    local allRecipes = RecipesExtractorDatabase:GetAllRecipes()
    local stats = {
        totalCharacters = 0,
        totalProfessions = 0,
        totalRecipes = 0,
        professionBreakdown = {},
        characterBreakdown = {}
    }
    
    for charKey, characterData in pairs(allRecipes) do
        stats.totalCharacters = stats.totalCharacters + 1
        local charRecipes = 0
        local charProfessions = 0
        
        for profName, profData in pairs(characterData.professions) do
            stats.totalProfessions = stats.totalProfessions + 1
            charProfessions = charProfessions + 1
            
            if not stats.professionBreakdown[profName] then
                stats.professionBreakdown[profName] = {
                    characters = 0,
                    totalRecipes = 0,
                    averageLevel = 0,
                    levels = {}
                }
            end
            
            stats.professionBreakdown[profName].characters = stats.professionBreakdown[profName].characters + 1
            table.insert(stats.professionBreakdown[profName].levels, profData.level)
            
            local recipeCount = 0
            for recipeName, recipeData in pairs(profData.recipes) do
                recipeCount = recipeCount + 1
                charRecipes = charRecipes + 1
                stats.totalRecipes = stats.totalRecipes + 1
            end
            
            stats.professionBreakdown[profName].totalRecipes = stats.professionBreakdown[profName].totalRecipes + recipeCount
        end
        
        stats.characterBreakdown[charKey] = {
            name = characterData.character.name,
            level = characterData.character.level,
            class = characterData.character.class,
            professions = charProfessions,
            recipes = charRecipes
        }
    end
    
    -- Calculate average levels
    for profName, profStats in pairs(stats.professionBreakdown) do
        local total = 0
        for _, level in ipairs(profStats.levels) do
            total = total + level
        end
        profStats.averageLevel = math.floor(total / table.getn(profStats.levels))
    end
    
    return stats
end
