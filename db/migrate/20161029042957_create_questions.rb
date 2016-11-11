class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :test, index: true, foreign_key: true
      t.text :content
      t.integer :type
      t.string :image

      t.timestamps null: false
    end
  end
end
