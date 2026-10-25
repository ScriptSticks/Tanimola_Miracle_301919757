-- Fictional sample records for Bank Platform.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at", "status") VALUES (101, 'Avery Stone', 'avery.stone@example.test', '2026-01-10T09:15:00Z', 'active');
INSERT INTO portfolio."customer" ("customer_id", "full_name", "email", "created_at", "status") VALUES (102, 'Jordan Lee', 'jordan.lee@example.test', '2026-01-11T10:30:00+00:00', 'active');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status") VALUES (201, 101, 'SYN-ACCT-001', '2026-01-12', 850.5, 'active');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status") VALUES (202, 101, 'SYN-ACCT-002', '2026-01-13', 275.25, 'active');
INSERT INTO portfolio."account" ("account_id", "customer_id", "account_number", "opened_on", "balance", "status") VALUES (203, 102, 'SYN-ACCT-003', '2026-01-14', 1200, 'active');
INSERT INTO portfolio."transfer" ("transfer_id", "source_account_id", "destination_account_id", "amount", "initiated_at", "status", "external_ref") VALUES (301, 201, 202, 50.25, '2026-02-01T12:00:00Z', 'posted', 'SYN-REF-001');
COMMIT;
