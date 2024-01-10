# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
users = [{name: "John", uin: "123456", email: "j@tamu.edu", credits: 50, user_type:"donor", date_joined: "01/01/2022"},
        {name: "Todd", uin: "324567", email: "t@tamu.edu", credits: 10, user_type:"recipient", date_joined: "01/01/2022"}]
CreditPool.create({credits: 0})
User.create(users)
