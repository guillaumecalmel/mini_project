-- 1. SECURITÉ ET NETTOYAGE
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE RECORDING; TRUNCATE TABLE ALBUM_TRACK; TRUNCATE TABLE ALBUM;
TRUNCATE TABLE TRACK; TRUNCATE TABLE ARTIST; TRUNCATE TABLE USER;
TRUNCATE TABLE SUBSCRIPTION; TRUNCATE TABLE GENRE; TRUNCATE TABLE STUDIO;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE TRACK MODIFY T_ISRC VARCHAR(30);

-- 2. SUBSCRIPTIONS
INSERT INTO SUBSCRIPTION (ID_SUBSCRIPTION, S_TYPE, S_START_DATE, S_STATUS) VALUES
(1, 'Premium', '2025-01-01', 'Active'),
(2, 'Free', '2025-01-15', 'Active'),
(3, 'Premium', '2025-02-01', 'Active'),
(4, 'Free', '2025-02-10', 'Expired');

-- 3. USERS (Ajout de profils au UK, France et USA pour tes requêtes)
INSERT INTO USER (ID_USER, U_EMAIL, U_PASSWORD, U_REGISTRATION_DATE, U_COUNTRY, ID_SUBSCRIPTION) VALUES
(1, 'alice.smith@email.com', 'pwd1', '2025-01-01', 'USA', 1),
(2, 'bob.normand@email.fr', 'pwd2', '2025-01-15', 'France', 2),
(3, 'charlie.uk@music.co.uk', 'pwd3', '2025-02-01', 'UK', 1), -- Pour ta requête 16 !
(4, 'david.london@gmail.com', 'pwd4', '2025-02-05', 'UK', 3), -- Pour ta requête 16 !
(5, 'emma.berlin@web.de', 'pwd5', '2025-02-10', 'Germany', 1);

-- 4. ARTISTS (Hierarchie de mentors)
INSERT INTO ARTIST (ID_ARTIST, A_NAME, A_CAREER_START, A_ORIGIN_COUNTRY, ID_MENTOR) VALUES
(1, 'The Legend', '1990-05-12', 'USA', NULL),
(2, 'Young Prodigy', '2020-01-01', 'UK', 1),
(3, 'Rhythm Master', '2010-11-20', 'France', NULL),
(4, 'Electro Queen', '2015-06-30', 'Germany', 3),
(5, 'Jazz Cat', '1985-03-15', 'USA', NULL),
(6, 'Indie Soul', '2023-09-12', 'UK', 2);

-- 5. GENRES
INSERT INTO GENRE (ID_GENRE, G_NAME, G_DESCRIPTION, G_ORIGIN, G_POPULARITY) VALUES
(1, 'Rock', 'Electric guitars and energy', 'USA/UK', 85),
(2, 'Jazz', 'Improvisation and soul', 'USA', 70),
(3, 'Techno', 'Electronic beats', 'Germany', 92),
(4, 'Pop', 'Catchy melodies', 'Global', 95),
(10, 'Reggae', 'Rhythmic offbeats', 'Jamaica', 72);

-- 6. TRACKS (Variété de durées pour tes tests)
INSERT INTO TRACK (ID_TRACK, T_TITLE, T_DURATION, T_ISRC, T_EXPLICIT) VALUES
(1, 'Eternal Flame', 210, 'US-RC1-23-00001', FALSE),
(2, 'Midnight Drive', 185, 'UK-RC2-23-00002', TRUE),
(3, 'Berlin Night', 320, 'DE-RC3-24-00101', FALSE),
(4, 'Neon Lights', 195, 'DE-RC4-24-00102', FALSE),
(5, 'Blue Note', 410, 'US-RC5-24-00501', FALSE),
(10, 'Cyber Beat', 180, 'SE-RC10-23-00010', TRUE);

-- 7. ALBUMS
INSERT INTO ALBUM (ID_ALBUM, A_TITLE, A_RELEASE_DATE, A_POPULARITY, ID_ARTIST) VALUES
(1, 'Greatest Hits', '2020-10-10', 95, 1),
(2, 'The Beginning', '2021-05-05', 80, 2),
(3, 'Night Walkers', '2024-01-15', 88, 4),
(4, 'Soul Sessions', '2018-11-20', 75, 5),
(10, 'Pulse Theory', '2024-02-02', 89, 3);

-- 8. ALBUM_TRACK
INSERT INTO ALBUM_TRACK (ID_ALBUM, TRACK_NUMBER, AT_DURATION, AT_DISPLAYED_TITLE, ID_TRACK) VALUES
(1, 1, 210, 'Eternal Flame (Remastered)', 1),
(2, 1, 185, 'Midnight Drive - Edit', 2),
(3, 1, 320, 'Berlin Night (Original)', 3),
(3, 2, 195, 'Neon Lights', 4),
(10, 1, 180, 'Cyber Beat', 10);

-- 9. STUDIOS
INSERT INTO STUDIO (ID_STUDIO, ST_NAME, ST_CITY, ST_COUNTRY) VALUES
(1, 'Abbey Road', 'London', 'UK'),
(2, 'Capitol Studios', 'Los Angeles', 'USA'),
(3, 'Berghain Studio', 'Berlin', 'Germany'),
(4, 'La Fabrique', 'Saint-Rémy', 'France'),
(10, 'Synth Haven', 'Stockholm', 'Sweden');

-- 10. RECORDINGS (Pour lier tout le monde)
INSERT INTO RECORDING (ID_RECORDING, ID_TRACK, ID_ARTIST, ID_STUDIO, recording_date) VALUES
(1, 1, 1, 2, '2020-08-15'),
(2, 2, 2, 1, '2021-02-10'),
(3, 3, 4, 3, '2023-11-05'),
(4, 4, 4, 3, '2023-11-06'),
(5, 5, 5, 2, '2018-05-20'),
(10, 10, 3, 10, '2024-01-05');
