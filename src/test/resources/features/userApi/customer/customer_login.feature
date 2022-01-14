Feature: Customer Login

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

  Scenario Outline: Customer Login - Fail Scenarios
    Given path '/Customer/Login'
    And request '{"email": "<email>","password": "<password>"}'
    When method POST
    Then status 401
    Then print response
    And match response.messages[0] == 'UnAuthorized'
    And assert response.message == 'UnAuthorized'
    And assert response.typeCode == 401

    Examples:
      | email                      | password      |
      | busbusraozdmr.80@gmail.com | wrongpassword |
      | wongemail                  | 123Asd123     |
      |                            | 123Asd123     |
      | busbusraozdmr.80@gmail.com |               |
      |                            |               |

    ##########################################################################################################

  Scenario: Customer Login - Success Scenario
    Given path '/Customer/Login'
    * def user =
      """
        {
          "email": "busraozdmr.801@gmail.com",
          "password": "123Asd123"
        }
      """
    And request user
    When method POST
    Then status 200
    Then print response
    And match $.user.email == user.email

    #null control
    Then match $.user.fullName != 'null'
    Then match $.user.customerId != 'null'
    Then match $.user.userId != 'null'
    Then match $.user.phoneAreaCode != 'null'
    Then match $.user.phoneNumber != 'null'
    Then match $.user.externalUserId != 'null'
    Then match $.user.referralCode != 'null'
    Then match $.user.phoneCountryId != 'null'
    Then match $.user.email != 'null'
    Then match $.accessToken != 'null'
    Then match $.refreshToken != 'null'

    #expected value control
    Then match $.accessToken == '#string'
    Then match $.user.userId == '#string'
    Then match $.user.phoneAreaCode == '#string'
    Then match $.user.phoneNumber == '#string'
    Then match $.user.externalUserId == '#string'
    Then match $.user.referralCode == '#string'
    Then match $.user.customerId == '#string'
    Then match $.user.phoneCountryId == '#string'
    Then match $.user.email == '#string'
    Then match $.refreshToken == '#string'
