# DBMS Experiment 7

## Aim

To identify functional dependencies in a denormalized Sales table and normalize the relation step-by-step from UNF to 1NF, 2NF, 3NF and BCNF, and to verify lossless join and dependency preservation using SQL queries.

## Database

`Experiment7`

## Concepts Covered

1. **Functional Dependencies** — Identifying dependencies among sale, customer, salesperson and product attributes.
2. **UNF** — Creating a denormalized Sales table containing repeating/multi-valued product attributes.
3. **1NF** — Converting repeating product values into atomic rows using `(Sale_ID, Product_ID)` as the primary key.
4. **2NF** — Removing partial dependencies by separating sale-level and sale-item data.
5. **3NF** — Separating Customer, Salesperson and Product information from the Sale relation.
6. **BCNF** — Verifying that determinants of the relevant functional dependencies are superkeys in their respective relations.
7. **Lossless Join** — Comparing the original 1NF row count with the reconstructed joined relation.
8. **Dependency Preservation** — Checking functional dependency violations in the decomposed relations.

## Files

- `Experiment7.sql` — Complete SQL script for UNF, 1NF, 2NF, 3NF, BCNF, lossless join and dependency preservation.
- `Experiment7_Queries.sql` — Queries for verifying each normalization stage and the final decomposition.
- `README.md` — Experiment description and documentation.

## Functional Dependencies

- `Sale_ID -> Sale_Date, Customer_ID, Salesperson_ID, Payment_Mode`
- `Customer_ID -> Customer_Name, Customer_City`
- `Salesperson_ID -> Salesperson_Name`
- `Product_ID -> Product_Name, Product_Category, Unit_Price`
- `(Sale_ID, Product_ID) -> Quantity`

## Candidate Key in 1NF

`(Sale_ID, Product_ID)`

## Verification

The experiment verifies:

- 1NF records
- 2NF decomposition
- 3NF decomposition
- BCNF structure
- Lossless join
- Dependency preservation

## Execution Requirements

- MySQL database server
- MySQL Workbench or another MySQL client
- Execute `Experiment7.sql` before running the verification queries.
