class UserAction < ApplicationRecord
  has_paper_trail
  enum status: {
      active: 0,
      disabled: 1
    }

  belongs_to :user, class_name: 'User'
  has_many :pois , foreign_key: :poi_id, class_name: 'Poi'
end
