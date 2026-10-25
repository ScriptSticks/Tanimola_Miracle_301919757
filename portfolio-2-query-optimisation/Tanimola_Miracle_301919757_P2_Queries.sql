-- Show related customer, account records (up to 20).
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_number" AS "account_account_number"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_number" AS "account_account_number"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;

-- Find account records where customer_id matches 101 (up to 20).
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;

-- Count transfer records for each source_account_id (up to 20 groups).
SELECT "source_account_id", count(*) AS record_count
FROM portfolio."transfer"
GROUP BY "source_account_id"
ORDER BY record_count DESC, "source_account_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "source_account_id", count(*) AS record_count
FROM portfolio."transfer"
GROUP BY "source_account_id"
ORDER BY record_count DESC, "source_account_id" NULLS LAST
LIMIT 20;
