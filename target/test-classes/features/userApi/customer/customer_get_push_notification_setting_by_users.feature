Feature: Get Push Notification Setting By Users

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * header Content-Type = 'application/json-patch+json'
    * def access_token = authInfo.response.accessToken

  Scenario: Get Push Notification Setting By Users - Success Scenario
    * def userId = authInfo.response.user.userId
    * def externalUserId = authInfo.response.user.externalUserId

    Given path '/Customer/GetPushNotificationSettingsByUsers'
    And header Authorization = 'Bearer ' + access_token
    * def getPushNotificationSettingsByUsersInfo =
      """
          [
            "#(userId)"
          ]
      """
    And request getPushNotificationSettingsByUsersInfo
    When method POST
    Then status 200
    Then print 'push notification setting by user response -->',response
    Then match $[0].userExternalId == externalUserId
    Then match $[0].userId == userId
    Then match $[0].deliveryPushAllowed == '#boolean'

    ####################################################################################################################

  Scenario: Get Push Notification Setting By Users - Wrong UserId
    * def userId = 'wrong'
    Given path '/Customer/GetPushNotificationSettingsByUsers'
    And header Authorization = 'Bearer ' + access_token
    * def getPushNotificationSettingsByUsersInfo =
      """
          [
            "#(userId)"
          ]
      """
    And request getPushNotificationSettingsByUsersInfo
    When method POST
    Then status 500
    Then match response.message contains 'Value cannot be null.'
