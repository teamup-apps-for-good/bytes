# frozen_string_literal: true

Given('a user with the email of {string}, uin of {string}, and {int} credits is in the external API') do |email, uin, credit|
  response = {
    credits: credit,
    first_name: 'First',
    last_name: 'Last',
    email:,
    uin:
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uin}))
    .to_return(status: 200, body: response.to_json)
end

Then('I should be on the create new user page') do
  expect(page).to have_current_path(new_user_path)
end

And('I should see a field for {string}') do |field|
  expect(page).to have_field(field)
end

And('I select {string} from {string}') do |value, field|
  page.select(value, from: field)
end
