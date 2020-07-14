#CLEARCHANGE: https://clear.gitbook.io/project/migrations/call-migration-script
require "clear"

class CreateTable
  include Clear::Migration

  def change(dir)
    create_enum("gender", %w(male female unknow))
    create_enum("renda", %w(low mid high unknow))

    create_table(:users, id: :uuid) do |t|
      t.column :username, :string, null: false
      t.column :phone, :string, unique: true, null: false, index: true
      t.column :money, :float
      t.column :gender, :gender, default: "'unknow'"
      t.column :renda, :renda, default: "'unknow'"

      t.timestamps
    end

  end
end

# Activate all the migrations. Will call change with up direction for each down migrations
p Clear::Migration::Manager.instance.apply_all