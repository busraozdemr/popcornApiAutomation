Feature: Get Push Notification Setting By User

  Background:
    * url userApiUrl
    * header accept = '*/*'
    * def access_token = authInfo.response.accessToken

  Scenario: Get Push Notification Setting By User - Success Scenario
    * def userId = authInfo.response.user.userId
    * def externalUserId = authInfo.response.user.externalUserId

    Given path 'Customer/GetPushNotificationSettingByUser?Id=' + userId
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 200
    Then print 'push notification setting by user response -->',response
    * match response contains { deliveryPushAllowed: '#boolean' }
    And match $.userExternalId == externalUserId

    ####################################################################################################################

  Scenario: Get Push Notification Setting By User - Wrong UserId
    * def userId = 'wrong'
    Given path 'Customer/GetPushNotificationSettingByUser?Id=' + userId
    And header Authorization = 'Bearer ' + access_token
    When method GET
    Then status 204
    Then print 'push notification setting by user with wrong user id response -->',response
