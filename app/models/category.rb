class Category < ApplicationRecord
    mount_uploader :image, CategoryUploader
    validates_presence_of :category_name
end
