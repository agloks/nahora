class User < Granite::Base
  connection pg
  table users

  column id : Int64, primary: true
  column username : String
  column age : Int32?
  column phone : String?
  timestamps
end
