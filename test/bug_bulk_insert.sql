-- Prévisualise les 400 premiers caractères "visibles"
SELECT TOP (1)
  REPLACE(REPLACE(CAST(BulkColumn AS NVARCHAR(400)), CHAR(13), '[CR]'), CHAR(10), '[LF]') AS preview
FROM OPENROWSET(
  BULK 'C:\Projet Data\warehouse_mma\dataset\event_details.csv',
  SINGLE_CLOB
) AS T;


-- 2A. On lit le fichier ligne par ligne dans une seule colonne (aucun parsing de colonnes)
CREATE TABLE #raw_lines (line NVARCHAR(MAX));

-- Essai 1 : LF
BULK INSERT #raw_lines
FROM 'C:\Projet Data\warehouse_mma\dataset\event_details.csv'
WITH (
  ROWTERMINATOR = '0x0a',           -- on teste LF
  FIELDTERMINATOR = '0x1F',         -- séparateur improbable, donc toute la ligne va dans 'line'
  CODEPAGE = '65001'
);
SELECT COUNT(*) AS rows_LF FROM #raw_lines;
TRUNCATE TABLE #raw_lines;
