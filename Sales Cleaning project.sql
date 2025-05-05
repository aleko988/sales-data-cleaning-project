
-- 1. Remove Duplicates
-- 2. Standardize The Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns11

select * from sales;

create table sales1
Like sales;

select * from sales1;


insert into sales1
select * from sales;



with Sales_CTE as (
	select *,
    row_number() over(partition by Date, CUstomer_age , Customer_gender, country, State, Product_category,
	Sub_category, Product, Order_Quantity, unit_cost, Unit_Price, profit, cost, Revenue) as row_num
    from sales1
)
select * from sales_cte
where row_num >1;


select * from sales1
where  Date = '2011-02-20' and Customer_Age=25 and country = 'canada';

select * from sales2;

CREATE TABLE `sales2` (
  `Date` text,
  `Day` int DEFAULT NULL,
  `Month` text,
  `Year` int DEFAULT NULL,
  `Customer_Age` int DEFAULT NULL,
  `Age_Group` text,
  `Customer_Gender` text,
  `Country` text,
  `State` text,
  `Product_Category` text,
  `Sub_Category` text,
  `Product` text,
  `Order_Quantity` int DEFAULT NULL,
  `Unit_Cost` int DEFAULT NULL,
  `Unit_Price` int DEFAULT NULL,
  `Profit` int DEFAULT NULL,
  `Cost` int DEFAULT NULL,
  `Revenue` int DEFAULT NULL,
  `row_num`  INT  				-- +1 column
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


insert into sales2
select *,
    row_number() over(partition by Date, CUstomer_age , Customer_gender, country, State, Product_category,
	Sub_category, Product, Order_Quantity, unit_cost, Unit_Price, profit, cost, Revenue) as row_num
    from sales1;
    

Delete from sales2
where row_num >1;


select * from sales2
where row_num >1;


-- Standardizing data

select * from sales2;

UPDATE sales2
SET Country = LOWER(Country),
    State = LOWER(State),
    Product_Category = LOWER(Product_Category),
    Sub_Category = LOWER(Sub_Category),
    Product = LOWER(Product),
    Age_Group = LOWER(Age_Group),
    Customer_Gender = LOWER(Customer_Gender);


select * from sales2
WHERE `date` LIKE '%/%/%';


alter table sales2
Modify column `date` Date;


SELECT * FROM sales2 WHERE profit <= 0 OR revenue <= 0 OR cost <= 0;-- Ensure no negative profit

update sales2
set profit= (ifnull(unit_price, 0) - ifnull(Unit_Cost, 0)) * ifnull(order_quantity, 0),
	revenue=ifnull(order_quantity, 0) * ifnull(unit_price, 0),
    cost=ifnull(Order_Quantity, 0) * ifnull(unit_cost, 0);


select length(country) as len, country, length(trim(country)) as trim
from sales2
where length(country) != length(trim(country)); -- result =0


select length(state) as len, state, length(trim(state)) as trim
from sales2
where length(state) != length(trim(state)); -- result =0



select length(month) as len, month, length(trim(month)) as trim
from sales2
where length(month) != length(trim(month)); -- result =0



select length(Age_Group) as len, Age_Group, length(trim(Age_Group)) as trim
from sales2
where length(Age_Group) != length(trim(Age_Group)); -- result =0


select length(Customer_Gender) as len, Customer_Gender, length(trim(Customer_Gender)) as trim
from sales2
where length(Customer_Gender) != length(trim(Customer_Gender)); -- result =0



select length(Product_Category) as len, Product_Category, length(trim(Product_Category)) as trim
from sales2
where length(Product_Category) != length(trim(Product_Category)); -- result =0


select length(Sub_Category) as len, Sub_Category, length(trim(Sub_Category)) as trim
from sales2
where length(Sub_Category) != length(trim(Sub_Category)); -- result =0


select length(Product) as len, Product, length(trim(Product)) as trim
from sales2
where length(Product) != length(trim(Product)); -- result =0


select * from sales2;


select distinct country
FROM SALES2; 

select distinct product_category
from sales2;

select distinct sub_category
from sales2;


select distinct sub_category
from sales2;


-- NUll value or blank value

select * from sales2;

UPDATE sales2
SET Country = NULLIF(Country, ''),
    State = NULLIF(State, ''),
    Product_Category = NULLIF(Product_Category, ''),
    Sub_Category = NULLIF(Sub_Category, ''),
    Product = NULLIF(Product, ''),
    Age_Group = NULLIF(Age_Group, ''),
    Customer_Gender = NULLIF(Customer_Gender, '');


SELECT 
    COUNT(*) - COUNT(`date`) AS null_date_count,
    COUNT(*) - COUNT(`Day`) AS null_day_count,
    COUNT(*) - COUNT(`Month`) AS null_month_count,
    COUNT(*) - COUNT(`Year`) AS null_year_count,
    COUNT(*) - COUNT(`Customer_Age`) AS null_customer_age_count,
    COUNT(*) - COUNT(`Age_Group`) AS null_age_group_count,
    COUNT(*) - COUNT(`Customer_Gender`) AS null_customer_gender_count,
    COUNT(*) - COUNT(`Country`) AS null_country_count,
    COUNT(*) - COUNT(`State`) AS null_state_count,
    COUNT(*) - COUNT(`Product_Category`) AS null_product_category_count,
    COUNT(*) - COUNT(`Sub_Category`) AS null_sub_category_count,
    COUNT(*) - COUNT(`Product`) AS null_product_count,
    COUNT(*) - COUNT(`Order_Quantity`) AS null_order_quantity_count,
    COUNT(*) - COUNT(`Unit_Cost`) AS null_unit_cost_count,
    COUNT(*) - COUNT(`Unit_Price`) AS null_unit_price_count,
    COUNT(*) - COUNT(`Profit`) AS null_profit_count,
    COUNT(*) - COUNT(`Cost`) AS null_cost_count,
    COUNT(*) - COUNT(`Revenue`) AS null_revenue_count

FROM sales2; -- THere are not any NULL data



select count(*) from sales2;

alter table sales2
drop column row_num;

select * from sales2
WHERE `date` LIKE '%/%/%'; -- Check if the date format is inconsistent


-- INdexes

CREATE INDEX idx_date ON sales2(Date);
CREATE INDEX idx_country ON sales2(Country(100));
CREATE INDEX idx_product ON sales2(Product(100));
CREATE INDEX idx_order_quantity ON sales2(Order_Quantity);
CREATE INDEX idx_customer_age ON sales2(Customer_Age);
CREATE INDEX idx_profit ON sales2(Profit);
CREATE INDEX idx_year ON sales2(Year);
CREATE INDEX idx_state ON sales2(State(100));