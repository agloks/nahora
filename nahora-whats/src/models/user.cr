# Define the enum : https://clear.gitbook.io/project/additional-and-advanced-features/enums
Clear.enum Gender, "male", "female", "unknow"
Clear.enum Renda, "low", "mid", "high", "unknow"


#CLEARCHANGE: https://github.com/anykeyh/clear/tree/master/manual/model/column-types / https://anykeyh.github.io/clear/Clear/Model.html
class User
  include Clear::Model
  self.table = "users"

  # primary_key
  # column id : Int64, primary: true, presence: false
  primary_key :id, type: :uuid
  column username : String
  column phone : String
  column money : Float32?
  column gender : Gender?
  # column renda : Renda?
  
  timestamps
end