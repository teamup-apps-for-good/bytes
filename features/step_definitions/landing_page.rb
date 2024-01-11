Given('I am on the landing page of the site') do
    visit('/')
end

Then('I should see {string} on the landing page') do |string|
    expect(page).to have_content(string)
end
