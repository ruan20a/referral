# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Referral.delete_all




Referral.create(name: "Lori Tiernan", referral_name: "Deaglan McEachern", relationship: "friend", referral_email: "deaglan1@gmail.com", additional_details: "Deaglan is awesome", linked_profile_url: "http://www.linkedin.com/profile/view?id=62134001&locale=en_US&trk=tyah&trkInfo=tarId%3A1397934136810%2Ctas%3Adea%2Cidx%3A2-1-2", job_id: 15 )
Referral.create(name: "Deaglan McEachern", referral_name: "Lori Tiernan", relationship: "coworker", referral_email: "loritiernan@gmail.com", additional_details: "Lori is the best", linked_profile_url: "http://www.linkedin.com/profile/view?id=19416736&trk=nav_responsive_tab_profile", job_id: 15 )
Referral.create(name: "Lori Tiernan", referral_name: "Deaglan McEachern", relationship: "friend", referral_email: "deaglan1@gmail.com", additional_details: "Deaglan is awesome", linked_profile_url: "http://www.linkedin.com/profile/view?id=62134001&locale=en_US&trk=tyah&trkInfo=tarId%3A1397934136810%2Ctas%3Adea%2Cidx%3A2-1-2", job_id: 10 )
Job.create(name: "Hukkster", job_name: "Operations Associate", description: "This is the Job", speciality_1: "Operations", speciality_2: "Administrative", city: "New York", state: "NY", referral_fee: 1500, recruiter_id: 1, admin_id: 1 )
