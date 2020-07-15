#CLEARCHANGE: https://anykeyh.github.io/clear/Clear/Migration/Helper.html#add_column(table,column,datatype,nullable=false,constraint=nil,default=nil,with_values=false)-instance-method
require "clear"

class CreateTable
  include Clear::Migration

  def change(dir)
    create_enum("budget", %w(low mid high unknow))
    add_column("users", "budget", "budget", nullable = true, constraint = nil, default = "'unknow'")
  end
end

# Activate all the migrations. Will call change with up direction for each down migrations
p Clear::Migration::Manager.instance.apply_all