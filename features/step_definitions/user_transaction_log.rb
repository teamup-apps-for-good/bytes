Given(/the following transactions exist/) do |transactions_table|
  transactions_table.hashes.each do |transaction|
    Transaction.create(transaction)
  end
end

Given('I have made or received a donation') do
  user = User.create(name: 'John', uin: '254007932', email: 'j@tamu.edu', credits: '50', user_type: 'donor', date_joined: '01/01/2022')

  Transaction.where(uin: user.uin).exists?
end

Given('I am on the My Transactions page') do
  visit('/transactions')
  current_path = '/transactions'
  expect(current_path).to eq(transactions_path)
end

Then('I should see my donations') do
  user = User.create(name: 'Billy', uin: '214003865', email: 'b@tamu.edu', credits: '43', user_type: 'donor', date_joined: '01/10/2022')

  Transaction.where(uin: user.uin).exists?
end

Then('I should see my received donations') do
  user = User.create(name: 'James', uin: '284007821', email: 'james@tamu.edu', credits: '15', user_type: 'recipent', date_joined: '01/01/2023')

  Transaction.where(uin: user.uin).exists?
end
