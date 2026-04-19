
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
WITH (
FIRSTROW =2,
FIELDTERMINATOR=',',
TABLOCK
)

TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
WITH (
FIRSTROW =2,
FIELDTERMINATOR=',',
TABLOCK
)

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
WITH (
FIRSTROW =2,
FIELDTERMINATOR=',',
TABLOCK
)
END