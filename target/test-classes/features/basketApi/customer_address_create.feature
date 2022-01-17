Feature: Customer Address Create

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken
    * def customerId = authInfo.response.user.customerId

  @getAddressId
  Scenario: Customer Address Create - Success Scenario
    Given path '/Customer/Address/Create'
    And header Authorization = 'Bearer ' + access_token
    * def adressInfo =
      """
        {
          "id": "#(customerId)",
          "title": "string",
          "additionalInfo": "string",
          "streetAddress": "280 Mornigside Dr, San Francisco",
          "type": 0,
          "titleType": 10,
          "longitude": -122.4936448,
          "latitude":37.7296159
        }
      """
    And request adressInfo
    When method POST
    Then status 200
    Then print response

    #match control
    Then match $.titleType == adressInfo.titleType
    Then match $.title == adressInfo.title
    Then match $.streetAddress == adressInfo.streetAddress
    Then match $.id == adressInfo.id
    Then match $.latitude == adressInfo.latitude
    Then match $.longitude == adressInfo.longitude
    * match response.streetAddress contains "San Francisco"

    #expected value control
    Then match $.titleType == '#number'
    Then match $.streetAddress == '#string'
    Then match $.latitude == '#number'
    Then match $.title == '#string'
    Then match $.id == '#string'
    Then match $.type == '#number'
    Then match response.longitude contains '#number'

    ####################################################################################################################

  Scenario Outline: Customer Address Create - Fail Scenarios
    Given path '/Customer/Address/Create'
    And header Authorization = 'Bearer ' + access_token
    * def adressInfo =
      """
        {
          "id": "<id>",
          "title": "<title>",
          "additionalInfo": "string",
          "streetAddress": "<streetAddress>",
          "type": 0,
          "titleType": 10,
          "longitude": <longitude>,
          "latitude":<latitude>
        }
      """
    And request adressInfo
    When method post
    Then status 400
    Then print response
    Then match response.message contains '<message>'

    Examples:
      | id            | title  | streetAddress                    | longitude    | latitude   | message                               |
      | 123           | string | 280 Mornigside Dr, San Francisco | -122.4936448 | 37.7296159 | Error converting value                |
      | #(customerId) | string | 280 Mornigside Dr, San Francisco | 0            | 37.7296159 | Outside of service area!              |
      | #(customerId) | string | 280 Mornigside Dr, San Francisco | -122.4936448 | 0          | Outside of service area!              |
      | #(customerId) | string | abc                              | -122.4936448 | 37.7296159 | be.user.length                        |
      | #(customerId) | string | 280 Mornigside Dr, San Francisco | -122.4936448 | a          | Could not convert string to double    |
      | #(customerId) | string | 280 Mornigside Dr, San Francisco | a            | 37.7296159 | Could not convert string to double    |
      |               | string | 280 Mornigside Dr, San Francisco | -122.4936448 | 37.7296159 | Error converting value                |
      | #(customerId) | string | 280 Mornigside Dr, San Francisco |              | 37.7296159 | Error converting value {null} to type |
      | #(customerId) | string |                                  | -122.4936448 | 37.7296159 | be.user.required                      |
