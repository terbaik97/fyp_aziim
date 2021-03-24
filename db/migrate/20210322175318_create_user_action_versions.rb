class CreateUserActionVersions < ActiveRecord::Migration[6.1]
    def change
      PaperTrail::Version.migrate_new_item_type(self, 'UserAction')
    end
  end
  