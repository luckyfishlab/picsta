When /^I click subscribe$/ do
  click_link "Subscribe"
  page.check("share_email_notice")
  click_button "OK"
end

When /^Album email notifications are processed$/ do
  nm = NotificationManager.new()
  nm.process

end


Then /^I see a successful subscribe message$/ do
  page.should have_content "Saved"
end