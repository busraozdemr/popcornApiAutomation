Feature: Employee Login With Phone

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def employeeLoginFeature = call read('employee_login.feature@employeeLoginInfo')
    * def phoneCountryId = employeeLoginFeature.response.user.phoneCountryId
    * def phoneNumber = employeeLoginFeature.response.user.phoneNumber

    * def randomString = Java.type('utils.RandomValue')
    * def randomIntValue = new randomString().createInt(10);

  Scenario: Employee Login With Phone - Success Scenario
    Given path '/Employee/LoginWithPhone'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeLoginWithPhoneInfo =
      """
         {
           "phoneCountryId": "#(phoneCountryId)",
           "phoneNumber": "#(phoneNumber)"
         }
      """
    And request employeeLoginWithPhoneInfo
    When method POST
    Then status 203
    Then print 'employee login with phone response -->', response
    Then match $.visible == true
    Then match response.messages[0] == 'OtpVerification'
    Then assert response.message == 'OtpVerification'
    Then assert response.typeCode == 203
    Then assert response.type == "otpverification"

    ####################################################################################################################

  Scenario Outline: Employee Login With Phone - Fail Scenarios
    Given path '/Employee/LoginWithPhone'
    * def employeeLoginWithPhoneInfo =
    """
        {
           "phoneCountryId": "<phoneCountryId>",
           "phoneNumber": "<phoneNumber>"
        }
    """
    And request employeeLoginWithPhoneInfo
    When method POST
    Then status <statusCode>
    Then print 'response employee login with phone--> ', response
    Then match response.message contains '<message>'

    Examples:
      | phoneCountryId    | phoneNumber              | statusCode | message               |
      | 123               | #(phoneNumber)           | 500        | Value cannot be null. |
      |                   | #(phoneNumber)           | 500        | Value cannot be null. |
      | #(phoneCountryId) | #(randomIntValue)        | 401        | UnAuthorized          |
      | #(phoneCountryId) | 1234567891asdfgghjj      | 401        | UnAuthorized          |
      | #(phoneCountryId) | 111111111111111111111111 | 401        | UnAuthorized          |