Given('the following meetings exist:') do |meetings_table|

    meetings_table.hashes.each do |meeting|
        Meeting.create(meeting)
    end

end

Then('I should see a link to the meeting page') do
    expect(page).to have_content("Meetings")
end

Given('I am on the meeting page') do
    visit("/meetings")
end

Then('I should see meetings on the page') do
    expect(page).to have_css('.meeting-item')
end

Then('I should not see any meetings on the page') do
    expect(page).not_to have_css('.meeting-item')
end

And('There are no existing meetings') do
    Meeting.destroy_all
    visit("/meetings")
end