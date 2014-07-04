class Photo < ActiveRecord::Base
  belongs_to :roll

  mount_uploader :image, ImageUploader

  # validates_format_of :image, :with => %r{\.(png|jpg|jpeg)\A}i, message: "Photo must be .png, .jpg or .jpeg"
end
