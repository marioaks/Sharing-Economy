Feature: Services Filter Test

  As a user
  I should be able to filter the services by "Ride-Sharing", "House-Sharing", "Other", and "All",
  In order to understand where the data is being collected from.

  Scenario: Ride Sharing filter works
    Given I'm on the Ride Sharing page
    Then I should see Transport Services

  Scenario: House Sharing filter works
    Given I'm on the House Sharing page
    Then I should see Home Services