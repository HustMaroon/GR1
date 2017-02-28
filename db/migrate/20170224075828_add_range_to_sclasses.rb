class AddRangeToSclasses < ActiveRecord::Migration
  def change
    add_column :sclasses, :start_date, :date
    add_column :sclasses, :end_date, :date
  end
end
