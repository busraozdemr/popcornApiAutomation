Feature: Customer Address Mark Selected

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'
    * def customerAddressListFeature = call read('customer_address_list.feature@getAddressInfo')
    * def addressId = customerAddressListFeature.response.items[0].id

  @markSelectedAddress
  Scenario: Customer Address Mark Selected - Success Scenario
    * def access_token = authInfo.response.accessToken

    Given path 'Customer/Address/MarkSelected'
    And header Authorization = 'Bearer ' + access_token
    * def markSelectedInfo =
    """
        {
          "id": "#(addressId)"
        }
    """
    And request markSelectedInfo
    When method PUT
    Then status 200
    And assert response == "true"

    ###################################################################################################################

  Scenario: Customer Address Mark Selected - Wrong Authentication
    Given path 'Customer/Address/MarkSelected'
    * def markSelectedInfo =
    """
        {
          "id": "#(addressId)"
        }
    """
    And request markSelectedInfo
    When method PUT
    Then status 401
    Then print 'response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401