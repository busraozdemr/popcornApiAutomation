Feature: Employee Validate Token

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def employeeLoginFeature = call read('employee_login.feature@employeeLoginInfo')
    * def userId = employeeLoginFeature.response.user.userId
    * def phoneNumber = employeeLoginFeature.response.user.phoneNumber
    * def externalUserId = employeeLoginFeature.response.user.externalUserId

  Scenario: Employee Validate Token - Success Scenario
    Given path '/Employee/ValidateToken'
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'employee validate token response --> ', response
    Then match $.userId == userId
    Then match $.phoneNumber == phoneNumber
    Then match $.externalUserId == externalUserId
    Then match $.email == employeeLoginFeature.employeeLoginInfo.email

      #null control
    Then match $.permissions[*].routePath != 'null'
    Then match $.permissions[*].controllerName != 'null'
    Then match $.permissions[*].name != 'null'
    Then match $.permissions[*].id != 'null'
    Then match $.permissions[*].key != 'null'
    Then match $.permissions[*].actionName != 'null'

      #type control in array
    Then match $.permissions[*].controllerName contains ["#string"]
    Then match $.permissions[*].name contains ["#string"]
    Then match $.permissions[*].id contains ["#string"]
    Then match $.permissions[*].key contains ["#string"]
    Then match $.permissions[*].actionName contains ["#string"]
    Then match $.phoneCountryId == "#string"
    Then match $.email == "#string"

      ##################################################################################################################

  Scenario: Employee Validate Token - Without Authorization
    Given path '/Employee/ValidateToken'
    When method GET
    Then status 401
    Then print 'employee validate token without authorization response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

