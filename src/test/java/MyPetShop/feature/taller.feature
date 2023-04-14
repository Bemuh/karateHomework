Feature: mystoreapi.com homework

  Background: random values and "global" variables
    Given url URL

      # Data generators
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def quantity = dataGenerator.getRandomQuantity()

    * def product = dataGenerator.getRandomProduct()
    * def price = dataGenerator.getRandomValue()
    * def manufacturer = dataGenerator.getRandomManufacturer()
    * def category = dataGenerator.getRandomCategory()
    * def description = dataGenerator.getRandomDescription()
    * def tag = dataGenerator.getRandomTags()

  Scenario: Main

    # 1. Create a new order:
    * def newOrder = call read('classpath:helpers/newOrder.feature')
    * def orderId = newOrder.orderId
    * def customer = newOrder.customer

    # 2. Create a new product
    * def product = call read('classpath:helpers/newProduct.feature')
    * def productId = product.productId
    * def productName = product.productName
    * def productPrice = product.productPrice

    # 3. Verify the order previously created:
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match orderResponse.order.customer == customer
    * match getOrder.getStatus == 200

    # 4. Add the product to the order
    * def addProduct = call read('classpath:helpers/addProduct.feature')

    # 5. Verify the previously created order and its added product:
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 200
    * match orderResponse.order.customer == customer
    * match orderResponse.items[0].name == productName
    * def totalCost = quantity * productPrice
    * match orderResponse.summary.totalCost == totalCost

    # 6. Remove the product from the order
    * def deleteOrder = call read('classpath:helpers/deleteProduct.feature')

    # 7. Verify that there are no products in the order
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 200
    * match orderResponse.order.customer == customer
    * match orderResponse.items == '#[0]'

    # 8. Delete the order and verify the status message
    * def deleteOrder = call read('classpath:helpers/deleteOrder.feature')
    * def deleteResponse = deleteOrder.deleteResponse

    * match deleteResponse.status == 'deleted'

    # 9. Verify the server response status and the response message
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 404
    * def message = 'Order with id ' + orderId + ' not found'
    * match orderResponse == {"statusCode":404,"message": "#(message)"}

  Scenario Outline: <caso> <campo> <nombre>

    Given path '/catalog/product'
    And request
    """
    {
      "name": <name>,
      "price": <price>,
      "manufacturer": "#(manufacturer)",
      "category": "#(category)",
      "description": "#(description)",
      "tags": "#(tag)"
    }
    """
    When method POST
    And match response == <response>

    Examples:
    |caso|campo |nombre |name         |price       |response                                                                                                                                                                    |
    |01  |name  |vacio  |null         |#(price)    |{"statusCode":500,"message":"Internal server error"}                                                                                                                        |
    |02  |price |null   |"#(product)" |"string"        |{"id":'#number',"name":'#string',"description":'#string',"manufacturer":'#string',"category":'#string',"price":0,"created":'#string',"status":'#string',"tags":'#string'}|