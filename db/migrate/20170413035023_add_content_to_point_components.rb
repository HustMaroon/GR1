class AddContentToPointComponents < ActiveRecord::Migration
  def change
    add_column :point_components, :content, :string
  end
end
