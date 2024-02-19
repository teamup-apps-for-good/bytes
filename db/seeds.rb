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
# users = [{ name: 'John', uid: '412334', email: 'j@tamu.edu', credits: 50, user_type: 'donor', date_joined: '01/01/2022' },
#          { name: 'Todd', uid: '324567', email: 't@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' },
#          { name: 'Steve', uid: '12321', email: 'v@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' }]
users = []
# users = [{ name: 'John', uid: '412334', email: 'j@tamu.edu', credits: 50, user_type: 'donor', date_joined: '01/01/2022' },
#          { name: 'Todd', uid: '324567', email: 't@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' },
#          { name: 'Steve', uid: '12321', email: 'v@tamu.edu', credits: 10, user_type: 'recipient',
#            date_joined: '01/01/2022' }]
users = []
User.create(users)

# transactions = [{ uid: '254007932', transaction_type: 'donated', time: '2024-01-09T00:52:48', amount: 3 },
#                 { uid: '214003865', transaction_type: 'donated', time: '2023-11-19T00:52:48', amount: 1 },
#                 { uid: '284007821', transaction_type: 'received', time: '2024-01-01T00:52:48', amount: 2 },
#                 { uid: '231006398', transaction_type: 'donated', time: '2024-01-01T00:52:48', amount: 2 }]
transactions = [{ uid: '123456785', transaction_type: 'donated', amount: 5, credit_pool_id: 1, created_at: '2024-02-14' },
                { uid: '123456785', transaction_type: 'donated', amount: 2, credit_pool_id: 1, created_at: '2024-02-15' },
                { uid: '123456785', transaction_type: 'donated', amount: 4, credit_pool_id: 1, created_at: '2024-02-16' },
                { uid: '123456785', transaction_type: 'donated', amount: 8, credit_pool_id: 1, created_at: '2024-02-17' },
                { uid: '123456785', transaction_type: 'donated', amount: 1, credit_pool_id: 1, created_at: '2024-02-18' },
                { uid: '123456785', transaction_type: 'received', amount: 3, credit_pool_id: 1, created_at: '2024-02-14' },
                { uid: '123456785', transaction_type: 'received', amount: 8, credit_pool_id: 1, created_at: '2024-02-15' },
                { uid: '123456785', transaction_type: 'received', amount: 5, credit_pool_id: 1, created_at: '2024-02-16' },
                { uid: '123456785', transaction_type: 'received', amount: 1, credit_pool_id: 1, created_at: '2024-02-17' },
                { uid: '123456785', transaction_type: 'received', amount: 5, credit_pool_id: 1, created_at: '2024-02-18' }]
Transaction.create(transactions)

credit_pools = [{ school_name: 'TAMU', email_suffix: 'tamu.edu', id_name: 'UIN', credits: 0, logo_url: 'https://www.tamu.edu/_files/images/athletics/LoneStar.png'},
                { school_name: 'UT Austin', email_suffix: 'utexas.edu', id_name: 'EID', credits: 0, logo_url: 'https://president.utexas.edu/sites/default/files/twitter_pres_emblem.png'}]
CreditPool.create(credit_pools)
