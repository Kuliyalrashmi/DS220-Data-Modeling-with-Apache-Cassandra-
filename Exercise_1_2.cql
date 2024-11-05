-- Create a Keyspace for KillrVideo
create keyspace KillrVideo with replication = { 'class' = 'SimpleStrategy' , 'replication_factor' : 1};

-- use keyspace
use killrVideo;

-- Create a table to store video metadata
create table videos(
    video_id TIMEUUID,
    added_date TIMESTAMP,
    description TEXT,
    title TEXT,
    user_id uuid,
    primary key (video_id)
);


-- Open 'cql/videos.csv' with a text editor and review the contents of the file.
copy videos(video id, added date, description, title, user id) from 'ds220-6.0-labwork/labwork/cql/videos.csv' with header = true;

-- verify data 
select * from videos;

-- Use SELECT to COUNT(*) the number of imported rows. It should match the number of rows COPY reported as imported.
select count(*) as total_records from videos;

-- Use SELECT to find a row where the video_id = 6c4cffb9-0dc4-1d59-af24-c960b5fc3652
select * from videos where video_id =  6c4cffb9-0dc4-1d59-af24-c960b5fc3652;

--  remove the data from our table using TRUNCATE.
truncate videos;

-- exit cqlsh
quit;

