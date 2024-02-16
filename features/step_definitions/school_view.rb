Given(/the following schools exist/) do |schools_table|
  schools_table.hashes.each do |school|
    School.create(school)
  end
end

Given('I am on the schools page') do
  visit(schools_path)
  expect(page).to have_current_path(schools_path)
end

Given('I am on the school page for tamu') do
  visit(schools_path(1))
  expect(page).to have_current_path(schools_path(1))
end

Then('I should see all of the schools') do
  School.exists?(School.all)
end
