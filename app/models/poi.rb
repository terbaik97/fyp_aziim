class Poi < ApplicationRecord
  has_paper_trail versions: { class_name: "PaperTrail::PoiVersion" }
  has_many :user_actions
  validates_presence_of  :name
  acts_as_mappable  :default_units => :miles,
                    :default_formula => :sphere,
                    :distance_field_name => :distance,
                    :lat_column_name => :poi_latitude,
                    :lng_column_name => :poi_longitude,
                    :name => :name
end
