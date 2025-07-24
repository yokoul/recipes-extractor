-- Configuration file for RecipesExtractor
-- This file contains customizable settings and constants

RecipesExtractorConfig = {
    -- Version information
    VERSION = "0.1.0-alpha",
    BUILD_DATE = "2025-07-24",
    AUTHOR = "yokoul@auberdine.eu",
    
    -- UI Settings
    UI = {
        MAIN_FRAME_WIDTH = 600,
        MAIN_FRAME_HEIGHT = 500,
        EXPORT_FRAME_WIDTH = 700,
        EXPORT_FRAME_HEIGHT = 600,
        
        -- Colors (RGB values 0-1)
        COLORS = {
            TITLE = { r = 1, g = 1, b = 0 },           -- Yellow
            SUCCESS = { r = 0, g = 1, b = 0 },         -- Green  
            ERROR = { r = 1, g = 0, b = 0 },           -- Red
            WARNING = { r = 1, g = 0.5, b = 0 },       -- Orange
            INFO = { r = 0.5, g = 0.5, b = 1 },        -- Light Blue
            BACKGROUND = { r = 0, g = 0, b = 0, a = 0.8 },
            BORDER = { r = 0.2, g = 0.2, b = 0.2, a = 1 }
        },
        
        -- Font settings
        FONTS = {
            TITLE = "GameFontNormalLarge",
            NORMAL = "GameFontNormal", 
            SMALL = "GameFontNormalSmall"
        }
    },
    
    -- Data collection settings
    DATA_COLLECTION = {
        AUTO_SCAN_DELAY = 0.5,          -- Delay before auto-scanning (seconds)
        SCAN_RETRY_ATTEMPTS = 3,        -- Number of retry attempts for failed scans
        SCAN_RETRY_DELAY = 1.0,         -- Delay between retry attempts
        
        -- Professions to ignore (if any)
        IGNORED_PROFESSIONS = {},
        
        -- Auto-scan settings
        AUTO_SCAN_ON_LOGIN = true,
        AUTO_SCAN_ON_PROFESSION_OPEN = true,
        
        -- Data validation
        VALIDATE_RECIPE_DATA = true,
        MIN_RECIPE_NAME_LENGTH = 2,
        MAX_REAGENTS_PER_RECIPE = 20
    },
    
    -- Export settings
    EXPORT = {
        -- Default export format
        DEFAULT_FORMAT = "json",
        
        -- Include optional data in exports
        INCLUDE_ICONS = true,
        INCLUDE_REAGENT_DETAILS = true, 
        INCLUDE_TIMESTAMPS = true,
        INCLUDE_CHARACTER_DETAILS = true,
        
        -- JSON formatting
        JSON_PRETTY_PRINT = true,
        JSON_INDENT_SIZE = 2,
        
        -- CSV settings
        CSV_DELIMITER = ",",
        CSV_QUOTE_CHAR = '"',
        CSV_INCLUDE_HEADERS = true,
        
        -- Web export settings
        WEB_INCLUDE_METADATA = true,
        WEB_COMPACT_FORMAT = false
    },
    
    -- Database settings
    DATABASE = {
        -- Automatic cleanup
        AUTO_CLEANUP_ENABLED = true,
        CLEANUP_INTERVAL_DAYS = 30,     -- Clean up data older than X days
        MAX_CHARACTERS_PER_REALM = 50,   -- Maximum characters to track per realm
        
        -- Data retention
        KEEP_DELETED_CHARACTERS = false, -- Keep data for deleted characters
        CHARACTER_TIMEOUT_DAYS = 90,     -- Remove character data after X days of inactivity
        
        -- Backup settings
        AUTO_BACKUP_ENABLED = false,     -- Automatic backup of data
        BACKUP_INTERVAL_HOURS = 24,      -- Backup frequency
        MAX_BACKUP_FILES = 5             -- Maximum backup files to keep
    },
    
    -- Notification settings
    NOTIFICATIONS = {
        SHOW_SCAN_NOTIFICATIONS = true,
        SHOW_ERROR_NOTIFICATIONS = true,
        SHOW_SUCCESS_NOTIFICATIONS = true,
        
        -- Notification colors
        NOTIFICATION_COLORS = {
            SUCCESS = "|cff00ff00",  -- Green
            ERROR = "|cffff0000",    -- Red  
            WARNING = "|cffffff00",  -- Yellow
            INFO = "|cff00ffff"      -- Cyan
        }
    },
    
    -- Debug settings
    DEBUG = {
        ENABLED = false,                 -- Enable debug mode
        LOG_LEVEL = "INFO",             -- DEBUG, INFO, WARN, ERROR
        LOG_TO_CHAT = false,            -- Show debug messages in chat
        LOG_TO_FILE = false,            -- Save debug logs to file (if supported)
        VERBOSE_SCANNING = false,       -- Detailed scanning information
        TRACE_FUNCTION_CALLS = false    -- Trace all function calls
    },
    
    -- Performance settings
    PERFORMANCE = {
        MAX_SCAN_TIME_MS = 1000,        -- Maximum time to spend scanning (milliseconds)
        THROTTLE_UPDATES = true,        -- Throttle UI updates during scanning
        UPDATE_INTERVAL_MS = 100,       -- UI update interval during operations
        
        -- Memory management
        CLEANUP_INTERVAL_MINUTES = 10,  -- Memory cleanup interval
        MAX_MEMORY_USAGE_MB = 50        -- Maximum memory usage before cleanup
    },
    
    -- Integration settings
    INTEGRATION = {
        -- Web integration specific settings
        WEB = {
            API_VERSION = "1.0",
            INCLUDE_REALM_DATA = true,
            INCLUDE_GUILD_DATA = false,   -- Future feature
            COMPRESS_OUTPUT = false       -- Future feature
        },
        
        -- Other addon compatibility
        COMPATIBILITY = {
            AUCTIONEER = false,           -- Future: price data integration
            ATLAS_LOOT = false,           -- Future: recipe source integration  
            GATHERER = false              -- Future: gathering location data
        }
    },
    
    -- Localization settings
    LOCALIZATION = {
        DEFAULT_LOCALE = "enUS",
        SUPPORTED_LOCALES = { "enUS", "frFR", "deDE", "esES" },
        AUTO_DETECT_LOCALE = true
    },
    
    -- Feature flags (for future development)
    FEATURES = {
        RECIPE_COSTS_CALCULATION = false,    -- Calculate material costs
        GUILD_SHARING = false,               -- Share data with guild members
        CROSS_REALM_SYNC = false,            -- Sync data across realms
        RECIPE_RECOMMENDATIONS = false,      -- Suggest recipes to learn
        PROFESSION_PLANNER = false,          -- Plan profession progression
        MARKET_INTEGRATION = false           -- Market price integration
    }
}

-- Helper function to get config values with defaults
function RecipesExtractorConfig:GetValue(path, default)
    local value = self
    for segment in string.gmatch(path, "[^%.]+") do
        if type(value) == "table" and value[segment] ~= nil then
            value = value[segment]
        else
            return default
        end
    end
    return value
end

-- Helper function to set config values
function RecipesExtractorConfig:SetValue(path, newValue)
    local segments = {}
    for segment in string.gmatch(path, "[^%.]+") do
        table.insert(segments, segment)
    end
    
    if table.getn(segments) == 0 then return false end
    
    local current = self
    for i = 1, table.getn(segments) - 1 do
        local segment = segments[i]
        if type(current[segment]) ~= "table" then
            current[segment] = {}
        end
        current = current[segment]
    end
    
    current[segments[table.getn(segments)]] = newValue
    return true
end

-- Validation function for configuration
function RecipesExtractorConfig:Validate()
    local errors = {}
    
    -- Validate UI settings
    if self.UI.MAIN_FRAME_WIDTH < 400 or self.UI.MAIN_FRAME_WIDTH > 1200 then
        table.insert(errors, "Invalid main frame width: " .. self.UI.MAIN_FRAME_WIDTH)
    end
    
    if self.UI.MAIN_FRAME_HEIGHT < 300 or self.UI.MAIN_FRAME_HEIGHT > 800 then
        table.insert(errors, "Invalid main frame height: " .. self.UI.MAIN_FRAME_HEIGHT)
    end
    
    -- Validate data collection settings
    if self.DATA_COLLECTION.AUTO_SCAN_DELAY < 0 or self.DATA_COLLECTION.AUTO_SCAN_DELAY > 5 then
        table.insert(errors, "Invalid auto scan delay: " .. self.DATA_COLLECTION.AUTO_SCAN_DELAY)
    end
    
    -- Validate export settings
    local validFormats = { json = true, csv = true, web = true }
    if not validFormats[self.EXPORT.DEFAULT_FORMAT] then
        table.insert(errors, "Invalid default export format: " .. self.EXPORT.DEFAULT_FORMAT)
    end
    
    return table.getn(errors) == 0, errors
end

return RecipesExtractorConfig
