-- 1. Insert SUBSCRIPTIONS (Parent table for USER)
INSERT INTO SUBSCRIPTION (ID_SUBSCRIPTION, S_TYPE, S_START_DATE, S_STATUS) VALUES
(1, 'Premium', '2025-01-01', 'Active'),
(2, 'Free', '2025-01-15', 'Active'),
(3, 'Premium', '2024-12-01', 'Expired'),
(4, 'Premium', '2025-02-10', 'Active'),
(5, 'Free', '2025-03-01', 'Active'),
(6, 'Premium', '2025-01-20', 'Active'),
(7, 'Free', '2024-11-15', 'Expired'),
(8, 'Premium', '2025-02-25', 'Active'),
(9, 'Free', '2025-03-05', 'Active'),
(10, 'Premium', '2025-01-10', 'Active');

-- 2. Insert USERS
INSERT INTO USER (ID_USER, U_EMAIL, U_PASSWORD, U_REGISTRATION_DATE, U_COUNTRY, ID_SUBSCRIPTION) VALUES
(1, 'alice.smith@email.com', 'hash_pw1', '2025-01-01', 'USA', 1),
(2, 'bob.jones@email.fr', 'hash_pw2', '2025-01-15', 'France', 2),
(3, 'charlie.brown@email.uk', 'hash_pw3', '2024-12-01', 'UK', 3),
(4, 'david.wilson@email.ca', 'hash_pw4', '2025-02-10', 'Canada', 4),
(5, 'eve.davis@email.de', 'hash_pw5', '2025-03-01', 'Germany', 5),
(6, 'frank.miller@email.it', 'hash_pw6', '2025-01-20', 'Italy', 6),
(7, 'grace.lee@email.jp', 'hash_pw7', '2024-11-15', 'Japan', 7),
(8, 'henry.ford@email.us', 'hash_pw8', '2025-02-25', 'USA', 8),
(9, 'isabel.garcia@email.es', 'hash_pw9', '2025-03-05', 'Spain', 9),
(10, 'jack.white@email.au', 'hash_pw10', '2025-01-10', 'Australia', 10);

-- 3. Insert ARTISTS (Including Recursive Relationship / Mentor)
INSERT INTO ARTIST (ID_ARTIST, A_NAME, A_CAREER_START, A_ORIGIN_COUNTRY, ID_ARTIST_1) VALUES
(1, 'The Legend', '1990-05-12', 'USA', NULL),
(2, 'Young Prodigy', '2020-01-01', 'UK', 1), -- Mentor is ID 1
(3, 'Rhythm Master', '2010-11-20', 'France', NULL),
(4, 'Synth Queen', '2015-06-15', 'Germany', 1),
(5, 'Jazz Cat', '2005-03-30', 'USA', NULL),
(6, 'Pop Star', '2022-09-10', 'Canada', 2),
(7, 'Indie Soul', '2018-02-14', 'Australia', NULL),
(8, 'Rock Titan', '1985-07-22', 'UK', NULL),
(9, 'Blue Note', '2012-12-12', 'USA', 3),
(10, 'Electro Pulse', '2024-01-01', 'Sweden', NULL);

-- 4. Insert GENRES
INSERT INTO GENRE (ID_GENRE, G_NAME, G_DESCRIPTION, G_ORIGIN, G_POPULARITY) VALUES
(1, 'Rock', 'Electric guitars and strong beats', 'USA/UK', 85),
(2, 'Jazz', 'Improvisation and swing', 'USA', 70),
(3, 'Pop', 'Catchy melodies and wide appeal', 'Global', 95),
(4, 'Electronic', 'Synthesizers and digital production', 'Germany', 80),
(5, 'Hip Hop', 'Rhythmic speech and street culture', 'USA', 90),
(6, 'Classical', 'Orchestral and traditional', 'Europe', 60),
(7, 'Blues', 'Melancholy and soulful', 'USA', 65),
(8, 'Indie', 'Independent production style', 'UK', 75),
(9, 'Metal', 'Heavy distortion and power', 'UK', 68),
(10, 'Reggae', 'Rhythmic offbeats and chill vibes', 'Jamaica', 72);

-- 5. Insert TRACKS
INSERT INTO TRACK (ID_TRACK, T_TITLE, T_DURATION, T_ISRC, T_EXPLICIT) VALUES
(1, 'Eternal Flame', 210, 'US-RC1-23-00001', FALSE),
(2, 'Midnight Drive', 185, 'UK-RC2-23-00002', TRUE),
(3, 'Sunset Boulevard', 245, 'FR-RC3-23-00003', FALSE),
(4, 'Neon Lights', 200, 'DE-RC4-23-00004', FALSE),
(5, 'Soul Groove', 300, 'US-RC5-23-00005', FALSE),
(6, 'City Echoes', 192, 'CA-RC6-23-00006', TRUE),
(7, 'Ocean Breeze', 220, 'AU-RC7-23-00007', FALSE),
(8, 'Thunder Road', 275, 'UK-RC8-23-00008', FALSE),
(9, 'Jazz Night', 320, 'US-RC9-23-00009', FALSE),
(10, 'Cyber Beat', 180, 'SE-RC10-23-00010', TRUE);

-- 6. Insert ALBUMS
INSERT INTO ALBUM (ID_ALBUM, A_TITLE, A_RELEASE_DATE, A_POPULARITY, ID_ARTIST) VALUES
(1, 'Greatest Hits', '2020-10-10', 95, 1),
(2, 'The Beginning', '2021-05-05', 80, 2),
(3, 'Rhythm Section', '2019-12-25', 75, 3),
(4, 'Digital Soul', '2022-03-14', 88, 4),
(5, 'Classic Vibe', '2018-08-20', 70, 5),
(6, 'Pop World', '2023-01-01', 92, 6),
(7, 'Acoustic Dreams', '2020-06-15', 78, 7),
(8, 'The Titan Era', '2015-11-30', 85, 8),
(9, 'Midnight Jazz', '2022-11-11', 82, 9),
(10, 'Pulse Theory', '2024-02-02', 89, 10);

-- 7. Insert ALBUM_TRACK (Weak Entity: ID_ALBUM + TRACK_NUMBER)
INSERT INTO ALBUM_TRACK (ID_ALBUM, TRACK_NUMBER, AT_DURATION, AT_DISPLAYED_TITLE, ID_TRACK) VALUES
(1, 1, 210, 'Eternal Flame (Remastered)', 1),
(2, 1, 185, 'Midnight Drive - Radio Edit', 2),
(3, 1, 245, 'Sunset Boulevard', 3),
(4, 1, 200, 'Neon Lights (Extended)', 4),
(5, 1, 300, 'Soul Groove', 5),
(6, 1, 192, 'City Echoes', 6),
(7, 1, 220, 'Ocean Breeze', 7),
(8, 1, 275, 'Thunder Road', 8),
(9, 1, 320, 'Jazz Night (Live)', 9),
(10, 1, 180, 'Cyber Beat', 10);

-- 8. Insert STUDIOS
INSERT INTO STUDIO (ID_STUDIO, ST_NAME, ST_CITY, ST_COUNTRY) VALUES
(1, 'Abbey Road', 'London', 'UK'),
(2, 'Capitol Studios', 'Los Angeles', 'USA'),
(3, 'Studio Davout', 'Paris', 'France'),
(4, 'Hansa Studios', 'Berlin', 'Germany'),
(5, 'Power Station', 'New York', 'USA'),
(6, 'Revolution Studio', 'Toronto', 'Canada'),
(7, 'The Groove Room', 'Sydney', 'Australia'),
(8, 'Rock Palace', 'Manchester', 'UK'),
(9, 'Blue Velvet', 'Nashville', 'USA'),
(10, 'Synth Haven', 'Stockholm', 'Sweden');

-- 9. Insert RECORDINGS (N-ary Relationship)
INSERT INTO RECORDING (ID_RECORDING, ID_TRACK, ID_ARTIST, ID_STUDIO, recording_date) VALUES
(1, 1, 1, 2, '2020-08-15'),
(2, 2, 2, 1, '2021-02-10'),
(3, 3, 3, 3, '2019-10-01'),
(4, 4, 4, 4, '2022-01-20'),
(5, 5, 5, 5, '2018-05-12'),
(6, 6, 6, 6, '2022-11-05'),
(7, 7, 7, 7, '2020-04-30'),
(8, 8, 8, 8, '2015-09-18'),
(9, 9, 9, 9, '2022-08-22'),
(10, 10, 10, 10, '2024-01-05');