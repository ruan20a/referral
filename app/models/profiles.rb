# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Profiles < ActiveRecord::Base
	belongs_to :admin
	belongs_to :user
end
