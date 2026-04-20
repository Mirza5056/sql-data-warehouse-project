
IF OBJECT_ID('bronze.erp_cust_az12','U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;
create table bronze.erp_cust_az12 (
CID varchar(50),
BDATE DATE,
GEN varchar(50)
)

IF OBJECT_ID('bronze.erp_loc_a101','U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
create table bronze.erp_loc_a101 (
CID varchar(50),
CNTRY varchar(50)
)

IF OBJECT_ID('bronze.erp_px_cat_g1v2','U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2 (
ID varchar(50),
CAT varchar(50),
SUBCAT varchar(50),
MAINTENANCE varchar(50)
)