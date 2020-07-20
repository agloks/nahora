require "json"
require "../../../root_path"

module CacheBotMapped
  class Cache
    include JSON::Serializable

    @[JSON::Field(key: "namePerson")]
    property namePerson : String?

    @[JSON::Field(key: "phonePerson")]
    property phonePerson : String?
      
    @[JSON::Field(key: "phase")]
    property phase : Int32 | Int64 | Nil
    
    @[JSON::Field(key: "address")]
    property address : String?

    @[JSON::Field(key: "timeUnixEpoch")]
    property timeUnixEpoch : Int32 | Int64 | Nil
  end
end

module UtiliesCacheBot
  def cacheExists(path : String) : Bool
    File.exists?(path)
  end

  def getFromFileCache(path : String)    
    jsonFile = File.read(path)
    cache = CacheBotMapped::Cache.from_json(jsonFile)
    cache_hash = {
      "namePerson" => cache.namePerson,
      "phonePerson" => cache.phonePerson,
      "phase" => cache.phase,
      "address" => cache.address,
      "timeUnixEpoch" => cache.timeUnixEpoch
    }

    cache_hash
  end

  def deleteCache(path : String)
    if cacheExists path
      File.delete(path)
    end
  end

  def saveCache(path : String, content)
    # TODO: throw error instead false
    File.write(path, content, mode: "w")
  end
end