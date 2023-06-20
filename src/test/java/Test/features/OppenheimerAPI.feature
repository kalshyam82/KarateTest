Feature: Oppenheimer Project API Scripts


  Background:
  * url 'http://localhost:8080'
    # http://localhost:8080/
  # Given path '/user?page=2'

#  Scenario: get all users and then get the first user by id
#    Given path 'users'
#    When method get
#    Then status 200
#
#    * def first = response[0]
#
#    Given path 'users', first.id
#    When method get
#    Then status 200

  Scenario: AC1 Verify Single record of Working class Hero is inserted to DB using API
    * def insertSingleRecord =
      """
              {
          "birthday": "01012000",
          "gender": "m",
          "name": "new",
          "natid": "111-$$$$$$$",
          "salary": "1000",
          "tax": "100"
        }
      """

    Given path 'calculator/insert'
    And request insertSingleRecord
    When method post
    Then print response
    Then status 202

  Scenario: AC2 Verify Multiple record of Working class Heroes is inserted to DB using API
    * def insertMultipleRecord =
      """
           [   {
          "birthday": "01012000",
          "gender": "m",
          "name": "new",
          "natid": "112-$$$$$$$",
          "salary": "1000",
          "tax": "100"
        },
        {
          "birthday": "01012000",
          "gender": "m",
          "name": "newe",
          "natid": "124-$$$$$$$",
          "salary": "1000",
          "tax": "100"
        }
        ]
      """

    Given path 'calculator/insertMultiple'
    And request insertMultipleRecord
    When method post
    Then print response
    Then status 202


  Scenario: AC3 Verify CSV File which contains record of Working class Heroes can be uploaded to the UI using API

    * def temp = karate.readAsString('classpath:Book2.csv')
    Given path 'calculator/uploadLargeFileForInsertionToDatabase'
    And multipart file file =  { value: '#(temp)', filename: 'Book2.csv', contentType: 'text/csv' }
    When method post
    Then print response
    Then status 200


  Scenario: AC4 As the Bookkeeper, I should be able to query the amount of tax
  relief for each person in the database so that I can report the
  figures to my Bookkeeping Manager

    * def expTaxRelief = read('classpath:jSonFiles/expTaxRelief.json')
    Given path 'calculator/taxRelief'
    When method get
    Then print response
    Then status 200
    Then print expTaxRelief
    Then match $ contains expTaxRelief


  Scenario: taxReliefSummary

    * def expTaxReliefSummary = read('classpath:jSonFiles/expTaxReliefSummary.json')
    Given path 'calculator/taxReliefSummary'
    When method get
    Then print response
    Then status 200
    Then match $ contains expTaxReliefSummary



  Scenario: Cash Dispense

  Given path 'dispense'
    When method get
    Then print response
    Then status 200
    Then match $ contains 'Cash dispensed'


#  Scenario: Rake Database
#
#
#    Given path 'calculator/rakeDatabase'
#    And request ''
#    When method post
#    Then print response
#    Then match $ contains 'Successfully raked DB'
#    Then status 200