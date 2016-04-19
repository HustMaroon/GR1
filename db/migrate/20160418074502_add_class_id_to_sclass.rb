class AddClassIdToSclass < ActiveRecord::Migration
  def change
    add_column :sclasses, :sclass_id, :string
  end
end
