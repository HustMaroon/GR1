class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_id
      t.float :term_ratio, default: 0.7

      t.timestamps null: false
    end
  end
end
