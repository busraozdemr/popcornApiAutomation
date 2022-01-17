Feature: Employee Create

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def randomString = Java.type('utils.RandomValue')
    * def randomEmailValue = new randomString().createRandomString(7,"email");
    * def randomStringValue = new randomString().createRandomString(7,"string");
    * def randomIntValue = new randomString().createInt(10);

  @employeeInfo
  Scenario: Employee Create - Success Scenario
    Given path '/Employee/Create'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeCreateInfo =
      """
          {
            "title": "#(randomStringValue)",
            "firstName": "#(randomStringValue)",
            "lastName": "#(randomStringValue)",
            "email": "#(randomEmailValue)",
            "roleIds": [
                        "4f1058c6-0985-4139-8302-b50df344c339"
                        ],
            "phoneCountryId": "a82b2d38-c995-4339-b436-43cabf8d3651",
            "phoneNumber": "#(randomIntValue)",
            "address": {}
          }
      """
    And request employeeCreateInfo
    When method POST
    Then status 200
    Then print 'employee create response -->', response
    Then match $.title == employeeCreateInfo.title
    Then match $.phoneNumber == employeeCreateInfo.phoneNumber
    Then match $.email == employeeCreateInfo.email
    Then match $.roleIds[0] == employeeCreateInfo.roleIds[0]
    Then match $.roles[0].id == employeeCreateInfo.roleIds[0]
    Then match $.phoneCountry.id == employeeCreateInfo.phoneCountryId
    Then match $.firstName == employeeCreateInfo.firstName
    Then match $.lastName == employeeCreateInfo.lastName
    Then match $.statusText == "Active"
    Then match $.status == 1

      #expected value control
    Then match $.lastName == '#string'
    Then match $.roles[0].name == '#string'
    Then match $.roles[0].id == '#string'
    Then match $.fullName == '#string'
    Then match $.title == '#string'
    Then match $.fullName == '#string'
    Then match $.userId == '#string'
    Then match $.phoneCountry.name == '#string'
    Then match $.phoneCountry.id == '#string'
    Then match $.firstName == '#string'
    Then match $.phoneNumber == '#string'
    Then match $.statusText == '#string'
    Then match $.email == '#string'
    Then match $.status == '#number'
    Then match $.id == '#string'

      ##################################################################################################################

  Scenario: Employee Create - Without Authorization
    Given path '/Employee/Create'
    * def employeeCreateInfo =
      """
          {
            "title": "#(randomStringValue)",
            "firstName": "#(randomStringValue)",
            "lastName": "#(randomStringValue)",
            "email": "#(randomEmailValue)",
            "roleIds": [
                        "4f1058c6-0985-4139-8302-b50df344c339"
                        ],
            "phoneCountryId": "a82b2d38-c995-4339-b436-43cabf8d3651",
            "phoneNumber": "#(randomIntValue)",
            "address": {}
          }
      """
    And request employeeCreateInfo
    When method POST
    Then status 401
    Then print 'employee create without authorization response -->', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

      ##################################################################################################################

  Scenario Outline: Employee Create - Fail Scenarios
    Given path '/Employee/Create'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeCreateInfo =
      """
          {
            "title": "<title>",
            "firstName": "<firstName>",
            "lastName": "<lastName>",
            "email": "<email>",
            "roleIds": [
                        "<roleIds>"
                        ],
            "phoneCountryId": "<phoneCountryId>",
            "phoneNumber": "<phoneNumber>",
            "address": {}
          }
      """
    And request employeeCreateInfo
    When method POST
    Then status 400
    Then print 'employee create fail response -->', response
    Then match response.message contains '<message>'

    Examples:
      | title                | firstName            | lastName             | email                    | roleIds                              | phoneCountryId                       | phoneNumber       | message                           |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) |                          | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | This email is not valid.          |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)      |                                      | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Error converting value            |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)      | 4f1058c6-0985-4139-8302-b50df344c339 |                                      | #(randomIntValue) | Error converting value            |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)      | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 |                   | be.user.phone.alreadyused  |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | busraozdmr.801@gmail.com | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | This email has already been used. |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)      | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | 5541397611        | be.user.phone.alreadyused         |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)      | 111                                  | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Error converting value            |
      | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue)     | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | This email is not valid.          |
