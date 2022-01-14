Feature: Customer Login With Phone

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def myFeature = call read('customer_register.feature@loginWithPhoneValue')
    * def phoneNumber = myFeature.registerInfo.phoneNumber
    * def phoneCountry = myFeature.registerInfo.phoneCountryId

    * def randomString = Java.type('utils.RandomValue')
    * def randomIntValue = new randomString().createInt(10);

  Scenario: Customer Login With Phone - Success Scenario
    Given path '/Customer/LoginWithPhone'
    * def loginWithPhoneInfo =
    """
        {
           "phoneCountryId": "#(phoneCountry)",
           "phoneNumber": "#(phoneNumber)"
        }
    """
    And request loginWithPhoneInfo
    When method POST
    Then status 203
    Then print 'response login with phone--> ', response
    Then match $.visible == true
    Then match response.messages[0] == 'OtpVerification'
    Then assert response.message == 'OtpVerification'
    Then assert response.typeCode == 203
    Then assert response.type == "otpverification"

    ####################################################################################################################

  Scenario Outline: Customer Login With Phone - Fail Scenarios
    Given path '/Customer/LoginWithPhone'
    * def loginWithPhoneInfo =
    """
        {
           "phoneCountryId": "<phoneCountryId>",
           "phoneNumber": "<phoneNumber>"
        }
    """
    And request loginWithPhoneInfo
    When method POST
    Then status 400
    Then print 'response login with phone--> ', response
    Then match response.message contains '<message>'

    Examples:
      | phoneCountryId  | phoneNumber              | message                                   |
      | 123             | #(phoneNumber)           | Error converting value                    |
      |                 | #(phoneNumber)           | Error converting value                    |
      | #(phoneCountry) | #(randomIntValue)        | This user does not exist. Please Sign up. |
      | #(phoneCountry) | 1234567891asdfgghjj      | This user does not exist. Please Sign up. |
      | #(phoneCountry) | 111111111111111111111111 | be.user.length                            |


