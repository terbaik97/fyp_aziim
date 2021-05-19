class ImagePoi < ApplicationRecord
    # single file upload
    mount_uploader :image, ImagePoiUploader
    # multiple file upload
    # mount_uploaders :images, ImagePoiUploader
    belongs_to :poi
    validates_presence_of :poi_id
end
