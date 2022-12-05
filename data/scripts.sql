SELECT
  COUNT(*),
  full_name,
  email_address
FROM
  `music-streaming-332016.star_schema.dim_account`
GROUP BY 2, 3
HAVING COUNT(*) > 1;

SELECT
  COUNT(*),
  band_id,
  song_title
FROM
  `music-streaming-332016.star_schema.dim_song`
GROUP BY  2, 3
HAVING COUNT(*) > 1;

SELECT
  s.stream_id,
  a.full_name,
  a.country,
  song.song_title,
  d.date
FROM
  `music-streaming-332016.star_schema.fact_streams` s
JOIN
  `music-streaming-332016.star_schema.dim_account` a
ON
  a.accout_id = s.account_id
JOIN
  `music-streaming-332016.star_schema.dim_song` song
ON
  CAST (s.song_id AS integer) = song.song_id
JOIN
  `music-streaming-332016.star_schema.dim_date` d
ON
  s.stream_date_id = d.date_id
WHERE
  date = '2019-06-05'
  AND full_name = 'Karli Johnston';

SELECT
  song.song_id,
  song.band_id,
  song.album_id,
  song.song_title,
  song.lyrics,
  rating.stars,
  rating.comment
FROM
  `music-streaming-332016.star_schema.dim_song` song,
  UNNEST(ratings) AS rating
WHERE
  song.song_id = 6481
  AND rating.stars = 5;
