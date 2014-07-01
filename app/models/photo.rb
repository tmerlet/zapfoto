class Photo < ActiveRecord::Base
  belongs_to :roll

  mount_uploader :image, ImageUploader
end
