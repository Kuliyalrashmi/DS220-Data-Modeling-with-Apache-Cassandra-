use killrVideo;

-- erase the data from the 'videos' table
truncate table videos;

-- Alter the 'videos' table to add a 'tags' column.
alter table videos add tags set<text>;


-- Load the data from the 'videos.csv'
copy videos from 'ds220-6.0-labwork/labwork/udts/videos.csv' with header = true;

-- Alter your table to add an 'encoding' column of the 'video_encoding' type.
alter table videos add encoding video_encoding;

-- Load the data from the 'videos_encoding.csv' file
copy videos(video_id, encoding) from 'ds220-6.0-labwork/labwork/udts/videos_encoding.csv' with header = true;


--  retrieve the first 10 rows of the 'videos' table
select json * from videos limit 10;

-- quit
exit;