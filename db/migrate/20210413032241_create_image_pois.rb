class CreateImagePois < ActiveRecord::Migration[6.1]
  def change
    create_table :image_pois, id: :uuid do |t|
      t.string :poi_id
      t.json :images
      t.timestamps
    end
  end
end
