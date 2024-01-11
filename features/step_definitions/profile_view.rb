Then('I should see my {string}') do |string|
    expect(page).to have_content(string)
    if string == "Name"
        expect(page).to have_content(@name)
    end
    if string == "Email"
        expect(page).to have_content(@email)
    end
    if string == "Credits"
        expect(page).to have_content(@credits)
    end 
    if string == "Type"
        expect(page).to have_content(@user_type)
    end
    if string == "UIN"
        expect(page).to have_content(@uin)
    end
end