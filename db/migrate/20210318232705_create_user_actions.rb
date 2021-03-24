class CreateUserActions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_actions, id: :uuid do |t|
      t.string :user_id
      t.string :poi_id
      t.string :action_user
      t.integer :status, :default => 0

      t.timestamps
    end
  end
end
