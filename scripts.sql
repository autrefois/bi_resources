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
  