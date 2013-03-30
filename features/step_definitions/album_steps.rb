
Given /^An album is shared with "(.*?)"$/ do |arg1|
  steps %{
    And I am logged in as "#{arg1}" as a "viewer"
    And I sign out
    And I am logged in as "Steve" as a "subscriber"
    And I create the album "my album"
    And I share the album "my album" with "#{arg1}"
    And I sign out
  }
end

When /^An image is added to a shared album$/ do
  steps %{
    And I sign out
    And I sign in as "Steve"
    And I visit the album "Test Album"
    And I want to add images to the album
    And I upload an image
    And I sign out
  }
end

When /^I add an image to "(.*?)"$/ do |arg1|
  steps %{
    And I visit the album "#{arg1}"
    And I want to add images to the album
    And I upload an image
  }
end

Given /^I create the album "(.*?)"$/ do |arg1|
  visit '/albums'
  click_link "New Album"
  fill_in "Title", :with => arg1
  click_button "Create Album"
  @last_uri = URI.parse(current_url).path
  @last_album = arg1
end

Given /^I share the album "(.*?)" with "(.*?)"$/ do |arg1, arg2|
  visit '/albums'
  click_link arg1
  first(:link, "Share Album").click
  select(arg2, :from => "User")
  click_button "Share"
end

Given /^I visit the album "(.*?)"$/ do |arg1|
  visit '/albums'
  click_link arg1
  #first(:link, arg1).click

end


When /^I try the last URL$/ do
  visit @last_uri

end

When /^I list albums$/ do
  visit '/albums'
end

When /^I create an album$/ do
  visit '/albums'
  click_link "New Album"
  fill_in "Title", :with => "my album"
  click_button "Create Album"
end

Then /^I should see an created message$/ do
  page.should have_content "Album was successfully created."


end
When /^I select the album$/ do
  visit '/albums'
  click_link "my album"
end
Then /^I should see the album contents$/ do
  page.should have_content "my album"
end


Then /^I should see an error$/ do
  page.should_not have_content @last_album
end


Then /^I should see the album "(.*?)"$/ do |arg1|
  page.should have_content arg1
end

Then /^I should not see the "(.*?)" link$/ do |arg1|
  page.should_not have_content arg1
end