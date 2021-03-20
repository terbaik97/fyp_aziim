class Poi < ApplicationRecord
  has_paper_trail
  cuba cari hubung kait poi dengan user_action
  # belongs_to :user_action , class_name: 'UserAction'
end
