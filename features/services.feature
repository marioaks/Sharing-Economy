Feature: Services Test

  As a user
  I want to see three different service category menu options
  So that I can navigate to their pages
  

  Scenario: Ride Sharing icon loads
    Given I'm on the homepage
    Then the speedometer icon loads

  Scenario: House Sharing icon loads
    Given I'm on the homepage
    When I follow "about_nav"
    When I follow "home_nav"
    Then the home icon loads

  Scenario: Other icon loads
    Given I'm on the homepage
    When I follow "about_nav"
    When I follow "contact_foot"
    When I follow "home_nav"
    Then the magnifier icon loads

  Scenario: All icon loads
    Given I'm on the homepage
    When I reload the page
    Then the layers icon loads