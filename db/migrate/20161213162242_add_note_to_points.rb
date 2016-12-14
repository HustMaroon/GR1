class AddNoteToPoints < ActiveRecord::Migration
  def change
    add_column :points, :note, :string
  end
end
