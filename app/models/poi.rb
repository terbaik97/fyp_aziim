class Poi < ApplicationRecord
  has_paper_trail versions: { class_name: "PaperTrail::PoiVersion" }
  has_many :user_actions
  validates_presence_of  :name
end
