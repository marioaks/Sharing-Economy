Feature: Nested Routes

  As a user
  If I am on a specific country or service page,
  Then I should be able to quickly look up the services or countries associated to it,
  In order to get the information quickly  

  Scenario: Services of a Country
    Given I'm on a country page
    When I move to its services route
    Then I should see its listed services

  Scenario: Countries of a Service
    Given I'm on a service page
    When I move to its countries route
    Then I should see its listed countries