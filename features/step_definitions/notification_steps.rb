When /^I click subscribe$/ do
  click_link "Subscribe"
  click_button "OK"
end

Then /^I see a successful subscribe message$/ do
  page.should have_content "Saved"
end