Feature: Passing Data to Graph 1

  As a user
  I should be able to see read the number of services per country in the first choropleth map
  In order to understand the data being presented.

  Scenario: (new) Countries page contains services
    Given I'm on a service page
    Then I should see the Service on the Country page

  Scenario: (new) Services page contains countries
    Given I'm on a country page
    Then I should see the Country on the Service page