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




