class AddTitleToScoreTables < ActiveRecord::Migration
  def change
    add_column :score_tables, :title, :string
  end
end
