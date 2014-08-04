class Company < ActiveRecord::Base
has_many :Recruiters
has_many :Jobs
has_many :users, :through => :access
validates_presence_of :name
before_create :generate_access_token

  def generate_access_token
    self.access_token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

end