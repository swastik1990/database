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
VALUES (generate_series(1, 10000000),
    'SO' || generate_series(1, 10000000)::text,
    (array['Ram Sharma', 'Bipin Karki', 'Hari Bastola', 'Swastik Gurung', 'ABC pvt. ltd.', 'Riwaz Ansari'])[floor(random() * 6 + 1)],
    10.00 + trunc(random() * 1000)::int,
    (array['Kathmandu', 'Pokhara', 'Nepalgunj', 'Chitwan'])[floor(random() * 4 + 1)],
    '2020-01-01'::date + trunc(random() * 365 * 4)::int);

-- create a table, partitioned using list    
CREATE TABLE sales_order_list
    (id integer,
    order_no text,
    customer text,
    amount numeric,
    order_region text,
    order_date date,
    CONSTRAINT id_order_region_pk PRIMARY KEY (id, order_region)) PARTITION BY LIST (order_region);

-- partition for order_region 'Kathmandu'
CREATE TABLE sales_order_list_p1 PARTITION OF sales_order_list FOR VALUES IN ('Kathmandu');

-- partition for order_region 'Pokhara'
CREATE TABLE sales_order_list_p2 PARTITION OF sales_order_list FOR VALUES IN ('Pokhara');

-- partition for order_region 'Nepalgunj'
CREATE TABLE sales_order_list_p3 PARTITION OF sales_order_list FOR VALUES IN ('Nepalgunj');

-- partition for order_region 'Chitwan'
CREATE TABLE sales_order_list_p4 PARTITION OF sales_order_list FOR VALUES IN ('Chitwan');

-- default partition for list
CREATE TABLE sales_order_list_default PARTITION OF sales_order_list DEFAULT;

\echo 'List partitioned Table and its partitions has been created.'

-- copy data from main table
INSERT INTO sales_order_list SELECT * FROM sales_order;

\echo 'Data copied into List partitioned Table.'

-- create a table, partitioned using range
CREATE TABLE sales_order_range
    (id integer,
    order_no text,
    customer text,
    amount numeric,
    order_region text,
    order_date date,
    CONSTRAINT id_order_date_pk PRIMARY KEY (id, order_date)) PARTITION BY RANGE (order_date);

-- partition for order_date between '2020-01-01' and '2021-01-01'
CREATE TABLE sales_order_range_p1 PARTITION OF sales_order_range FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

-- partition for order_date between '2021-01-01' and '2022-01-01'
CREATE TABLE sales_order_range_p2 PARTITION OF sales_order_range FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

-- partition for order_date between '2022-01-01' and '2023-01-01'
CREATE TABLE sales_order_range_p3 PARTITION OF sales_order_range FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

-- partition for order_date between '2023-01-01' and '2024-01-01'
CREATE TABLE sales_order_range_p4 PARTITION OF sales_order_range FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- default partition for range
CREATE TABLE sales_order_range_default PARTITION OF sales_order_range DEFAULT;

\echo 'Range partitioned Table and its partitions has been created.'

-- copy data from main table
INSERT INTO sales_order_range SELECT * FROM sales_order;

\echo 'Data copied into Range partitioned Table.'

-- create a table, partitioned using hash
CREATE TABLE sales_order_hash
    (id integer,
    order_no text,
    customer text,
    amount numeric,
    order_region text,
    order_date date,
    CONSTRAINT id_customer_pk PRIMARY KEY (id, customer)) PARTITION BY HASH (customer);
    
-- partition for hash value of customer, with remainder 0
CREATE TABLE sales_order_hash_p1 PARTITION OF sales_order_hash FOR VALUES WITH (MODULUS 4, REMAINDER 0);

-- partition for hash value of customer, with remainder 1
CREATE TABLE sales_order_hash_p2 PARTITION OF sales_order_hash FOR VALUES WITH (MODULUS 4, REMAINDER 1);

-- partition for hash value of customer, with remainder 2
CREATE TABLE sales_order_hash_p3 PARTITION OF sales_order_hash FOR VALUES WITH (MODULUS 4, REMAINDER 2);

-- partition for hash value of customer, with remainder 3
CREATE TABLE sales_order_hash_p4 PARTITION OF sales_order_hash FOR VALUES WITH (MODULUS 4, REMAINDER 3);

\echo 'Hash partitioned Table and its partitions has been created.'

-- copy data from main table
INSERT INTO sales_order_hash SELECT * FROM sales_order;

\echo 'Data copied into Hash partitioned Table.'
