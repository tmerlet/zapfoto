class Roll < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  def available_photos
    remaining = self.size - photos.count
    self.current = false if remaining == 0 && self.current  != false
    self.state = "full" if remaining == 0 && self.current != "full"
    self.save
    remaining
  end
end
