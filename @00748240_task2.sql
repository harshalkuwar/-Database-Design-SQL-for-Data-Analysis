
---Part 1

CREATE DATABASE FoodserviceDB;
USE FoodserviceDB;

-- View Restaurants Table
SELECT * FROM Restaurants;

-- View Consumers Table
SELECT * FROM Consumers;

-- View Ratings Table
SELECT * FROM Ratings;

-- View Restaurant_Cuisines Table
SELECT * FROM Restaurant_Cuisines;

-- Alter the relations in Ratings Table

ALTER TABLE [dbo].[Ratings] WITH CHECK ADD CONSTRAINT [FK_Ratings_Consumers] 
FOREIGN KEY([Consumer_ID]) REFERENCES [dbo].[Consumers] ([Consumer_ID])
GO

ALTER TABLE [dbo].[Ratings] WITH CHECK ADD CONSTRAINT [FK_Ratings_Restaurants] 
FOREIGN KEY([Restaurant_ID]) REFERENCES [dbo].[Restaurants] ([Restaurant_ID])
GO

-- Alter the relations in Restaurant_Cuisines Table

ALTER TABLE [dbo].[Restaurant_Cuisines] WITH CHECK ADD CONSTRAINT [FK_Restaurant_Cuisines_Restaurants] 
FOREIGN KEY([Restaurant_ID]) REFERENCES [dbo].[Restaurants] ([Restaurant_ID])
GO

---Part 2

-- 1. Query to list all restaurants

SELECT * 
FROM Restaurants
WHERE Price = 'Medium' 
AND Area = 'Open' 
AND Restaurant_id IN (
    SELECT Restaurant_id 
    FROM Restaurant_Cuisines 
    WHERE Cuisine = 'Mexican'
);

-- 2. Query to return the total number of restaurants
SELECT RC.Cuisine,COUNT(DISTINCT R.Restaurant_id) AS Total_Restaurants
FROM Restaurants R
INNER JOIN Restaurant_Cuisines RC ON R.Restaurant_id = RC.Restaurant_id
INNER JOIN Ratings RT ON R.Restaurant_id = RT.Restaurant_id
WHERE  RC.Cuisine IN ('Mexican', 'Italian') AND RT.Overall_Rating = 1
GROUP BY  RC.Cuisine;


-- 3. Query to calculate the average age of consumers

SELECT ROUND(AVG(c.Age), 0) AS Average_Age
FROM Consumers c
WHERE c.Consumer_id IN (
    SELECT r.Consumer_id
    FROM Ratings r
    WHERE r.Service_Rating = 0
);

-- 4. Query to return the restaurants ranked by the youngest consumer

SELECT  R.Name AS RestaurantName, Ra.Food_Rating,  C.Age AS ConsumerAge
FROM Ratings Ra JOIN Restaurants R ON Ra.Restaurant_id = R.Restaurant_id
JOIN Consumers C ON Ra.Consumer_id = C.Consumer_id
WHERE C.Age = (SELECT MIN(C2.Age) FROM Consumers C2 WHERE C2.Consumer_id = Ra.Consumer_id )
ORDER BY Ra.Food_Rating DESC, C.Age ASC;

-- 5. Stored procedure for updating the Service_rating

CREATE PROCEDURE UpdateServiceRating
AS
BEGIN
    UPDATE Ratings
    SET Service_Rating = 2
    WHERE Restaurant_id IN (
        SELECT r.Restaurant_id
        FROM Restaurants r inner join Ratings rg
		ON r.Restaurant_ID=rg.Restaurant_ID
        WHERE Parking IN ('yes', 'public')
    );
END;

EXEC UpdateServiceRating;

SELECT Name,r.Restaurant_id,r.Service_rating,rest.Parking
FROM Ratings r
INNER JOIN Restaurants rest ON r.Restaurant_id=rest.Restaurant_id
WHERE rest.Parking='yes' OR rest.Parking='public';

-- 6. Four additional queries

-- Query using EXISTS
SELECT *
FROM Restaurants r
WHERE EXISTS (
    SELECT *
    FROM Ratings ra
    WHERE ra.Restaurant_id = r.Restaurant_id
    AND ra.Overall_Rating = 2
);

-- Query using IN
SELECT *
FROM Consumers
WHERE Consumer_id IN (
    SELECT Consumer_id
    FROM Ratings
    GROUP BY Consumer_id
    HAVING COUNT(*) > 4
);

-- Query using system functions (e.g., ROUND)
SELECT ROUND(Latitude, 2) AS Rounded_Latitude,
ROUND(Longitude, 2) AS Rounded_Longitude
FROM Restaurants;

-- Query using GROUP BY, HAVING, and ORDER BY
SELECT Occupation, AVG(Age) AS Avg_Age
FROM Consumers
GROUP BY Occupation
HAVING COUNT(*) > 5
ORDER BY Avg_Age DESC;
