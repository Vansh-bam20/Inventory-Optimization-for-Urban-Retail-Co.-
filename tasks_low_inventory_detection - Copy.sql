use project;
-- Calculate total stock levels across stores and regions
SELECT 
    Region,
    Store_ID,
    SUM(Inventory_Level) AS Total_Stock
FROM inventory_forecasting
GROUP BY Region, Store_ID
WITH ROLLUP;

-- Revised low inventory detection with flexible thresholds and debugging
WITH ProductAverages AS (
    SELECT 
        Product_ID,
        AVG(COALESCE(Inventory_Level, 0)) AS Avg_Inventory
    FROM inventory_forecasting
    GROUP BY Product_ID
)
SELECT 
    i.Product_ID,
    i.Store_ID,
    i.Date,
    i.Inventory_Level,
    p.Avg_Inventory AS Avg_Inventory_Per_Product,
    p.Avg_Inventory * 0.1 AS Reorder_Point_10,
    p.Avg_Inventory * 0.2 AS Reorder_Point_20,
    50 AS Fixed_Reorder_Point
FROM inventory_forecasting i
JOIN ProductAverages p ON i.Product_ID = p.Product_ID
WHERE i.Inventory_Level < p.Avg_Inventory * 0.1  -- 10% threshold
   OR i.Inventory_Level < p.Avg_Inventory * 0.2    -- 20% threshold
   OR i.Inventory_Level < 50                      -- Fixed threshold
ORDER BY i.Product_ID, i.Store_ID, i.Date DESC;

-- revised low inventory detection 
-- Revised low inventory detection with flexible thresholds and debugging
WITH ProductAverages AS (
    SELECT 
        Product_ID,
        AVG(COALESCE(Inventory_Level, 0)) AS Avg_Inventory
    FROM inventory_forecasting
    GROUP BY Product_ID
)
SELECT 
    i.Product_ID,
    i.Store_ID,
    i.Date,
    i.Inventory_Level,
    p.Avg_Inventory AS Avg_Inventory_Per_Product,
    p.Avg_Inventory * 0.1 AS Reorder_Point_10,
    p.Avg_Inventory * 0.2 AS Reorder_Point_20,
    50 AS Fixed_Reorder_Point
FROM inventory_forecasting i
JOIN ProductAverages p ON i.Product_ID = p.Product_ID
WHERE i.Inventory_Level < p.Avg_Inventory * 0.1  -- 10% threshold
   OR i.Inventory_Level < p.Avg_Inventory * 0.2    -- 20% threshold
   OR i.Inventory_Level < 50                      -- Fixed threshold
ORDER BY i.Product_ID, i.Store_ID, i.Date DESC;

-- Inventory Turnover Analysis
SELECT 
    i.Product_ID,
    i.Store_ID,
    MIN(i.Date) AS Start_Date,
    MAX(i.Date) AS End_Date,
    SUM(COALESCE(i.Units_Sold, 0)) AS Total_Units_Sold,
    AVG(COALESCE(i.Inventory_Level, 0)) AS Avg_Inventory,
    ROUND(SUM(COALESCE(i.Units_Sold, 0)) / NULLIF(AVG(COALESCE(i.Inventory_Level, 0)), 0), 2) AS Inventory_Turnover_Ratio
FROM inventory_forecasting i
GROUP BY i.Product_ID, i.Store_ID
HAVING SUM(COALESCE(i.Units_Sold, 0)) > 0 AND AVG(COALESCE(i.Inventory_Level, 0)) > 0
ORDER BY i.Product_ID, i.Store_ID;


