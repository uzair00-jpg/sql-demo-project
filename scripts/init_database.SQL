-- step 1
use master;

create database DataWarehouse;

use DataWarehouse; 

create schema bronze;

create schema silver;

create schema gold;



step 2

  use DataWarehouse;
if object_id('bronze.crm_cust_info','U') is not null
	DROP TABLE bronze.crm_cust_info;
create table bronze.crm_cust_info(
	cst_id int,
	cst_key nvarchar(50),
	cst_firstname nvarchar(50),
	cst_lastname nvarchar(50),
	cst_material_status nvarchar(50),
	cst_gndr nvarchar(50),
	cst_create_date DATE
);
if object_id('bronze.crm_prd_info','U') is not null
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(100),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);
if object_id('bronze.crm_sales_details','U') is not null
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt NVARCHAR(8),
    sls_ship_dt NVARCHAR(8),
    sls_due_dt NVARCHAR(8),
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);
if object_id('bronze.erp_cust_az12','U') is not null
	DROP TABLE bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
	cid nvarchar(50),
	bdate date,
	gen nvarchar(50)
);
if object_id('bronze.erp_loc_a101','U') is not null
	DROP TABLE bronze.erp_loc_a101;
create table bronze.erp_loc_a101(
	cid nvarchar(50),
	cntry nvarchar(50)
);
if object_id('bronze.erp_px_cat_g1v2','U') is not null
	DROP TABLE bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(
	id nvarchar(50),
	cat nvarchar(50),
	subcat nvarchar(50),
	maintenance nvarchar(50)
);
