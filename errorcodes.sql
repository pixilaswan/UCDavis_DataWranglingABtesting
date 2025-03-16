
/*Goal: Here we use users table to pull a list of user email addresses. Edit the query to pull email
/*addresses, but only for non-deleted users.*/
SELECT *
FROM dsv1069.users
where deleted_at ISNULL;

Select * from dsv1069.users;

/*Exercise 2:
--Goal: Use the items table to count the number of items for sale in each category
Starter Code: (none)*/
SELECT category, count(id) as number_of_items
FROM dsv1069.items 
Group By(category); 

/*Exercise 3:
--Goal: Select all of the columns from the result when you JOIN the users table to the orders
table*/
SELECT * from dsv1069.users as u
JOIN dsv1069.items as i on u.id = i.id;

/*Exercise 4:
--Goal: Check out the query below. This is not the right way to count the number of viewed_item
* events. Determine what is wrong and correct the error.
Starter Code:*/

SELECT event_name, count(event_id) as Count_events
FROM dsv1069.events 
Group By event_name;

/*Exercise 5:
--Goal:Compute the number of items in the items table which have been ordered. The query
*below runs, but it isn’t right. Determine what is wrong and correct the error or start from scratch.
Starter Code:*/
/*SELECT count(item_id) as item_count
*from dsv1069.orders 
*INNER JOIN dsv1069.items
ON orders.item_id = items.id;*/
/* The correct code is */
Select i.name, COUNT(DISTINCT i.id) as item_count
from dsv1069.items as i
INNER JOIN dsv1069.orders as o
ON i.id = o.item_id
GROUP BY i.name;

/*Exercise 6:
--Goal: For each user figure out IF a user has ordered something, and when their first purchase
was. The query below doesn’t return info for any of the users who haven’t ordered anything.
Starter Code */
Select users.id as user_id 
Min(orders.paid_at) AS min_paid_at
FROM dsv.1069.orders
inner join dsv1069.users
ON
orders.user_id = users.id
group by 
users.id
/* Since I need to consider the users who has ordered something and when their first pushase was, it should be created_at column vs paid_at column.
For each users I have to check if there has been any purchases at minimum from the orders table so here is the revised code*/
SELECT users.id, min(orders.created_at) AS first_purchase_at,
CASE
WHEN min(orders.created_at) is NULL THEN 'NO'
ELSE 'YES'
END AS has_made_purchase
FROM dsv1069.users as users
INNER JOIN dsv1069.orders as orders
ON users.id = orders.user_id
GROUP BY users.id;

Select count(event_id) as count_events, event_name from dsv1069.events group by event_name;
/*Exercise 7:
--Goal: Figure out what percent of users have ever viewed the user profile page, but this query
isn’t right. Check to make sure the number of users adds up, and if not, fix the query.*/
Select 100 *
(Select COUNT(DISTINCT users.id)
            from dsv1069.users as users 
            JOIN dsv1069.events as events 
            ON users.id = events.user_id
            Where events.event_name = 'view_user_profile')/
            (Select count(DISTINCT id) from dsv1069.users) as percentage_of_users;
