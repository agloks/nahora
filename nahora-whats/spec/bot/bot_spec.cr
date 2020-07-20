require "./spec_helper"

describe Bot do

  describe "#Instance" do
    it "Instance type of bootstrap application is correct", tags: "integration" do
      letter = LetterToBOT.new "Amanda", "1", "oi"
      bot = Bot.new letter, "bot_msg.json"
      
      letter.should be_a(LetterToBOT)
      bot.should be_a(Bot)
    end

    #Sometimes here give error, and others not because ->
      #@blocks = botContext.configBot.not_nil![ACTION_TEXT_BLOCKS].as(
      #  Array(Hash(String, Int32 | String | Nil)) | Array(String)
      #)
    #botContext.configBot is coming nil because of async operation time of process (I think the reason is the async I/O that read config from json)
    it "context of state classes should be the bot class", tags: "integration" do
      letter = LetterToBOT.new "Amanda", "1", "oi"
      bot = Bot.new letter, "bot_msg.json"
      bot.build

      sleep(0.05) #Putting sleep, the error of configBot is null not happen, but this solution not is so good as could be
      
      handler_with_action = HandlerConversationAction.new bot
      handler_without_action = HandlerConversation.new bot

      handler_with_action.botContext.not_nil!.should be_a(Bot)
      handler_without_action.botContext.not_nil!.should be_a(Bot)
    end

    it "change with the intern variables", tags: "integration" do
      Utilies.deleteCache(PATH_CACHES + "1.json")

      letter = LetterToBOT.new "Amanda", "1", "oi"
      bot = Bot.new letter, "bot_msg.json"
      bot.build

      text = bot.conversation.not_nil!.response
      text_preprocessed = bot.preprocess_intern_variables text

      text_preprocessed.as(String).should contain("Oi Amanda")
    end
  end

  describe "#Workflow" do
    it "#Flow one", tags: ["integration", "workflow"] do
      fake_conversation = [
        "Oi",
        "Quero comer",
        "Mais próximos",
        "MEEE CoMEr"
      ]
      expected_response = [
        "linguagem dos humanos",
        "qual endereço você se encontra",
        "gostei de você",
        "linguagem dos humanos"
      ]
      Utilies.deleteCache(PATH_CACHES + "1.json")
      
      fake_conversation.each_index do |idx|
        letter = LetterToBOT.new "Amanda", "1", fake_conversation[idx]
        bot = Bot.new letter, "bot_msg.json"
        bot.build

        response = bot.run
        response.not_nil!.should contain(expected_response[idx])
      end
    end
  end

  describe "#MappedJSON" do
    it "Read config file json for bot", tags: "basic" do
      configs = Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json")

      blocks = configs["blocks"].should be_a(Array(BotMapped::Conversation))
      configs["metadata"].should be_a(BotMapped::Metadata)
    end

    it "Extract conversations from blocks", tags: "basic" do
      configs = Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json")

      blocks = configs["blocks"].should be_a(Array(BotMapped::Conversation))
      configs["metadata"].should be_a(BotMapped::Metadata)

      conversations = Converter.extractConversations(blocks)

      conversations[0].should be_truthy
    end
  end

  describe "#Functions" do
    it "Control cache time with 2 min", tags: ["basic", "function"] do
      two_minutes_in_second = minutesToSecond(2)
      time_now = Time.utc.to_unix
      inCache_case = isInCacheTime(time_now)
      notCache_case = isInCacheTime(time_now - two_minutes_in_second)

      inCache_case.should be_true
      notCache_case.should be_false
    end

    it "has action block", tags: ["basic, function"] do
      configs = Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json")
      blocks = configs["blocks"].should be_a(Array(BotMapped::Conversation))
      conversations = Converter.extractConversations(blocks)
      block_with_action = Utilies.hasActionTextBlocks conversations[1]
      block_without_action = Utilies.hasActionTextBlocks conversations[0]
      
      block_with_action.should be_true
      block_without_action.should be_false
    end

    it "get the intern variables", tags: ["basic, function"] do
      configs = Utilies.getFromFileConfiguration(PATH_CONFIG_BOT + "bot_msg.json")
      blocks = configs["blocks"].should be_a(Array(BotMapped::Conversation))
      conversations = Converter.extractConversations(blocks)
      block_with_intern_variable = Utilies.getInternVariables conversations[0]
      block_without_intern_variable = Utilies.getInternVariables conversations[1]
    
      block_with_intern_variable.should be_a(Array(String))
      block_without_intern_variable.should be_nil
    end
  end
end