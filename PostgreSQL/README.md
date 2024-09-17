# Table of Contents

1. **sample_data.sql**: Test file to `CREATE` and `INSERT` some test data on sample tables. The corresponding Linkedin Article can be found [here](https://www.linkedin.com/pulse/brief-introduction-postgresql-explain-swastik-gurung-hhuhc/). This script will create three tables, namely:

	- `department` table
	- `employee` table where `id` PK of `department` table references to `dept_id` FK of this table
	- `staff_expense` table where `id` PK of `employee` table references to `emp_id` FK of this table

To import the file simply use a `psql` terminal, such as:

```bash
psql pg_database < sample_data.sql
```

2. **postgresql_monitoring.sql**: Test file to monitor some statistics of the Database Server, consisting of:

	- List of TOP 10 Databases with sizes, sorted in descending order **(Global)**
	- List of TOP 10 Relations *(Tables)* with sizes, sorted in descending order **(Current database)**
	- Total percentage of Sequential Scan vs. Index Scan **(Current database)**
	- Number of current db connections, grouped by `state` and `backend_type` **(Global)**
	- Percentage of parameter `max_connections` being currently used **(Global)**
	- Cache Hit Ration **(Current database)**
	- Index Cache Hit Ratio **(Current database)**
	- Top 10 Table with index usage **(Current database)**
	- Transaction Committed Percentage **(Global)**
	- Transaction Rollback Percentage **(Global)**
	- Total number of transactions executed *(commits & rollbacks)* **(Global)**

The corresponding GitHub gist can be found [here](https://gist.github.com/swastik1990/3304be0514afdec8fb60bd1bbb5a09aa).

To execute the SQL commands against a database, simply import the sql file using a `psql` terminal:

```bash
psql postgres < postgresql_monitoring.sql
```

> **_NOTE:_** In the above sql, postgres is the name of the database being used. Please change it accordingly, before executing the command.

3. **table_partitioning.sql**: Test file for table partitioning in PostgreSQL. The corresponding Linkedin Article can be found [here](https://www.linkedin.com/pulse/table-partitioning-postgresql-swastik-gurung/). Creates following table with some test data:

	- `sales_order` A base table, without partitioning.
	- `sales_order_list` Table partitioned by list.
	- `sales_order_range` Table partitioned by range.
	- `sales_order_hash` Table partitioned by hash.

To import the file simply use a `psql` terminal, such as:

```bash
psql pg_database < table_partitioning.sql
```

> **_NOTE:_** Inside the sql script, we haven't define a DEFAULT partition for Hash, as we won't have any out-of-range data with Hash Partitioning.
