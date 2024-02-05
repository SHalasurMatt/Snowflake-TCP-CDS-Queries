/*Compute the total discounted amount for a particular manufacturer in a particular 90 day period for catalog sales whose discounts exceeded the average discount by at least 30%.*/ 

SELECT Sum(cs_ext_discount_amt) AS extra_disc_amt
FROM   catalog_sales ,item , date_dim 
WHERE  i_item_sk = cs_item_sk 
AND    d_date_sk = cs_sold_date_sk
AND    d_date BETWEEN '2000-01-27' AND ( Cast('2000-01-27' AS DATE) + INTERVAL '90 days')
AND    i_manufact_id = 977
AND    cs_ext_discount_amt > 
       (SELECT 1.3 * avg(cs_ext_discount_amt)
        FROM   catalog_sales , date_dim 
        WHERE  cs_item_sk = i_item_sk
        AND    d_date_sk = cs_sold_date_sk
        AND    d_date BETWEEN '2000-01-27' AND ( Cast('2000-01-27' AS DATE) + INTERVAL '90 days'));
