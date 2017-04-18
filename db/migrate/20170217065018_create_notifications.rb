class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :user_type
      t.string :content
      t.string :link
      t.boolean :read, default: false

      t.timestamps null: false
    end
  end
end
