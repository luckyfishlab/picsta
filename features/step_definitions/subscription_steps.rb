When /^I visit the "(.*?)" page$/ do |arg1|
  visit arg1
end

Given /^The "(.*?)" plan exists$/ do |arg1|
  FactoryGirl.create(:plan, {:name => arg1})
end

When /^I click the link "(.*?)"$/ do |arg1|
  click_link arg1
end

When /^I select the "(.*?)" plan$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I see the subscription form$/ do
  pending # express the regexp above with the code you wish you had
end


When /^I complete the subscription form with valid credit card data$/ do
  pending # express the regexp above with the code you wish you had
end
