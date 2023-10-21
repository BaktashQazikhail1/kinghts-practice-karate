Feature: Create Account

  #Story 9)
  #Endpoint: /api/accounts/add-primary-account
  #Send request
  #Validate response is 201
  #And response contain you request. email entity is correct

  Background: Setup test
    Given url "https://qa.insurance-api.tekschool-students.com"
    * def tokenResult = callonce read('GenerateToken.feature')
    * def token = "Bearer " + tokenResult.response.token

    Scenario: Create Valid account
      Given path "/api/accounts/add-primary-account"
      And request
"""
{
  "email": "imran_qazi15311@yahoo.com",
  "firstName": "Baktash",
  "lastName": "Qazikhail",
  "title": "Mr",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "SoftwareEngineer",
  "dateOfBirth": "1992-12-12"
  }
"""
      When method post
      And print response
      Then status 201
      And assert response.email == "imran_qazi15311@yahoo.com"
      * def createdAccountId = response.id
      Given path "/api/accounts/delete-account"
      And param primaryPersonId = createdAccountId
      And header Authorization = token
      When method delete
      Then status 200
      And print response
      And match response contains {"message" : "Account Successfully deleted", "status" : true}

