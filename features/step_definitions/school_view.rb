Given(/the following schools exist/) do |schools_table|
  schools_table.hashes.each do |school|
    School.create(school)
  end
end

Given('I am on the schools page') do
  visit(schools_path)
  expect(page).to have_current_path(schools_path)
end

Given('I am on the school page for {string}') do |school_name|
  school = School.find_by(name: school_name)
  visit(school_path(school))
  expect(page).to have_current_path(school_path(school))
end

Then('I should see all of the schools') do
  School.exists?(School.all)
end

Given("I am on the new school page") do
  visit(new_school_path)
end

When("I fill in the form with valid school information") do
  fill_in "Name", with: "Test"
  fill_in "Domain", with: "test.edu"
  fill_in "Logo", with: "test.png"
end

Then("I should be redirected to the schools index page") do
  expect(page).to have_current_path(schools_path)
end
