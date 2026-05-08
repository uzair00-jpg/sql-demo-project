/*
===========================================================================
Strored Procedure :Load Bronze Layer (Source->bronze)
===============================================================================
Script purpose:
  This stored procedure loads data into the 'bronze' schema from external CSV files
  It performs the following actions:
  - truncates the bronze tables before loading data
  - Uses the 'bulk insert' command to load data from csv files to bronze tables
Paramters:
	None
	This stored procedure does not accept any parameters or return any values

Usage Example:
	Exec dbo.load_bronze
===================================================================================
*/
use DataWarehouse;
go
create or alter procedure dbo.load_bronze as
begin
	begin try
	declare @start_time DATETIME,@end_time DATETIME
	declare @start datetime,@end datetime
	set @start = GETDATE()
	print'===========================';
	print 'loading bronze layer';
	print'===========================';

	print '----------------------------------';
	print 'loading crm';
	print '----------------------------------';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.crm_cust_info'
	truncate table bronze.crm_cust_info
	PRINT 'INSERTING bronze.crm_cust_info'

	bulk insert bronze.crm_cust_info
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds'



	set @start_time = GETDATE();
	-- ok now inserting date from all files in same manner
	PRINT 'TRUNCATING bronze.crm_PRD_info'
	truncate table bronze.crm_prd_info
	PRINT 'INSERTING bronze.crm_prd_info'
	bulk insert bronze.crm_prd_info
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.crm_sales_deatils'
	truncate table bronze.crm_sales_details
	PRINT 'INSERTING bronze.crm_sales_deatils'
	bulk insert bronze.crm_sales_details
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.crm_PRD_info'
	truncate table bronze.crm_cust_info
	PRINT 'TRUNCATING bronze.crm_PRD_info'
	bulk insert bronze.crm_cust_info
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	print '----------------------------------';
	print 'loading erp';
	print '----------------------------------';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.erp_cust_az12'
	truncate table bronze.erp_cust_az12
	PRINT 'TRUNCATING bronze.erp_cust_az12'
	bulk insert bronze.erp_cust_az12
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 

	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.erp_loc_a101'
	truncate table bronze.erp_loc_a101
	PRINT 'TRUNCATING bronze.erp_loc_a101'
	bulk insert bronze.erp_loc_a101
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	set @start_time = GETDATE();
	PRINT 'TRUNCATING bronze.erp_px_cat_g1v2'
	truncate table bronze.erp_px_cat_g1v2
	PRINT 'TRUNCATING bronze.erp_px_cat_g1v2'
	bulk insert bronze.erp_px_cat_g1v2
	from 'C:\Sql_project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	with (
		FIRSTROW=2,
		FIELDTERMINATOR = ',',
		TABLOCK
	); 
	SET @end_time = GETDATE();
	PRINT 'LOAD DURATION:' + cast(DATEDIFF(SECOND,@start_time,@end_time) as nvarchar) + 'seconds';

	end try
	begin catch
		print '==========================';
		print 'eroror ocuured during loading bronze layer';
		print 'error message'  + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
		print '==========================';

	end catch
	set @end = GETDATE();
	PRINT 'LOAD DURATION for entire procedure:' + cast(DATEDIFF(SECOND,@start,@end) as nvarchar) + 'seconds';
end
go
