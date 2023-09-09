SELECT * FROM pizza.customer_orders;
SELECT * FROM pizza.runners_orders;
SELECT * FROM pizza.pizza_names;
SELECT * FROM pizza.pizza_recipes;
SELECT * FROM pizza.pizza_toppings;
SELECT * FROM pizza.runners;


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



  
Q1. How many pizzas were ordered?
select count(order_id) as Total_order
from customer_orders

Q2. How many unique customer orders were made?
select count(distinct order_id) as Unique_order
from customer_orders

Q3. How many successful orders were delivered by each runner?
select runner_id, count(*) as successful_orders 
from runner_orders
where cancellation is null
group by runner_id

Q4. How many of each type of pizza was delivered?
with pizza_ as (
select pizza_name,c.order_id from pizza_names as p 
join customer_orders as c on p.pizza_id = c.pizza_id
join runner_orders as r on c.order_id = r.order_id
where cancellation is null
)

select pizza_name,count(*) as delivered
from pizza_
group by pizza_name

Q5. How many Vegetarian and Meatlovers were ordered by each customer?
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

Q6. What was the maximum number of pizzas delivered in a single order?
select c.order_id, count(c.order_id) as max_order from customer_orders as c
join runner_orders as r on c.order_id = r.order_id 
where cancellation is null
group by c.order_id
order by max_order Desc limit 1

Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
select c.customer_id,
sum(case when exclusions is null and extras is null then 1 else 0 end) as no_changes,
sum(case when exclusions is not null or extras is not null then 1 else 0 end) as changes
from customer_orders as c join runner_orders as r on c.order_id = r.order_id
where cancellation is null
group by c.customer_id;


Q8. How many pizzas were delivered that had both exclusions and extras?
select c.order_id,count(c.order_id) as total from customer_orders as c
join runner_orders as r on c.order_id = r.order_id
where exclusions is not null and extras is not null and cancellation is null;


Q9. What was the total volume of pizzas ordered for each hour of the day?
select hour(c.order_time) as hours, count(c.order_id) as total_orders from customer_orders as c
join runner_orders as r on c.order_id= r.order_id
where cancellation is null
group by hours;

Q10. What was the volume of orders for each day of the week?
select dayname(order_time) as Days, count(order_id) as total_orders
from customer_orders
group by days



