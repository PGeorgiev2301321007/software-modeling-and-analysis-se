CREATE PROCEDURE GetCustomerDeliveries
    @CustomerID INT
AS
    SELECT d.deliveryId, d.restaurantId, d.courierId, d.status, d.address, d.estDeliveryTime, d.deliveryItems, d.price
    FROM Delivery d
    INNER JOIN Orders o ON o.customerId = @CustomerID AND o.restaurantId = d.restaurantId
    WHERE o.customerId = @CustomerID;


--- процедура даваща справка за поръчките на клиент

-- проверка:
-- EXEC GetCustomerDeliveries @CustomerID = 1;
