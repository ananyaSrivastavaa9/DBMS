# Database Management System (DBMS) Lab

This repository contains the practical work completed as part of the Database Management System (DBMS) laboratory course.

The repository covers ER diagram design, relational schema implementation, SQL queries, joins, subqueries, views, recursive queries, stored procedures, triggers, and integrity constraints using MySQL.

## Experiments

### Experiment 1: ER Diagram Design
Designed an Entity-Relationship (ER) diagram for an Indian e-commerce platform involving Customer, Product, Order, OrderItem, Seller, Category, Payment, Delivery, and Address entities.

The design covers:
- Primary keys and composite keys
- Multivalued attributes
- Weak entities
- Product specialization
- Participation constraints

**File:** `Experiment1/Experiment1.pdf`

### Experiment 2: Relational Schema and Constraints
Converted an ER diagram into a relational schema and implemented it using MySQL CREATE TABLE statements.

Topics covered:
- Primary and foreign keys
- NOT NULL and UNIQUE constraints
- ON DELETE CASCADE
- ON DELETE SET NULL
- Sample data insertion
- Referential integrity violations

**File:** `Experiment2/Experiment2.pdf`

### Experiment 3: SQL Fundamentals and Database Operations
Created and populated relational tables using SQL and practised database operations through SQL queries.

**Files:** `Experiment3/`

### Experiment 4: Joins, Subqueries, and Query Analysis
Practised INNER JOIN, LEFT JOIN, SELF JOIN, three-way joins, correlated subqueries, EXISTS, simulated INTERSECT and EXCEPT operations, and query execution plan analysis using EXPLAIN.

**Files:** `Experiment4/`

### Experiment 5: Views and Recursive Queries
Created SQL views for department salary summaries and employee hierarchy, explored view updatability, and used recursive Common Table Expressions (CTEs) to retrieve employee reporting hierarchies.

**Files:** `Experiment5/`

### Experiment 6: Stored Procedures, Triggers, and Validation
Implemented a stored procedure for employee department transfers with validation and error handling. Created salary validation triggers and audit logging to demonstrate database integrity and controlled data modification.

**Files:** `Experiment6/`

## Technologies Used

- MySQL
- SQL
- Entity-Relationship (ER) Modelling
- Relational Database Design

## Repository Structure

```text
DBMS/
├── Experiment1/
│   ├── README.md
│   └── Experiment1.pdf
├── Experiment2/
│   ├── README.md
│   └── Experiment2.pdf
├── Experiment3/
│   ├── README.md
│   ├── Experiment3.sql
│   └── Experiment3_Queries.sql
├── Experiment4/
│   ├── README.md
│   ├── Experiment4.sql
│   └── Experiment4_Queries.sql
├── Experiment5/
│   ├── README.md
│   ├── Experiment5.sql
│   └── Experiment5_Queries.sql
└── Experiment6/
    ├── README.md
    ├── Experiment6.sql
    └── Experiment6_Queries.sql
```

## Learning Outcomes

- Understand ER modelling and relational schema design.
- Implement database tables and integrity constraints.
- Write SQL queries using joins and subqueries.
- Work with views and recursive queries.
- Implement stored procedures and triggers.
- Understand data validation, referential integrity, and audit logging.

---

## Student Details

- **Name:** Ananya Srivastava
- **UID:** 25LBCS3220
- **Course:** B.Tech CSE (AI & ML)
- **Section:** AIML 2
- **Subject:** Database Management System (DBMS) Lab
