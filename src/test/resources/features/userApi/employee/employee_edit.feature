Feature: Employee Edit

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def randomString = Java.type('utils.RandomValue')
    * def randomEmailValue = new randomString().createRandomString(7,"email");
    * def randomStringValue = new randomString().createRandomString(7,"string");
    * def randomIntValue = new randomString().createInt(10);

    * def employeeCreateFeature = call read('employee_create.feature@employeeInfo')
    * def id = employeeCreateFeature.response.id

  Scenario: Employee Edit - Success Scenario
    Given path '/Employee/Edit'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeEditInfo =
      """
          {
              "id":"#(id)",
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
    And request employeeEditInfo
    When method PUT
    Then status 200
    Then print 'employee edit response -->', response
    Then match $.id == employeeEditInfo.id
    Then match $.title == employeeEditInfo.title
    Then match $.phoneNumber == employeeEditInfo.phoneNumber
    Then match $.email == employeeEditInfo.email
    Then match $.roleIds[0] == employeeEditInfo.roleIds[0]
    Then match $.roles[0].id == employeeEditInfo.roleIds[0]
    Then match $.phoneCountry.id == employeeEditInfo.phoneCountryId
    Then match $.firstName == employeeEditInfo.firstName
    Then match $.lastName == employeeEditInfo.lastName
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

    ####################################################################################################################

  Scenario: Employee Edit - Without Authorization
    Given path '/Employee/Edit'
    * def employeeEditInfo =
      """
          {
              "id":"#(id)",
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
    And request employeeEditInfo
    When method PUT
    Then status 401
    Then print 'employee edit without authorization response -->', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario Outline: Employee Edit - Fail Scenarios
    Given path '/Employee/Edit'
    And header Authorization = 'Bearer ' + consoleAuthorization
    * def employeeEditInfo =
      """
          {
              "id":"<id>",
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
    And request employeeEditInfo
    When method PUT
    Then status 400
    Then print 'employee edit fail scenario response -->', response
    Then match response.message contains '<message>'

    Examples:
      | id    | title                | firstName            | lastName             | email                | roleIds                              | phoneCountryId                       | phoneNumber       | message                |
      | #(id) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) |                      | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Email.NotValid         |
      | #(id) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)  |                                      | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Error converting value |
      | #(id) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)  | 4f1058c6-0985-4139-8302-b50df344c339 |                                      | #(randomIntValue) | Error converting value |
      | #(id) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)  | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 |                   | Required               |
      |       | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)  | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Error converting value |
      | wrong | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomEmailValue)  | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Error converting value |
      | #(id) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | #(randomStringValue) | 4f1058c6-0985-4139-8302-b50df344c339 | a82b2d38-c995-4339-b436-43cabf8d3651 | #(randomIntValue) | Email.NotValid         |
