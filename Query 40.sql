/* Compute the impact of an item price change on the sales by computing the total sales for items in a 30 day period before and after the price change. Group the items by location of warehouse where they were delivered from.*/

SELECT w_state,i_item_id ,
       Sum(CASE WHEN (Cast(d_date AS DATE) < Cast ('2000-03-11' AS DATE)) THEN cs_sales_price - COALESCE(cr_refunded_cash,0) 
           ELSE 0 
           END) AS sales_before , 
       Sum(CASE WHEN (Cast(d_date AS DATE) >= Cast ('2000-03-11' AS DATE)) THEN cs_sales_price - COALESCE(cr_refunded_cash,0) 
           ELSE 0 
           END) AS sales_after 
FROM   catalog_sales 
LEFT OUTER JOIN catalog_returns ON (cs_order_number = cr_order_number AND cs_item_sk = cr_item_sk) , 
                warehouse ,item ,date_dim 
WHERE           i_current_price BETWEEN 2.99 AND 3.49 
AND             i_item_sk = cs_item_sk 
AND             cs_warehouse_sk = w_warehouse_sk 
AND             cs_sold_date_sk = d_date_sk 
AND             d_date BETWEEN (Cast ('2000-03-11' AS DATE) - INTERVAL '30 days') AND (cast ('2000-03-11' AS date) + INTERVAL '30 days') 
GROUP BY        w_state,i_item_id 
ORDER BY        w_state,i_item_id ;
