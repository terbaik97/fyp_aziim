class CreatePois < ActiveRecord::Migration[6.1]
  def change
    create_table :pois, id: :uuid do |t|
      t.string :user_id
      t.string :action_id
      t.json :fields
      t.point :coordinate
      t.string :subcategory_id
      
      t.timestamps
    end
  end
end
