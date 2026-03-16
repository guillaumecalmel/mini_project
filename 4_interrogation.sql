-- CATEGORY 1: Selections, Projections, Sorting & Masks (5)
-- 1. Identify artists from the USA (Target market)
SELECT A_NAME, A_ORIGIN_COUNTRY 
FROM ARTIST 
WHERE A_ORIGIN_COUNTRY = 'USA'
ORDER BY A_NAME ASC;

-- 2. Find tracks with 'Beat' in the titlalbumID_ALBUMID_ALBUMA_TITLEID_LABELalbum_trackartiste (Trend searching)
SELECT T_TITLE, T_ISRC 
FROM TRACK 
WHERE T_TITLE LIKE '%Beat%';

-- 3. List unique countries where the label has studios
SELECT DISTINCT ST_COUNTRY FROM STUDIO;

-- 4. Find highly popular albums (Score > 80)
SELECT A_TITLE, A_POPULARITY 
FROM ALBUM 
WHERE A_POPULARITY > 80;

-- 5. List all non-explicit tracks for radio promotion
SELECT T_TITLE, T_DURATION 
FROM TRACK 
WHERE T_EXPLICIT = FALSE; 

-- CATEGORY 2: Aggregation Functions & Grouping (5)
-- 6. Count how many users the platform has per country

SELECT U_COUNTRY, COUNT(*) AS TOTAL_USERS 
FROM USER 
GROUP BY U_COUNTRY;

-- 7. Average popularity of genres (Market trends)
SELECT G_NAME, AVG(G_POPULARITY) AS AVG_POP 
FROM GENRE 
GROUP BY G_NAME 
HAVING AVG(G_POPULARITY) > 50;

-- 8. Find the longest track duration available
SELECT MAX(T_DURATION) AS LONGEST_TRACK FROM TRACK;

-- 9. Total number of recordings produced by the label
SELECT COUNT(*) AS TOTAL_RECORDINGS FROM RECORDING;

-- 10. List genres more popular than the average of all genres
SELECT G_NAME, G_POPULARITY 
FROM GENRE 
WHERE G_POPULARITY > (SELECT AVG(G_POPULARITY) FROM GENRE);

-- CATEGORY 3: Joins (Internal, External, Multiple) (5)
-- 11. Traceability: Track name, Artist name, and Studio used (Triple Join)
SELECT T.T_TITLE, A.A_NAME, S.ST_NAME 
FROM RECORDING R
JOIN TRACK T ON R.ID_TRACK = T.ID_TRACK
JOIN ARTIST A ON R.ID_ARTIST = A.ID_ARTIST
JOIN STUDIO S ON R.ID_STUDIO = S.ID_STUDIO;

-- 12. Mentorship: List all Proteges and their Mentors (Left Join)
SELECT P.A_NAME AS PROTEGE, M.A_NAME AS MENTOR
FROM ARTIST P
LEFT JOIN ARTIST M ON P.ID_MENTOR = M.ID_ARTIST;

-- 13. Revenue potential: List users with their subscription type
SELECT U.U_EMAIL, S.S_TYPE 
FROM USER U
JOIN SUBSCRIPTION S ON U.ID_SUBSCRIPTION = S.ID_SUBSCRIPTION;

-- 14. Inventory: List tracks displayed on the 'Greatest Hits' album
SELECT AT.AT_DISPLAYED_TITLE, AT.TRACK_NUMBER
FROM ALBUM_TRACK AT
JOIN ALBUM A ON AT.ID_ALBUM = A.ID_ALBUM
WHERE A.A_TITLE = 'Greatest Hits';

-- 15. Studio check: Find all artists who recorded at 'Capitol Studios'
SELECT DISTINCT A.A_NAME
FROM ARTIST A
JOIN RECORDING R ON A.ID_ARTIST = R.ID_ARTIST
JOIN STUDIO S ON R.ID_STUDIO = S.ID_STUDIO
WHERE S.ST_NAME = 'Capitol Studios';

-- CATEGORY 4: Nested Queries (Subqueries) (5)
-- 16. Find users in the same country as the artist 'Young Prodigy'

SELECT U_EMAIL FROM USER 
WHERE U_COUNTRY = (SELECT A_ORIGIN_COUNTRY FROM ARTIST WHERE A_NAME = 'Young Prodigy');

-- 17. Detect artists who have no recorded sessions yet (Ghost Artists)
SELECT A_NAME FROM ARTIST 
WHERE ID_ARTIST NOT IN (SELECT ID_ARTIST FROM RECORDING);

-- 18. Find tracks longer than the 'Cyber Beat' track
SELECT T_TITLE, T_DURATION FROM TRACK 
WHERE T_DURATION > (SELECT T_DURATION FROM TRACK WHERE T_TITLE = 'Cyber Beat');

-- 19. Identify artists with at least one high-popularity album (EXISTS)
SELECT A_NAME FROM ARTIST A 
WHERE EXISTS (SELECT 1 FROM ALBUM AL WHERE AL.ID_ARTIST = A.ID_ARTIST AND AL.A_POPULARITY > 90);

-- 20. List studios located in countries with at least one registered user
SELECT ST_NAME, ST_COUNTRY FROM STUDIO 
WHERE ST_COUNTRY IN (SELECT DISTINCT U_COUNTRY FROM USER);
