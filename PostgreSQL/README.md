# Table of Contents

1. **table_partitioning.sql**: Test file to `CREATE` and `INSERT` some test data on sample tables. The corresponding Linkedin Article can be found [here](https://www.linkedin.com/pulse/brief-introduction-postgresql-explain-swastik-gurung-hhuhc/). This script will create three tables, namely:

	- `department` table
	- `employee` table where `id` PK of `department` table references to `dept_id` FK of this table
	- `staff_expense` table where `id` PK of `employee` table references to `emp_id` FK of this table

To import the file simply use a `psql` terminal, such as:

```bash
psql table_partitioning < table_partitioning.sql
```
