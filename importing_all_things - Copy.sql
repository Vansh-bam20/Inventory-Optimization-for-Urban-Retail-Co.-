use project;

CREATE TABLE Products (
    product_id VARCHAR(10) PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE Stores (
    store_id VARCHAR(10) PRIMARY KEY,
    region VARCHAR(50)
);

CREATE TABLE Inventory_Facts (
    date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    demand_forecast DECIMAL(10, 2),
    PRIMARY KEY (date, store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE External_Factors (
    date DATE,
    store_id VARCHAR(10),
    product_id VARCHAR(10),
    discount INT,
    weather_condition VARCHAR(20),
    holiday_promotion BOOLEAN,
    competitor_pricing DECIMAL(10, 2),
    seasonality VARCHAR(20),
    PRIMARY KEY (date, store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/inventory_facts.csv'
INTO TABLE Inventory_Facts
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(date, store_id, product_id, inventory_level, units_sold, units_ordered, demand_forecast);

select * 
from inventory_forecasting;

 
select sum( Units_Sold) as total_un,Store_ID, Product_ID
from inventory_forecasting
group by Product_ID,Store_ID
