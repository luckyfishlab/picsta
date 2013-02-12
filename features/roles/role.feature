Feature: Administer users
  As an administrator
  I want to edit user group memberships
  So I can control who can access resources

  Scenario: I sign in and use admin dashboard
    Given I am logged in as an admin
    When I can click on the users page
    Then I should see the admin portal
