require "./depedency"

class Converter
  extend ConverterBOT
end
class Utilies
  extend UtiliesBOT
  extend UtiliesCacheBot
end

#Inject here the variable provide by our integration conversation
struct LetterToBOT
  property name, phone, text

  def initialize(@name : String, @phone : String, @text : String) end
  
  def to_h
    {
      "name" => name,
      "phone" => phone,
      "text" => text
    }
  end
end

abstract class IConversation
  abstract def initialize(botContext : Bot)
  abstract def response() : String
end

class Bot
  property phase_stage : AllType
  property conversation : IConversation | Nil #state
  property letter : LetterToBOT
  property helpText : String | Nil
  property configBot : Hash(String, Array(Hash(String, Int32 | String | Nil)) | Array(String) | Bool | Int32 | String | Nil) | Nil

  def initialize(@letter : LetterToBOT, @configBotFile : String)
    @phase_stage = 0
    @conversation = HandlerConversation.new self
  end

  def set_phase(phase : AllType)
    @phase_stage = phase
  end

  def build : Void
    cache = PATH_CACHES + "#{@letter.phone}.json"
    if(Utilies.cacheExists cache)
      cache_hash = Utilies.getFromFileCache(cache)
      @phase_stage = cache_hash[PHASE]
    end
    @configBot = up_configBot
    @helpText = Utilies.getHelpText @configBot
  end

  def up_configBot : BlockTypeOne #Why here it's working and if put in property not work...
    result = Converter.extractConversations(Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + @configBotFile))
    configBot = Utilies.getPhaseBlock(result, @phase_stage.as(AllInt))
    configBot
  end

  def preprocess_intern_variables(text : String) : String | Bool
    variables = Utilies.getInternVariables(@configBot.not_nil!)
    options = @letter.to_h
    if variables.is_a?(Array(String))
      variables.not_nil!.each do |var|
        text = text.gsub(/\#{#{var}}/, options[var])
      end
    end

    text.is_a?(String) ? text : false
  end

  def run
    begin
      if(@configBot.not_nil![ACTION_RESULT_BLOCK])
        @conversation = HandlerConversationAction.new self
      end
  
      text = @conversation.not_nil!.response
      text_preprocessed = preprocess_intern_variables text
      
      if text_preprocessed.is_a?(String)
        text = text_preprocessed
      end
      
      set_phase @phase_stage
      text
    rescue exception
      @helpText
    end
  end
end

class HandlerConversationAction < IConversation
  def initialize(botContext : Bot)
    @botContext = botContext
    @blocks = botContext.configBot.not_nil![ACTION_TEXT_BLOCKS].as(
      Array(Hash(String, Int32 | String | Nil)) | Array(String)
    )
  end

  def build_commands
    commands = Array(String).new
    @blocks.each do |block|
      commands << block[ACTION_COMMAND].as(String)
    end 
    commands
  end

  def get_blockMatched(action)
    @blocks.each do |block|
      if(block[ACTION_COMMAND] == action)
        return block
      end
    end
    -1
  end

  def response : String
    actionCommands = build_commands.join("|")
    pattern = /.*(?<command>#{actionCommands}).*/mi
    result = pattern.match @botContext.letter.text

    if result != nil
      blockMatched = get_blockMatched result.try &.["command"]
      if blockMatched != -1
        block = blockMatched.as(Hash(String, Int32 | String | Nil))
        @botContext.phase_stage = block[UPDATE_TO_PHASE].as(AllType)
       
        return block[TEXT_BLOCK].as(String)
      end
    end

    #TODO: PUT DEFAULT HELP TEXT
    @botContext.helpText.as(String)
  end
end

class HandlerConversation < IConversation
  def initialize(botContext : Bot)
    @botContext = botContext
  end

  def response : String
    block = @botContext.configBot.not_nil!
    text = block[TEXT_BLOCK]
    @botContext.phase_stage = block[UPDATE_TO_PHASE].as(AllType)

    text.as(String)
  end
end