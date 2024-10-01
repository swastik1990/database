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

4. **user_access.sql**: Test file to introduce the users with GRANT/REVOKE command in PostgreSQL. Upon successful execution of the SQL file, following will happen:

	- A new table `sales_order` is created on the current database, on public schema.
	- Sample data is populated on `sales_order` table.
	- A new user `minimal_user` is created with default privileges.
	- `GRANT` on `SELECT` for the `sales_order` table to the `minimal_user`.

To import the file simply use a `psql` terminal, such as:

```bash
psql pg_database < user_access.sql
```

Now, try accessing the database using the new user, and try executing `SELECT` `INSERT` `UPDATE` commands on `sales_order` table.

```bash
psql -h localhost -U minimal_user pg_database
```

> **_NOTE:_** The password for the db user `minimal_user` can be found inside the file `user_access.sql`, please use that or change it accordingly. Also, we need to use -h parameter to define the localhost, as peer authentication might not work if the connection is through unix socket, and the username is different.

To revoke the access, simply execute the following SQL command on the desired database:

```sql
REVOKE SELECT ON sales_order FROM minimal_user;
```
