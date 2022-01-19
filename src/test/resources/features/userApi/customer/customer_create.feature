Feature: Customer Create

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def randomString = Java.type('utils.RandomValue')
    * def randomStringValue = Java.type('utils.Extension')
    * def randomEmailValue = new randomString().createRandomString(7,"email");
    * def randomStringValue1 = new randomStringValue().randomFirstName();
    * def randomIntValue = new randomString().createInt(10);

  @customerInfo
  Scenario: Customer Create - Success Scenario
    Given path '/Customer/Create'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def customerCreateInfo =
    """
       {
          "fullName": "#(randomStringValue1)",
          "phoneCountryId": "59c4edba-f347-45b3-a5c9-aed7ac852ff8",
          "email": "#(randomEmailValue)",
          "phoneNumber": "#(randomIntValue)"
       }
    """
    And request customerCreateInfo
    When method POST
    Then status 200
    Then print 'customer create response -->',response
    Then match $.status == 1
    Then match $.statusText == "Active"
    Then match $.customerStatus == 0
    Then match $.email == customerCreateInfo.email
    Then match $.fullName == customerCreateInfo.fullName
    Then match $.phoneNumber == customerCreateInfo.phoneNumber
    Then match $.phoneCountry.id == customerCreateInfo.phoneCountryId

    #expected value control
    Then match $.phoneCountry.name == '#string'
    Then match $.phoneCountry.id == '#string'
    Then match $.customerStatus == '#number'
    Then match $.email == '#string'
    Then match $.id == '#string'
    Then match $.fullName == '#string'
    Then match $.userId == '#string'
    Then match $.firstName == '#string'
    Then match $.phoneNumber == '#string'
    Then match $.statusText == '#string'
    Then match $.status == '#number'

    #null control
    * match response.referralCode == '#null'
    Then match $.customerId == '#null'
    Then match $.riderId == '#null'
    Then match $.password == '#null'
    Then match $.nationalSecurityNumber == '#null'
    Then match $.employeeId == '#null'
    Then match $.roleIds == '#null'
    Then match $.orders == '#null'

    ####################################################################################################################

  Scenario: Customer Create - Without Authorization
    Given path '/Customer/Create'
    * def customerCreateInfo =
    """
       {
          "fullName": "#(randomStringValue)",
          "phoneCountryId": "59c4edba-f347-45b3-a5c9-aed7ac852ff8",
          "email": "#(randomEmailValue)",
          "phoneNumber": "#(randomIntValue)"
       }
    """
    And request customerCreateInfo
    When method POST
    Then status 401
    Then print 'customer create without authorization response -->',response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario Outline: Customer Create - Fail Scenarios
    Given path '/Customer/Create'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def customerCreateInfo =
    """
       {
          "fullName": "<fullName>",
          "phoneCountryId": "<phoneCountryId>",
          "email": "<email>",
          "phoneNumber": "<phoneNumber>"
       }
    """
    And request customerCreateInfo
    When method POST
    Then status 400
    Then print 'customer create with wrong data response -->',response
    Then match response.message contains '<message>'

    Examples:
      | fullName             | phoneCountryId                       | email               | phoneNumber       | message                |
      | #(randomStringValue) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 |                     | #(randomIntValue) | Email.NotValid         |
      | #(randomStringValue) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | #(randomEmailValue) |                   | Phone.AlreadyUsed      |
      | #(randomStringValue) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | #(randomEmailValue) | wrongwrong        | Phone.AlreadyUsed      |
      | #(randomStringValue) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | abc                 | #(randomIntValue) | Email.NotValid         |
      | #(randomStringValue) |                                      | #(randomEmailValue) | #(randomIntValue) | Error converting value |
      | #(randomStringValue) | wrong                                | #(randomEmailValue) | #(randomIntValue) | Error converting value |
