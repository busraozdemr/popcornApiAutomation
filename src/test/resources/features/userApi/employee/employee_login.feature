Feature: Employee Login

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

  Scenario: Employee Login - Success Scenario
    Given path '/Employee/Login'
    * def employeeLoginInfo =
      """
          {
            "email": "busra@popcornvan.com",
            "password": "LE0J628V"
          }
      """
    And request employeeLoginInfo
    When method POST
    Then status 200
    Then print 'employee login response -->', response
    Then match $.user.email == employeeLoginInfo.email

    #null control
    Then match $.accessToken != 'null'
    Then match $.user.fullName != 'null'
    Then match $.user.employeeId != 'null'
    Then match $.user.userId != 'null'
    Then match $.user.phoneNumber != 'null'
    Then match $.user.externalUserId != 'null'
    Then match $.user.externalUserId != 'null'
    Then match $.user.phoneCountryId != 'null'
    Then match $.user.email != 'null'
    Then match $.refreshToken != 'null'
    Then match $.user.permissions[*].actionName != 'null'

    #expected value control
    Then match $.accessToken == '#string'
    Then match $.user.roles[0].name == '#string'
    Then match $.user.roles[0].id == '#string'
    Then match $.user.fullName == '#string'
    Then match $.user.employeeId == '#string'
    Then match $.user.userId == '#string'
    Then match $.user.phoneNumber == '#string'
    Then match $.user.externalUserId == '#string'
    Then match $.user.permissions[*].actionName contains ["#string"]
    Then match $.user.email == '#string'
    Then match $.refreshToken == '#string'

    ####################################################################################################################

  Scenario Outline: Employee Login - Fail Scenarios
    Given path '/Employee/Login'
    * def employeeLoginInfo =
      """
          {
            "email": "<email>",
            "password": "<password>"
          }
      """
    And request employeeLoginInfo
    When method POST
    Then status 401
    Then print 'employee login with wrong scenario response -->', response
    Then match response.message contains '<message>'

    Examples:
      | email                | password | message      |
      | busra@popcornvan.com | wrong    | UnAuthorized |
      | wrong                | LE0J628V | UnAuthorized |
      |                      | LE0J628V | UnAuthorized |
      | busra@popcornvan.com |          | UnAuthorized |
      |                      |          | UnAuthorized |
      | wrong                | wrong    | UnAuthorized |
