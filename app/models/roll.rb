class Roll < ActiveRecord::Base
  belongs_to :user
  has_many :photos, dependent: :destroy

  def available_photos
    remaining = self.size - photos.count
    self.current = false if remaining == 0 && self.current  != false
    self.state = "full" if remaining == 0 && self.current != "full"
    self.save
    remaining
  end

  def automailer(current_user)
    if self.available_photos == 0
      MailWorker.perform_async current_user.id, self.id
    end
  end
end
