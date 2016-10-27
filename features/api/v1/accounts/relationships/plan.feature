@api/v1
Feature: Account plan

  Background:
    Given the following "accounts" exist:
      | Name  | Subdomain |
      | Test1 | test1     |
      | Test2 | test2     |
    And I send and accept JSON

  Scenario: Admin changes subscribed account to a new plan
    Given the account "test1" is subscribed
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "200"

  Scenario: Admin changes trialing account to a new plan
    Given the account "test1" is trialing
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "200"

  Scenario: Admin changes pending account to a new plan
    Given the account "test1" is pending
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "200"

  Scenario: Admin changes paused account to a new plan
    Given the account "test1" is paused
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "422"

  Scenario: Admin changes canceled account to a new plan
    Given the account "test1" is canceled
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "422"

  Scenario: Admin attempts to change to an invalid plan
    Given the account "test1" is subscribed
    And there exists 3 "plans"
    And I am an admin of account "test1"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "invalid" }
      """
    Then the response status should be "422"

  Scenario: Admin attempts to change plan for another account
    Given the account "test1" is subscribed
    And there exists 3 "plans"
    And I am an admin of account "test2"
    And I use my authentication token
    When I send a POST request to "/accounts/$0/relationships/plan" with the following:
      """
      { "plan": "$plan[0]" }
      """
    Then the response status should be "401"
