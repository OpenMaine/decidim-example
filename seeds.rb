email = "admin@openmaine.test"
password = 'OpenMaine123456'
user = Decidim::System::Admin.new(email: email, password: password, password_confirmation: password)
user.save!
