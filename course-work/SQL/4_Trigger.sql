CREATE TRIGGER trg_UpdateRestaurantRating
ON Reviews
AFTER INSERT
AS
BEGIN
    UPDATE Restaurant
    SET rating = (
        SELECT ISNULL(AVG(CAST(r.rating AS FLOAT)),0)
        FROM Reviews r
        WHERE r.restaurantId = i.restaurantId
    )
    FROM Restaurant r
    INNER JOIN inserted i ON r.restaurantId = i.restaurantId
END;

-- тригер, който променя средната оценка на ресторант

-- проверка :
-- SELECT restaurantId, name, rating
-- FROM Restaurant
-- WHERE restaurantId = 1;



