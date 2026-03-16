
-- CATEGORY 1: Selections, Projections, Sorting & Masks 
-- 1. High-potential artists from UK/France (Scouting)
SELECT A_NAME, A_ORIGIN_COUNTRY, A_CAREER_START 
FROM ARTIST 
WHERE A_ORIGIN_COUNTRY IN ('UK', 'France')
ORDER BY A_CAREER_START DESC;

-- 2. Search for unreleased/demo tracks (Masks)
SELECT T_TITLE, T_ISRC 
FROM TRACK 
WHERE T_TITLE LIKE '%Demo%' OR T_TITLE LIKE '%Unreleased%';

-- 3. Unique studio locations for planning trips
SELECT DISTINCT ST_COUNTRY, ST_CITY FROM STUDIO;

-- 4. Top albums by popularity (> 85)
SELECT A_TITLE, A_POPULARITY 
FROM ALBUM 
WHERE A_POPULARITY > 85 
ORDER BY A_POPULARITY DESC;

-- 5. List explicit tracks (Parental Advisory management)
SELECT T_TITLE, T_EXPLICIT 
FROM TRACK 
WHERE T_EXPLICIT = TRUE;

-- CATEGORY 2: Aggregation Functions & Grouping 
-- 6. Count artists per country (Market share)
SELECT A_ORIGIN_COUNTRY, COUNT(*) AS ARTIST_COUNT 
FROM ARTIST 
GROUP BY A_ORIGIN_COUNTRY;

-- 7. Trending genres by average popularity (> 75)
SELECT G_NAME, AVG(G_POPULARITY) AS TREND_SCORE 
FROM GENRE 
GROUP BY G_NAME 
HAVING AVG(G_POPULARITY) > 75;

-- 8. Artist with most total studio time (Seconds)
SELECT ID_ARTIST, SUM(T_DURATION) AS TOTAL_TIME
FROM TRACK T 
JOIN RECORDING R ON T.ID_TRACK = R.ID_TRACK 
GROUP BY ID_ARTIST
ORDER BY TOTAL_TIME DESC;

-- 9. Volume of new recordings since 2024
SELECT COUNT(ID_RECORDING) 
FROM RECORDING 
WHERE recording_date >= '2024-01-01';

-- 10. Genres exceeding global average popularity
SELECT G_NAME, G_POPULARITY 
FROM GENRE 
WHERE G_POPULARITY > (SELECT AVG(G_POPULARITY) FROM GENRE);


-- CATEGORY 3: Joins
-- 11. Traceability: Artist, Track, and Studio used (Triple Join)
SELECT A.A_NAME, T.T_TITLE, S.ST_NAME 
FROM RECORDING R
JOIN ARTIST A ON R.ID_ARTIST = A.ID_ARTIST
JOIN TRACK T ON R.ID_TRACK = T.ID_TRACK
JOIN STUDIO S ON R.ID_STUDIO = S.ID_STUDIO;

-- 12. Mentorship follow-up (Recursive Join)
SELECT PROT.A_NAME AS PROTEGE, MENTOR.A_NAME AS MENTOR
FROM ARTIST PROT
LEFT JOIN ARTIST MENTOR ON PROT.ID_ARTIST_1 = MENTOR.ID_ARTIST;

-- 13. Target Premium users for marketing
SELECT U.U_EMAIL, S.S_TYPE 
FROM USER U
JOIN SUBSCRIPTION S ON U.ID_SUBSCRIPTION = S.ID_SUBSCRIPTION
WHERE S.S_TYPE = 'Premium';

-- 14. Tracklist for a priority album ('Pulse Theory')
SELECT AT.TRACK_NUMBER, AT.AT_DISPLAYED_TITLE
FROM ALBUM_TRACK AT
JOIN ALBUM A ON AT.ID_ALBUM = A.ID_ALBUM
WHERE A.A_TITLE = 'Pulse Theory';

-- 15. Identify preferred studios for a top artist (ID 1)
SELECT DISTINCT S.ST_NAME, S.ST_CITY
FROM STUDIO S
JOIN RECORDING R ON S.ID_STUDIO = R.ID_STUDIO
WHERE R.ID_ARTIST = 1;


-- CATEGORY 4: Nested Queries
-- 16. Local users for a specific artist's country
SELECT U_EMAIL FROM USER 
WHERE U_COUNTRY = (SELECT A_ORIGIN_COUNTRY FROM ARTIST WHERE A_NAME = 'Young Prodigy');

-- 17. Detect artists with zero recordings (Scouting potential)
SELECT A_NAME FROM ARTIST 
WHERE ID_ARTIST NOT IN (SELECT ID_ARTIST FROM RECORDING);

-- 18. Tracks longer than the global average duration
SELECT T_TITLE, T_DURATION FROM TRACK 
WHERE T_DURATION > (SELECT AVG(T_DURATION) FROM TRACK);

-- 19. Artists with high-impact albums (> 90) (EXISTS)
SELECT A_NAME FROM ARTIST A 
WHERE EXISTS (SELECT 1 FROM ALBUM AL WHERE AL.ID_ARTIST = A.ID_ARTIST AND AL.A_POPULARITY > 90);

-- 20. Studios in countries with at least 1 user
SELECT ST_NAME, ST_COUNTRY FROM STUDIO 
WHERE ST_COUNTRY IN (SELECT DISTINCT U_COUNTRY FROM USER);

