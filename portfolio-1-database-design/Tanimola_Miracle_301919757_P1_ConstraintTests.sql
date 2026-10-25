-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. reject customer pk. Expected: pk_customer, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at", "status")
VALUES (101, 'Morgan Vale', 'morgan.pk@example.test', '2026-02-02T09:00:00Z', 'active');

-- 2. reject customer email unique. Expected: uq_customer_0, SQLSTATE 23505.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at", "status")
VALUES (401, 'Casey North', 'avery.stone@example.test', '2026-02-02T09:05:00Z', 'active');

-- 3. reject customer full name not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at", "status")
VALUES (402, NULL, 'casey.null@example.test', '2026-02-02T09:10:00Z', 'active');

-- 4. reject account pk. Expected: pk_account, SQLSTATE 23505.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status")
VALUES (201, 102, 'SYN-ACCT-PK', '2026-02-02', 25, 'active');

-- 5. reject account number unique. Expected: uq_account_0, SQLSTATE 23505.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status")
VALUES (403, 101, 'SYN-ACCT-001', '2026-02-02', 25, 'active');

-- 6. reject account owner fk. Expected: fk_account_0, SQLSTATE 23503.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status")
VALUES (404, 9999, 'SYN-ACCT-FK', '2026-02-02', 25, 'active');

-- 7. reject transfer pk. Expected: pk_transfer, SQLSTATE 23505.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (301, 202, 203, 5, '2026-02-02T10:00:00Z', 'posted', 'SYN-REF-PK');

-- 8. reject transfer external ref unique. Expected: uq_transfer_0, SQLSTATE 23505.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (405, 202, 203, 5, '2026-02-02T10:05:00Z', 'posted', 'SYN-REF-001');

-- 9. reject transfer source fk. Expected: fk_transfer_0, SQLSTATE 23503.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (406, 9998, 203, 5, '2026-02-02T10:10:00Z', 'posted', 'SYN-REF-SOURCE-FK');

-- 10. reject transfer destination fk. Expected: fk_transfer_1, SQLSTATE 23503.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (407, 202, 9997, 5, '2026-02-02T10:15:00Z', 'posted', 'SYN-REF-DEST-FK');

-- 11. reject account negative balance. Expected: account_balance_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status")
VALUES (408, 101, 'SYN-ACCT-CHECK', '2026-02-02', -1, 'active');

-- 12. reject transfer nonpositive amount. Expected: transfer_amount_positive, SQLSTATE 23514.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (409, 201, 202, 0, '2026-02-02T10:20:00Z', 'posted', 'SYN-REF-AMOUNT-CHECK');

-- 13. reject transfer same account. Expected: transfer_accounts_distinct, SQLSTATE 23514.
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref")
VALUES (410, 201, 201, 5, '2026-02-02T10:25:00Z', 'posted', 'SYN-REF-ACCOUNTS-CHECK');
