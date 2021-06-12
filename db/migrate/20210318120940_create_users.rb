class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :nickname
      t.string :full_name
      t.string :email
      t.string :mobile_number
      t.string :nationality
      t.integer :status, :default => 0
      t.integer :user_point, :default => 100
      t.string :avatar
      t.integer :total_badges
      t.boolean :is_verified_mobile_number, default: false
      t.boolean :is_verified_email, default: false
      t.string :password_digest

      t.timestamps
    end
  end
end
