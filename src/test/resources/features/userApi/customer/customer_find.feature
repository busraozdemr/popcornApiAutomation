Feature: Customer Find

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'

    * def customerCreateFeature = call read('customer_create.feature@customerInfo')
    * def userId = customerCreateFeature.response.userId

  Scenario: Customer Find - Success Scenario
    Given path '/Customer/Find?Id=' + userId
    And header Authorization = 'Bearer ' + consoleAuthorization
    When method GET
    Then status 200
    Then print 'customer find response --> ', response
    Then match $.userId == userId
    Then match $.email == customerCreateFeature.response.email
    Then match $.phoneNumber == customerCreateFeature.response.phoneNumber
    Then match $.statusText == customerCreateFeature.response.statusText
    Then match $.firstName == customerCreateFeature.response.firstName

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
    Then match $.customerId == '#string'
    Then match $.password == '#string'

  ######################################################################################################################

  Scenario: Customer Find - Without Authorization
    Given path 'Customer/Find?Id=' + userId
    When method GET
    Then status 401
    Then print 'customer find without authorization response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401
