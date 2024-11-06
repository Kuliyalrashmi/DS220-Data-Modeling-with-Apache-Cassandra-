-- create the following (bad) table with the (crummy) primary key:
-- Column Name Data Type
-- tag text
-- added_year int
-- video_id uuid
-- added_date timestamp
-- title text
-- user_id uuid

create table bad_videos_by_tag_year(
    tag text,
    added_year int,
    added_date timestamp,
    title text,
    description text,
    user_id uuid,
    video_id timeuuid,
    PRIMARY KEY ((video_id))
);

-- view the structure of your 'bad_videos_by_tag_year' table.
describe bad_videos_by_tag_year;


-- import `videos_by_tag_year.csv` file
copy bad_videos_by_tag_year from 'ds220-6.0-labwork/labwork/clustering/videos_by_tag_year.csv' with header = true;


-- Now COUNT() the number of rows in the `bad_videos_by_tag_year`
select count(*) as total_records from bad_videos_by_tag_year;



-- Notice the number of rows in the 'bad_videos_by_tag_year' does not match the number of rows imported from 'videos_by_tag_year.csv'. Since 'videos_by_tag_year.csv' duplicates 'video_id' for each unique 'tag' and 'year' per video, Cassandra upserted several records during the COPY. `video_id` is not a proper partition key for this scenario.

-- Drop your nasty table
drop table bad_videos_by_tag_year;


-- Create a table with the columns above to facilitate querying for videos by tag within a given year range returning the results in descending order by year
CREATE TABLE videos_by_tag_year (
    tag text,
    added_year int,
    video_id timeuuid,
    added_date timestamp,
    description text,
    title text,
    user_id uuid,
    PRIMARY KEY ((tag) , added_date , video_id)
) WITH CLUSTERING ORDER BY ( added_date desc);


-- Load the data from the 'videos_by_tag_year.csv' file
COPY videos_by_tag_year FROM 'videos_by_tag_year.csv' WITH HEADER=true;


-- Check the number of rows in the 'videos_by_tag_year' table.
select count(*) as total_records from videos_by_tag_year;

-- Try running queries on the 'videos_by_tag_year' table to query on a specific tag and
-- added year.
-- Example queries:
-- tag added_year
-- trailer 2015
-- cql 2014
-- spark 2014


select * from videos_by_tag_year where tag = 'trailer' and year = 2015;
select * from videos_by_tag_year where tag = 'cql' and year = 2014;
select * from videos_by_tag_year where tag = 'spark' and year = 2014;



--  querying for all videos with tag "cql" added before the year 2015. Notice you can do range queries on clustering columns.
select * from videos_by_tag_year where tag = 'sql' and year < 2015;

-- Try querying for all videos added before 2015. The query will fail.
select * from videos_by_tag_year where year < 2015 allow filtering;

-- exit
exit;


