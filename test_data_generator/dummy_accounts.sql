/** Generator function */
CREATE TEMP FUNCTION dummy_account()
RETURNS STRUCT<account_id Int, 
               full_name String,
               email_address String,
               date_of_birth Timestamp,
               gender String,
               address Struct<street_name String,
                              street_number Int,
                              city String
                              >,
               country String
               >
LANGUAGE js 
AS """
var faker = getFaker()
var dummy_account = {};

dummy_account.account_id = faker.random.number();
dummy_account.full_name = faker.name.findName();
dummy_account.email_address = faker.internet.email();
dummy_account.date_of_birth = faker.date.past();
let genders = [ 'F' , 'M' ];
dummy_account.gender = faker.random.arrayElement(genders);
dummy_account.country = faker.address.country();

var dummy_address = {};
dummy_address.street_name = faker.address.streetName();
dummy_address.street_number = faker.random.number();
dummy_address.city = faker.address.city();

dummy_account.address = dummy_address;
return dummy_account;
"""
OPTIONS (
library=["gs://music-streaming/faker.js"]
);

/** Insert 1000 dummy records */
INSERT INTO
`music-streaming-332016.star_schema.dim_account` 
(SELECT dummy_account().*  from UNNEST(GENERATE_ARRAY(1, 1000)));

SELECT * FROM `music-streaming-332016.star_schema.dim_account` ;
