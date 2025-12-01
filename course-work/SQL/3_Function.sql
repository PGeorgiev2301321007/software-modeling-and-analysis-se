CREATE FUNCTION GetCustomerTotalSpent(@CustomerID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @total DECIMAL(18,2)

    SELECT @total = ISNULL(SUM(d.price), 0)
    FROM Delivery d
    INNER JOIN Orders o ON d.restaurantId = o.restaurantId
    WHERE o.customerId = @CustomerID

    RETURN @total
END;


--- функция, която връща общата похарчена сума от даден потребител

-- проверка:
-- SELECT dbo.GetCustomerTotalSpent(2) AS TotalSpent;


