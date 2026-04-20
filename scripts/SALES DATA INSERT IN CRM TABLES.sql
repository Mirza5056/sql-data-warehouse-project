
INSERT INTO silver.crm_sales_details (
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_quantity,
sls_sales,
sls_price
)
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 OR len(sls_order_dt) != 8 THEN NULL ELSE CAST(sls_order_dt as DATE) END as sls_order_dt,
case when sls_ship_dt = 0 OR len(sls_ship_dt) != 8 THEN NULL ELSE CAST(sls_ship_dt as DATE) END as sls_ship_dt,
case when sls_due_dt = 0 OR len(sls_due_dt) != 8 THEN NULL ELSE CAST(sls_due_dt AS DATE) END As sls_due_dt,
sls_quantity,
case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity*ABS(sls_price)
then sls_quantity * ABS(sls_price)
Else sls_sales
end as sls_sales,
case when sls_price is null or sls_price <= 0
then sls_sales / nullif(sls_quantity,0) else sls_price end as sls_price
from 
bronze.crm_sales_details