-- Table Department
-- CREATE TABLE
CREATE TABLE public.department (
	id serial4 NOT NULL,
	"name" varchar NULL,
	CONSTRAINT dep_id_pk PRIMARY KEY (id),
	CONSTRAINT dep_name_uniq UNIQUE (name)
);

-- INSERT INTO TABLE
INSERT INTO public.department (name) VALUES ('admin'),('hr'),('sales'),('operation');

-- SELECT TABLE
SELECT COUNT(*) FROM public.department;


-- Table Employee
-- CREATE TABLE
CREATE TABLE public.employee (
	id serial4 NOT NULL,
	"name" varchar NULL,
	dob date NULL,
	dept_id int4 NOT NULL,
	CONSTRAINT emp_id_pk PRIMARY KEY (id),
	CONSTRAINT emp_dept_fkey FOREIGN KEY (dept_id) REFERENCES public.department(id) ON DELETE RESTRICT
);

-- INSERT INTO TABLE
INSERT INTO public.employee (name, dob, dept_id) VALUES
('Ram Sharma','2000-10-12',1), 
('Bipin Karki','1956-08-22',2), 
('Swastik Gurung','1983-07-03',3), 
('Christopher J. Date','1975-10-01',4), 
('Brian K. Harvey','1980-10-01',4);

-- SELECT TABLE
SELECT COUNT(*) FROM public.employee;


-- Table Staff Expense
-- CREATE TABLE
CREATE TABLE public.staff_expense (
	id serial4 NOT NULL,
	"name" varchar NOT NULL,
	expense_date date NULL,
	emp_id int4 NOT NULL,
	amount float NOT NULL,
	CONSTRAINT staff_expense_pk PRIMARY KEY (id),
	CONSTRAINT staff_emp_fkey FOREIGN KEY (emp_id) REFERENCES public.employee(id) ON DELETE RESTRICT
);

-- INSERT INTO TABLE
INSERT INTO public.staff_expense (name,expense_date,emp_id,amount) VALUES (
				(array['Canteen Lunch', 'Visit to Client', 'Fuel Expense', 'First Aid'])[floor(random() * 4 + 1)],
				(array['2020-10-23', '2021-01-01', '2022-01-10', '2023-01-15', '2023-02-02'])[floor(random() * 5 + 1)]::date,
				floor(random() * 5 + 1)::int,
				generate_series(1,50000,0.25)
				);

-- SELECT TABLE
SELECT COUNT(*) FROM public.staff_expense;
