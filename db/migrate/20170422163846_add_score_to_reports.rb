class AddScoreToReports < ActiveRecord::Migration
  def change
    add_column :reports, :score, :float
  end
end
