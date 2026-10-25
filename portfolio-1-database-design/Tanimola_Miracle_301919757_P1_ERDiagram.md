# Bank Platform — ER diagram

```mermaid
erDiagram
    direction LR
    customer {
        bigint customer_id PK
        text full_name
        text email UK
        timestamptz created_at
        text status
    }
    account {
        bigint account_id PK
        bigint customer_id FK
        text account_number UK
        date opened_on
        numeric balance
        text status
    }
    transfer {
        bigint transfer_id PK
        bigint source_account_id FK
        bigint destination_account_id FK
        numeric amount
        timestamptz initiated_at
        text status
        text external_ref UK
    }
    customer ||--o{ account : "customer_id"
    account ||--o{ transfer : "source_account_id"
    account ||--o{ transfer : "destination_account_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Tanimola_Miracle_301919757_ERDiagram.png)
