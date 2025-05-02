use project;

select * from fashion;

-- check data types
describe fashion;
select `date purchase` from fashion;

-- put off safe update remember to set it back to 1
set sql_safe_updates = 0;

-- changing data format for the date purchase column
update fashion
set `date purchase` = case
when `date purchase` like '%/%' then date_format(str_to_date(`date purchase`, '%Y/%m/%d'), '%m-%d-%Y')
when `date purchase` like '%-%' then date_format(str_to_date(`date purchase`, '%Y-%m-%d'), '%m-%d-%Y')
else null
end;

-- changing data type of the date purchase
alter table fashion
modify column `date purchase` date;


-- analysis
-- checking total number of purchase by customer
select `Customer reference ID`,  count(*) as total_purchase
from fashion
group by `customer reference ID`;

-- number of purchase made in 2022
select count(*) as total_purchase
from fashion
where year(`date purchase`) = 2022;

-- number of puchase made in 2023
select count(*) as total_purchase
from fashion
where year(`date purchase`) = 2023;

-- total number of purchase
select count(*) as total_purchase
from fashion;

-- most used payment method
select `Payment Method`, count(*) as total_count
from fashion
group by `Payment Method`
order by total_count desc;

-- total sales by product
select `Item Purchased`, sum(`Purchase Amount (USD)`) as total_sales
from fashion
group by `Item Purchased`
order by total_sales desc;

-- revenue gotten from each product
select `Item Purchased`, sum(`Purchase Amount (USD)`) as product_revenue
from fashion
group by `Item Purchased`
order by product_revenue desc;

-- review count
select `Item Purchased`, round(avg(`Review Rating`),2) as average_review
from fashion
where `Review Rating` is not null
group by `Item Purchased`
order by average_review 
limit 8;

-- calculating days with highest sales
select DAYNAME(`date purchase`) as day_of_week, count(*) as sales_count
from fashion
group by day_of_week
order by sales_count desc;

-- month with the highest sales
select monthname(`date purchase`) as  month_name, count(*) as sales_count
from fashion
group by month_name
order by sales_count desc;


-- products sold more on each month
select monthname(`date purchase`) as sales_month, `Item Purchased`, count(*) as total_sold
from fashion
group by sales_month, `Item Purchased`
order by sales_month, total_sold desc;