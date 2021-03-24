class CreateUserActionVersions < ActiveRecord::Migration[6.0]
  def change
    PaperTrail::Version.migrate_new_item_type(self, 'User')
  end
end
