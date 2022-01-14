Feature: Customer Validate Otp

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def myFeature = call read('customer_register.feature@loginWithPhoneValue')
    * def phoneCountryId = myFeature.registerInfo.phoneCountryId
    * def phoneNumber = myFeature.registerInfo.phoneNumber
    * def email = myFeature.registerInfo.email

  Scenario: Customer Validate Otp - Success Scenario
    Given path '/Customer/ValidateOtp'
    * def validateOtpInfo =
     """
       {
         "phoneCountryId": "#(phoneCountryId)",
         "phoneNumber": "#(phoneNumber)",
         "email": "#(email)",
         "otpCode": "1234"
       }
     """
    And request validateOtpInfo
    When method POST
    Then status 200
    Then print 'customer validate otp response -->', response
    Then match $.user.email == validateOtpInfo.email
    Then match $.user.phoneNumber == validateOtpInfo.phoneNumber
    Then match $.user.phoneCountryId == validateOtpInfo.phoneCountryId
    Then match $.user.fullName == myFeature.registerInfo.fullName

    #null control
    Then match $.user.referralCode != 'null'
    Then match $.user.customerId != 'null'
    Then match $.accessToken != 'null'
    Then match $.user.fullName != 'null'
    Then match $.user.userId != 'null'
    Then match $.user.phoneAreaCode != 'null'
    Then match $.user.phoneNumber != 'null'
    Then match $.user.externalUserId != 'null'
    Then match $.user.referralCode != 'null'
    Then match $.user.customerId != 'null'
    Then match $.user.phoneCountryId != 'null'
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

    ####################################################################################################################

  Scenario Outline: Customer Validate Otp - Fail Scenarios
    Given path '/Customer/ValidateOtp'
    * def validateOtpInfo =
     """
       {
         "phoneCountryId": "<phoneCountryId>",
         "phoneNumber": "<phoneNumber>",
         "email": "<email>",
         "otpCode": "<otpCode>"
       }
     """
    And request validateOtpInfo
    When method POST
    Then status 401
    Then print response
    Then match response.message contains '<message>'

    Examples:
      | phoneCountryId    | phoneNumber    | email    | otpCode | message      |
      | #(phoneCountryId) | #(phoneNumber) | #(email) |         | UnAuthorized |
      | #(phoneCountryId) | #(phoneNumber) | #(email) | wrong   | UnAuthorized |
      | #(phoneCountryId) | wrong          | #(email) | 1234    | UnAuthorized |
      | #(phoneCountryId) |                | #(email) | 1234    | UnAuthorized |
      | #(phoneCountryId) | #(phoneNumber) | #(email) |         | UnAuthorized |

    ####################################################################################################################

  Scenario: Customer Validate Otp - Invalid phoneCountryId
    Given path '/Customer/ValidateOtp'
    * def validateOtpInfo =
     """
       {
         "phoneCountryId": "wrong",
         "phoneNumber": "#(phoneNumber)",
         "email": "#(email)",
         "otpCode": "1234"
       }
     """
    And request validateOtpInfo
    When method POST
    Then status 500
    Then print response
    Then match response.message contains 'Value cannot be null.'

