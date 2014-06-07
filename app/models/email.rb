# == Schema Information
#
# Table name: emails
#
#  id                    :integer          not null, primary key
#  referral_id           :integer
#  admin_notification    :boolean          default(FALSE)
#  first_admin_reminder  :boolean          default(FALSE)
#  first_user_reminder   :boolean          default(FALSE)
#  second_admin_reminder :boolean          default(FALSE)
#  second_user_reminder  :boolean          default(FALSE)
#

#referral_id, :integer
#first_admin_notification, :boolean
#first_user_reminder, :boolean
#first_admin_reminder, :boolean
#second_user_reminder, :boolean
#second_admin_reminder, :boolean


class Email < ActiveRecord::Base
  belongs_to :referral
  validates_uniqueness_of :referral_id
end
