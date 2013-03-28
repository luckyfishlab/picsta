Feature: Email notice
  In order to keep up with changes to my albums
  As a user
  I want to be able to be notified when an album changes

#  Scenario: Subscriber gets an email
#    Given An album is shared with "Joe"
#    Given I sign in as "Joe"
#      And I list albums
#      And I click subscribe
#     When An image is added to a shared album
#      And Album email notifications are processed
#     Then "joe@example.com" should receive 1 emails

  Scenario: Invited user can access subscriber's albums
     Given I am logged in as "Steve" as a "subscriber"
     Given I create the album "Test Album"
     And I invite someone
     And I sign out
     And "invited@example.com" opens the email
     And I follow "Accept invitation" in the email
     And I register with valid credentials
     When I list albums
     When I should see the album "Test Album"
    When An image is added to a shared album
     And a clear email queue
     And Album email notifications are processed
    Then "invited@example.com" should receive 1 emails
     And "invited@example.com" opens the email
     And they should see "Test Album" in the email body