# Bank Platform — SQL queries

## 1. Show related customer, account records (up to 20).

```sql
SELECT t0."customer_id" AS "customer_customer_id",
       t0."full_name" AS "customer_full_name",
       t1."account_id" AS "account_account_id",
       t1."account_number" AS "account_account_number"
FROM portfolio."customer" t0
JOIN portfolio."account" t1 ON t1."customer_id" = t0."customer_id"
ORDER BY t0."customer_id", t1."account_id"
LIMIT 20;
```

| customer_customer_id | customer_full_name | account_account_id | account_account_number |
| --- | --- | --- | --- |
| 101 | Avery Stone | 201 | SYN-ACCT-001 |
| 101 | Avery Stone | 202 | SYN-ACCT-002 |
| 102 | Jordan Lee | 203 | SYN-ACCT-003 |

## 2. Find account records where customer_id matches 101 (up to 20).

```sql
SELECT * FROM portfolio."account"
WHERE "customer_id" IS NOT DISTINCT FROM 101
ORDER BY "account_id"
LIMIT 20;
```

| account_id | customer_id | account_number | opened_on | balance | status |
| --- | --- | --- | --- | --- | --- |
| 201 | 101 | SYN-ACCT-001 | 2026-01-12 | 850.5 | active |
| 202 | 101 | SYN-ACCT-002 | 2026-01-13 | 275.25 | active |

## 3. Count transfer records for each source_account_id (up to 20 groups).

```sql
SELECT "source_account_id", count(*) AS record_count
FROM portfolio."transfer"
GROUP BY "source_account_id"
ORDER BY record_count DESC, "source_account_id" NULLS LAST
LIMIT 20;
```

| source_account_id | record_count |
| --- | --- |
| 201 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.452 | 2.471, 2.452, 2.424 | Sort → Seq Scan | 274 |
| After index | 0.324 | 0.324, 0.289, 0.428 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.452 ms to 0.324 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.438..2.441 rows=50 loops=1)
  Seq Scan on transfer (actual time=0.016..2.399 rows=50 loops=1)
Planning Time: 0.36 ms
Execution Time: 2.471 ms
```

### Before index, run 2

```text
Sort (actual time=2.419..2.422 rows=50 loops=1)
  Seq Scan on transfer (actual time=0.016..2.38 rows=50 loops=1)
Planning Time: 0.395 ms
Execution Time: 2.452 ms
```

### Before index, run 3

```text
Sort (actual time=2.391..2.394 rows=50 loops=1)
  Seq Scan on transfer (actual time=0.015..2.354 rows=50 loops=1)
Planning Time: 0.38 ms
Execution Time: 2.424 ms
```

### After index, run 1

```text
Sort (actual time=0.261..0.264 rows=50 loops=1)
  Bitmap Heap Scan on transfer (actual time=0.031..0.223 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=50 loops=1)
Planning Time: 0.572 ms
Execution Time: 0.324 ms
```

### After index, run 2

```text
Sort (actual time=0.227..0.23 rows=50 loops=1)
  Bitmap Heap Scan on transfer (actual time=0.031..0.189 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=50 loops=1)
Planning Time: 0.587 ms
Execution Time: 0.289 ms
```

### After index, run 3

```text
Sort (actual time=0.367..0.37 rows=50 loops=1)
  Bitmap Heap Scan on transfer (actual time=0.032..0.329 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.016..0.016 rows=50 loops=1)
Planning Time: 0.763 ms
Execution Time: 0.428 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Tanimola_Miracle_301919757_P2_Queries.sql, then Tanimola_Miracle_301919757_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Tanimola_Miracle_301919757_P2_QueryResults.png) · [Index comparison](screenshots/Tanimola_Miracle_301919757_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

