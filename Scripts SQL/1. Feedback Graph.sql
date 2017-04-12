#######################################################################################################################
################################################   FEEDBACK NETWORK   #################################################
#######################################################################################################################

#Nodi con canzoni, nuove canzoni e overdub scritti
SELECT
  users_and_usernames.id,
  username                       AS label,
  coalesce(songs_written, 0)     AS songs_written,
  coalesce(new_songs_written, 0) AS new_songs_written,
  coalesce(overdubs_written, 0)  AS overdubs_written
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs_written,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END) AS new_songs_written,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END) AS overdubs_written
   FROM songs
   GROUP BY memberId) AS t RIGHT JOIN users_and_usernames ON t.memberId = users_and_usernames.id;

#Archi pesati in base al numero di commenti tra due utenti
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
WHERE
  songs.id = songtree_messages.songid AND songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid
GROUP BY source, target;

#Archi NON ORIENTATI pesati in base al numero di commenti tra due utenti
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight,
  'Undirected'
FROM songs
  INNER JOIN songtree_messages
WHERE
  songs.id = songtree_messages.songid AND songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid
GROUP BY source, target;

#######################################################################################################################
###########################################   FEEDBACK NETWORK (PER GENERE)   #########################################
#######################################################################################################################

#################   ROCK E BLUES   #################

#Autori con canzoni, nuove canzoni e overdub scritti
SELECT
  memberId AS id,
  username AS label,
  songs_written,
  new_songs_written,
  overdubs_written
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs_written,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END) AS new_songs_written,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END) AS overdubs_written
   FROM songs
   WHERE (genre = 'Rock'
          OR genre = 'Religious'
          OR genre = 'Country'
          OR genre = 'Reggae'
          OR genre = 'Gospel'
          OR genre = 'Punk'
          OR genre = 'Heavy Metal'
          OR genre = 'Folk'
          OR genre = 'Pop'
          OR genre = 'Blues')
   GROUP BY memberId) AS t INNER JOIN users_and_usernames ON t.memberId = users_and_usernames.id;

#Archi pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Rock'
           OR genre = 'Religious'
           OR genre = 'Country'
           OR genre = 'Reggae'
           OR genre = 'Gospel'
           OR genre = 'Punk'
           OR genre = 'Heavy Metal'
           OR genre = 'Folk'
           OR genre = 'Pop'
           OR genre = 'Blues')
GROUP BY SOURCE, target;

#Archi NON ORIENTATI pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight,
  'Undirected'
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Rock'
           OR genre = 'Religious'
           OR genre = 'Country'
           OR genre = 'Reggae'
           OR genre = 'Gospel'
           OR genre = 'Punk'
           OR genre = 'Heavy Metal'
           OR genre = 'Folk'
           OR genre = 'Pop'
           OR genre = 'Blues')
GROUP BY SOURCE, target;

#################   HIP HOP E R&B   #################

#Autori con canzoni, nuove canzoni e overdub scritti
SELECT
  memberId AS id,
  username AS label,
  songs_written,
  new_songs_written,
  overdubs_written
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs_written,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END) AS new_songs_written,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END) AS overdubs_written
   FROM songs
   WHERE (genre = 'Hip Hop'
          OR genre = 'Rap'
          OR genre = 'Dance'
          OR genre = 'R&B'
          OR genre = 'Soul'
          OR genre = 'Funky')
   GROUP BY memberId) AS t INNER JOIN users_and_usernames ON t.memberId = users_and_usernames.id;

#Archi pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Hip Hop'
           OR genre = 'Rap'
           OR genre = 'Dance'
           OR genre = 'R&B'
           OR genre = 'Soul'
           OR genre = 'Funky')
GROUP BY source, target;

#Archi NON ORIENTATI pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight,
  'Undirected'
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Hip Hop'
           OR genre = 'Rap'
           OR genre = 'Dance'
           OR genre = 'R&B'
           OR genre = 'Soul'
           OR genre = 'Funky')
GROUP BY source, target;

#################   ALTERNATIVE E ELECTRONIC   #################

#Autori con canzoni, nuove canzoni e overdub scritti
SELECT
  memberId AS id,
  username AS label,
  songs_written,
  new_songs_written,
  overdubs_written
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs_written,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END) AS new_songs_written,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END) AS overdubs_written
   FROM songs
   WHERE (genre = 'Alternative'
          OR genre = 'Indie'
          OR genre = 'Electronic'
          OR genre = 'Acoustic')
   GROUP BY memberId) AS t INNER JOIN users_and_usernames ON t.memberId = users_and_usernames.id;

#Archi pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Alternative'
           OR genre = 'Indie'
           OR genre = 'Electronic'
           OR genre = 'Acoustic')
GROUP BY source, target;

#Archi NON ORIENTATI pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight,
  'Undirected'
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Alternative'
           OR genre = 'Indie'
           OR genre = 'Electronic'
           OR genre = 'Acoustic')
GROUP BY source, target;

#################   JAZZ E CLASSICAL   #################

#Autori con canzoni, nuove canzoni e overdub scritti
SELECT
  memberId AS id,
  username AS label,
  songs_written,
  new_songs_written,
  overdubs_written
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs_written,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END) AS new_songs_written,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END) AS overdubs_written
   FROM songs
   WHERE (genre = 'Ambient'
          OR genre = 'Jazz'
          OR genre = 'Fusion'
          OR genre = 'Classical'
          OR genre = 'Soundtrack')
   GROUP BY memberId) AS t INNER JOIN users_and_usernames ON T.memberId = users_and_usernames.id;

#Archi pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Ambient'
           OR genre = 'Jazz'
           OR genre = 'Fusion'
           OR genre = 'Classical'
           OR genre = 'Soundtrack')
GROUP BY source, target;

#Archi NON ORIENTATI pesati in base al numero di commenti tra due utenti.
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight,
  'Undirected'
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0
      AND songs.memberId != songtree_messages.senderid
      AND (genre = 'Ambient'
           OR genre = 'Jazz'
           OR genre = 'Fusion'
           OR genre = 'Classical'
           OR genre = 'Soundtrack')
GROUP BY source, target;