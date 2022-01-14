Feature: Customer Get Selected Address

  Background:
    * url userApiUrl
    * header accept = '*/*'


  Scenario: Customer Get Selected Address - Success Scenario
    * def access_token = authInfo.response.accessToken
    * def markSelectedFeature = call read('customer_address_mark_selected.feature@markSelectedAddress')

    Given path '/Customer/Address/GetSelectedAddress'
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'customer get selected address response  --> ', response

    #response value control
    * def getAddressListFeature = call read('customer_address_list.feature@getAddressInfo')

    And match $.streetAddress == getAddressListFeature.response.items[0].streetAddress
    And match $.longitude == getAddressListFeature.response.items[0].longitude
    And match $.latitude == getAddressListFeature.response.items[0].latitude
    And match $.title == getAddressListFeature.response.items[0].title
    And match $.id == markSelectedFeature.markSelectedInfo.id

    #null control
    Then match $.streetAddress != 'null'
    Then match $.latitude != 'null'
    Then match $.longitude != 'null'
    Then match $.title != 'null'
    Then match $.titleType != 'null'
    Then match $.type != 'null'

    #expected value control
    Then match $.streetAddress == '#string'
    Then match $.latitude == '#number'
    Then match $.longitude == '#number'
    Then match $.id == '#string'
    Then match $.title == '#string'
    Then match $.titleType == '#number'
    Then match $.type == '#number'

    ####################################################################################################################

  Scenario: Customer Get Selected Address - Without Authorization
    * def markSelectedFeature = call read('customer_address_mark_selected.feature@markSelectedAddress')

    Given path '/Customer/Address/GetSelectedAddress'
    When method GET
    Then status 401
    Then print 'customer get selected address response  --> ', response
    Then match response.messages[0] == 'User Authorization Error'
    Then assert response.message == 'User Authorization Error'
    Then assert response.typeCode == 401
