Feature: Customer Get Address For Order

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken

  Scenario: Customer Get Address For Order -  Success Scenario with CustomerId
    * def customerId = authInfo.response.user.customerId
    * def customerAddressCreateFeature = call read('customer_address_create.feature@getAddressId')

    Given path '/Customer/Address/GetAddressForOrder?Id=' + customerId
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'Customer Get Address For Order Response -->',response

    #null control
    Then match $.country.name != 'null'
    Then match $.country.id != 'null'
    Then match $.stateId != 'null'
    Then match $.latitude != 'null'
    Then match $.countryId != 'null'
    Then match $.county.name != 'null'
    Then match $.county.id != 'null'
    Then match $.countyId != 'null'
    Then match $.streetAddress != 'null'
    Then match $.state.name != 'null'
    Then match $.state.id != 'null'

    #expected value control
    Then match $.titleType == '#number'
    Then match $.country.name == '#string'
    Then match $.country.id == '#string'
    Then match $.stateId == '#string'
    Then match $.latitude == '#number'
    Then match $.county.name == '#string'
    Then match $.county.id == '#string'
    Then match $.countryId == '#string'
    Then match $.streetAddress == '#string'
    Then match $.countyId == '#string'
    Then match $.state.name == '#string'
    Then match $.state.id == '#string'

    ####################################################################################################################

  Scenario: Customer Get Address For Order -  Success Scenario without CustomerId
    Given path '/Customer/Address/GetAddressForOrder'
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 204
    * def cacheStatus = responseHeaders['CF-Cache-Status'][0]
    And match cacheStatus == 'DYNAMIC'
    Then print 'cacheStatus -->',cacheStatus

    ####################################################################################################################

  Scenario: Customer Get Address For Order -  Without Authorization
    * def customerId = authInfo.response.user.customerId
    * def myFeature = call read('customer_address_create.feature@getAddressId')

    Given path '/Customer/Address/GetAddressForOrder?Id=' + customerId
    When method GET
    Then status 401
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401

