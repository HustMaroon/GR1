class AddRoomToSclass < ActiveRecord::Migration
  def change
    add_column :sclasses, :room, :string
  end
end
