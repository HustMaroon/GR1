class AddPointToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :point, :integer, default: 0
  end
end
