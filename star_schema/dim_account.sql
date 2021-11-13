[
    {
        "name": "account_id",
        "type": "INTEGER",
        "mode": "REQUIRED"
    },
    {
        "name": "full_name",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "email_address",
        "type": "STRING",
        "mode": "NULLABLE"
    },
    {
        "name": "date_of_birth",
        "type": "TIMESTAMP",
        "mode": "NULLABLE"
    },
    {
        "name": "gender",
        "type": "STRING",
        "mode": "NULLABLE",
        "maxLength": "1"
    },
    {
        "name": "address",
        "type": "RECORD",
        "mode": "NULLABLE",
        "fields": [
            {
                "name": "street_name",
                "type": "STRING",
                "mode": "NULLABLE"
            },
            {
                "name": "street_number",
                "type": "INTEGER",
                "mode": "NULLABLE"
            },
            {
                "name": "city",
                "type": "STRING",
                "mode": "NULLABLE"
            }
        ]
    },
    {
        "name": "country",
        "type": "STRING",
        "mode": "NULLABLE"
    }
]

