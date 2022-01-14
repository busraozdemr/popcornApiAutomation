Feature: Customer Address List

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken
    * def customerId = authInfo.response.user.customerId
    * def customerAddressCreateFeature = call read('customer_address_create.feature@getAddressId')

  @getAddressInfo
  Scenario: Customer Address List - Success Scenario
    Given path '/Customer/Address/List?Id=' + customerId
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'Customer Address List Response --> ', response
    Then match $.items[1].id == customerId

    #null control
    Then match $.items[0].titleType != 'null'
    Then match $.items[0].streetAddress != 'null'
    Then match $.items[0].latitude != 'null'
    Then match $.items[0].id != 'null'
    Then match $.items[0].title != 'null'
    Then match $.items[0].longitude != 'null'
    Then match $.items[0].type != 'null'

    #expected value control
    Then match $.items[0].titleType == '#number'
    Then match $.items[0].streetAddress == '#string'
    Then match $.items[0].latitude == '#number'
    Then match $.items[0].title == '#string'
    Then match $.items[0].id == '#string'

    ####################################################################################################################

  Scenario: Customer Address List - Without Authorization
    Given path '/Customer/Address/List?Id=' + customerId
    When method GET
    Then status 401
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

    ####################################################################################################################

  Scenario: Customer Address List - Without Customer Id
    Given path '/Customer/Address/List'
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'response --> ', response

    #null control
    Then match $.items[*].id != 'null'
    Then match $.items[*].streetAddress != 'null'
    Then match $.items[*].latitude != 'null'
    Then match $.items[*].longitude != 'null'
    Then match $.items[*].titleType != 'null'
    Then match $.items[*].additionalInfo != 'null'
    Then match $.items[*].title != 'null'

    #type control in array
    Then match response.items[*].id contains ["#string"]
    Then match response.items[*].streetAddress contains ["#string"]
    Then match response.items[*].latitude contains [#number]
    Then match response.items[*].longitude contains [#number]
    Then match response.items[*].title contains ["#string"]
    Then match response.items[*].titleType contains [#number]

