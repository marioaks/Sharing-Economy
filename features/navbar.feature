Feature: Navigation Bar and Footer Test

  As a user
  I want to see a top navigation bar and a footer with menu options
  So that I can easily get to the 'Home', 'About' and 'Contact' pages
  

  Scenario: Go to About Page from navigation bar (Home)
    Given I'm on the homepage
    When I follow "about_nav"
    Then I should be on about
    
  Scenario: Go to About Page from footer (Home)
    Given I'm on the homepage
    When I follow "about_foot"
    Then I should be on about

  Scenario: Go to Contact Page from navigation bar (Home)
    Given I'm on the homepage
    When I follow "contact_nav"
    Then I should be on contact
    
  Scenario: Go to Contact Page from footer (Home)
    Given I'm on the homepage
    When I follow "contact_foot"
    Then I should be on contact

  Scenario: Go to Home Page from navigation bar (About)
    Given I'm on the about page
    When I follow "home_nav"
    Then I should be on the homepage
    
  Scenario: Go to Home Page from footer (About)
    Given I'm on the about page
    When I follow "home_foot"
    Then I should be on the homepage

  Scenario: Go to Contact Page from navigation bar (About)
    Given I'm on the about page
    When I follow "contact_nav"
    Then I should be on contact
    
  Scenario: Go to Contact Page from footer (About)
    Given I'm on the about page
    When I follow "contact_foot"
    Then I should be on contact

  Scenario: Go to Home Page from navigation bar (Contact)
    Given I'm on the contact page
    When I follow "home_nav"
    Then I should be on the homepage
    
  Scenario: Go to Home Page from footer (Contact)
    Given I'm on the contact page
    When I follow "home_foot"
    Then I should be on the homepage

  Scenario: Go to Contact Page from navigation bar (Contact)
    Given I'm on the contact page
    When I follow "contact_nav"
    Then I should be on contact
    
  Scenario: Go to Contact Page from footer (Contact)
    Given I'm on the contact page
    When I follow "contact_foot"
    Then I should be on contact

