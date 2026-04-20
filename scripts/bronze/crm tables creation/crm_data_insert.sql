
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
TRUNCATE TABLE bronze.crm_cust_info;
BULK INSERT bronze.crm_cust_info 
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
)

TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
FIRSTROW =2,
FIELDTERMINATOR = ',',
TABLOCK
)

TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details 
FROM 'D:\SQL_Warehhouse_Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (FIRSTROW=2,FIELDTERMINATOR=',',TABLOCK)
END