class AddDefaultPointsToLearnings < ActiveRecord::Migration
  def change
  	change_column :learnings, :process_point, :float, :default => 0.0
  	change_column :learnings, :term_point, :float, :default => 0.0
  	change_column :learnings, :avg_point, :float, :default => 0.0
  end
end
