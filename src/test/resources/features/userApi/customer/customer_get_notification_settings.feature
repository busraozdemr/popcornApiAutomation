Feature: Get Notification Settings

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken

  @getNotificationSettingsInfo
  Scenario: Get Notification Settings - Success Scenario
    Given path '/Customer/GetNotificationSettings'
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'get notification settings response --> ', response
    * match response contains { campaignEmailAllowed: '#boolean' }
    * match response contains { deliveryEmailAllowed: '#boolean' }
    * match response contains { campaignPushAllowed: '#boolean' }
    * match response contains { campaignSmsAllowed: '#boolean' }
    * match response contains { deliverySmsAllowed: '#boolean' }
    * match response contains { deliveryPushAllowed: '#boolean' }

    ####################################################################################################################

  Scenario: Get Notification Settings - Without Authorization
    Given path 'Customer/GetNotificationSettings'
    When method GET
    Then status 401
    Then print 'response --> ', response
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401
