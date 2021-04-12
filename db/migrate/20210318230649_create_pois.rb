class CreatePois < ActiveRecord::Migration[6.1]
  def change
    create_table :pois, id: :uuid do |t|
      t.string :user_id
      t.string :action_id
      t.string :name
      t.string :subcategory_id
      t.json :fields
      t.decimal :poi_latitude, precision: 10, scale: 6
      t.decimal :poi_longitude, precision: 10, scale: 6
      
      
      t.timestamps
    end
    add_index :pois, [:poi_latitude, :poi_longitude]
  end
end
