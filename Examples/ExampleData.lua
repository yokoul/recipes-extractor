-- Example export data for testing RecipesExtractor
-- This file shows what the exported data structure looks like

local ExampleData = {
    addon = "RecipesExtractor",
    version = "1.0.0",
    timestamp = 1721836800, -- 2025-07-24 12:00:00
    exportDate = "2025-07-24 12:00:00",
    realm = "Sulfuron",
    characters = {
        {
            name = "Thorin",
            realm = "Sulfuron",
            level = 60,
            class = "Warrior",
            race = "Dwarf",
            lastUpdate = 1721836800,
            lastUpdateDate = "2025-07-24 12:00:00",
            professions = {
                {
                    name = "Blacksmithing",
                    level = 300,
                    maxLevel = 300,
                    lastScan = 1721836800,
                    lastScanDate = "2025-07-24 12:00:00",
                    recipes = {
                        {
                            name = "Arcanite Champion",
                            type = "optimal",
                            difficulty = "optimal",
                            icon = "Interface\\Icons\\INV_Sword_17",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Arcanite Bar",
                                    icon = "Interface\\Icons\\INV_Ingot_06",
                                    required = 15,
                                    have = 3
                                },
                                {
                                    name = "Dense Grinding Stone",
                                    icon = "Interface\\Icons\\INV_Stone_GrindingStone_02",
                                    required = 4,
                                    have = 8
                                }
                            }
                        },
                        {
                            name = "Titanic Leggings",
                            type = "medium",
                            difficulty = "medium",
                            icon = "Interface\\Icons\\INV_Pants_04",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Thorium Bar",
                                    icon = "Interface\\Icons\\INV_Ingot_05",
                                    required = 24,
                                    have = 45
                                },
                                {
                                    name = "Essence of Earth",
                                    icon = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
                                    required = 4,
                                    have = 2
                                }
                            }
                        }
                    }
                },
                {
                    name = "Mining",
                    level = 300,
                    maxLevel = 300,
                    lastScan = 1721836800,
                    lastScanDate = "2025-07-24 12:00:00",
                    recipes = {
                        {
                            name = "Smelt Thorium",
                            type = "trivial",
                            difficulty = "trivial",
                            icon = "Interface\\Icons\\INV_Ingot_05",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Thorium Ore",
                                    icon = "Interface\\Icons\\INV_Ore_Thorium_01",
                                    required = 1,
                                    have = 120
                                }
                            }
                        },
                        {
                            name = "Smelt Arcanite",
                            type = "optimal",
                            difficulty = "optimal",
                            icon = "Interface\\Icons\\INV_Ingot_06",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Thorium Bar",
                                    icon = "Interface\\Icons\\INV_Ingot_05",
                                    required = 1,
                                    have = 45
                                },
                                {
                                    name = "Arcane Crystal",
                                    icon = "Interface\\Icons\\INV_Enchant_EssenceArcaneLarge",
                                    required = 1,
                                    have = 0
                                }
                            }
                        }
                    }
                }
            }
        },
        {
            name = "Elara",
            realm = "Sulfuron", 
            level = 55,
            class = "Mage",
            race = "Human",
            lastUpdate = 1721836800,
            lastUpdateDate = "2025-07-24 12:00:00",
            professions = {
                {
                    name = "Tailoring",
                    level = 285,
                    maxLevel = 300,
                    lastScan = 1721836800,
                    lastScanDate = "2025-07-24 12:00:00",
                    recipes = {
                        {
                            name = "Mooncloth",
                            type = "easy",
                            difficulty = "easy",
                            icon = "Interface\\Icons\\INV_Fabric_Moonrag_01",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Felcloth",
                                    icon = "Interface\\Icons\\INV_Fabric_Felcloth_Ebon",
                                    required = 2,
                                    have = 8
                                }
                            }
                        },
                        {
                            name = "Robe of the Archmage",
                            type = "optimal",
                            difficulty = "optimal",
                            icon = "Interface\\Icons\\INV_Chest_Cloth_17",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Mooncloth",
                                    icon = "Interface\\Icons\\INV_Fabric_Moonrag_01",
                                    required = 4,
                                    have = 2
                                },
                                {
                                    name = "Golden Thread",
                                    icon = "Interface\\Icons\\INV_Misc_Thread_01",
                                    required = 2,
                                    have = 15
                                }
                            }
                        }
                    }
                },
                {
                    name = "Enchanting",
                    level = 275,
                    maxLevel = 300,
                    lastScan = 1721836800,
                    lastScanDate = "2025-07-24 12:00:00",
                    recipes = {
                        {
                            name = "Enchant Weapon - Crusader",
                            type = "optimal",
                            difficulty = "optimal",
                            icon = "Interface\\Icons\\INV_Sword_20",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Large Brilliant Shard",
                                    icon = "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge",
                                    required = 4,
                                    have = 1
                                },
                                {
                                    name = "Righteous Orb",
                                    icon = "Interface\\Icons\\INV_Misc_Orb_03",
                                    required = 2,
                                    have = 0
                                }
                            }
                        },
                        {
                            name = "Enchant Chest - Major Health",
                            type = "medium",
                            difficulty = "medium",
                            icon = "Interface\\Icons\\INV_Chest_Cloth_17",
                            timestamp = 1721836800,
                            reagents = {
                                {
                                    name = "Greater Eternal Essence",
                                    icon = "Interface\\Icons\\INV_Enchant_EssenceEternalLarge",
                                    required = 15,
                                    have = 8
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

-- Web format example (optimized for web integration)
local WebFormatExample = {
    source = "RecipesExtractor",
    version = "1.0.0",
    realm = "Sulfuron",
    timestamp = 1721836800,
    data = {
        {
            character = {
                name = "Thorin",
                realm = "Sulfuron",
                level = 60,
                class = "Warrior",
                race = "Dwarf"
            },
            professions = {
                {
                    name = "Blacksmithing",
                    level = 300,
                    maxLevel = 300,
                    recipes = {
                        {
                            name = "Arcanite Champion",
                            difficulty = "optimal",
                            reagents = {
                                { name = "Arcanite Bar", required = 15, have = 3 },
                                { name = "Dense Grinding Stone", required = 4, have = 8 }
                            }
                        }
                    }
                }
            }
        }
    }
}

-- CSV format example
local CSVExample = [[
"Character","Realm","Class","Level","Profession","ProfessionLevel","MaxLevel","Recipe","Type","Difficulty","Reagents"
"Thorin","Sulfuron","Warrior",60,"Blacksmithing",300,300,"Arcanite Champion","optimal","optimal","Arcanite Bar (15); Dense Grinding Stone (4)"
"Thorin","Sulfuron","Warrior",60,"Mining",300,300,"Smelt Arcanite","optimal","optimal","Thorium Bar (1); Arcane Crystal (1)"
"Elara","Sulfuron","Mage",55,"Tailoring",285,300,"Robe of the Archmage","optimal","optimal","Mooncloth (4); Golden Thread (2)"
"Elara","Sulfuron","Mage",55,"Enchanting",275,300,"Enchant Weapon - Crusader","optimal","optimal","Large Brilliant Shard (4); Righteous Orb (2)"
]]

return {
    full = ExampleData,
    web = WebFormatExample,
    csv = CSVExample
}
