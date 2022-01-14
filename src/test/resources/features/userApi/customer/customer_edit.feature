Feature: Customer Edit

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def randomString = Java.type('utils.RandomValue')
    * def randomEmailValue = new randomString().createRandomString(7,"email");
    * def randomStringValue = new randomString().createRandomString(7,"string");
    * def randomIntValue = new randomString().createInt(10);

    * def customerCreateFeature = call read('customer_create.feature@customerInfo')
    * def id = customerCreateFeature.response.id


  Scenario: Customer Edit - Success Scenario
    Given path '/Customer/Edit'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def customerEditInfo =
    """
       {
          "id": "#(id)",
          "fullName": "tes123 deneme1234",
          "phoneCountryId": "59c4edba-f347-45b3-a5c9-aed7ac852ff8",
          "email": "#(randomEmailValue)",
          "phoneNumber": "#(randomIntValue)"
       }
    """
    And request customerEditInfo
    When method PUT
    Then status 200
    Then print 'customer edit response -->',response
    Then match $.email == customerEditInfo.email
    Then match $.fullName == customerEditInfo.fullName
    Then match $.phoneNumber == customerEditInfo.phoneNumber
    Then match $.phoneCountry.id == customerEditInfo.phoneCountryId

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

  Scenario: Customer Edit - Without Authorization
    Given path '/Customer/Edit'
    * def customerEditInfo =
    """
       {
          "id": "#(id)",
          "fullName": "tes123 deneme1234",
          "phoneCountryId": "59c4edba-f347-45b3-a5c9-aed7ac852ff8",
          "email": "#(randomEmailValue)",
          "phoneNumber": "#(randomIntValue)"
       }
    """
    And request customerEditInfo
    When method PUT
    Then status 401
    Then print 'customer edit without authorization response -->',response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario Outline: Customer Edit - Fail Scenarios
    Given path '/Customer/Edit'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def customerEditInfo =
    """
       {
          "id": "<id>",
          "fullName": "tes123 test123",
          "phoneCountryId": "<phoneCountryId>",
          "email": "<email>",
          "phoneNumber": "<phoneNumber>"
       }
    """
    And request customerEditInfo
    When method PUT
    Then status 400
    Then print 'customer edit fail scenario response -->',response
    Then match response.message contains '<message>'

    Examples:
      | id    | phoneCountryId                       | email               | phoneNumber       | message                |
      |       | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | #(randomEmailValue) | #(randomIntValue) | Error converting value |
      | #(id) |                                      | #(randomEmailValue) | #(randomIntValue) | Error converting value |
      | #(id) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 |                     | #(randomIntValue) | Email.NotValid         |
      | #(id) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | #(randomEmailValue) |                   | Required               |
      | wrong | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | #(randomEmailValue) | #(randomIntValue) | Error converting value |
      | #(id) | 59c4edba-f347-45b3-a5c9-aed7ac852ff8 | wrong               | #(randomIntValue) | Email.NotValid         |
      | #(id) | wrong                                | #(randomEmailValue) | #(randomIntValue) | Error converting value |
