  /** Check min / max ids in dim tables */
  /** ... */
  /** Generator function */
CREATE TEMP FUNCTION
  dummy_stream()
  RETURNS STRUCT<stream_id Int,
  stream_date_id Int,
  account_id Int,
  song_id String >
  LANGUAGE js AS 
"""
var faker = getFaker()
var dummy_stream = {};

dummy_stream.song_id = faker.random.number({
                                            'min': 0,
                                            'max': 99979
                                            });
dummy_stream.stream_id = faker.random.number();
dummy_stream.stream_date_id = faker.random.number({
                                                    'min': 2,
                                                    'max': 1827
                                                  });
dummy_stream.account_id = faker.random.number({
                                               'min': 11,
                                                'max': 99982
                                              });

return dummy_stream;
""" 
OPTIONS ( library=["gs://music-streaming/faker.js"] ); 

/** Insert dummy records */
INSERT INTO
  `spotify-data-explorer-369917.data_explorer.fact_streams` (
  WITH
    test_data AS (
    SELECT
      stream_id,
      dummy_stream().stream_date_id,
      dummy_stream().account_id,
      dummy_stream().song_id
    FROM
      UNNEST(GENERATE_ARRAY(1, 100000)) stream_id )
  SELECT
    test_data.stream_id,
    test_data.stream_date_id,
    test_data.account_id,
    test_data.song_id
  FROM
    test_data
  RIGHT JOIN
    `spotify-data-explorer-369917.data_explorer.dim_account` da
  ON
    test_data.account_id = da.accout_id
  WHERE
    test_data.stream_id IS NOT NULL );

  -- select * from `spotify-data-explorer-369917.data_explorer.fact_streams` ;
  -- truncate table `spotify-data-explorer-369917.data_explorer.fact_streams` ;