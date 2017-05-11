class CreateLearnings < ActiveRecord::Migration
  def change
  	create_table :learnings do |t|
  		t.references :student, index: true, foreign_key: true
  		t.references :sclass, index: true, foreign_key: true
  		t.references :group, index: true
  		t.float :term_point, default: 0
  		t.timestamps null: false
  	end
  end
end
