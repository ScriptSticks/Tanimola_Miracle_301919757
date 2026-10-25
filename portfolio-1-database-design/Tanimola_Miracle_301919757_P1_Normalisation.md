# Bank Platform — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| customer_id | account records (list) |
| --- | --- |
| 101 | [201,202] |
| 102 | [203] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| account.account_id | account.customer_id | account.account_number | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | SYN-ACCT-001 | 101 | Avery Stone |
| 202 | 101 | SYN-ACCT-002 | 101 | Avery Stone |
| 203 | 102 | SYN-ACCT-003 | 102 | Jordan Lee |

Key: account_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## account_example

| account.account_id | account.customer_id | account.account_number | customer.customer_id | customer.full_name |
| --- | --- | --- | --- | --- |
| 201 | 101 | SYN-ACCT-001 | 101 | Avery Stone |
| 202 | 101 | SYN-ACCT-002 | 101 | Avery Stone |
| 203 | 102 | SYN-ACCT-003 | 102 | Jordan Lee |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## customer

| customer_id | full_name | email | created_at | status |
| --- | --- | --- | --- | --- |
| 101 | Avery Stone | avery.stone@example.test | 2026-01-10T09:15:00+00:00 | active |
| 102 | Jordan Lee | jordan.lee@example.test | 2026-01-11T10:30:00+00:00 | active |

## account

| account_id | customer_id | account_number | opened_on | balance | status |
| --- | --- | --- | --- | --- | --- |
| 201 | 101 | SYN-ACCT-001 | 2026-01-12 | 850.5 | active |
| 202 | 101 | SYN-ACCT-002 | 2026-01-13 | 275.25 | active |
| 203 | 102 | SYN-ACCT-003 | 2026-01-14 | 1200 | active |

## transfer

| transfer_id | source_account_id | destination_account_id | amount | initiated_at | status | external_ref |
| --- | --- | --- | --- | --- | --- | --- |
| 301 | 201 | 202 | 50.25 | 2026-02-01T12:00:00+00:00 | posted | SYN-REF-001 |

## Dependencies

- customer: (customer_id) → full_name, email, created_at, status
- account: (account_id) → customer_id, account_number, opened_on, balance, status
- transfer: (transfer_id) → source_account_id, destination_account_id, amount, initiated_at, status, external_ref

Joining the decomposed sample tables reproduces the original 3 example rows. The design assumes the declared keys describe the relevant business dependencies.
