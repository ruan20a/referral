# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end


# every 1.day, :at => '10:00 pm' do
#   rake "events:fetch"
# end

# Learn more: http://github.com/javan/whenever
set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
job_type :script, "'#{path}/script/:task' :output"


every 5.minutes do
  rake "pending_reminder_user:check", environment => "development"
  rake "pending_reminder_admin:check", environment => "development"
  rake "inactive_referral_user:check", environment => "development"
  rake "inactive_referral_admin:check", environment => "development"
  rake "inactive_referral_is_inactive_check", environment => "development"
end