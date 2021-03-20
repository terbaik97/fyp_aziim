class User < ApplicationRecord
    rolify
    has_secure_password
    has_paper_trail
  
    PASSWORD_REQUIREMENTS = /\A
      (?=.{8,})
    /x
  
    enum status: {
      active: 0,
      disabled: 1
    }
  
    # validates_presence_of :email, :password_digest
    # # validates :password, format: PASSWORD_REQUIREMENTS
    # validates :password
    # validates :email, uniqueness: true
    validates_presence_of  :email, :password_digest

    has_many :user_actions , foreign_key: :user_id, class_name: 'UserAction'
end
