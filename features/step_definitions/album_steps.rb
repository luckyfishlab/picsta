

Given /^I create the album "(.*?)"$/ do |arg1|
  visit '/albums'
  click_link "New Album"
  fill_in "Title", :with => arg1
  click_button "Create Album"
  @last_uri = URI.parse(current_url).path
  @last_album = arg1
end

When /^I try the last URL$/ do
  visit @last_uri

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
