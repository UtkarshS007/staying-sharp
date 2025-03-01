-- SQL Competitive EASY 

-- StrataScratch

-- Question 1: You have been asked to find the 5 most lucrative products in terms of total revenue for the first half of 2022 (from January to June inclusive).
--             Output their IDs and the total revenue.

SELECT 
    product_id,
    SUM(cost_in_dollars * units_sold) AS total_revenue
FROM 
    online_orders
WHERE 
    DATE(date) BETWEEN '2022-01-01' AND '2022-06-30'
GROUP BY 
    product_id
ORDER BY 
    total_revenue DESC
LIMIT 5;

-- Question 2: Find the number of employees working in the Admin department that joined in April or later.

SELECT 
    COUNT(*) AS num_employees
FROM (
    SELECT 
        department,
        joining_date,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY joining_date ASC) AS rn
    FROM 
        worker
    WHERE 
        MONTH(joining_date) >= 4
) subquery
WHERE 
    department = 'Admin';


-- Question 3: Find the number of workers by department who joined on or after April 1, 2014.
--             Output the department name along with the corresponding number of workers.
--             Sort the results based on the number of workers in descending order.

WITH department_count AS (
    SELECT 
        department,
        COUNT(worker_id) AS total_workers
    FROM
        worker
    WHERE
        MONTH(joining_date) >= 4
    GROUP BY
        department
)
SELECT
    department,
    total_workers
FROM
    department_count
ORDER BY
    total_workers DESC;


-- Question 4: Find the last time each bike was in use. Output both the bike number and the date-timestamp of the 
--             bike's last use (i.e., the date-time the bike was returned). Order the results by bikes that were most
--             recently used.

SELECT bike_number, end_time
FROM dc_bikeshare_q1_2012
GROUP BY bike_number
ORDER BY end_time DESC LIMIT 1;

-- Question 5: Find the details of each customer regardless of whether the customer made an order. 
--             Output the customer's first name, last name, and the city along with the order details.
--             Sort records based on the customer's first name and the order details in ascending order.

select c.first_name, c.last_name, c.city, o.order_details
FROM customers c 
LEFT JOIN orders o 
ON c.id = o.cust_id
ORDER BY 
    c.first_name ASC,
    o.order_details ASC;


-- Question 6: Find the average number of bathrooms and bedrooms for each city’s property types. 
--             Output the result along with the city name and the property type.

WITH avg_details AS (
    SELECT 
        AVG(bedrooms) AS AVG_BEDR, 
        AVG(bathrooms) AS AVG_BATHR, 
        city, 
        property_type
    FROM 
        airbnb_search_details
    GROUP BY 
        city, property_type
)
SELECT * FROM avg_details;

-- Question 6: Find how many reviews exist for each review score given to 'Hotel Arena'. Output the
--             hotel name ('Hotel Arena'), each review score, and the number of reviews for that score.
--             Ensure the results only include 'Hotel Arena.'

SELECT 
    'Hotel Arena' AS hotel_name,
    reviewer_score AS review_score,
    COUNT(*) AS number_of_reviews
FROM 
    hotel_reviews
WHERE 
    hotel_name = 'Hotel Arena'
GROUP BY 
    reviewer_score
ORDER BY 
    reviewer_score DESC;

-- Question 7: Count the number of movies for which Abigail Breslin was nominated for an Oscar.

select COUNT(movie) AS movies_nominated_by_Abigail
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin';

-- Question 8: Write a query that returns the number of unique users per client per month

WITH user_counts_per_month AS (
    SELECT 
        client_id, 
        COUNT(DISTINCT user_id) AS unique_users, 
        MONTH(time_id) AS month
    FROM 
        fact_events
    GROUP BY 
        client_id, 
        MONTH(time_id)
)
SELECT 
    client_id, 
    unique_users, 
    month
FROM 
    user_counts_per_month
ORDER BY 
    client_id, 
    month;





