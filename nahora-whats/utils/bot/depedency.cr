#The ORDER does total difference, be careful
require "file"
require "./config_bot/bot_config_read"
require "./config_bot/bot_config_process"
require "./cache_bot/bot_cache"
require "./handle_conversation"

PHASE = "phase"
UPDATE_TO_PHASE = "updateToPhase"
TEXT_BLOCK = "textBlock"
ACTION_TEXT_BLOCKS =  "actionTextBlocks"
ACTION_RESULT_BLOCK = "actionResultBlock"
ACTION_COMMAND = "actionCommand"
INTERN_VARIABLES = "internVariables"
PATH_CACHES = ROOT_PATH + "/utils/bot/cache_bot/_caches/"
PATH_CONFIG_BOT = ROOT_PATH + "/utils/bot/config_bot/_configs/"

alias AllInt = Int8 | Int16 | Int32 | Int64
alias AllType = Float32 | Float64 | Int16 | Int32 | Int64 | Int8 | String | Nil
alias BlockTypeOne = Hash(String, Array(Hash(String, Int32 | String | Nil)) | Array(String) | Bool | Int32 | String | Nil) | Nil