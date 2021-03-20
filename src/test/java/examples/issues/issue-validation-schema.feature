Feature: Validar issue con json schema

  Background:
    * url urlApp
    * def token = authToken
    * configure headers = read('classpath:headers.js')

  Scenario: Obtener un issue por su id y validar su json schema
    * def idIssue =  3488
    Given path 'issues', idIssue + '.json'
    When method get
    Then status 200
    And match response.issue ==
    """
    {
      id: '#number',
      project: '#ignore',
      tracker: '#ignore',
      status: {
        id: '#number? _ >= 0',
        name: '#string',
      },
      priority: '#ignore',
      author: '#ignore',
      subject: '#string',
      description: '#string',
      start_date: '#string',
      due_date: '## #string',
      done_ratio: '#notnull',
      is_private: '#boolean',
      estimated_hours: '#ignore',
      total_estimated_hours: '#ignore',
      spent_hours: '#ignore',
      total_spent_hours: '#number? _ == 0',
      created_on: '#ignore',
      updated_on: '#ignore',
      closed_on: '##'
      }
    """

  Scenario: Obtener un issue por id y validar su json schema con SchemaUtils
    * def idIssue =  3488
    * string schema = read('classpath:examples/issues/issue_schema.json')
    * def SchemaUtils = Java.type('com.company.utils.SchemaUtils')

    Given path 'issues', idIssue + '.json'
    When method get
    Then status 200
    And assert SchemaUtils.isValid(response, schema)