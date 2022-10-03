


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
SELECT DISTINCT(name), CEILING(avg_rating/0.25)*0.25 AS avg_rating, avg_price::money, primary_genre, asa.content_rating, 
(CEILING(avg_rating/0.25)/2)+1 AS rate_in_year, (((CEILING(avg_rating/0.25)/2)+1)*12)*5000::money AS total_return,
												(((CEILING(avg_rating/0.25)/2)+1)*12)*1000::money AS marketing_price,
		                                        ((((((CEILING(avg_rating/0.25)/2)+1)*12)*2500) - (((CEILING(avg_rating/0.25)/2)+1)*12)*1000)-25000)::money AS profit
FROM total_avg_rating
LEFT JOIN total_avg_price USING (name)
LEFT JOIN app_store_apps AS asa USING (name)
LEFT JOIN play_store_apps AS psa USING(name)
WHERE avg_rating IS NOT NULL
AND avg_rating > 4.5
AND avg_price <= 2.50
ORDER BY avg_rating DESC
LIMIT 10;

--

WITH total_avg_rating AS (SELECT ROUND(AVG(psa.rating + asa.rating)/2,2) AS avg_rating, name
			FROM play_store_apps AS psa
			FULL JOIN app_store_apps AS asa USING(name)
			GROUP BY name
			ORDER BY avg_rating), 
total_avg_price AS (SELECT AVG(asa.price + psa.price::money::numeric)/2 AS avg_price, name
				 FROM app_store_apps AS asa
				 FULL JOIN play_store_apps AS psa USING (name)
				 GROUP BY name)
SELECT DISTINCT(name), CEILING(avg_rating/0.25)*0.25 AS avg_rating, avg_price::money, primary_genre, asa.content_rating, 
(CEILING(avg_rating/0.25)/2)+1 AS rate_in_year, (((CEILING(avg_rating/0.25)/2)+1)*12)*5000::money AS total_return,
												(((CEILING(avg_rating/0.25)/2)+1)*12)*1000::money AS marketing_price,
		                                        ((((((CEILING(avg_rating/0.25)/2)+1)*12)*2500) - (((CEILING(avg_rating/0.25)/2)+1)*12)*1000)-25000)::money AS profit
FROM total_avg_rating
LEFT JOIN total_avg_price USING (name)
LEFT JOIN app_store_apps AS asa USING (name)
LEFT JOIN play_store_apps AS psa USING(name)
WHERE avg_rating IS NOT NULL
AND avg_rating > 4.5
AND avg_price <= 2.50
ORDER BY avg_rating DESC
LIMIT 10;

--
WITH halloween_games AS (WITH total_avg_rating AS (SELECT ROUND(AVG(psa.rating + asa.rating)/2,2) AS avg_rating, name
						FROM play_store_apps AS psa
						FULL JOIN app_store_apps AS asa USING(name)
						GROUP BY name
						ORDER BY avg_rating), 
			total_avg_price AS (SELECT AVG(asa.price + psa.price::money::numeric)/2 AS avg_price, name
							 FROM app_store_apps AS asa
							 FULL JOIN play_store_apps AS psa USING (name)
							 GROUP BY name)
			SELECT DISTINCT(name), CEILING(avg_rating/0.25)*0.25 AS avg_rating, avg_price::money, primary_genre, asa.content_rating, 
			CEILING(avg_rating/0.25)/2+1 AS longevity, (((CEILING(avg_rating/0.25)/2)+1)*12)*5000::money AS total_return, 
			(((CEILING(avg_rating/0.25)/2)+1)*12)*1000::money AS marketintg_price, (((((CEILING(avg_rating/0.25)/2)+1)*12)*2500-(((CEILING(avg_rating/0.25)/2)+1)*12)*1000)-25000)::money AS profit
			FROM total_avg_rating
			LEFT JOIN total_avg_price USING (name)
			LEFT JOIN app_store_apps AS asa USING (name)
			LEFT JOIN play_store_apps AS psa USING(name)
			WHERE avg_rating IS NOT NULL
			AND avg_rating > 4.5
			AND avg_price <= 2.99
			AND avg_rating IS NOT NULL
			ORDER BY avg_rating DESC)
SELECT DISTINCT name, avg_rating, avg_price, primary_genre
FROM halloween_games
WHERE name ILIKE '%Freddy%' OR name ILIKE '%Fallout%' OR name ILIKE '%Zombie%' OR name ILIKE '%Earn to Die%'

		






