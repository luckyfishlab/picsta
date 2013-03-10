Feature: Subscription plans
  As a site user
  I'd like to subscribe to a plan
  So that I can maintain albums
  Background:
    Given I am not logged in
     And  The "entry level" plan exists

  Scenario: Must be signed in
    When I visit the "/thanks" page
    Then I should see "You need to sign in or sign up before continuing"

  Scenario: Thanks page
     When I sign up with valid user data
     Then I should be on the "thanks" page
      And I should see "Thanks"

  Scenario: Can look at available plans
      And I sign up with valid user data
     When I click the link "Subscribe"
     Then I should see "Choose a subscription plan"

  Scenario: Can pick a plan
    And I sign up with valid user data
    And I click the link "Subscribe"
   When I select the "entry level" plan
    Then I see the subscription form

  Scenario: Can subscribe
    And I sign up with valid user data
    And I click the link "Subscribe"
    And I select the "entry level" plan
    When I complete the subscription form with valid credit card data
    Then I should see "Thank you for subscribing"

