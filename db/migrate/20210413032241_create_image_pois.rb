class CreateImagePois < ActiveRecord::Migration[6.1]
  def change
    create_table :image_pois, id: :uuid do |t|
      t.string :poi_id
      t.string :image
      t.text :name
      t.text :base_64
      t.string :size
      t.timestamps
    end
  end
end
