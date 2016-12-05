class AddPointsToLearnings < ActiveRecord::Migration
  def change
    add_column :learnings, :term_point, :float, default: 0.0
  end
end
