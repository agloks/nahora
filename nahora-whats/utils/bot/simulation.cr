require "./depedency"

fake_conversation = [
  "Oi",
  "Quero comer",
  "Mais próximos",
  "MEEE CoMEr"
]

while true
  fake_conversation.each do |text|
    letter = LetterToBOT.new "Amanda", "1", text
    bot = Bot.new letter, "bot_msg.json"
  
    bot.build
    pp bot.run
    sleep(1)
  end  
end