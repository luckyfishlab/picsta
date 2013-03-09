Feature: Subscription plans
  As a site user
  I'd like to subscribe to a plan
  So that I can maintain albums

  Scenario: Subscription page
    Given I am a visitor
    When I a register with the site
    Then I see the "new subscription page"

