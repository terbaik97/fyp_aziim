class PaperTrailVersionGenerator < Rails::Generators::NamedBase
    include Rails::Generators::Migration
    source_root File.expand_path("templates", __dir__)
  
    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      ActiveRecord::Migration.next_migration_number(next_migration_number)
    end
  
    def create_paper_trail_version_file
      @item_class_name = file_name.camelize
      version_model_path = Rails.root.join("app/models/paper_trail/#{file_name}_version.rb")
      db_migrate_path = Rails.root.join("db/migrate")
      @version_class_name = "#{file_name}_version".camelize
      version_table_name = "#{file_name}_versions"
  
      # version model file
      create_file version_model_path, <<~EOS
        module PaperTrail
          class #{@version_class_name} < ::PaperTrail::Version
            define_split_table_for('#{@item_class_name}')
          end
        end
      EOS
  
      # migration file
      migration_template "create_paper_trail_version_table.rb.erb", db_migrate_path.join("create_#{version_table_name}.rb")
    end
  end
  