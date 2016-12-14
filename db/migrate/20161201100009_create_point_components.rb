class CreatePointComponents < ActiveRecord::Migration
  def change
    create_table :point_components do |t|
    	t.references :sclass
    	t.string :content
    	t.integer :ratio, default: 0
      t.timestamps null: false
    end
  end
end
