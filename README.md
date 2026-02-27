# TI404 – Mini-Project: Database Design and Development
## Music Streaming Platform (Deezer-like)

> **Module:** TI404 – Databases 1: Basic Concepts  
> **Part:** 1 – Requirements Analysis & MCD  
> **Deadline:** February 27, 2026  

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Requirements Analysis](#2-requirements-analysis)
   - [Priming Prompt](#21-priming-prompt)
   - [RICARDO Prompt](#22-ricardo-prompt)
   - [Business Rules](#23-business-rules-obtained)
   - [Data Dictionary](#24-data-dictionary-obtained)
3. [Conceptual Data Model (MCD)](#3-conceptual-data-model-mcd)
   - [MCD Diagram](#31-mcd-diagram)
   - [Modeling Choices](#32-modeling-choices)

---

## 1. Project Overview

This project follows the **MERISE methodology** to design and develop a relational database for a music streaming platform similar to **Deezer**. The platform allows registered users to listen to tracks, browse albums, create playlists, and manage their music library.

---

## 2. Requirements Analysis

### 2.1 Priming Prompt

> You will play the role of a fictional company specializing in music streaming, similar to Deezer. I am a computer science student and I need to design a relational database for this type of platform using the MERISE method. I will send you a structured prompt (RICARDO framework) that you must answer precisely and exhaustively. Do not generate anything yet — wait for my next message.

---

### 2.2 RICARDO Prompt
```
[R - ROLE]
You are the technical director of an online music streaming platform
similar to Deezer. You have in-depth knowledge of the music catalog,
users, subscriptions, and the internal workings of such a platform.

[I - INSTRUCTIONS]
1. Describe the business rules of your platform (minimum 12 rules)
2. Produce a complete data dictionary
3. Make sure each entity has at least 4 distinct attributes

[C - CONTEXT]
The platform is an online music streaming service similar to Deezer.
It allows registered users to listen to tracks, browse albums, create
playlists, and manage their music library.

The main actors are:
- Users: they register, subscribe to a plan (free or premium),
  listen to tracks, and create playlists.
- Artists: they publish albums and tracks. An artist can be solo
  or belong to a group.
- Albums: they contain several tracks, have a release date,
  a music genre, and a record label.
- Tracks: each track has a duration, a title, a unique ISRC code,
  and belongs to one or more albums.
- Playlists: created by users, they group tracks from different artists.
- Subscriptions: free (with ads) or premium (no ads, offline listening).
  A user has one active subscription at a time.
- Music genres: each track and album is associated with one or more
  genres (Pop, Rock, Hip-hop, Electronic...).

The platform also manages copyright: each track is linked to one or
more rights holders with a royalty percentage.

[A - ADDITIONAL CONSTRAINTS]
- Each entity must have at least 4 attributes (including the identifier)
- Specify data types (INT, VARCHAR, DATE, BOOLEAN...)
- Indicate constraints (NOT NULL, UNIQUE, foreign key...)
- Business rules must be written as clear sentences
- Stay consistent with how a real streaming platform works

[R - REFERENCES]
- Official Deezer API: https://developers.deezer.com/api
- Deezer objects: https://developers.deezer.com/api/album
  https://developers.deezer.com/api/track
  https://developers.deezer.com/api/artist
- Spotify API reference: https://developer.spotify.com/documentation/web-api/reference/get-track
- Reference platforms: https://www.deezer.com and https://www.spotify.com

[D - DESIRED OUTPUT]
Return your response in two distinct parts:

PART 1 — Business Rules
Format: numbered list of sentences (minimum 12 rules)

PART 2 — Data Dictionary
Format: Markdown table with columns:
| Entity | Attribute | Type | Constraint | Description |

Expected entities: USER, ARTIST, ALBUM, TRACK, PLAYLIST,
SUBSCRIPTION, GENRE, RECORD_LABEL, GROUP, RIGHTS_HOLDER

[O - OBJECTIVES]
Produce a complete requirements analysis to design a normalized
MERISE MCD in 3NF for a Deezer-like music streaming platform.
The MCD must include: a recursive relationship, an n-ary relationship
(n>2), and a weak entity.
```

---

### 2.3 Business Rules Obtained

1. A user must be registered to access the music listening service.
2. A user has one and only one active subscription at any given time.
3. A subscription can be of type free or premium.
4. A user can create multiple playlists.
5. A playlist is always created by a single user.
6. A playlist can contain multiple tracks, and a track can appear in multiple playlists.
7. An artist can publish multiple albums.
8. An album is published by at least one artist or group.
9. An artist can belong to multiple groups.
10. A group is composed of at least one artist.
11. A track belongs to at least one album.
12. An album contains multiple tracks.
13. Each track has a unique ISRC identifier.
14. A track can be associated with multiple music genres.
15. An album can be associated with multiple music genres.
16. Each track is linked to one or more rights holders.
17. Each rights holder receives a royalty percentage for a given track.
18. The sum of royalties for a track must equal 100%.
19. A track can be recorded by an artist in a studio on a specific date *(n-ary relationship)*.
20. An artist can be the mentor of another artist *(recursive relationship)*.
21. An album track is identified by its track number within the album *(weak entity)*.
22. A record label can produce multiple albums.
23. An album is produced by a single record label.

---

### 2.4 Data Dictionary Obtained

#### USER

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| USER | id_user | INT | PK, NOT NULL | Unique identifier |
| USER | email | VARCHAR(255) | UNIQUE, NOT NULL | Email address |
| USER | password | VARCHAR(255) | NOT NULL | Hashed password |
| USER | registration_date | DATE | NOT NULL | Registration date |
| USER | country | VARCHAR(100) | NOT NULL | Country of residence |

#### SUBSCRIPTION

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| SUBSCRIPTION | id_subscription | INT | PK, NOT NULL | Unique identifier |
| SUBSCRIPTION | type | VARCHAR(20) | NOT NULL | Free / Premium |
| SUBSCRIPTION | start_date | DATE | NOT NULL | Start date |
| SUBSCRIPTION | end_date | DATE | NULL | End date |
| SUBSCRIPTION | status | VARCHAR(20) | NOT NULL | Active / Expired |

#### ARTIST

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| ARTIST | id_artist | INT | PK, NOT NULL | Unique identifier |
| ARTIST | name | VARCHAR(255) | NOT NULL | Artist name |
| ARTIST | career_start | DATE | NULL | Career start date |
| ARTIST | origin_country | VARCHAR(100) | NOT NULL | Country of origin |
| ARTIST | id_mentor | INT | FK (ARTIST) | Mentor artist (recursive) |

#### GROUP

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| GROUP | id_group | INT | PK, NOT NULL | Unique identifier |
| GROUP | name | VARCHAR(255) | NOT NULL | Group name |
| GROUP | creation_date | DATE | NOT NULL | Creation date |
| GROUP | country | VARCHAR(100) | NOT NULL | Country |
| GROUP | status | VARCHAR(50) | NOT NULL | Active / Disbanded |

#### ALBUM

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| ALBUM | id_album | INT | PK, NOT NULL | Unique identifier |
| ALBUM | title | VARCHAR(255) | NOT NULL | Album title |
| ALBUM | release_date | DATE | NOT NULL | Release date |
| ALBUM | id_label | INT | FK | Record label |
| ALBUM | popularity | INT | NOT NULL | Popularity score |

#### TRACK

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| TRACK | id_track | INT | PK, NOT NULL | Unique identifier |
| TRACK | title | VARCHAR(255) | NOT NULL | Track title |
| TRACK | duration | INT | NOT NULL | Duration in seconds |
| TRACK | isrc | VARCHAR(15) | UNIQUE, NOT NULL | ISRC code |
| TRACK | explicit | BOOLEAN | NOT NULL | Explicit content flag |

#### PLAYLIST

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| PLAYLIST | id_playlist | INT | PK, NOT NULL | Unique identifier |
| PLAYLIST | name | VARCHAR(255) | NOT NULL | Playlist name |
| PLAYLIST | creation_date | DATE | NOT NULL | Creation date |
| PLAYLIST | public | BOOLEAN | NOT NULL | Public visibility |
| PLAYLIST | id_user | INT | FK | Creator (User) |

#### GENRE

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| GENRE | id_genre | INT | PK, NOT NULL | Unique identifier |
| GENRE | name | VARCHAR(100) | UNIQUE, NOT NULL | Genre name |
| GENRE | description | VARCHAR(255) | NULL | Description |
| GENRE | origin | VARCHAR(100) | NULL | Geographic origin |
| GENRE | popularity | INT | NOT NULL | Popularity score |

#### RECORD_LABEL

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| RECORD_LABEL | id_label | INT | PK, NOT NULL | Unique identifier |
| RECORD_LABEL | name | VARCHAR(255) | NOT NULL | Label name |
| RECORD_LABEL | country | VARCHAR(100) | NOT NULL | Country |
| RECORD_LABEL | creation_date | DATE | NULL | Creation date |
| RECORD_LABEL | website | VARCHAR(255) | NULL | Website URL |

#### RIGHTS_HOLDER

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| RIGHTS_HOLDER | id_holder | INT | PK, NOT NULL | Unique identifier |
| RIGHTS_HOLDER | name | VARCHAR(255) | NOT NULL | Name |
| RIGHTS_HOLDER | type | VARCHAR(50) | NOT NULL | Artist / Label |
| RIGHTS_HOLDER | contact | VARCHAR(255) | NULL | Contact info |
| RIGHTS_HOLDER | country | VARCHAR(100) | NOT NULL | Country |

#### STUDIO

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| STUDIO | id_studio | INT | PK, NOT NULL | Unique identifier |
| STUDIO | name | VARCHAR(255) | NOT NULL | Studio name |
| STUDIO | city | VARCHAR(100) | NOT NULL | City |
| STUDIO | country | VARCHAR(100) | NOT NULL | Country |
| STUDIO | capacity | INT | NULL | Capacity |

#### RECORDING *(n-ary relationship)*

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| RECORDING | id_recording | INT | PK, NOT NULL | Unique identifier |
| RECORDING | id_track | INT | FK | Track |
| RECORDING | id_artist | INT | FK | Artist |
| RECORDING | id_studio | INT | FK | Studio |
| RECORDING | recording_date | DATE | NOT NULL | Recording date |

#### ALBUM_TRACK *(weak entity)*

| Entity | Attribute | Type | Constraint | Description |
|--------|-----------|------|------------|-------------|
| ALBUM_TRACK | id_album | INT | PK, FK | Album (strong entity) |
| ALBUM_TRACK | track_number | INT | PK | Track number in album |
| ALBUM_TRACK | id_track | INT | FK | Track |
| ALBUM_TRACK | duration | INT | NOT NULL | Duration in seconds |
| ALBUM_TRACK | displayed_title | VARCHAR(255) | NOT NULL | Displayed track title |

> ✔ **Recursive relationship:** `id_mentor` in ARTIST  
> ✔ **N-ary relationship (n=3):** RECORDING (ARTIST + TRACK + STUDIO + date)  
> ✔ **Weak entity:** ALBUM_TRACK (identified by track_number + id_album)

---

## 3. Conceptual Data Model (MCD)

### 3.1 MCD Diagram

![MCD](./mcd.png)

> *The MCD source file is available in this repository.*

---

### 3.2 Modeling Choices

**Recursive relationship — ARTIST mentors ARTIST**  
An artist can be the mentor of one or more other artists, modeled as a self-referencing relationship on ARTIST via `id_mentor`. Cardinality: 0,1 — 0,N.

**N-ary relationship (n=3) — RECORDING**  
A track is recorded by an artist, in a specific studio, on a specific date. All three entities are required to fully describe a recording session and cannot be split into binary relationships without losing information.

**Weak entity — ALBUM_TRACK**  
A track's position in an album has no meaning outside of its parent album. Its composite key is `(id_album, track_number)`. ALBUM is the strong entity, ALBUM_TRACK is the weak entity.

**3NF compliance**  
All entities comply with the Third Normal Form: no partial dependencies (2NF) and no transitive dependencies (3NF). Record label data is stored in a separate RECORD_LABEL entity rather than directly in ALBUM to avoid redundancy.
