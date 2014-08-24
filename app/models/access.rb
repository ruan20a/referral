# == Schema Information
#
# Table name: accesses
#
#  id         :integer          not null, primary key
#  company_id :integer
#  user_id    :integer
#  level      :integer          default(1)
#

class Access < ActiveRecord::Base
  belongs_to :company, :dependent => :destroy
  belongs_to :user, :dependent => :destroy
  validates_presence_of :company_id, :user_id

end
