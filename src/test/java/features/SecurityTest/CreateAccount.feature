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

    Scenario: Create Valid account /api/accounts/add-primary-account
      Given path "/api/accounts/add-primary-account"
      And request
"""
{
  "email": "imran_qazi1531112@yahoo.com",
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
      And assert response.email == "imran_qazi1531112@yahoo.com"
      * def createdAccountId = response.id
      Given path "/api/accounts/delete-account"
      And param primaryPersonId = createdAccountId
      And header Authorization = token
      When method delete
      Then status 200
      And print response
      And match response contains {"message" : "Account Successfully deleted", "status" : true}

      Scenario: Create account with existing email /api/accounts/add-primary-account validate response
        Given path "/api/accounts/add-primary-account"
        * def email = "imran_qazi1531111@yahoo.com"
        And request

        """
   {
  "email": "#(email)",
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
        Then print response
        Then status 201
        * def createdAccountId = response.id
        Given path "/api/accounts/add-primary-account"
        And request

        """
   {
  "email": "#(email)",
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
        Then print response
        Then status 400
        And assert response.errorMessage == "Account with email " + email + " is exist"
        Given path "/api/accounts/delete-account"
        And param primaryPersonId = createdAccountId
        And header Authorization = token
        When method delete
        Then status 200
        And print response
        And match response contains {"message" : "Account Successfully deleted", "status" : true}
