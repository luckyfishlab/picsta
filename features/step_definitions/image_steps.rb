### GIVEN ###
Given /^I want to add images to the album$/ do
  click_link "Add Images"
end

Given /^I click on the image$/ do
  click_link "test image"
end

#Given /^I want to delete an image$/ do
#  click_link "Remove"
#end

### WHEN ###
When /^I upload an image$/ do
  fill_in "Title", :with => "test image"
  attach_file('image_pic', "#{Rails.root}/features/fixtures/test.jpg")
  click_button "Save"
end

When /^I click on remove image$/ do
  click_link "Remove"
end

### THEN ###
Then /^I see a successful add image message$/ do
  page.should have_content "The image was saved successfully."
end

Then /^I see a successful delete image message$/ do
  page.should have_content "The image was successfully removed."
end