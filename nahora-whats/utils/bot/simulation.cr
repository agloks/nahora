require "./depedency"

fake_conversation = [
  "Oi",
  "Quero comer",
  "Mais próximos"
]

fake_conversation.each do |text|
  letter = LetterToBOT.new "Amanda", "55119506934", text
  bot = Bot.new letter, "bot_msg.json"

  bot.build
  pp bot.run
end