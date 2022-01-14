Feature: Address Type List

  Background:
    * url userApiUrl
    * header accept = '*/*'

    Scenario: Address Type List - Success Scenario
      Given path '/Common/AddressTypeList'
      When method GET
      Then status 200
      Then print 'response --> ', response

      Then match $[0].isDefault == true
      Then match $[0].name == "be.user.enums.addresstype.unknown"
      Then match $[0].displayOrder == 0
      Then match $[0].id == 0
      Then match $[0].enumName == "Unknown"

      Then match $[1].isDefault == false
      Then match $[1].name == "be.user.enums.addresstype.delivery"
      Then match $[1].displayOrder == 0
      Then match $[1].id == 1
      Then match $[1].enumName == "Delivery"

      Then match $[2].isDefault == false
      Then match $[2].name == "be.user.enums.addresstype.residence"
      Then match $[2].displayOrder == 0
      Then match $[2].id == 2
      Then match $[2].enumName == "Residence"

      #type control in array
      Then match response[*].isDefault contains ["#boolean"]
      Then match response[*].name contains ["#string"]
      Then match response[*].enumName contains [#string]
      Then match response[*].id contains [#number]