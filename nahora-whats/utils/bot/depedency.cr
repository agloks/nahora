#The ORDER does total difference, be careful
require "file"
require "./config_bot/bot_config_read"
require "./config_bot/bot_config_process"
require "./cache_bot/bot_cache"
require "./handle_conversation"

PHASE = "phase"
UPDATE_TO_PHASE = "updateToPhase"
ACTION_TEXT_BLOCKS =  "actionTextBlocks"
INTERN_VARIABLES = "internVariables"
PATH_CACHES = ROOT_PATH + "/utils/bot/cache_bot/_caches/"
PATH_CONFIG_BOT = ROOT_PATH + "/utils/bot/config_bot/_configs/"

alias AllInt = Int8 | Int16 | Int32 | Int64