
create view gold.dim_products as 
select 
row_number() over(order by prd_id) as s_no,
cr.prd_id as product_id,
cr.prd_key as product_number,
cr.prd_nm as product_name,
cr.cat_id as category_id,
cr.prd_cost as product_cost,
cr.prd_line as product_line,
cr.prd_start_dt as start_date,
er.cat as product_category,
er.SUBCAT,
er.MAINTENANCE
from silver.crm_prd_info cr
LEFT JOIN silver.erp_px_cat_g1v2 er ON cr.cat_id = er.id
where cr.prd_end_dt is null