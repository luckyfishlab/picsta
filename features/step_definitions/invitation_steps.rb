Given /^I am a paid subscriber$/ do
  @user = FactoryGirl.create(:paid_subscriber)
  sign_in
end

When /^I invite someone$/ do
  visit "/users/invitation/new"
  fill_in "user_email", :with => "invited@example.com"
  click_button "Send an invitation"
end


When /^I register with invalid credentials$/ do
  fill_in "user_password", :with => "short"
  click_button "Accept invitation"
end

When /^I register with valid credentials$/ do
  fill_in "user_name", :with => "Invited User"
  fill_in "user_password", :with => "changeme"
  fill_in "user_password_confirmation", :with => "changeme"
  click_button "Accept invitation"
end


Then /^I should see "(.*?)"$/ do |arg1|
  page.should  have_content arg1
end