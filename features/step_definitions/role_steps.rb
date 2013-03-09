Given /^I am logged in as an admin$/ do
  create_user_as 'Test Admin',:admin
  sign_in_as "admin"
end

When /^I can click on the users page$/ do
  visit '/users'
end

Then /^I should see the admin portal$/ do
  page.should have_content "Hello Admin"
end

When /^I visit the root$/ do
  visit '/'
end

Then /^I should not see the admin link$/ do
  page.should_not have_content "Admin"
end
