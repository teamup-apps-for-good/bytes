Given /the following users exist/ do |table|
    table.hashes.each do |user|
        User.create user
    end
end

