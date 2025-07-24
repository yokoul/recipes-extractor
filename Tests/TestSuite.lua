-- Test functions for RecipesExtractor
-- Use these functions to test the addon functionality

RecipesExtractorTests = {}

function RecipesExtractorTests:RunAllTests()
    print("|cff00ff00RecipesExtractor Tests:|r Starting test suite...")
    
    local tests = {
        "TestDatabaseInitialization",
        "TestProfessionData", 
        "TestDataManager",
        "TestExportFormats",
        "TestConfiguration"
    }
    
    local passed = 0
    local failed = 0
    
    for _, testName in ipairs(tests) do
        if self[testName] then
            local success, error = pcall(self[testName], self)
            if success then
                print("|cff00ff00✓|r " .. testName)
                passed = passed + 1
            else
                print("|cffff0000✗|r " .. testName .. ": " .. tostring(error))
                failed = failed + 1
            end
        else
            print("|cffff0000✗|r " .. testName .. ": Test not found")
            failed = failed + 1
        end
    end
    
    print("|cff00ff00RecipesExtractor Tests:|r Completed - " .. passed .. " passed, " .. failed .. " failed")
end

function RecipesExtractorTests:TestDatabaseInitialization()
    -- Test database initialization
    RecipesExtractorDatabase:Initialize()
    
    assert(RecipesExtractorDB ~= nil, "RecipesExtractorDB should be initialized")
    assert(RecipesExtractorDB.version == "1.0.0", "Version should be 1.0.0")
    assert(type(RecipesExtractorDB.characters) == "table", "Characters should be a table")
    assert(type(RecipesExtractorDB.settings) == "table", "Settings should be a table")
    
    -- Test character initialization
    RecipesExtractorDatabase:InitializeCharacter("TestChar", "TestRealm", "test-guid")
    local charKey = "TestChar-TestRealm"
    
    assert(RecipesExtractorDB.characters[charKey] ~= nil, "Test character should be created")
    assert(RecipesExtractorDB.characters[charKey].name == "TestChar", "Character name should match")
    assert(RecipesExtractorDB.characters[charKey].realm == "TestRealm", "Character realm should match")
end

function RecipesExtractorTests:TestProfessionData()
    -- Test profession data constants
    local professions = RecipesExtractorProfessionData:GetAllProfessions()
    
    assert(type(professions) == "table", "Professions should be a table")
    assert(professions[164] ~= nil, "Blacksmithing should be defined")
    assert(professions[164].name == "Blacksmithing", "Blacksmithing name should match")
    assert(professions[333] ~= nil, "Enchanting should be defined")
    assert(professions[333].type == "craft", "Enchanting should be craft type")
    
    -- Test profession type detection
    assert(RecipesExtractorProfessionData:IsPrimaryProfession(164) == true, "Blacksmithing should be primary")
    assert(RecipesExtractorProfessionData:IsSecondaryProfession(185) == true, "Cooking should be secondary")
    assert(RecipesExtractorProfessionData:IsPrimaryProfession(185) == false, "Cooking should not be primary")
    
    -- Test difficulty colors
    local colors = RecipesExtractorProfessionData:GetDifficultyColor("optimal")
    assert(type(colors) == "table", "Colors should be a table")
    assert(colors.r ~= nil and colors.g ~= nil and colors.b ~= nil, "Colors should have RGB values")
end

function RecipesExtractorTests:TestDataManager()
    -- Setup test data
    RecipesExtractorDatabase:Initialize()
    RecipesExtractorDatabase:InitializeCharacter("TestChar", "TestRealm", "test-guid")
    
    local testProfessionData = {
        level = 300,
        maxLevel = 300,
        recipes = {
            ["Test Recipe"] = {
                name = "Test Recipe",
                type = "optimal",
                difficulty = "optimal", 
                reagents = {
                    { name = "Test Reagent", required = 1, have = 5 }
                },
                icon = "Interface\\Icons\\Test",
                timestamp = time()
            }
        }
    }
    
    RecipesExtractorDatabase:SaveProfessionData("Blacksmithing", testProfessionData)
    
    -- Test statistics generation
    local stats = RecipesExtractorDataManager:GetStatistics()
    
    assert(type(stats) == "table", "Statistics should be a table")
    assert(stats.totalCharacters >= 1, "Should have at least 1 character")
    assert(stats.totalProfessions >= 1, "Should have at least 1 profession")
    assert(stats.totalRecipes >= 1, "Should have at least 1 recipe")
    assert(type(stats.professionBreakdown) == "table", "Profession breakdown should be a table")
    
    -- Test export data generation
    local exportData = RecipesExtractorDataManager:GenerateExportData()
    
    assert(type(exportData) == "table", "Export data should be a table")
    assert(exportData.addon == "RecipesExtractor", "Addon name should match")
    assert(exportData.version == "1.0.0", "Version should match")
    assert(type(exportData.characters) == "table", "Characters should be a table")
    assert(table.getn(exportData.characters) >= 1, "Should have at least 1 character")
end

function RecipesExtractorTests:TestExportFormats()
    -- Setup test data (same as previous test)
    RecipesExtractorDatabase:Initialize()
    RecipesExtractorDatabase:InitializeCharacter("TestChar", "TestRealm", "test-guid")
    
    local testProfessionData = {
        level = 300,
        maxLevel = 300,
        recipes = {
            ["Test Recipe"] = {
                name = "Test Recipe",
                type = "optimal",
                difficulty = "optimal",
                reagents = {
                    { name = "Test Reagent", required = 1, have = 5 }
                },
                icon = "Interface\\Icons\\Test",
                timestamp = time()
            }
        }
    }
    
    RecipesExtractorDatabase:SaveProfessionData("Blacksmithing", testProfessionData)
    
    -- Test JSON export
    local jsonExport = RecipesExtractorDataManager:GenerateJSONExport()
    assert(type(jsonExport) == "string", "JSON export should be a string")
    assert(string.find(jsonExport, "RecipesExtractor") ~= nil, "JSON should contain addon name")
    assert(string.find(jsonExport, "TestChar") ~= nil, "JSON should contain character name")
    
    -- Test CSV export
    local csvExport = RecipesExtractorDataManager:GenerateCSVExport()
    assert(type(csvExport) == "string", "CSV export should be a string")
    assert(string.find(csvExport, "Character,Realm") ~= nil, "CSV should contain headers")
    assert(string.find(csvExport, "TestChar") ~= nil, "CSV should contain character data")
    
    -- Test Web export
    local webExport = RecipesExtractorDataManager:GenerateWebExport()
    assert(type(webExport) == "string", "Web export should be a string")
    assert(string.find(webExport, "RecipesExtractor") ~= nil, "Web export should contain source")
end

function RecipesExtractorTests:TestConfiguration()
    -- Test configuration loading
    assert(RecipesExtractorConfig ~= nil, "Configuration should be loaded")
    assert(RecipesExtractorConfig.VERSION == "1.0.0", "Configuration version should match")
    
    -- Test config value getter
    local width = RecipesExtractorConfig:GetValue("UI.MAIN_FRAME_WIDTH", 500)
    assert(type(width) == "number", "Width should be a number")
    assert(width > 0, "Width should be positive")
    
    -- Test config validation
    local isValid, errors = RecipesExtractorConfig:Validate()
    assert(type(isValid) == "boolean", "Validation should return boolean")
    assert(type(errors) == "table", "Errors should be a table")
    
    if not isValid then
        print("|cffff8000Warning:|r Configuration validation failed:")
        for _, error in ipairs(errors) do
            print("  - " .. error)
        end
    end
end

-- Helper function to create test data
function RecipesExtractorTests:CreateTestData()
    RecipesExtractorDatabase:Initialize()
    
    -- Create multiple test characters
    local testChars = {
        { name = "Warrior1", realm = "TestRealm", class = "Warrior", race = "Human", level = 60 },
        { name = "Mage1", realm = "TestRealm", class = "Mage", race = "Human", level = 55 },
        { name = "Priest1", realm = "TestRealm", class = "Priest", race = "Dwarf", level = 50 }
    }
    
    for _, char in ipairs(testChars) do
        RecipesExtractorDatabase:InitializeCharacter(char.name, char.realm, "test-guid-" .. char.name)
        
        -- Add Blacksmithing to warrior
        if char.class == "Warrior" then
            local blacksmithingData = {
                level = 300,
                maxLevel = 300,
                recipes = {
                    ["Arcanite Champion"] = {
                        name = "Arcanite Champion",
                        type = "optimal",
                        difficulty = "optimal",
                        reagents = {
                            { name = "Arcanite Bar", required = 15, have = 3 },
                            { name = "Dense Grinding Stone", required = 4, have = 8 }
                        },
                        icon = "Interface\\Icons\\INV_Sword_17",
                        timestamp = time()
                    },
                    ["Thorium Boots"] = {
                        name = "Thorium Boots",
                        type = "easy",
                        difficulty = "easy",
                        reagents = {
                            { name = "Thorium Bar", required = 14, have = 25 }
                        },
                        icon = "Interface\\Icons\\INV_Boots_05",
                        timestamp = time()
                    }
                }
            }
            RecipesExtractorDatabase:SaveProfessionData("Blacksmithing", blacksmithingData)
        end
        
        -- Add Tailoring to mage
        if char.class == "Mage" then
            local tailoringData = {
                level = 285,
                maxLevel = 300,
                recipes = {
                    ["Mooncloth"] = {
                        name = "Mooncloth",
                        type = "easy",
                        difficulty = "easy",
                        reagents = {
                            { name = "Felcloth", required = 2, have = 8 }
                        },
                        icon = "Interface\\Icons\\INV_Fabric_Moonrag_01",
                        timestamp = time()
                    }
                }
            }
            RecipesExtractorDatabase:SaveProfessionData("Tailoring", tailoringData)
        end
        
        -- Add First Aid to all
        local firstAidData = {
            level = 150,
            maxLevel = 300,
            recipes = {
                ["Heavy Silk Bandage"] = {
                    name = "Heavy Silk Bandage",
                    type = "trivial",
                    difficulty = "trivial",
                    reagents = {
                        { name = "Silk Cloth", required = 2, have = 50 }
                    },
                    icon = "Interface\\Icons\\INV_Misc_Bandage_12",
                    timestamp = time()
                }
            }
        }
        RecipesExtractorDatabase:SaveProfessionData("First Aid", firstAidData)
    end
    
    print("|cff00ff00RecipesExtractor Tests:|r Test data created successfully")
end

-- Slash command for testing
SLASH_REXTESTS1 = "/rextest"
SlashCmdList["REXTESTS"] = function(msg)
    local command = string.lower(msg or "")
    
    if command == "all" then
        RecipesExtractorTests:RunAllTests()
    elseif command == "create" then
        RecipesExtractorTests:CreateTestData()
    elseif command == "clear" then
        RecipesExtractorDatabase:ResetData()
        print("|cff00ff00RecipesExtractor Tests:|r Test data cleared")
    else
        print("|cff00ff00RecipesExtractor Tests:|r Available commands:")
        print("  /rextest all - Run all tests")
        print("  /rextest create - Create test data")
        print("  /rextest clear - Clear all data")
    end
end
