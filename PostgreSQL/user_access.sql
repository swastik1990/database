-- create normal table
CREATE TABLE sales_order 
    (id integer, 
    order_no text, 
    customer text, 
    amount numeric, 
    order_region text, 
    order_date date, 
    CONSTRAINT id_pkey PRIMARY KEY (id));

-- insert some data
INSERT 
    INTO
    sales_order 
VALUES (generate_series(1, 100000),
    'SO' || generate_series(1, 100000)::text,
    (array['Ram Sharma', 'Bipin Karki', 'Hari Bastola', 'Swastik Gurung', 'ABC pvt. ltd.', 'Riwaz Ansari'])[floor(random() * 6 + 1)],
    10.00 + trunc(random() * 1000)::int,
    (array['Kathmandu', 'Pokhara', 'Nepalgunj', 'Chitwan'])[floor(random() * 4 + 1)],
    '2020-01-01'::date + trunc(random() * 365 * 4)::int);
    
-- create minimal_user
CREATE USER minimal_user WITH ENCRYPTED PASSWORD 'pass@123';

-- grant select on sales_order table
GRANT SELECT ON sales_order TO minimal_user;
