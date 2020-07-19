require "./depedency"

include ConverterBOT
include UtiliesBOT

# result = extractConversations(getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json"))
# p getPhaseBlock(result, 0)
# p hasActionTextBlocks result[0]
# p getUpdateToPhase result[0]
# p getInternVariables result[1]

#Inject here the variable provide by our integration conversation
struct LetterToBOT
  property name, phone, text

  def initialize(@name : String, @phone : String, @text : String) end
end

abstract class IConversation
  abstract def initialize(botContext : Bot)
  abstract def response() : String | Nil
end

class Bot
  property phase_stage : AllInt
  property conversation : IConversation | Nil #state
  property letter : LetterToBOT

  def initialize(@letter : LetterToBOT)
    @phase_stage = 0
    @conversation = HandlerConversation.new self
  end

  def set_phase(phase : AllInt)
    @phase_stage = phase
  end

  def run
    conversation = HandlerConversationAction.new self
    conversation.response
  end
end

class HandlerConversationAction < IConversation
  property updateToPhase = 0

  def initialize(botContext : Bot)
    @botContext = botContext
  end

  def response : String | Nil
    # pattern = /.*#{@actionCommand}.*/mi
    pattern = /.*/mi
    result = pattern.match @botContext.letter.text
    if result != nil
      @botContext.set_phase @updateToPhase
    end

    result.try &.string
  end
end

class HandlerConversation < IConversation
  def initialize(botContext : Bot)
    @botContext = botContext
  end

  def response : String
    @botContext.letter.text
  end
end

letter = LetterToBOT.new "Amanda", "551195069324", "Quero comer"
# p letter

bot = Bot.new letter
p bot.run

# ------------------------------------------------------ TIP ------------------------------------------------------------------------ #

# In all:
#   
# def _updateStage(self, level):
#   self.phase_stage = level
#   self.data_to_cache["phaseStagePerson"] = self.phase_stage
#   self.data_to_cache["address"] = self.address  
#   
#   handlerJson.writeToJSONFile(self.data_to_cache, "./temp/", self.phone)

# def phase_X(self):
#   pattern = re.compile(".*((?P<number>1|2)|(?P<command>ajuda|comer))", re.I | re.M)
#   regex_result = pattern.match(self.text)
  
#   self.commands = f'''
#     1) Ajuda
#     2) Comer
#   '''

#   if(regex_result == None):
#     unknow_response(self.commands)
#     return -1

#   action = [item for item in regex_result.groupdict().values() if item != None][0].lower()
#   if((action == "2") or (action == "comer")):
#     self._updateStage(2)

#   return stage_1(action)

# class HandlerConversation(PhasesConversation):
#   def __init__(self, name, phone, text):
#     super().__init__(name, phone, text)
#     self.name = name
#     self.phone = phone
#     self.text = text

#   def run(self):
#     #must to ben run at root folder project
#     data_cached = handlerJson.loadJson("./temp/", self.phone)
#     if(data_cached):
#       #if it overcome the limit of the 2 min without update, reset the stage
#       if(not isCached(data_cached)):
#         self._updateStage(0)
#         self.phase_stage = 0
#       else:
#         self.phase_stage = data_cached["phaseStagePerson"]
#       #putting address to the class base manipulate
#       if("address" in data_cached):
#         self.address = data_cached["address"]

#     phases = {
#       0: self.phase_0,
#       1: self.phase_1,
#       2: self.phase_2,
#       3: self.phase_3,
#       4: self.phase_4,
#       4.1: self.phase_4_01,
#       4.2: self.phase_4_02
#     }

#     try:
#       return phases[self.phase_stage]()
#     except Exception as e:
#       return unknow_response(self.commands)

# for text in conversation_test_one:
#   handlerConversation = HandlerConversation("Amanda", "551195069324", text)
#   time.sleep(1)
#   print(handlerConversation.run())