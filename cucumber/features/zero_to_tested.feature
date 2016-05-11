Feature: Zero To Tested App

  Scenario: Status is healthy
    When I visit status url
    Then the response contains "OK"

  @javascript
  Scenario: Ajaxy content can be found
    When I visit ajaxy url
    Then the response contains "delayed"

    @javascript
  Scenario: Retry flaky url
    When I visit flaky url
    Then the response contains "you made it"
