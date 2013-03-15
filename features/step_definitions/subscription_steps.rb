def assert_modal_visible arg1
  wait_until { page.find(arg1).visible? }
rescue Capybara::TimeoutError
  flunk 'Expected modal to be visible.'
end

When /^I visit the "(.*?)" page$/ do |arg1|
  visit arg1
end

Given /^The "(.*?)" plan exists$/ do |arg1|
  FactoryGirl.create(:plan, {:name => arg1})
end

When /^I click the link "(.*?)"$/ do |arg1|
  page.should have_content(arg1)
  click_link arg1
end


Given /^I edit my subscription details$/ do
  click_link "Edit account"

end

When /^I change to the "(.*?)" plan$/ do |arg1|
  choose arg1
end

Then /^I see a successful subscription change message$/ do
  pending # express the regexp above with the code you wish you had
end


Then /^I debug$/ do
  debugger
end

Then /^I see I am subscribed to "(.*?)" plan$/ do |arg1|
  page.should have_content "#{arg1} plan"
end

def modal_wrapper_id
  "#subscription_plan_id_1"
end
Then /^I see the subscription option "(.*?)"$/ do |arg1|
  page.should have_selector(modal_wrapper_id, visible: true)
  page.should have_content "#{arg1}"
end

Then /^I save a screenshot as "(.*?)"$/ do |arg1|
  page.save_screenshot(arg1)
end