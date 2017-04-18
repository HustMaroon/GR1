class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true, foreign_key: true
      t.text :content
      t.boolean :correct, default: false
      t.string :image

      t.timestamps null: false
    end
  end
end
