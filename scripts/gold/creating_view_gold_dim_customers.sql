
CREATE VIEW gold.dim_customers as
select 
row_number() over (order by cst_id) as customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
case when ci.cst_gndr != 'N/A' THEN ci.cst_gndr ELSE COALESCE(ca.gen,'') END as gender,
ci.cst_marital_status as  marital_status,
la.CNTRY as country,
ca.BDATE as birthdate,
ci.cst_create_date as create_date
from
silver.crm_cust_info ci 
LEFT JOIN silver.erp_cust_az12 ca ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la  ON ci.cst_key = la.cid