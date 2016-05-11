class AddContentToMiniWorks < ActiveRecord::Migration
  def change
    add_column :mini_works, :content, :string
  end
end
