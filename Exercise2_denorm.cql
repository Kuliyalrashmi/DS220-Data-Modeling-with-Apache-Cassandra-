-- creating udt for encoding;
CREATE TYPE IF NOT EXISTS video_encoding (
    encoding TEXT,
    height INT,
    width INT,
    bit_rates SET<TEXT>
);

-- create table for ( Retrieve videos an actor has appeared in (newest first). )
CREATE TABLE videos_by_actor (
    actor text,
    added_date timestamp,
    video_id timeuuid,
    character_name text,
    description text,
    encoding frozen<video_encoding>,
    tags set<text>,
    title text,
    user_id uuid,
    PRIMARY KEY ((actor) , added_date , video_id)
) WITH CLUSTERING ORDER BY ( added_date desc , video_id asc);


-- Load 'videos_by_actor.csv' into the 'videos_by_actor' table using the COPY command
COPY videos_by_actor (actor,added_date,video_id,character_name,description,encoding,tags,title,user_id) FROM 'videos_by_actor.csv' WITH HEADER = true;



--  query to retrieve the video information for a particular actor (Tom Hanks, Denzel Washington)
select * from videos_by_actor where actor = 'Tom Hanks';
select * from videos_by_actor where actor  = 'Denzel Washington';


--  SELECTing just the actor and the added_date columns. Notice the order of added_dates.
select actor , added_date  from videos_by_actor;




-- create a new table called 'videos_by_genre' which will support query ( : Retrieve videos within a particular genre (newest first))
CREATE TABLE videos_by_genre (
    genre text,
    added_date timestamp,
    video_id timeuuid,
    description text,
    encoding frozen<video_encoding>,
    tags set<text>,
    title text,
    user_id uuid,
    PRIMARY KEY ((genre) , added_date , video_id )
) WITH CLUSTERING ORDER BY ( added_date desc , video_id asc);



-- query to retrieve the video information for a particular genre (Future noir, Time travel).
select * from videso_by_genre where genre = 'Musical' limit 10;
select * from videso_by_genre where genre = 'Future noir' limit 10;
select * from videso_by_genre where genre = 'Time travel' limit 10;

--exit;
exit;