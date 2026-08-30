use [pizza_sales.project]

select * from pizza_sales

--#1_total_revenue

	select sum(total_price) as Total_Revenue from pizza_sales

--#2_average_order_value

	select sum(total_price) / count ( distinct order_id )  as avg_order_values from pizza_sales


--#3_total_pizza_sold
	select sum( quantity) as total_pizza_sold from pizza_sales 

--#4_total_order_placed
	
	select count ( distinct order_id ) as total_order_placed from pizza_sales

--#5_Average_pizza_per_head 
	
	select cast ( cast(sum( quantity) as decimal (10,2)) / cast (count ( distinct order_id ) as decimal (10,2))  as decimal(10,2)) as Average_pizza_per_head   from pizza_sales

--CHART_REQUIREMENTS

--#1
	select DATENAME (dw,order_date) as order_day, count ( distinct order_id) as Total_orders from pizza_sales
	group by DATENAME (dw,order_date)

--#2
	SELECT DATENAME(MONTH, order_date ) as month_name , 
	count ( distinct order_id) as total_orders from pizza_sales 
	group by DATENAME(MONTH, order_date )
	order by total_orders desc 

--#3 little complicated
	select pizza_category ,sum( total_price) AS Total_sales , sum( total_price)*100 / 
	( select sum (total_price) from pizza_sales  where month(order_date)=1) as PCT from pizza_sales 
	where month(order_date)=1
	group by pizza_category 

--#4

	select pizza_size ,cast (sum( total_price) as decimal (10,2)) AS Total_sales ,cast ( sum( total_price)*100 / 
	( select sum (total_price) from pizza_sales where datepart(quarter,order_date)=1) as decimal (10,2)) as PCT from pizza_sales 
	where datepart(quarter,order_date)=1
	group by pizza_size
	order by pct desc

--#5 missing 

--#6
	
	select top 5 pizza_name,sum(total_price) as Total_revenue from pizza_sales
	group by pizza_name
	order by Total_revenue desc 

--#7
	select top 5 pizza_name,sum(quantity) as Total_quantity from pizza_sales
	group by pizza_name
	order by Total_quantity asc

	select top 5 pizza_name,count(distinct order_id) as Total_orders from pizza_sales
	group by pizza_name
	order by Total_order