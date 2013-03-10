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

Then /^I am a viewer$/ do
  @user = User.find_by_email("invited@example.com")
  m = Membership.find_by_user_id(@user.id)
  r = Role.find_by_name(:viewer)
  m.role_id.should be(r.id)
end

