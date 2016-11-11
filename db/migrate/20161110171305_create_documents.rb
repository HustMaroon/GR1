class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :sclass, index: true, foreign_key: true
      t.string :title
      t.string :link
      t.text :description

      t.timestamps null: false
    end
  end
end
