USE [Real Estate Data] ;

ALTER TABLE real_estate
ALTER COLUMN price BIGINT;

SELECT * FROM real_estate ;
==================================================================================
/* Dashboard 1: Market Overview */

-- 1. Total Properties Listed
SELECT COUNT(*) AS total_properties
FROM real_estate;

-- 2. Overall Average Price
SELECT AVG(price) AS avg_price
FROM real_estate;

-- 3. Median Price
SELECT DISTINCT
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) 
       OVER () AS median_price
FROM real_estate;

-- Bar Chart – Average Price per Location
SELECT locations, AVG(price) AS avg_price
FROM real_estate
GROUP BY locations
ORDER BY avg_price DESC;

-- Bar Chart – Median Price by Property Type
SELECT DISTINCT property_type,
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price)
       OVER (PARTITION BY property_type) AS median_price
FROM real_estate
ORDER BY median_price DESC;

-- Pie/Donut Chart – Furnished vs Unfurnished
SELECT furnished_status, COUNT(*) AS total
FROM real_estate
GROUP BY furnished_status
ORDER BY total DESC;

-- Map – Average Price Ranges by City (if city column exists in locations)
SELECT locations, AVG(price) AS avg_price
FROM real_estate
GROUP BY locations
ORDER BY avg_price DESC;
==================================================================================
/*Dashboard 2: Price Drivers (Features vs Value)*/

-- 1. Average Price per SqFt
SELECT AVG(price / square_feet) AS avg_price_per_sqft
FROM real_estate
WHERE Square_feet > 0;

-- 2. Average Price per Bedroom
SELECT AVG(price * 1.0 / NULLIF(bedrooms,0)) AS avg_price_per_bedroom
FROM real_estate;

-- 3. Average Price per Bathroom
SELECT AVG(price * 1.0 / NULLIF(bathrooms,0)) AS avg_price_per_bathroom
FROM real_estate;

-- Scatter Plot – SqFt vs Price
SELECT square_feet, price, locations
FROM real_estate;

-- Box Plot – Price by Bedrooms
SELECT bedrooms, price
FROM real_estate;

-- Bar Chart – Avg. Price by Bathrooms
SELECT bathrooms, AVG(price) AS avg_price
FROM real_estate
GROUP BY bathrooms
ORDER BY bathrooms;

-- Stacked Bar – Price Comparison (Amenities)
SELECT amenities, AVG(price) AS avg_price
FROM real_estate
GROUP BY amenities
ORDER BY avg_price DESC;











