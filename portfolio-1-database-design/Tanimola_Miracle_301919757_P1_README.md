# Portfolio 1 — Database Design and Modelling

I organised the data into customer, account, transfer. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| customer | 2 |
| account | 3 |
| transfer | 1 |

The 13 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Tanimola_Miracle_301919757_P1_Design.md)
- [ER diagram](Tanimola_Miracle_301919757_P1_ERDiagram.md)
- [Normalisation](Tanimola_Miracle_301919757_P1_Normalisation.md)
- [Schema](Tanimola_Miracle_301919757_P1_Schema.sql)
- [Sample data](Tanimola_Miracle_301919757_P1_SampleData.sql)
- [Constraint tests](Tanimola_Miracle_301919757_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Tanimola_Miracle_301919757_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

