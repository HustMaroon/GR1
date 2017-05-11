class CreateScoreComponents < ActiveRecord::Migration
  def change
    create_table :score_components do |t|
    	t.references :sclass
    	t.string :content
    	t.integer :ratio, default: 0
      t.timestamps null: false
    end
  end
end
