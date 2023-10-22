Feature: Create Account with Random Email using java

  Background: Setup test
    Given url "https://qa.insurance-api.tekschool-students.com"

  Scenario: Create Valid account /api/accounts/add-primary-account
    Given path "/api/accounts/add-primary-account"

    * def dataGenerator = Java.type('data.DataGenerator')
    * def autoEmail = dataGenerator.getEmail();
    And request

    """
{
  "email": "#(autoEmail)",
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
    Then assert response.email == autoEmail