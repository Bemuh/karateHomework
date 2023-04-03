Feature: taller de mystoreapi.com

  Background: valores aleatorios y de entorno
    Given url URL

    # Crear orden
    * def newOrder = callonce read('classpath:helpers/newOrder.feature')
    * def orderId = newOrder.orderId
    * def customer = newOrder.customer

    # Crear producto
    * def product = callonce read('classpath:helpers/newProduct.feature')
    * def productId = product.productId
    * def productName = product.productName
    * def productPrice = product.productPrice

    # Variables aleatorias
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def quantity = dataGenerator.getRandomQuantity()

  Scenario:
    # 3. Verificar la orden
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match orderResponse.order.customer == customer
    * match getOrder.getStatus == 200

    # 4. Añadir el producto a la orden
    * def addProduct = call read('classpath:helpers/addProduct.feature'){"productId": "#(productId)", "amount": #(quantity)}

    # 5. Verificar la adición del producto a la orden
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 200
    * match orderResponse.order.customer == customer
    * match orderResponse.items[0].name == productName
    * def totalCost = quantity * productPrice
    * match orderResponse.summary.totalCost == totalCost

    # 6. Eliminar el producto de la orden
#    Given path order + '/' + orderId + '/product/' + productId
#    When method DELETE
#    Then status 200
    * def deleteOrder = call read('classpath:helpers/deleteProduct.feature')

    # 7. Corroborar que no hayan productos en la orden
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 200
    * match orderResponse.order.customer == customer
    * match orderResponse.items == '#[0]'

    # 8. Eliminar la orden y corroborar el mensaje de estado
    * def deleteOrder = call read('classpath:helpers/deleteOrder.feature')
    * def deleteResponse = deleteOrder.deleteResponse
#    Given path order + '/' + orderId
#    When method DELETE
#    Then status 200

    * match deleteResponse.status == 'deleted'

    # 9. Corroborar el estado de la respuesta y el mensaje
    * def getOrder = call read('classpath:helpers/getOrder.feature')
    * def orderResponse = getOrder.orderResponse

    * match getOrder.getStatus == 404
    * def message = 'Order with id ' + orderId + ' not found'
    * print message
    * match orderResponse == {"statusCode":404,"message": "#(message)"}