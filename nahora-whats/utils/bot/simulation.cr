require "./depedency"

class Converter
  extend ConverterBOT
end
class Utilies
  extend UtiliesBOT
  extend UtiliesCacheBot
end

configs = Converter.extractConversations(Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json"))

fake_conversation = [
  "Oi",
  "Quero comer",
  "Mais próximos"
]

fake_conversation.each do |text|
  p Utilies.getFromFileCache(PATH_CACHES + "55119506934.json")
end