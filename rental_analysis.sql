
1. Which city has the highest average rental price?
2. How does the number of rental listings vary by city?

SELECT
    city,
    COUNT(*) AS total_properties,
    ROUND(AVG(rent), 2) AS average_rent,
    ROUND(MIN(rent), 2) AS minimum_rent,
    ROUND(MAX(rent), 2) AS maximum_rent
FROM rental_properties_clean
GROUP BY city
ORDER BY average_rent DESC;

2What does this query tell you?

* Which city has the highest average rent?
* How many rental listings are available in each city?
SELECT
    city,
    COUNT(*) AS total_properties,
    ROUND(AVG(rent), 2) AS average_rent
FROM rental_properties_clean
GROUP BY city
ORDER BY average_rent DESC;

3 Business question: Which property type—Flat, House, or Villa—has the highest average rent?
SELECT
    property_type,
    COUNT(*) AS total_properties,
    ROUND(AVG(rent), 2) AS average_rent,
    ROUND(MIN(rent), 2) AS minimum_rent,
    ROUND(MAX(rent), 2) AS maximum_rent
FROM rental_properties_clean
GROUP BY property_type
ORDER BY average_rent DESC;

4 Analyze furnishing categories
Business question: How do average rental prices vary between furnishing categories?
SELECT
    furnishing,
    COUNT(*) AS total_properties,
    ROUND(AVG(rent), 2) AS average_rent
FROM rental_properties_clean
GROUP BY furnishing
ORDER BY average_rent DESC;

Step 4: Find the most expensive localities
Business question: Which localities have the highest average rent among localities with at least five listings?
SELECT
    city,
    locality,
    COUNT(*) AS total_properties,
    ROUND(AVG(rent), 2) AS average_rent
FROM rental_properties_clean
GROUP BY city, locality
HAVING COUNT(*) >= 5
ORDER BY average_rent DESC
LIMIT 10;

Step 5: Analyze rent per square foot
Business question: Which city has the highest average listed rent per square foot?

SELECT
    city,
    ROUND(AVG(rent / NULLIF(area, 0)), 2)
        AS average_rent_per_sqft
FROM rental_properties_clean
GROUP BY city
ORDER BY average_rent_per_sqft DESC;

Step 6: Find properties above their city’s average rent
Business question: Which listings are priced above their respective city’s average rent?
SELECT
    city,
    locality,
    property_type,
    rent
FROM rental_properties_clean AS p
WHERE rent > (
    SELECT AVG(rent)
    FROM rental_properties_clean
    WHERE city = p.city
)
ORDER BY rent DESC
LIMIT 20;

Step 7: Rank the most expensive properties in each city
Business question: Which properties have the highest listed rents in each city?
SELECT *
FROM (
    SELECT
        city,
        locality,
        property_type,
        rent,
        RANK() OVER (
            PARTITION BY city
            ORDER BY rent DESC
        ) AS rent_rank
    FROM rental_properties_clean
) AS ranked_properties
WHERE rent_rank <= 3
ORDER BY city, rent_rank;

Step 8: Compare property area and rent
Business question: How do average property size and rental prices vary across cities?
SELECT
    city,
    ROUND(AVG(area), 2) AS average_area,
    ROUND(AVG(rent), 2) AS average_rent,
    COUNT(*) AS total_properties
FROM rental_properties_clean
GROUP BY city
ORDER BY average_rent DESC;