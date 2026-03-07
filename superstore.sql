use testdb;

SELECT 
    *
FROM
    superstore;

SELECT 
    *
FROM
    superstore
LIMIT 10 OFFSET 20;

SELECT 
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM
    superstore
GROUP BY region;

select region,round((sum(profit)/sum(sales)) *100,2) as profit_margin from superstore group by region;
select state,sum(sales)as total_state,sum(profit) as total_sales from superstore group by state; 

select state,round((sum(region)/sum(sales)) *100 ,2) as total_profit from superstore group by state order by total_profit Desc limit 10;
select state,round((sum(region)/sum(sales)) *100 ,2) as total_profit from superstore group by state order by total_profit Asc limit 10;
select city,round((sum(region)/sum(sales)) *100 ,2) as total_profit from superstore group by city order by total_profit Asc limit 10;
select city,round((sum(region)/sum(sales)) *100 ,2) as total_profit from superstore group by city order by total_profit desc limit 10;
select discount,avg(sales) as avg_sales from superstore group by discount; 
select category,sum(discount) as total_discount from superstore group by category; 
select category,Sub-Category,sum(discount) as total_discount from superstore group by category,Sub-Category; 
select sum(gross_sales)as total_gross_sales from superstore;
/*Total Sales including Tax (assuming 5%)*/
select sales,sales * 1.05 as sales_tax from superstore;
/*Profit Margin percentage*/
select sales,profit ,(profit/sales)*100 as marginpct from superstore where sales >0;
/*Discount Amount*/
select sales,discount,(sales*discount) as discountamt from superstore;
/*Sales per Unit*/
select sales,quantity ,sales / quantity as unitprice from superstore;
/*Net Sales (Sales minus Profit):*/
select sales,profit,sales - profit as net sales from superstore;
/*Double the Quantity:*/
select Quantity ,quantity *2 from superstore;
/*Profit after additional 10% fee*/
select profit,profit-(profit *0.10)as adjustedprofit from superstore;
/*Sales if price was 20% higher*/
select sales,sales *0.20 as targetsales from superstore;
/*Difference between Sales and Discount*/
select sales -(sales *discount)as finalprice from superstore; 
/*Quantity remainder (even/odd check)*/
select quantity ,quantity % 2 as isodd from superstore;
/*WHERE Clause (Filtering)Filter by Region*/
select * from superstore where region="West"; 
/*Filter by Sales range*/
select * from superstore where sales>1000;
/*Filter by Sales range*/
select * from superstore where sales="california";
/*Filter by Negative Profit*/
select * from superstore where profit<0;
/*Filter by Category and Ship Mode*/
select * from superstore where category='furniture' and `Ship Mode` ='Second Class'; 
/*Filter by specific Year (assuming standard SQL date functions)*/
select * from superstore where `Order Date` Like '%2017%';
/*Filter by multiple States*/
select * from superstore where state in('Texas','Florida','New York');
/*Filter by Segment and low Quantity*/
select * from superstore where segment='Corporate' and Quantity <3;
/*Filter by Profit margin > 50*/
select * from superstore where profit>50;
/*Filter by Product Category excluding Office Supplies*/
select * from superstore where category not in ('office supplie');
select * from superstore where category !='office supplie';
/*GROUP BY & HAVING (Aggregations) Sales by Category*/
select category,sum(sales) from superstore group by category;
/*Average Profit by State*/
select state,avg(profit) from superstore group by state;
/*Count Orders per Region*/
select region,count(`order Id`) from superstore group by region;
/*Total Quantity per Sub-Category*/
select `Sub-Category`,sum(quantity) from superstore group by `Sub-Category`;
/*Cities with total Sales over 50,000*/
select city,sum(sales) from superstore group by city having sum(sales)>50000;
/*States with negative average Profit*/
select state,avg(profit) from superstore group by state having avg(profit)<0;
/*Categories with more than 500 items sold*/
select category,sum(quantity) from superstore group by category having sum(quantity)>500;
/*Sub-Categories with average Discount > 0.1*/
select `sub-category`,avg(discount) from superstore group by `sub-category` having avg(discount)>0.1;
/*Regions with more than 1000 orders*/
select region ,count(`Order Id`) from  superstore group by region having count(`Order Id`)>1000;
/*Customers with total Sales > 10000*/
select `Customer Name`,sum(sales) from superstore group by `Customer Name` having sum(sales)>10000;
/*Segments with average sales < 200*/
select segment,avg(sales) from superstore group by segment having avg(sales)<200;
/*Count of unique products per Category*/
select category, count(distinct`Product Id`) from superstore group by category;
/*Max Profit per State*/
select state,max(profit) from superstore group by state;
/*Min Sales per Region*/
select region,min(sales) from superstore group by region;
/*Total Profit by Year (HAVING profit > 0)*/
select `Order Date`,sum(profit) from superstore group by `order Date` having sum(profit)>0;
/*ORDER BY (Sorting)Sales High to Low*/
select * from superstore order by sales Desc;
/*Alphabetical Customers*/
select * from superstore order by `customer Name` asc;
/*Chronological Orders*/
select * from superstor order by `Order Date` asc;
/*Profit Low to High (Losses first)*/
select * from superstore order by profit asc;
/*Sort by Category then Sub-Category*/
select * from superstore order by `category`,`sub-category`;
/*CASE Statements (Logic)Label Sales Performance*/
select sales,case when sales >1000 then 'High' when sales>500 then 'Medium' else 'Low' end as performance from superstore;
/*Cities with 'San' in name*/
select city from superstore where city like 'San%';
/*Products containing 'Phone'*/
select * from superstore where `Product Name` like '%Phone%';
/*Customer names with 'e' as second letter*/
select * from superstore where `Customer Name`like '_e%';
/*Previous row Sales value*/
select sales,lag(sales)over(order by `Row Id`) as presales  from superstore;
/*Next Profit value by Customer*/
select `Customer Name`,profit,lead(profit)over(partition by`Customer Name`order by `Order Date`) from superstore;
/*All unique cities from West and South*/
select city from superstore where region="south"union  select city from superstore where region="west";
/*Products sold in 2014 but not 2015*/
select `Product Name` from superstore where `Order Date` like '%2014' EXCEPT  select `Product Name` from superstore where `Order Date` like '%2015';
/*Multiple window functions*/
select sales,lead(sales) over (order by `Row Id`),lag(sales) over (order by `Row Id`) from superstore;
/*Profitability Status*/
select profit,case when profit>0 then 'Profitable' else 'Loss' end as status from superstore;
/*Region Shortcode*/
select region,case when region="west" then 'W' when region="South" then 'S' when region="East" then 'E' else 'H' end as code from superstore;
/*Shipping Speed Label*/
select `Ship Mode`,case when `Ship Mode`='same Day' then 'Express' else 'Standard'end as "speed" from superstore;
/*Discount Category*/
select discount,case when discount>0.5 then 'High' when discount>0 then 'Regular' else 'None' end as type from Superstore;
/*Customer Segment Initial*/
select `Customer Name`,case when segment='Corporate' then'Co' when segment='Consumer' then'c' else 'H' end from superstore;
/*Quantity Warning*/
select quantity,case when quantity<2 then 'Restoke' else 'Ok' end from superstore;
/*Priority based on Sales*/
select sales,case when sales>5000 then 1 else 0  end as priority  from superstore;
/*Tax Code by State*/
select state,case when state='california' then 'Tax-A' else 'Tex-B' end from superstore;
/*Seasonality (Simple)*/
select `order Date`,case when `order Date` like '%/12/%' then 'Hoidat' else 'Normal' end  from superstore;
/*Customers starting with 'A'*/
select * from superstore where `Customer Name` like 'A%';
/*Order IDs ending with '123'*/
select * from superstore where `order Id` like '%123';
/*Postal codes starting with '9'*/
select * from superstore where `Postal Code` like '9%';
/*Sub-Categories with 'ies' suffix*/
select * from superstore where `Sub-Category` like '%ies';
/*Products with 'Table' in name*/
select * from superstore where `Product Name` like '%Table%';
/*States containing 'New'*/
select * from superstore where state like '%New%';
/*Segment ending with 'er'*/
select * from superstore where segment like '%er';
/*Next row Sales value*/
select sales,lead(sales) over (order by `Order Id`) as nextsales from superstore;
/*Sales growth (Diff from prev)*/
select sales,lag(sales) over (order by `Order Id`)as prevsales from superstore;
/*Lead Ship Date*/
select `order date`,lead(`ship date`) over (order by `order date`) from superstore; 
/*Lag Quantity within Category*/
select category,quantity,lag(quantity) over (partition by category order by `order date`) from superstore;
/*Comparison with next Discount*/
select discount ,lead(discount) over(order by `row Id`) from superstore;
/*Lag Sales for same Product ID*/
select sales ,lag(sales) over (partition by `Product Id` order by `order date`) from superstore;
/*Profit trend (Lag)*/
select profit,lag(profit) over(order by `row Id`) from superstore;
/*Lead Row ID*/
select `row Id`,lead(`row Id`)over(order by `row Id`) from superstore;
/*Union of two segments*/
select `Customer name` from superstore where segment='consumer'
union
select `Customer name` from superstore where segment='corporate'; 
/*Customers in both California and New York*/
select `customer name` from superstore where state='California'
union
select `customer name` from superstore where state='New York';
/*States with Sales > 1000 INTERSECT States with Profit < 0*/
select state from superstore where sales >10000
intersect 
select state from superstore where sales >0;
/*Cities in Central EXCEPT Cities in Texas*/
select city from superstore where region = "central"
Except
select city from superstore where region = "Texas";
/*Union of unique Categories and Sub-Categories*/
select category from superstore 
union 
select `sub-category` from superstore;
/*Customers with high sales INTERSECT with low profit*/
select `customer name` from superstore where sales >5000
intersect
select `customer name` from superstore where sales <100;
/*Products in Furniture EXCEPT Office Supplies*/
select `Product name` from superstore where category="Furniture"
except
select `Product name` from superstore where category="Office Supplies";
/*Union of two specific Regions*/
select * from superstore where region='East'
union
select * from superstore where region='west';
