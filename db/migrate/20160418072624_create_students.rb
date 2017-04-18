class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :std_id
      t.string :name
      t.string :password_digest
      t.date :last_reminded

      t.timestamps null: false
    end
  end
end
