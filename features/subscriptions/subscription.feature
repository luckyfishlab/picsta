Feature: Subscription plans
  As a site user
  I'd like to subscribe to a plan
  So that I can maintain albums
  Background:
    Given I am not logged in

  Scenario: Must be signed in
    When I visit the "/thanks" page
    Then I should see "You need to sign in or sign up before continuing"

  Scenario: Thanks page
     When I sign up with valid user data
     Then I should be on the "thanks" page
      And I should see "Thanks"

  Scenario: Can choose a plan
      And I sign up with valid user data
     When I press "Subscribe"
     Then I should see "Choose a subscription level"



