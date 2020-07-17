#https://crystal-lang.org/api/0.19.4/Array.html
#https://crystal-lang.org/api/0.21.0/Hash.html
#https://crystal-lang.org/api/0.21.0/NamedTuple.html
#https://crystal-lang.org/api/0.21.0/Enumerable.html#each_with_object(obj%2C%26block)-instance-method
require "file"
require "./bot_config_read"

jsonFile = File.read("./bot_msg.json")

blocks = BotMapped::Blocks.from_json(jsonFile)
conversation = blocks.blocks

def extractActionTextBlocks(configs)
  configs.map do |c|
    {
      "actionCommand" => c.actionCommand,
      "updateToPhase" => c.updateToPhase,
      "textBlock" => c.textBlock
    }
  end
end

def extractConversations(conversation)
  conversation.map do |c|
      {
        "phase" => c.phase,
        "actionResultBlock" => c.actionResultBlock,
        "internVariables" => c.internVariables,
        "updateToPhase" => c.updateToPhase,
        "textBlock" => c.textBlock,
        "actionTextBlocks" => c.actionTextBlocks.is_a?(Array(BotMapped::ActionTextBlocks)) ? 
        extractActionTextBlocks(c.actionTextBlocks.as(Array(BotMapped::ActionTextBlocks))) : nil
      }
  end
end
resul = extractConversations conversation

p resul[0].keys.includes?("actionTextBlocks")



# -----------------------------------------------------TIPS------------------------------------------------------------------ #
#To get key, not search in the children
# p configs.fetch("blocks", nil)

#See if key exists, not search in the children
# p configs.has_key?("person")

#Give all keys in the root
# p configs.keys

#Give all values in the root
# p configs.values

#self explanation, not search in the children, and ! make function in the self object
# p configs.reject! "person"

#contrary of the above
# p configs.select! "person"
