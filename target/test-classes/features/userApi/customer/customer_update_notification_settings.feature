Feature: Update Notification Settings

  Background:
    * url userApiUrl
    * header Content-Type = 'application/json-patch+json'
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken

  Scenario: Update Notification Settings - Success Scenario
    Given path '/Customer/UpdateNotificationSettings'
    And header Authorization = 'Bearer ' + access_token
    * def notificationInfo =
      """
        {
          "deliverySmsAllowed": true,
          "deliveryEmailAllowed": false,
          "deliveryPushAllowed": false,
          "campaignSmsAllowed": false,
          "campaignEmailAllowed": false,
          "campaignPushAllowed": true
        }
      """
    And request notificationInfo
    When method PUT
    Then status 200
    Then print 'update notification settings response --> ', response
    * match response contains { campaignEmailAllowed: '#boolean' }
    * match response contains { deliveryEmailAllowed: '#boolean' }
    * match response contains { campaignPushAllowed: '#boolean' }
    * match response contains { campaignSmsAllowed: '#boolean' }
    * match response contains { deliverySmsAllowed: '#boolean' }
    * match response contains { deliveryPushAllowed: '#boolean' }

    ####################################################################################################################

  Scenario: Update Notification Settings - Without Authentication
    Given path '/Customer/UpdateNotificationSettings'
    * def notificationInfo =
      """
        {
          "deliverySmsAllowed": true,
          "deliveryEmailAllowed": false,
          "deliveryPushAllowed": false,
          "campaignSmsAllowed": false,
          "campaignEmailAllowed": false,
          "campaignPushAllowed": true
        }
      """
    And request notificationInfo
    When method PUT
    Then status 401
    And match response.messages[0] == 'User Authorization Error'
    And assert response.message == 'User Authorization Error'
    And assert response.typeCode == 401
