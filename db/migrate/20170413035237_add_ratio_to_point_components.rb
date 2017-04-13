class AddRatioToPointComponents < ActiveRecord::Migration
  def change
    add_column :point_components, :ratio, :float
  end
end
