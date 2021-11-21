/** Generator function */
CREATE TEMP FUNCTION dummy_song()
RETURNS STRUCT<song_id Int, 
               band_id Int,
               album_id Int,
               song_title String,
               lyrics String,
               ratings Array<Struct<stars Int,
                                    comment String
                            >>
               >
LANGUAGE js 
AS """
var faker = getFaker()
var dummy_song = {};

dummy_song.song_id = faker.random.number();
dummy_song.band_id = faker.random.number();
dummy_song.album_id = faker.random.number();
dummy_song.song_title = faker.lorem.words();
dummy_song.lyrics = faker.lorem.sentences();

var ratings = [];
var rating = {};
let number_of_ratings = faker.random.arrayElement([...Array(30).keys()]);
for (let i = 0; i < number_of_ratings; i++) {
    let stars = [1, 2, 3, 4, 5]
    rating.stars = faker.random.arrayElement(stars);
    rating.comment = faker.lorem.sentences();
    ratings.push(rating)
    rating = {}
}
dummy_song.ratings = ratings;
return dummy_song;
"""
OPTIONS (
library=["gs://music-streaming/faker.js"]
);

/** Insert 10000 dummy records */
INSERT INTO
`music-streaming-332016.star_schema.dim_song` 
(SELECT dummy_song().*  from UNNEST(GENERATE_ARRAY(1, 10000)));
