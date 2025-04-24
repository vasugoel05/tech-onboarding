Feature: Validate Ultimate QA Automation Page

  Scenario: Verify page title, links, and console errors
    Given I open the Ultimate QA automation page
    Then the page title should be "Automation Practice - Ultimate QA"
    And all links should redirect to their proper URLs
    And there should be no console errors