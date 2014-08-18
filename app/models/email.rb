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
#  created_at            :datetime
#  updated_at            :datetime
#

#referral_id, :integer
#first_admin_notification, :boolean
#first_user_reminder, :boolean
#first_admin_reminder, :boolean
#second_user_reminder, :boolean
#second_admin_reminder, :boolean


class Email < ActiveRecord::Base
  belongs_to :referral, :dependent => :destroy
  validates_uniqueness_of :referral_id

  def return_second_user_lag
    if self.second_user_reminder #if second_admin_reminder that will be the latest reminder.
      last_update = Date.parse(self.updated_at.to_s)
      current_date = Date.parse(Time.now.to_s)
      days_lag = current_date - last_update
    else
      days_lag = 0
    end
  end


  def return_second_admin_lag
    if self.second_admin_reminder #if second_admin_reminder that will be the latest reminder.
      last_update = Date.parse(self.updated_at.to_s)
      current_date = Date.parse(Time.now.to_s)
      days_lag = current_date - last_update
    else
      days_lag = 0
    end
  end
end
