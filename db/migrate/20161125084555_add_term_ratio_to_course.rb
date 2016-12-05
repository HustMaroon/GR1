class AddTermRatioToCourse < ActiveRecord::Migration
  def change
    add_column :subjects, :term_ratio, :float, default: 0.7
  end
end
