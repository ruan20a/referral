# == Schema Information
#
# Table name: companies
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  image          :string(255)
#  access_token   :string(255)
#  address_line_1 :text
#  address_line_2 :text
#  city           :string(255)
#  state          :string(255)
#  country        :string(255)
#  postal_code    :string(255)
#  level          :integer          default(1)
#  description    :text
#  industry       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  url			  :string
#

class Company < ActiveRecord::Base
mount_uploader :image, ImageUploader
has_many :admins
has_many :jobs

has_many :users, :through => :access

has_many :accesses
has_many :private_invitations
accepts_nested_attributes_for :private_invitations
has_many :users, :through => :accesses
validates_presence_of :name, :description, :city, :state
validates_uniqueness_of :name
before_create :generate_access_token
scope :private_users, lambda { |company|
  joins(:accesses).where('accesses.company_id', company.id)
} #pulls up list of private users


  def generate_access_token
    self.access_token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

end
