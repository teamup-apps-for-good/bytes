# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# users = [{ name: 'John', uin: '412334', email: 'j@tamu.edu', credits: 50, user_type: 'donor', date_joined: '01/01/2022' },
#          { name: 'Todd', uin: '324567', email: 't@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' },
#          { name: 'Steve', uin: '12321', email: 'v@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' }]
# User.create(users)

transactions = [{ uin: '254007932', transaction_type: 'donated', time: '2024-01-09T00:52:48', amount: 3 },
                { uin: '214003865', transaction_type: 'donated', time: '2023-11-19T00:52:48', amount: 1 },
                { uin: '284007821', transaction_type: 'recieved', time: '2024-01-01T00:52:48', amount: 2 },
                { uin: '231006398', transaction_type: 'donated', time: '2024-01-01T00:52:48', amount: 2 }]
Transaction.create(transactions)
CreditPool.create({ credits: 0 })

schools = [{name: 'Texas A&M University', domain: 'tamu.edu', logo: 'tamu-logo-words.png'}]
School.create(schools)
