Feature: Customer Validate Token

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken

    Scenario: Customer Validate Token - Success Scenario
      Given path '/Customer/ValidateToken'
      And header Authorization = 'Bearer ' + access_token
      When method GET
      Then status 200
      Then print 'customer validate token response --> ', response
      Then match $.user.fullName == authInfo.response.user.fullName
      Then match $.user.phoneNumber == authInfo.response.user.phoneNumber
      Then match $.user.referralCode == authInfo.response.user.referralCode
      Then match $.user.customerId == authInfo.response.user.customerId
      Then match $.user.email == authInfo.response.user.email
      Then match $.user.phoneCountryId == authInfo.response.user.phoneCountryId

      Then match $.user.userId == '#string'
      Then match $.user.externalUserId == '#string'
      Then match $.user.email == '#string'
      Then match $.user.phoneCountryId == '#string'
      Then match $.user.customerId == '#string'

      ##################################################################################################################

  Scenario: Customer Validate Token - Without Authorization
    Given path '/Customer/ValidateToken'
    When method GET
    Then status 401
    Then print response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401