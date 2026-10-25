# Bank Platform — database design

My case study records customer, account, transfer.

## Users

- Bank operations staff review accounts and transfer activity.
- Customers initiate transfers between their accounts.

## Main operations

- Create customers and accounts with synthetic identifiers and details.
- Record a transfer only when both accounts exist and the source can cover it.
- Commit each transfer and both balance changes atomically; roll back all changes on failure.
- Benchmark a date-range transfer filter on 50000 synthetic transfer rows, comparing the query plan with and without a B-tree index on initiated_at.

## Entities

| Entity | Information stored |
| --- | --- |
| customer | Stores synthetic bank customer identity and contact details. |
| account | Stores an account, its customer owner, opening date, status, and current balance. |
| transfer | Records a transfer request between two accounts and its processing status. |

## customer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| customer_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
- Unique key: (email).

## account

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| account_id | BIGINT | PK | Yes |
| customer_id | BIGINT | FK | Yes |
| account_number | TEXT | Unique | Yes |
| opened_on | DATE |  | Yes |
| balance | NUMERIC(18,2) |  | Yes |
| status | TEXT |  | Yes |
- customer_id → customer.customer_id
- Unique key: (account_number).

## transfer

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| transfer_id | BIGINT | PK | Yes |
| source_account_id | BIGINT | FK | Yes |
| destination_account_id | BIGINT | FK | Yes |
| amount | NUMERIC(18,2) |  | Yes |
| initiated_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| external_ref | TEXT | Unique | Yes |
- source_account_id → account.account_id
- destination_account_id → account.account_id
- Unique key: (external_ref).

## Relationships and business rules

- Each customer email identifies at most one customer.
- Every account references an existing customer.
- An account balance must be greater than or equal to zero after each committed update.
- A transfer amount must be greater than zero.
- A transfer's source and destination account identifiers must differ.
- Every transfer source references an existing account.
- Every transfer destination references an existing account.
- Each external reference identifies at most one transfer, preventing duplicate transfer requests.

## Assumptions

- All records and identifiers are synthetic; each table's single-column UUID primary key is globally unique.
- Each account has exactly one customer owner, and each transfer has one source account and one destination account.
- Balances are stored on accounts and are updated with transfer records in one database transaction.
- Transfers have a positive amount, cannot move funds to the same account, and do not permit a negative account balance.
- The worked normalization example separates customer name and email from the account listing into customer and account tables.

