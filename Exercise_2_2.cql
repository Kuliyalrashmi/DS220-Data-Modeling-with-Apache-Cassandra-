-- use keyspace;
use killrvideo;

-- Create a new table that allows querying videos by title and year using a composite partition key.Your peers need to query videos based on 'title' and 'added_year'.
create table videos_by_title_year(
    title TEXT,
    added_year INT,
    added_date TIMESTAMP,
    description TEXT,
    user_id UUID,
    video_id UUID,
    PRIMARY KEY ((title , added_year))
);

-- load data from 'ds220-6.0-labwork\labwork\partitions\videos_by_title_year.csv'
copy videos_by_title_year(title, added year, added date, description, user id, video id) from 'ds220-6.0-labwork/labwork/partitions/videos_by_title_year.csv' with header  = true;


--Try running queries on the 'videos_by_title_year' table to query on a specific 'title' and 'added_year'.
-- Example queries:
-- title added_year
-- Introduction to Apache Cassandra 2014
-- Grumpy Cat: Slow Motion 2015
-- AzureDev 2015

select * from videos_by_title_year where title = 'Introduction to Apache Cassandra 2014'  and year = 2014;
select * from videos_by_title_year where title = 'Grumpy Cat: Slow Motion'  and year = 2015;
select * from videos_by_title_year where title = 'AzureDev'  and year = 2015;


-- What error does Cassandra return when you try to query on just title or just year? Why?

-- the reason behind this is the data model we build relies data partioning wiht help of 2 keys however if we try querying for data with just 1 key it kill hard for it exactly find where it is , however we can do full cluster scan by allow filtering about it is ineffecient..



-- Exit cqlsh
quit;