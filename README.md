# Snowflake-TPC-DS-Queries

TPC-DS models the decision support functions of a retail product supplier. The supporting schema contains vital business information, such as customer, order, and product data.

In order to address the enormous range of query types and user behaviors encountered by a decision support system, TPC-DS utilizes a generalized query model. This model allows the benchmark to capture important aspects of the interactive, iterative nature of on-line analytical processing (OLAP) queries, the longer-running complex queries of data mining and knowledge discovery, and the more planned behavior of well known report queries.”

Database and Schemas

Snowflake provides both 10 TB and 100 TB versions of TPC-DS, in schemas named TPCDS_SF10TCL and TPCDS_SF100TCL, respectively, within the SNOWFLAKE_SAMPLE_DATA shared database

Database Entities, Relationships, and Characteristics

TPC-DS consists of 7 fact tables and 17 dimensions in the following schemas:

TPCDS_SF10TCL: The 10 TB (scale factor 10,000) version represents 65 million customers and over 400,000 items stored, with sales data spanning 3 channels — stores, catalogs, and the web — covering a period of 5 years. The largest table, STORE_SALES, contains nearly 29 billion rows, and the fact tables contain over 56 billion rows in total.
