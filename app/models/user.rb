class User < ApplicationRecord
  rolify
    has_paper_trail
    # encrypt password
    has_secure_password
    # Validations
    validates_presence_of :name, :email, :password_digest
    # Model associations
    # has_many :todos, foreign_key: :created_by
end
