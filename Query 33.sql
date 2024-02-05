/* What is the monthly sales figure based on extended price for a specific month in a specific year, for manufacturers in a specific category in a given time zone. 
Group sales by manufacturer identifier and sort output by sales amount, by channel, and give Total sales */


WITH ss 
     AS (SELECT i_manufact_id, Sum(ss_ext_sales_price) total_sales_amt 
         FROM   store_sales, date_dim, customer_address,item 
         WHERE  i_manufact_id IN (SELECT i_manufact_id 
                                  FROM   item 
                                  WHERE  i_category IN ( 'Electronics' )) 
         AND ss_item_sk = i_item_sk 
         AND ss_sold_date_sk = d_date_sk
         AND ss_addr_sk = ca_address_sk
         AND ca_gmt_offset = -5
         AND d_moy = 5 
         AND d_year = 1998
         GROUP  BY i_manufact_id), 
     cs 
     AS (SELECT i_manufact_id, Sum(cs_ext_sales_price) total_sales_amt
         FROM   catalog_sales, date_dim, customer_address, item 
         WHERE  i_manufact_id IN (SELECT i_manufact_id 
                                  FROM   item 
                                  WHERE  i_category IN ( 'Electronics' )) 
         AND cs_item_sk = i_item_sk 
         AND cs_sold_date_sk = d_date_sk
         AND cs_bill_addr_sk = ca_address_sk
         AND ca_gmt_offset = -5
         AND d_moy = 5
         AND d_year = 1998 
         GROUP  BY i_manufact_id), 
     ws 
     AS (SELECT i_manufact_id, Sum(ws_ext_sales_price) total_sales_amt 
         FROM   web_sales, date_dim, customer_address, item 
         WHERE  i_manufact_id IN (SELECT i_manufact_id 
                                  FROM   item 
                                  WHERE  i_category IN ( 'Electronics' )) 
         AND ws_item_sk = i_item_sk 
         AND ws_sold_date_sk = d_date_sk
         AND ws_bill_addr_sk = ca_address_sk
         AND ca_gmt_offset = -5
         AND d_year = 1998  
         GROUP  BY i_manufact_id) 
         
SELECT i_manufact_id, Sum(total_sales_amt) total_sales_amt 
FROM   (SELECT * 
        FROM   ss 
        UNION ALL 
        SELECT * 
        FROM   cs 
        UNION ALL 
        SELECT * 
        FROM   ws) temp
GROUP  BY i_manufact_id 
ORDER  BY total_sales_amt
LIMIT 100;
