
CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
TRUNCATE TABLE silver.crm_cust_info;
insert into silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,cst_lastname,cst_marital_status,cst_gndr,cst_create_date
)
select distinct
cst_id,
cst_key,
trim(cst_firstname) as cst_firstname,
trim(cst_lastname) as cst_lastname,
case  when upper(trim(cst_marital_status)) = 'M' then 'Married' when upper(trim(cst_marital_status)) = 'S' then 'Single' ElSE 'N/A' END as cst_marital_status,
case when upper(trim(cst_gndr)) = 'F' THEN 'Female' when upper(trim(cst_gndr))='M' THEN 'Male' ELSE 'N/A' END as cst_gndr,
cst_create_date
from (
select *, ROW_NUMBER() over(partition by cst_id order by cst_create_date desc) as flag
from bronze.crm_cust_info
where cst_id is not null
)t where flag = 1




TRUNCATE TABLE silver.crm_prd_info;
insert into silver.crm_prd_info (
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
select 
prd_id,
replace(SUBSTRING(prd_key,1,5),'-','_') as cat_id,
substring(prd_key,7,len(prd_key)) as prd_key,
prd_nm,
ISNULL(prd_cost,0) as prd_cost,
case when upper(trim(prd_line)) = 'M' THEN 'Mountain' when upper(trim(prd_line)) = 'S' THEN 'Other Sales' when upper(trim(prd_line)) = 'R' THEN 'Road'
when upper(trim(prd_line)) = 'T' THEN 'Touring'
else 'N/A' ENd as prd_line,
prd_start_dt,
DATEADD(day, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt
from bronze.crm_prd_info

TRUNCATE TABLE silver.crm_sales_details;
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



TRUNCATE TABLE silver.erp_cust_az12;
insert into silver.erp_cust_az12(cid,bdate,gen)
SELECT case when cid like 'NAS%' then SUBSTRING(cid,4,len(cid)) else cid end as cid,
case when bdate > getdate() THEN null else BDATE end as bdate,
case when upper(trim(gen)) In ('F','Female') then 'Female'
     when upper(trim(gen)) In ('M','Male') then 'Male' else 'N/A'
end as gen
FROM bronze.erp_cust_az12



TRUNCATE TABLE silver.erp_loc_a101;
insert into silver.erp_loc_a101(cid,cntry)
select 
replace(cid,'-','') as cid,
case when trim(cntry) = 'DE' then 'Germany'
when trim(cntry) IN ('USA','US') then 'United States'
when trim(cntry) = '' or cntry is null then 'N/A'
else trim(cntry) end as cntry
from bronze.erp_loc_a101



TRUNCATE TABLE silver.erp_px_cat_g1v2;
insert into silver.erp_px_cat_g1v2(id,cat,SUBCAT,MAINTENANCE)
select id,cat,SUBCAT,MAINTENANCE from bronze.erp_px_cat_g1v2
END