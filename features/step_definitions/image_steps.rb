### GIVEN ###
Given /^I want to add images to the album$/ do
  first(:link, "Add Images").click
end

Given /^I click on the image$/ do
  click_link "test image"
end

Given /^I save the URL$/ do
  @last_uri = URI.parse(current_url).path
end


### WHEN ###
When /^I upload an image$/ do
  fill_in "Title", :with => "test image"
  attach_file('image_pic', "#{Rails.root}/features/fixtures/test.jpg")
  click_button "Save"
end

When /^I click on remove image$/ do
  click_link "Remove"
end

When /^I try to delete an image$/ do
  puts @last_uri
  pending # express the regexp above with the code you wish you had
end

### THEN ###
Then /^I see a successful add image message$/ do
  page.should have_content "The image was saved successfully."
end

Then /^I see a successful delete image message$/ do
  page.should have_content "The image was successfully removed."
end


Then /^I get an error message$/ do
  pending # express the regexp above with the code you wish you had
end
