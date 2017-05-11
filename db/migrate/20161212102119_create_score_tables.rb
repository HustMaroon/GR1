class CreateScoreTables < ActiveRecord::Migration
  def change
    create_table :score_tables do |t|
      t.references :score_component, index: true, foreign_key: true
      t.string :title

      t.timestamps null: false
    end
  end
end
