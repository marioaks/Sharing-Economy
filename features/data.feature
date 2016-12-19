Feature: Data Test

  As a data inputer
  I want to be able to add services and/or listings and have the number of services in a country automatically recalculate
  In order to populate my d3 visualizations.
  
#not relevant anymore
  #Scenario: Add a Country
  #  Given I'm on the country page
  #  When I try to add a new country
  #  Then I should be able to see the new country's page


  Scenario: Add a Service
    Given I'm on the service page
    When I try to add a new service
    Then I should be able to see the new service's page

#not relevant anymore
  #Scenario: Add a Listing without a Country
  #  Given I'm on the listing page
  #  When I try to add a new listing without a country
  #  Then I should see a blank country error