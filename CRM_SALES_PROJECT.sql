CREATE DATABASE SALES;
USE SALES ;
-- Show all records from the accounts table.
SELECT * FROM accounts;

-- Count total number of customers (accounts).
SELECT count(account) from accounts ;

-- List all unique industries.
select distinct sector from accounts;

-- Show customers from Technology industry.
SELECT `account`, sector
FROM accounts
WHERE sector = 'technolgy';

-- Find total number of sales opportunities.
select count(opportunity_id)AS NUMBER_OPPOTUNITY FROM sales_pipeline;

-- Display opportunities with deal size greater than 5000.
SELECT opportunity_id , close_value from sales_pipeline
where close_value >= 5000;

-- Show distinct sales stages
SELECT DISTINCT deal_stage
FROM sales_pipeline;

-- List customers created after 2010.
select `account`, year_established from accounts
where year_established >= 2010;

-- Find total deal value of all opportunities.
SELECT * FROM sales_pipeline;
SELECT  sum(close_value)as total_value from sales_pipeline ;

-- Calculate average deal size
select avg(close_value)as deal_size from sales_pipeline ;

-- Show industry-wise total revenue.
select sector , sum(revenue)as total_revenue from accounts 
group by sector;

-- Count number of opportunities per sales stage.
select count(opportunity_id) , deal_stage from sales_pipeline
group by deal_stage;

-- Show sales team-wise opportunity count.
select product, count(opportunity_id)as product_sales from sales_pipeline
group by product ;


-- Find top 5 customers by total deal value.
select opportunity_id , close_value FROM sales_pipeline 
order by close_value DESC limit 5;

SELECT * FROM accounts;
-- Show average deal size per industry.
SELECT sector, avg(revenue)as AVG_DEAL FROM accounts 
group by sector;

-- Find industries with total revenue > 5,000.
SELECT sector ,  sum(revenue)as total_revenue from accounts
where revenue > 5000
group by sector;



-- Join accounts and opportunities to show:
select accounts.account,  accounts.sector, sales_pipeline.close_value, sales_pipeline.deal_stage
 from accounts join sales_pipeline 
 on accounts.account = sales_pipeline.account;
 
 -- Show sales rep name with total revenue generated.
 select  distinct accounts.account ,  accounts.revenue
 from accounts join sales_pipeline 
 on accounts.account = sales_pipeline.account;
 

-- Find customers who never created any opportunity.
select accounts.account ,sales_pipeline.opportunity_id from accounts left join sales_pipeline 
 on accounts.account = sales_pipeline.account
where sales_pipeline.opportunity_id is null ;
 


-- Show opportunities with product name.
select count(opportunity_id)as product_sale , product from sales_pipeline 
group by product;


-- List customers and their number of opportunities.
select accounts.account,count(sales_pipeline.opportunity_id) from accounts join sales_pipeline 
 on accounts.account = sales_pipeline.account 
group by accounts.account;

-- Find customers with more than 3 opportunities.
select accounts.account from accounts join sales_pipeline 
 on accounts.account = sales_pipeline.account 
 group by accounts.account
having count(sales_pipeline.opportunity_id)>3;
 
 
-- Show sales team-wise total deal value.
SELECT 
    sales_agent,
    SUM(close_value) AS total_deal_value
FROM sales_pipeline
GROUP BY sales_agent;


-- Deal Value Category
SELECT
    opportunity_id,
    close_value,
    CASE
        WHEN  close_value> 100000 THEN 'High Value'
        WHEN close_value BETWEEN 50000 AND 100000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS deal_category
FROM sales_pipeline;


-- Mark opportunities as: Won,Lost,In Progress
SELECT
    opportunity_id,
    deal_stage,
    CASE
        WHEN deal_stage = 'Won' THEN 'Won'
        WHEN deal_stage = 'Lost' THEN 'Lost'
        ELSE 'In Progress'
    END AS opportunity_status
FROM sales_pipeline;

-- RISK STATUS
SELECT
    opportunity_id,
    deal_stage,
    close_value,
    engage_date,
    datediff(CURRENT_DATE, engage_date) AS days_open,
    CASE
        WHEN deal_stage NOT IN ('Won', 'Lost')
             AND DATEDIFF(CURRENT_DATE, engage_date) > 90
        THEN 'At Risk'
        ELSE 'Normal'
    END AS risk_status
FROM sales_pipeline;

-- Find customers with deal size above average.
SELECT DISTINCT
       a.account AS customer_name,
       sp.close_value
FROM sales_pipeline sp
JOIN accounts a
  ON sp.account = a.account
WHERE sp.close_value >
      (SELECT AVG(close_value) FROM sales_pipeline);


-- Show opportunities belonging to top 3 industries by revenue.
SELECT
    sp.opportunity_id,
    a.account_name,
    a.industry,
    sp.deal_size
FROM sales_pipeline sp
JOIN accounts a
  ON sp.account = a.account
WHERE a.industry IN (
    SELECT a2.industry
    FROM sales_pipeline sp2
    JOIN accounts a2
      ON sp2.account = a2.account
    GROUP BY a2.industry
    ORDER BY SUM(sp2.deal_size) DESC
    LIMIT 3
);


-- Show year-wise opportunity count.
select count(opportunity_id)as number_opportunity ,year(engage_date) from sales_pipeline
group by year(engage_date);

select * from sales_pipeline;


-- Calculate monthly revenue trend.
select monthname(engage_date)as month_name, sum(close_value) as total_value
from sales_pipeline
group by monthname(engage_date);
 
 
-- Find average deal closing time.
select avg(close_value)as AVG_DEAL from sales_pipeline;

-- Rank customers by total revenue.
SELECT
    sector,
    opportunity_id,
   close_value
FROM (
    SELECT
        a.sector,
        sp.opportunity_id,
        sp.close_value,
        RANK() OVER (
            PARTITION BY a.sector
            ORDER BY sp.close_value DESC
        ) AS deal_rank
    FROM sales_pipeline sp
    JOIN accounts a
      ON sp.account = a.account
) RANK_DEAL
WHERE deal_rank = 1;

-- Find top deal per industry
SELECT 
    sector,
    sector_value,
    DENSE_RANK() OVER (
        ORDER BY sector_value DESC
    ) AS sector_rank
FROM (
    SELECT 
        a.sector,
        SUM(sp.close_value) AS sector_value
    FROM sales_pipeline sp
    JOIN accounts a
        ON sp.account = a.account
    GROUP BY a.sector
) t;

-- Customer has more than 1 deal (repeat)
SELECT
    a.account AS customer_name,
    COUNT(sp.opportunity_id) AS total_deals,
    SUM(sp.close_value) AS total_revenue
FROM sales_pipeline sp
JOIN accounts a
  ON sp.account = a.account
GROUP BY a.account
HAVING COUNT(sp.opportunity_id) > 1
   AND SUM(sp.close_value) > (
        SELECT AVG(total_rev)
        FROM (
            SELECT SUM(close_value) AS total_rev
            FROM sales_pipeline
            GROUP BY account
        ) t
   )
ORDER BY total_revenue DESC;

-- Calculate Customer Lifetime Value (CLV)
SELECT
    a.account AS customer_name,
    COUNT(sp.opportunity_id) AS total_deals,
    AVG(sp.close_value) AS avg_deal_value,
    SUM(sp.close_value) AS customer_lifetime_value
FROM sales_pipeline sp
JOIN accounts a
  ON sp.account = a.account
GROUP BY a.account
ORDER BY customer_lifetime_value DESC;



     
      
