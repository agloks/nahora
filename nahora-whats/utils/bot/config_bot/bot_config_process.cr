#https://crystal-lang.org/api/0.19.4/Array.html
#https://crystal-lang.org/api/0.21.0/Hash.html
#https://crystal-lang.org/api/0.21.0/NamedTuple.html
#https://crystal-lang.org/api/0.21.0/Enumerable.html#each_with_object(obj%2C%26block)-instance-method
require "../depedency"

module ConverterBOT
  def _extractActionTextBlocks(configs)
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
          "helpTextBlock" => c.helpTextBlock,
          "actionTextBlocks" => c.actionTextBlocks.is_a?(Array(BotMapped::ActionTextBlocks)) ? 
          _extractActionTextBlocks(c.actionTextBlocks.as(Array(BotMapped::ActionTextBlocks))) : nil
        }
    end
  end
end

module UtiliesBOT
  #block == the hash with the actual phase conversation
  #blocks == array with block

  def getPhaseBlock(blocks, phase : AllInt)
    #return block case found, if not return nil
    blocks.each do |block|
      return block if block[PHASE] == phase
    end
  end
  
  def getHelpText(block) : String
    block.not_nil![HELP_TEXT_BLOCK].as(String)
  end

  def getUpdateToPhase(block) : AllInt | Nil
    #return the phase to update case exists, if not return nil
    temp_hash = block.select UPDATE_TO_PHASE
    if temp_hash[UPDATE_TO_PHASE] != nil
      temp_hash[UPDATE_TO_PHASE].as(AllInt | Nil)
    end
  end

  def hasActionTextBlocks(block) : Bool
    block.fetch(ACTION_TEXT_BLOCKS, nil) != nil
  end

  def getInternVariables(block) : Array(String) | Nil
    begin
      block.fetch(INTERN_VARIABLES, nil).as(Array(String))      
    rescue exception
      nil
    end
  end

  def getFromFileConfiguration(path : String)
    jsonFile = File.read(path)
    blocks = BotMapped::Blocks.from_json(jsonFile)

    {
     "blocks" => blocks.blocks,
     "metadata" => blocks.metadata
    }
  end
end


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