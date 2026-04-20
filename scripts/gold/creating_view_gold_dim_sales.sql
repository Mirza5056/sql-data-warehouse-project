


create view gold.fact_sales as 
select 
row_number() over (order by sls_ord_num) as order_sno,
sd.sls_ord_num as order_num,
dp.product_key,
cu.customer_key,
sd.sls_cust_id,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_quantity as quantity,
sd.sls_price as price,
sd.sls_sales as sales_amount
from silver.crm_sales_details sd
LEFT JOIN gold.dim_products dp ON sd.sls_prd_key = dp.product_key
LEFT JOIN gold.dim_customers cu ON sd.sls_cust_id = cu.customer_id

