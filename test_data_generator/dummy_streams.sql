/** Generator function */
CREATE TEMP FUNCTION dummy_stream()
RETURNS STRUCT<stream_id Int,
               stream_date_id Int,
               account_id Int,
               song_id String
               >
LANGUAGE js 
AS """
var faker = getFaker()
var dummy_stream = {};

dummy_stream.song_id = faker.random.number();
dummy_stream.stream_id = faker.random.number();
dummy_stream.stream_date_id = faker.random.number();
dummy_stream.account_id = faker.random.number();

return dummy_stream;
"""
OPTIONS (
library=["gs://music-streaming/faker.js"]
);

/** Insert 10000 dummy records */
INSERT INTO
`music-streaming-332016.star_schema.fact_streams` 
(SELECT dummy_stream().*  from UNNEST(GENERATE_ARRAY(1, 10000)));

--select * from `music-streaming-332016.star_schema.fact_streams` ;

--truncate table `music-streaming-332016.star_schema.fact_streams` ;
