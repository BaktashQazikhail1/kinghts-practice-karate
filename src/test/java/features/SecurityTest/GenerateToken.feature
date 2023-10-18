Feature: Generate Token Feature

  Scenario: Generate valid token
    Given url "https://qa.insurance-api.tekschool-students.com"
    Given path "api/accounts/add-primary-account"
    And request

    """ {
  "email": "baktash_qazikhail@yahoo.com",
  "title": "Mr",
  "firstName": "Khan",
  "lastName": "Ahmad",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "Tester",
  "dateOfBirth": "1992-10-18"
  } """
    When method post
    Then status 201
    And print response