/* Creating the database */

CREATE DATABASE sales_data;

USE sales_data;

/* I used the Table Data Import Wizard
to import each CSV. After the import,
I cleaned up column data types that initially
gave errors in the Import Wizard */

ALTER TABLE salespersons
MODIFY COLUMN salesperson_id INT,
MODIFY COLUMN first_name VARCHAR(50),
MODIFY COLUMN last_name	VARCHAR(50),
MODIFY COLUMN tenure_in_months DECIMAL(10,2),
MODIFY COLUMN location VARCHAR(10),
MODIFY COLUMN commission_rate DECIMAL(10,2);

ALTER TABLE customers
MODIFY COLUMN customer_id INT,
MODIFY COLUMN project_id INT,
MODIFY COLUMN  first_name VARCHAR(50),
MODIFY COLUMN last_name VARCHAR(50),
MODIFY COLUMN market VARCHAR(10);

ALTER TABLE projects
MODIFY COLUMN project_id INT,
MODIFY COLUMN customer_id INT,
MODIFY COLUMN salesperson_id INT,
MODIFY COLUMN location VARCHAR(10),
MODIFY COLUMN project_price DECIMAL(20,2),
MODIFY COLUMN project_cost DECIMAL (20,2),
MODIFY COLUMN scope_of_work VARCHAR(255),
MODIFY COLUMN build_status VARCHAR(25),
MODIFY COLUMN project_profit DECIMAL(20,2);

