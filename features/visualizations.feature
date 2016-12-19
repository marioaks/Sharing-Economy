Feature: D3 Visualizations Test

  As a user
  I want to see D3 Graph Visualizations on the Homepage
  So that I can visualize my dummy data
  

  Scenario: The First WorldMap is visible
    Given I'm on the homepage
    Then I should see an element "#worldMap"


  Scenario: Visualization 2 is visible on a redirect
    Given I'm on the homepage
    When I follow "about_nav"
    When I follow "home_nav"
    Then I should see an element "#citiesMap"

  Scenario: Visualization 3 is visible on a homepage reload
    Given I'm on the homepage
    When I reload the page
    Then I should see an element "#swedenMap"
