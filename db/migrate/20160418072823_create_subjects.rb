class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :sbj_id
      t.float :term_ratio, default: 0.7

      t.timestamps null: false
    end
  end
end
