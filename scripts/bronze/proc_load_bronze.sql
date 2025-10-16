/*
===========================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
===========================================================

Script purpose :
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	It performs the following actions :
	- Truncates the bronze tables before loading data
	- Uses the 'BULK INSERT' command to load data from csv Files to bronze tables

	Parameters : 
	None.
	This stored procedure does not accept any parameters or return any values.

	Usage example:
	EXEC bronze.load_bronze;
===========================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS 
BEGIN
    DECLARE @start_time DATETIME = GETDATE(), @end_time DATETIME;
    BEGIN TRY
        PRINT '=====================================';
        PRINT 'Loading Bronze Layer';
        PRINT '=====================================';
        -- -------------------------------
        -- event_details
        -- -------------------------------
        PRINT '>> Truncating: bronze.ufcstat_event_details';
        TRUNCATE TABLE bronze.ufcstat_event_details;

        PRINT '>> Inserting: bronze.ufcstat_event_details';
        BULK INSERT bronze.ufcstat_event_details
        FROM 'C:\Users\trist\Projet Data\warehouse_mma\dataset\event_details.csv'
        WITH (
              FIRSTROW = 2,
              FIELDTERMINATOR = ',',
              FIELDQUOTE = '"',
              ROWTERMINATOR = '0x0a',  
              TABLOCK
        );
        PRINT '>> OK: event_details';

        -- -------------------------------
        -- fight_details
        -- -------------------------------
        PRINT '>> Truncating: bronze.ufcstat_fight_details';
        TRUNCATE TABLE bronze.ufcstat_fight_details;

        PRINT '>> Inserting: bronze.ufcstat_fight_details';
        BULK INSERT bronze.ufcstat_fight_details
        FROM 'C:\Users\trist\Projet Data\warehouse_mma\dataset\fight_details.csv'
        WITH (
              FIRSTROW = 2,
              FIELDTERMINATOR = ',',
              FIELDQUOTE = '"',
              -- CODEPAGE = '65001',
              ROWTERMINATOR = '0x0a',
              TABLOCK
        );
        PRINT '>> OK: fight_details';

        -- -------------------------------
        -- fighter_details
        -- -------------------------------
        PRINT '>> Truncating: bronze.ufcstat_fighter_details';
        TRUNCATE TABLE bronze.ufcstat_fighter_details;

        PRINT '>> Inserting: bronze.ufcstat_fighter_details';
        BULK INSERT bronze.ufcstat_fighter_details
        FROM 'C:\Users\trist\Projet Data\warehouse_mma\dataset\fighter_details.csv'
        WITH (
              FIRSTROW = 2,
              FIELDTERMINATOR = ',',
              FIELDQUOTE = '"',
              -- CODEPAGE = '65001',
              ROWTERMINATOR = '0x0a',
              TABLOCK
        );
        PRINT '>> OK: fighter_details';

        SET @end_time = GETDATE();
        PRINT '>> Total Load Duration: ' 
              + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) 
              + ' seconds';
    END TRY
    BEGIN CATCH
        PRINT '===== ERROR DURING BRONZE LOAD =====';
        PRINT 'Message: ' + ERROR_MESSAGE();
        PRINT 'Number : ' + CAST(ERROR_NUMBER() AS NVARCHAR(20));
        PRINT '====================================';
    END CATCH
END
GO
