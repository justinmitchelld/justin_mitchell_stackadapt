@ui
@request_demo
Feature: StackAdapt - Request Demo
  Navigate to StackAdapt -> Request A Demo.
  Submit Request a Demo with predefined dataset.

  Background:
    Given I navigate to the StackAdapt web application landing page
    Then I arrive at the landing page

  Scenario: Attempt to submit Request Demo form using an incomplete dataset.
    - Missing required fields company_size, budget, intention, GDPR
    When I click on the Request a Demo button
    Then I arrive at the request_demo page
    When I provide the following information for request_demo form:
      | first_name | last_name | email                    | phone        | company_name    | job_title               | company_type | company_size | country | region  | budget | intention | gdpr_consent |
      | Jane       | Doe       | jane.doe@advertising.com | +1112223344  | advertising.com | Chief Executive Officer | Publisher    |              | Canada  | Ontario |        |           | false        |
    And I click the submit button
    Then request_demo form attributes will be in the following state:
      | attribute    | feedback                                              |
      | first_name   |                                                       |
      | last_name    |                                                       |
      | email        |                                                       |
      | phone        |                                                       |
      | company_name |                                                       |
      | job_title    |                                                       |
      | company_type |                                                       |
      | company_size | Tell us the size of your company.                     |
      | country      |                                                       |
      | province     |                                                       |
      | budget       | Tell us your annual programmatic budget.              |
      | intention    | Tell us how you are looking to work with us.          |
      | gdpr_consent | Please agree in order for us to process your request. |