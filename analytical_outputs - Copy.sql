-- analytical outputs 
-- Fast-Selling vs. Slow-Moving Products (Binary Classification) Based on Total Units Sold vs. Total Inventory
SELECT 
    i.Product_ID,
    i.Store_ID,
    SUM(COALESCE(i.Units_Sold, 0)) AS Total_Units_Sold,
    SUM(COALESCE(i.Inventory_Level, 0)) AS Total_Inventory,
    ABS(SUM(COALESCE(i.Units_Sold, 0)) - SUM(COALESCE(i.Inventory_Level, 0))) / NULLIF(SUM(COALESCE(i.Inventory_Level, 0)), 0) * 100 AS Percent_Difference,
    CASE 
        WHEN ABS(SUM(COALESCE(i.Units_Sold, 0)) - SUM(COALESCE(i.Inventory_Level, 0))) / NULLIF(SUM(COALESCE(i.Inventory_Level, 0)), 0) * 100 <= 34 THEN 'Fast-Moving'
        ELSE 'Slow-Moving'
    END AS Product_Category
FROM inventory_forecasting i
GROUP BY i.Product_ID, i.Store_ID
HAVING SUM(COALESCE(i.Inventory_Level, 0)) > 0 AND SUM(COALESCE(i.Units_Sold, 0)) > 0
ORDER BY Percent_Difference;




WITH ProductAverages AS (
    SELECT 
        Product_ID,
        AVG(COALESCE(Inventory_Level, 0)) AS Avg_Inventory
    FROM inventory_forecasting
    GROUP BY Product_ID
),
LowInventoryEvents AS (
    SELECT 
        i.Product_ID,
        i.Store_ID,
        COUNT(*) AS Low_Inventory_Count,
        SUM(CASE WHEN i.Inventory_Level < 50 THEN 1 ELSE 0 END) AS Below_50_Count,
        SUM(COALESCE(i.Units_Sold, 0)) AS Total_Units_Sold,
        AVG(COALESCE(i.Inventory_Level, 0)) AS Avg_Inventory_Per_Store
    FROM inventory_forecasting i
    JOIN ProductAverages p ON i.Product_ID = p.Product_ID
    WHERE i.Inventory_Level < p.Avg_Inventory * 0.1
       OR i.Inventory_Level < p.Avg_Inventory * 0.2
       OR i.Inventory_Level < 50
    GROUP BY i.Product_ID, i.Store_ID
)
SELECT 
    lie.Product_ID,
    lie.Store_ID,
    lie.Low_Inventory_Count,
    lie.Below_50_Count,
    lie.Total_Units_Sold,
    lie.Avg_Inventory_Per_Store,
    p.Avg_Inventory AS Avg_Inventory_Per_Product,
    p.Avg_Inventory * 0.2 AS Reorder_Point_20,
    CASE 
        WHEN lie.Low_Inventory_Count > 5 AND lie.Total_Units_Sold / NULLIF(lie.Avg_Inventory_Per_Store, 0) > 1 THEN 'Fast-Moving'
        ELSE 'Slow-Moving'
    END AS Product_Category
FROM LowInventoryEvents lie
JOIN ProductAverages p ON lie.Product_ID = p.Product_ID
ORDER BY lie.Product_ID, lie.Store_ID;
