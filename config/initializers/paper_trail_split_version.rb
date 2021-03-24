PAPERTRAIL_VERSION_ITEM_TYPES = Dir[File.expand_path(Rails.root.join("app/models/paper_trail/*_version.rb"), __dir__)].map do |version_model_path|
  str = File.read(version_model_path)
  m = str.match(/define_split_table_for\('([^']+)'\)/)
  if m
    m[1]
  else
    raise "#{version_model_path} should call define_split_table_for(item_type)"
  end
end.freeze

if PAPERTRAIL_VERSION_ITEM_TYPES.uniq.length != PAPERTRAIL_VERSION_ITEM_TYPES.length
  duplicated_ones = PAPERTRAIL_VERSION_ITEM_TYPES - PAPERTRAIL_VERSION_ITEM_TYPES.uniq
  raise "duplicate paper trail version item types found. #{duplicated_ones.join(', ')}"
end

require "paper_trail/frameworks/active_record/models/paper_trail/version"

module PaperTrail
  class Version < ActiveRecord::Base
    include PaperTrail::VersionConcern
    self.abstract_class = true

    belongs_to :operator, class_name: '::User', foreign_key: :whodunnit, optional: true

    # Create new version table for new item_type
    #
    # @param migration_context [ActiveRecord::Migration[5.2]] The migration instance context. You could pass it with **self**
    # @param item_type [String] The item_type of version. Needs to be stored in PAPERTRAIL_VERSION_ITEM_TYPES
    #
    # @return [ActiveRecord::Migration[5.2]] The migration instance context
    def self.migrate_new_item_type(migration_context, item_type)
      raise "#{item_type} should be inside PAPERTRAIL_VERSION_ITEM_TYPES" unless PAPERTRAIL_VERSION_ITEM_TYPES.include?(item_type)

      item_type_in_table = item_type.underscore.tr('/', '_')
      split_table_name = "versions_#{item_type_in_table}"
      migration_context.instance_eval do
        create_table(split_table_name, id: :uuid) do |t|
          t.string :item_type, null: false
          t.string :item_id, null: false
          t.string :event, null: false
          t.string :whodunnit
          t.json :object_changes
          t.json :object
          
          t.datetime :created_at
          t.index %i[item_type item_id], name: "idx_#{split_table_name}_on_item"
        end
        add_index(split_table_name, [ :created_at ])
      end
      migration_context
    end

    # Define new version table class attributes for new item_type
    #
    # @param item_type [String] The item_type of version. Needs to be stored in PAPERTRAIL_VERSION_ITEM_TYPES
    #
    # @return [PaperTrail::Version] record class instance context
    def self.define_split_table_for(item_type)
      raise "#{item_type} should be inside PAPERTRAIL_VERSION_ITEM_TYPES" unless PAPERTRAIL_VERSION_ITEM_TYPES.include?(item_type)

      item_type_in_table = item_type.underscore.tr('/', '_')
      split_table_name = "versions_#{item_type_in_table}"
      self.primary_key = :id
      self.table_name = split_table_name.to_sym
      self.sequence_name = "#{split_table_name}_id_seq".to_sym
      self
    end
  end
end
