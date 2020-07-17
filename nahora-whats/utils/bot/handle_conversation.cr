require "file"

require "./bot_config_read"

jsonFile = File.read("./bot_msg.json")

configs = BotUnmapped::Person.from_json(jsonFile).json_unmapped


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