class UserAction < ApplicationRecord
  has_paper_trail versions: { class_name: "PaperTrail::UserActionVersion" }
  enum status: {
      active: 0,
      disabled: 1
    }

  belongs_to :user
  belongs_to :poi

end
