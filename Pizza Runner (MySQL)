# pizza Runner

## Table
--> [Data Cleaning and Normalization]
  --> [Table 1 : Runners]
  --> [Table 2 : customers_Orders]
  --> [Table 3 : runner_orders]
  --> [Table 4 : pizza_names]
  --> [Table 5: pizza_recipes]
  --> [Table 6: pizza_toppings]
--> [Solution : 1. Pizza Metrics]

1. How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5. How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?





















-- change empty and null string to null in customer_orders
update customer_orders
set exclusions = null
where exclusions in ("null","");

update customer_orders
set extras = null
where extras in ("null","");

alter table customer_orders
modify order_time datetime;

-- change empty and null string to null in runners_orders

select * from runner_orders;

update runner_orders
set cancellation = null
where cancellation in ("null","");

update runner_orders
set pickup_time = null
where pickup_time in ("null","");


update runner_orders
set duration = null
where duration in ("null","");


update runner_orders
set distance = null
where distance in ("null","");

update runner_orders
set distance = replace(distance,"km","");

update runner_orders
set duration = replace(distance,"minute","");


update runner_orders
set duration = replace(distance,"minutes","");

alter table runner_orders
modify pickup_time datetime;


alter table runner_orders
modify distance int;

select * from customer_orders;
select * from runner_orders

-- A.
-- How many pizzas were ordered?
select count(order_id) as Total_order
from customer_orders

-- How many unique customer orders were made?
select count(distinct order_id) as Unique_order
from customer_orders

-- How many successful orders were delivered by each runner?
select runner_id, count(*) as successful_orders 
from runner_orders
where cancellation is null
group by runner_id

-- How many of each type of pizza was delivered?
with pizza_ as (
select pizza_name,c.order_id from pizza_names as p 
join customer_orders as c on p.pizza_id = c.pizza_id
join runner_orders as r on c.order_id = r.order_id
where cancellation is null
)

select pizza_name,count(*) as delivered
from pizza_
group by pizza_name

-- How many Vegetarian and Meatlovers were ordered by each customer?
with cte as( 
select customer_id,
if (pizza_name = "Vegetarian", customer_id,null) as vc,
if (pizza_name = "Meatlovers", customer_id,null) as mtc
from customer_orders as c
join pizza_names as p on c.pizza_id = p.pizza_id
)

select customer_id, count(vc) as Vegetarian, count(mtc) as Meatlovers
from cte
group by customer_id



