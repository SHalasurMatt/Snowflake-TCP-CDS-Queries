/* List all items and current prices sold through the catalog channel from certain manufacturers in a given $30  price range and consistently had a quantity between 100 and 500 on hand in a 60-day period */

SELECT   i_item_id , i_item_desc ,i_current_price 
FROM     item, inventory, date_dim, catalog_sales 
WHERE    i_current_price BETWEEN 68 AND  68 + 30 
AND      inv_item_sk = i_item_sk 
AND      d_date_sk=inv_date_sk 
AND      d_date BETWEEN Cast('2000-02-01' AS DATE) AND (Cast('2000-02-01' AS DATE) + INTERVAL '60 days') 
AND      i_manufact_id IN (677,970,694,808) 
AND      inv_quantity_on_hand BETWEEN 100 AND 500 
AND      cs_item_sk = i_item_sk 
GROUP BY i_item_id, i_item_desc, i_current_price 
ORDER BY i_item_id ;
