use master
use SQLDataWarehouse
select * from bronze.crm_sales_details 


select id,count(*) from bronze.erp_px_cat_g1v2 
group by id having count(*) > 1


select *,
lead(prd_start_dt) over(partition by prd_key order by prd_start_dt)-1 as test 
from bronze.crm_prd_info  
where prd_key in('AC-HE-HL-U509-R','AC-HE-HL-U509')

SELECT *,
       DATEADD(day, -1, LEAD(prd_start_dt) 
           OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS test
FROM bronze.crm_prd_info
WHERE prd_key IN ('AC-HE-HL-U509-R','AC-HE-HL-U509');


select * from bronze.erp_px_cat_g1v2

select sls_ship_dt from bronze.crm_sales_details where len(sls_ship_dt) != 8 or sls_ship_dt < 19001210

select cast(sls_order_dt as  DATE) as sls_order_dt from bronze.crm_sales_details 
where sls_prd_key not in
(select prd_key from silver.crm_prd_info)


select sls_sales,sls_quantity,sls_price,
case when sls_quantity * sls_price =sls_sales then 1 else 0 end as issue
from bronze.crm_sales_details 

select sls_sales as old_sls_price,sls_quantity,sls_price as old_sls_price,

case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity*ABS(sls_price)
then sls_quantity * ABS(sls_price)
Else sls_sales
end as sls_sales,
case when sls_price is null or sls_price <= 0
then sls_sales / nullif(sls_quantity,0) else sls_price end as sls_price

from bronze.crm_sales_details where sls_price <=0 or sls_price is null or sls_quantity<=0 or sls_quantity is null or sls_sales <= 0 or sls_sales is null
order by sls_sales,sls_quantity,sls_price

select top 2* from bronze.erp_cust_az12





select distinct gen,
case when upper(trim(gen)) In ('F') then 'Female'
     when upper(trim(gen)) In ('M') then 'Male' else 'N/A'
end as gen
from bronze.erp_cust_az12


select * from silver.crm_cust_info

select * from bronze.crm_cust_info

 where MAINTENANCE != trim(MAINTENANCE)

where id in(
select cat_id from silver.crm_prd_info)

select top 2* from silver.crm_cust_info

select top 2* from bronze.erp_px_cat_g1v2