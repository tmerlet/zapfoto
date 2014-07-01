class Roll < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  def available_photos
    self.size - photos.count
  end
end
