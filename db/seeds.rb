Whitelist.delete_all
Job.delete_all
Referral.delete_all
User.delete_all
Admin.delete_all

Whitelist.create(email: "loritiernan@gmail.com", is_admin: false)
Whitelist.create(email: "info@wekrut.com", is_admin: true)
Whitelist.create(email: "deaglan1@gmail.com", is_admin: true)

