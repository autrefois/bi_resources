[
      {
        "mode": "REQUIRED",
        "name": "song_id",
        "type": "INTEGER"
      },
      {
        "mode": "NULLABLE",
        "name": "band_id",
        "type": "INTEGER"
      },
      {
        "mode": "NULLABLE",
        "name": "album_id",
        "type": "INTEGER"
      },
      {
        "mode": "NULLABLE",
        "name": "song_title",
        "type": "STRING"
      },
      {
        "mode": "NULLABLE",
        "name": "lyrics",
        "type": "STRING"
      },
      {
        "fields": [
          {
            "mode": "NULLABLE",
            "name": "stars",
            "type": "INTEGER"
          },
          {
            "mode": "NULLABLE",
            "name": "comment",
            "type": "STRING"
          }
        ],
        "mode": "REPEATED",
        "name": "ratings",
        "type": "RECORD"
      }
]
