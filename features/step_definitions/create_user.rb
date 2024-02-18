# frozen_string_literal: true

Given('there is an user with the email of {string}, uid of {string}, and {int} credits in the external API') do |email, uid, credit|
  response = {
    credits: credit,
    first_name: 'First',
    last_name: 'Last',
    email:,
    uid:
  }
  stub_request(:get, %(https://tamu-dining-62fbd726fd19.herokuapp.com/users/#{uid}))
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
