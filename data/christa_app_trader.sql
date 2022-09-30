/*a. Develop some general recommendations as to the price range, genre, 
content rating, or anything else for apps that the company should target.*/

---------------------------------------
WITH total_avg_rating AS (SELECT ROUND(AVG(psa.rating + asa.rating)/2,2) AS avg_rating, name
			FROM play_store_apps AS psa
			FULL JOIN app_store_apps AS asa USING(name)
			GROUP BY name
			ORDER BY avg_rating)
SELECT avg_rating, name
FROM total_avg_rating
WHERE avg_rating >= 4.5
ORDER BY avg_rating DESC

-- This gives us the average rating of all apps from both tables and excludes any rating lower than 4.5
WITH total_avg_rating AS (SELECT ROUND(AVG(psa.rating + asa.rating)/2,2) AS avg_rating, name
			FROM play_store_apps AS psa
			FULL JOIN app_store_apps AS asa USING(name)
			GROUP BY name
			ORDER BY avg_rating), 
total_avg_price AS (SELECT AVG(asa.price + psa.price::money::numeric)/2 AS avg_price, name
				 FROM app_store_apps AS asa
				 FULL JOIN play_store_apps AS psa USING (name)
				 GROUP BY name)
SELECT name, CEILING(avg_rating/0.25)*0.25 AS avg_rating, avg_price::money, primary_genre, asa.content_rating
FROM total_avg_rating
LEFT JOIN total_avg_price USING (name)
LEFT JOIN app_store_apps AS asa USING (name)
LEFT JOIN play_store_apps AS psa USING(name)
WHERE avg_rating IS NOT NULL
AND avg_rating > 4.5
AND avg_price <= 2.99
ORDER BY avg_rating DESC
