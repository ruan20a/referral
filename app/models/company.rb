class Company < ActiveRecord::Base
has_many :admins
has_many :jobs

has_many :users, :through => :access

has_many :accesses
has_many :users, :through => :accesses

validates_presence_of :name
before_create :generate_access_token
mount_uploader :image, ImageUploader

  def generate_access_token
    self.access_token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

end