class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.date :last_reminded

      t.timestamps null: false
    end
  end
end
