INSERT INTO
`music-streaming-332016.star_schema.dim_date`
SELECT ROW_NUMBER() OVER() date_id,
    date,
    cast (date as timestamp) as datetime, 
    DATE_ADD(DATE_TRUNC(DATE_SUB(date, INTERVAL 1 DAY), WEEK), INTERVAL 1 DAY) as week_start_date,
    DATE_ADD(DATE_ADD(DATE_TRUNC(DATE_SUB(date, INTERVAL 1 DAY), WEEK), INTERVAL 1 DAY), INTERVAL 6 DAY) as week_end_date,
    DATE_TRUNC(date, MONTH) as month_start_date,
    DATE_SUB(DATE_TRUNC(DATE_ADD(date, INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY) as month_end_date,
    DATE_TRUNC(date, QUARTER) as quarter_start_date,
    DATE_SUB(DATE_TRUNC(DATE_ADD(date, INTERVAL 1 QUARTER), QUARTER), INTERVAL 1 DAY) as quarter_end_date
FROM 
       UNNEST(GENERATE_DATE_ARRAY('2017-01-01', '2022-01-01')) AS date;

SELECT * FROM `spotify-data-explorer-369917.data_explorer.dim_date` ;
