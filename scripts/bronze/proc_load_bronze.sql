/*
===========================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
===========================================================

Script purpose :
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It truncates existing bronze tables and reloads them from CSV files.
===========================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze 
AS 
BEGIN
  SET NOCOUNT ON;

  DECLARE @start DATETIME = GETDATE(), @end DATETIME;
  DECLARE @rows INT;

  PRINT '=====================================';
  PRINT 'Loading Bronze Layer';
  PRINT '=====================================';

  -------------------------------------------------------------
  -- ufcstat_event_details  (LF, UTF-8)
  -------------------------------------------------------------
  BEGIN TRY
    PRINT '>> Truncating: bronze.ufcstat_event_details';
    TRUNCATE TABLE bronze.ufcstat_event_details;

    PRINT '>> Inserting: bronze.ufcstat_event_details';
    BULK INSERT bronze.ufcstat_event_details
    FROM 'C:\Projet Data\warehouse_mma\dataset\event_details.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ';',
      FIELDQUOTE = '"',
      ROWTERMINATOR = '0x0a',    -- LF (même que fight_details)
      CODEPAGE = '65001',
      TABLOCK
    );
    SET @rows = @@ROWCOUNT;
    PRINT '>> OK: event_details - rows inserted = ' + CAST(@rows AS NVARCHAR(20));
  END TRY
  BEGIN CATCH
    PRINT 'ERREUR sur event_details: ' + ERROR_MESSAGE();
    RETURN;
  END CATCH;

  -------------------------------------------------------------
  -- ufcstat_fight_details  (LF, UTF-8)
  -------------------------------------------------------------
  BEGIN TRY
    PRINT '>> Truncating: bronze.ufcstat_fight_details';
    TRUNCATE TABLE bronze.ufcstat_fight_details;

    PRINT '>> Inserting: bronze.ufcstat_fight_details';
    BULK INSERT bronze.ufcstat_fight_details
    FROM 'C:\Projet Data\warehouse_mma\dataset\fight_details.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ',',
      FIELDQUOTE = '"',
      ROWTERMINATOR = '0x0a',
      CODEPAGE = '65001',
      TABLOCK
    );
    SET @rows = @@ROWCOUNT;
    PRINT '>> OK: fight_details - rows inserted = ' + CAST(@rows AS NVARCHAR(20));
  END TRY
  BEGIN CATCH
    PRINT 'ERREUR sur fight_details: ' + ERROR_MESSAGE();
    RETURN;
  END CATCH;

  -------------------------------------------------------------
  -- ufcstat_fighter_details  (LF, UTF-8)
  -------------------------------------------------------------
  BEGIN TRY
    PRINT '>> Truncating: bronze.ufcstat_fighter_details';
    TRUNCATE TABLE bronze.ufcstat_fighter_details;

    PRINT '>> Inserting: bronze.ufcstat_fighter_details';
    BULK INSERT bronze.ufcstat_fighter_details
    FROM 'C:\Projet Data\warehouse_mma\dataset\fighter_details.csv'
    WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR = ';',
      FIELDQUOTE = '"',
      ROWTERMINATOR = '0x0a',
      CODEPAGE = '65001',
      TABLOCK
    );
    SET @rows = @@ROWCOUNT;
    PRINT '>> OK: fighter_details - rows inserted = ' + CAST(@rows AS NVARCHAR(20));
  END TRY
  BEGIN CATCH
    PRINT 'ERREUR sur fighter_details: ' + ERROR_MESSAGE();
    RETURN;
  END CATCH;

  -------------------------------------------------------------
  -- Fin
  -------------------------------------------------------------
  SET @end = GETDATE();
  PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @start, @end) AS NVARCHAR(20)) + ' seconds';
END
GO
