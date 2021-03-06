require "json"

module BotMapped
  class ActionTextBlocks
    include JSON::Serializable

    @[JSON::Field(key: "actionCommand")]
    property actionCommand : String

    @[JSON::Field(key: "updateToPhase")]
    property updateToPhase : Int32
      
    @[JSON::Field(key: "textBlock")]
    property textBlock : String?
  end

  class Conversation
    include JSON::Serializable

    @[JSON::Field(key:"phase")]
    property phase : Int32
    
    @[JSON::Field(key: "actionResultBlock")]
    property actionResultBlock : Bool
    
    @[JSON::Field(key: "internVariables")]
    property internVariables : Array(String)?
    
    @[JSON::Field(key: "updateToPhase")]
    property updateToPhase : Int32?

    @[JSON::Field(key: "textBlock")]
    property textBlock : String?
      
    @[JSON::Field(key: "helpTextBlock")]
    property helpTextBlock : String?

    @[JSON::Field(key: "actionTextBlocks")]
    property actionTextBlocks : Array(ActionTextBlocks)?
  end

  class Metadata
    include JSON::Serializable

    @[JSON::Field(key: "maxPhase")]
    property maxPhase : Int32    
  end

  class Blocks
    include JSON::Serializable

    @[JSON::Field(key: "blocks")]
    property blocks : Array(Conversation)

    @[JSON::Field(key: "metadata")]
    property metadata : Metadata
  end
end