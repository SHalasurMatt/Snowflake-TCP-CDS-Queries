/*QUERY 35: For the groups of customers living in the same state, having the same gender and marital status who have purchased from stores and from either the catalog or the web during a given year, display the following: state, gender, marital status, count of customers  min, max, avg, count distinct of the customer’s dependent count  min, max, avg, count distinct of the customer’s employed dependent count  min, max, avg, count distinct of the customer’s dependents in college count  Display / calculate the “count of customers” multiple times to emulate a potential reporting tool scenario */



SELECT ca_state,cd_gender,cd_marital_status, cd_dep_count, 
       Count(*) cnt1,Stddev_samp(cd_dep_count),Avg(cd_dep_count),Max(cd_dep_count),cd_dep_employed_count, 
       Count(*) cnt2,Stddev_samp(cd_dep_employed_count),Avg(cd_dep_employed_count),Max(cd_dep_employed_count),cd_dep_college_count, 
       Count(*) cnt3,Stddev_samp(cd_dep_college_count),Avg(cd_dep_college_count),Max(cd_dep_college_count) 
FROM   customer c,customer_address ca,customer_demographics 
WHERE  c.c_current_addr_sk = ca.ca_address_sk 
       AND cd_demo_sk = c.c_current_cdemo_sk 
       AND EXISTS (SELECT * 
                   FROM   store_sales,date_dim 
                   WHERE  c.c_customer_sk = ss_customer_sk 
                   AND ss_sold_date_sk = d_date_sk 
                   AND d_year = 2002) 
       AND ( EXISTS (SELECT * 
                     FROM   web_sales,date_dim 
                     WHERE  c.c_customer_sk = ws_bill_customer_sk 
                     AND ws_sold_date_sk = d_date_sk 
                     AND d_year = 2002) 
              OR EXISTS (SELECT * 
                         FROM   catalog_sales,date_dim 
                         WHERE  c.c_customer_sk = cs_ship_customer_sk 
                         AND cs_sold_date_sk = d_date_sk 
                         AND d_year = 2002)) 
GROUP  BY ca_state, cd_gender, cd_marital_status,cd_dep_count, cd_dep_employed_count,cd_dep_college_count 
ORDER  BY ca_state, cd_gender, cd_marital_status,cd_dep_count, cd_dep_employed_count,cd_dep_college_count;


