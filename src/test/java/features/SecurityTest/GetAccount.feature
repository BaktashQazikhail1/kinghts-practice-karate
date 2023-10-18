Feature: Get Account Feature Testing

  Background: Setup test
  Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Testing endpoint /api/accounts/get-account
    * def tokenResult = callonce read('GenerateToken.feature')
    And print tokenResult
    Given path "/api/accounts/get-account"
    * def expectedId = 33
    Given param primaryPersonId = expectedId
    * def validToken = "Bearer " + tokenResult.response.token
    Given header Authorization = validToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPersonId == expectedId








