Feature: Customer Register

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def randomString = Java.type('utils.RandomValue')
    * def randomEmailValue = new randomString().createRandomString(7,"email");
    * def randomStringValue = new randomString().createRandomString(7,"string");
    * def randomIntValue = new randomString().createInt(10);

  @loginWithPhoneValue
  Scenario: Customer Register - Success Scenario
    Given path '/Customer/Register'
    * def registerInfo =
    """
      {
        "email": "#(randomEmailValue)",
        "password": "123Asd123",
        "phoneCountryId": "81a2f978-226e-46e5-87b1-950e67b7f550",
        "phoneNumber": "#(randomIntValue)",
        "fullName": "#(randomStringValue)"
      }
    """
    And request registerInfo
    When method POST
    Then status 203
    Then print 'Customer Register response --> ', response
    Then match $.visible == true
    Then match response.messages[0] == 'OtpVerification'
    Then assert response.message == 'OtpVerification'
    Then assert response.typeCode == 203
    Then assert response.type == "otpverification"

    ####################################################################################################################

  Scenario Outline: Customer Register - Fail Scenarios
    Given path '/Customer/Register'
    * def registerInfo =
    """
      {
        "email": "<email>",
        "password": "<password>",
        "phoneCountryId": "<phoneCountryId>",
        "phoneNumber": "<phoneNumber>",
        "fullName": "(randomStringValue) (randomStringValue)"
      }
    """
    And request registerInfo
    When method POST
    Then status <statusCode>
    Then print 'response --> ', response
    Then match response.message contains '<message>'

    Examples:
      | email                    | password  | phoneNumber       | statusCode | phoneCountryId                       | message                |
      | #(randomEmailValue)      | 123       | #(randomIntValue) | 400        | 81a2f978-226e-46e5-87b1-950e67b7f550 | be.user.length         |
      | #(randomEmailValue)      |           | #(randomIntValue) | 400        | 81a2f978-226e-46e5-87b1-950e67b7f550 | be.user.required       |
      | #(randomEmailValue)      | 123Asd123 | #(randomIntValue) | 400        |                                      | Error converting value |
      | #(randomEmailValue)      | 123Asd123 | #(randomIntValue) | 400        | wrongdata                            | Error converting value |
      | #(randomStringValue)     | 123Asd123 | #(randomIntValue) | 400        | 81a2f978-226e-46e5-87b1-950e67b7f550 | be.user.email.notvalid |
      | busraozdmr.801@gmail.com | 123Asd123 | #(randomIntValue) | 203        | 81a2f978-226e-46e5-87b1-950e67b7f550 | OtpVerification        |
