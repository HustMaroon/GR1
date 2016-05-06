class AddPointsToLearnings < ActiveRecord::Migration
  def change
    add_column :learnings, :process_point, :float
    add_column :learnings, :term_point, :float
    add_column :learnings, :avg_point, :float
  end
end
