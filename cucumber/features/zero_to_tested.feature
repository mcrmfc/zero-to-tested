Feature: Zero To Tested App

  Scenario: Status is healthy
    When I visit status url
    Then the response contains "OK"

  @javascript
  Scenario: Ajaxy content can be found
    When I visit ajaxy url
    Then the response contains "delayed"

  @javascript
  Scenario: Wait for elements to become visible
    When I visit visibility url
    Then the response contains "Can you see me?"

  @javascript
  Scenario: Retry flaky url
    When I visit flaky url
    Then the response contains "you made it"

  Scenario: Sloooow API
    When I visit the hit count incrementer
    Then the hit count increments
