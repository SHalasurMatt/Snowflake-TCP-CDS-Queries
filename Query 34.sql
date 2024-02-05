/*Display all customers with specific buy potentials and whose dependent count to vehicle count ratio is larger than 1.2, who in three consecutive years made purchases with 
between 15 and 20 items in the beginning or the end of each month in stores located in 8 counties.  */


SELECT c_last_name,c_first_name,c_preferred_cust_flag,ss_ticket_number,cnt 
FROM   (SELECT ss_ticket_number,ss_customer_sk,Count(*) cnt 
        FROM   store_sales,date_dim,store,household_demographics 
        WHERE  store_sales.ss_sold_date_sk = date_dim.d_date_sk 
        AND store_sales.ss_store_sk = store.s_store_sk 
        AND store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk 
        AND ( date_dim.d_dom BETWEEN 1 AND 3 OR date_dim.d_dom BETWEEN 15 AND 20 ) 
        AND ( household_demographics.hd_buy_potential = '>10000' OR household_demographics.hd_buy_potential = 'unknown' ) 
        AND household_demographics.hd_vehicle_count > 0 
        AND ( CASE WHEN household_demographics.hd_vehicle_count > 0 THEN household_demographics.hd_dep_count / household_demographics.hd_vehicle_count 
              ELSE NULL 
              END ) > 1.2 
        AND date_dim.d_year IN ( 1999, 1999 + 1, 1999 + 2 ) 
        AND store.s_county IN ( 'Williamson County') 
        GROUP  BY ss_ticket_number,ss_customer_sk) dn,customer 
WHERE  ss_customer_sk = c_customer_sk AND cnt BETWEEN 15 AND 20 
ORDER  BY c_last_name,c_first_name,c_salutation,c_preferred_cust_flag DESC;

