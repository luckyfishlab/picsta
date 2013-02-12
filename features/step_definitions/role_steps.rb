def set_role(user_name , role)
  role = FactoryGirl.create(:admin_role)
  user = User.where(:name => user_name)
  membership = FactoryGirl.create(:admin_membership)
end


Given /^I am logged in as user "(.*?)" with role "(.*?)"$/ do |arg1, arg2|
    create_user_as arg1
    sign_in_as arg1
    set_role(arg1, arg2)
end

When /^I can click on the users page$/ do
  visit '/users'
end

Then /^I should see the admin portal$/ do
  page.should have_content "Hello admin"
end
