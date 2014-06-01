# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




Whitelist.create(email: "loritiernan@gmail.com", is_admin: false)
Whitelist.create(email: "info@wekrut.com", is_admin: true)



Referral.create(name: "Lori Tiernan", referral_name: "Deaglan McEachern", relationship: "friend", referral_email: "deaglan1@gmail.com", additional_details: "Deaglan is awesome", linked_profile_url: "http://www.linkedin.com/profile/view?id=62134001&locale=en_US&trk=tyah&trkInfo=tarId%3A1397934136810%2Ctas%3Adea%2Cidx%3A2-1-2", status: "Interview Stage", job_id: 8, admin_id: 1 )

Referral.create(name: "Deaglan McEachern", referral_name: "Lori Tiernan", relationship: "coworker", referral_email: "loritiernan@gmail.com", additional_details: "Lori is the best", linked_profile_url: "http://www.linkedin.com/profile/view?id=19416736&trk=nav_responsive_tab_profile", status: "Interview Stage", job_id: 8, admin_id: 1 )

