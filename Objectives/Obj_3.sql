-- Objective 3

-- 1. Combine the menu_items and order_details tables into a single table.
-- List the table that is the transaction table
SELECT *
FROM menu_items as tb_1
	JOIN order_details as tb_2
    ON tb_1.menu_item_id = tb_2.item_id;

-- Solution:
SELECT *
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id;
    
/* 
Only matches where item_id=menu_item_id.
So, row with item_id=3 in order_details is excluded (no Pizza with id=3).

LEFT JOIN:
Keeps all order_details rows.
The row with item_id=3 appears, but menu_items columns will be NULL.

INNER JOIN:
Would only return menu item ids that existed in both order_Details table and menu_items table > exlcuding some orders
*/

-- 2. What were the least and most ordered items? What categories were they in?
SELECT item_name, category, COUNT(order_id) as num_times_ordered
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY item_name, category
ORDER BY num_times_ordered ASC; 


-- 3. What were the top 5 orders that spent the most money?
SELECT order_id, SUM(price)
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
GROUP BY order_id
ORDER by SUM(price) DESC
LIMIT 5;

-- 4. View the details of the highest spend order. Which specific items were purchased? What insights can you gather? 
SELECT *
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440;

-- Italian ordered a lot even though it's not ordered much overall
SELECT category, COUNT(item_id)
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440
GROUP BY category;


-- 5. BONUS: View the details of the top 5 highest spend orders
SELECT order_id, category, COUNT(item_id)
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id IN (440, 2075, 1957, 330, 2675)
GROUP BY order_id, category;

-- Bonus How much was the most expensive order in the dataset?
SELECT SUM(price)
FROM order_details od 
LEFT JOIN menu_items mi
	ON od.item_id = mi.menu_item_id
WHERE order_id = 440;