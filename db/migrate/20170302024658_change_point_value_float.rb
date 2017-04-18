class ChangePointValueFloat < ActiveRecord::Migration
  def change
  	change_column :points, :value, :float
  end
end
