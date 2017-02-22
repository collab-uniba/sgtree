#Archi pesati in base al numero di commenti tra due utenti
SELECT
  songtree_messages.senderid  AS commentator,
  songs.memberId              AS author,
  count(songtree_messages.id) AS num_comments
FROM songs
  INNER JOIN songtree_messages
WHERE
  songs.id = songtree_messages.songid AND songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid
GROUP BY commentator, author;

#Nodi e numero di canzoni scritte (solo autori di almeno una canzone)
SELECT
  memberId,
  count(songs.id) AS written_songs
FROM songs
GROUP BY memberId;

#Nodi e numero di canzoni scritte (compresi gli utenti che non hanno scritto mai una canzone)
SELECT
  members.id,
  count(songs.id) AS written_songs
FROM members
  LEFT JOIN songs ON members.id = songs.memberId
GROUP BY members.id;

#################################################   STATISTICHE   #####################################################

#numero di utenti
SELECT count(*)
FROM members;

#numero di song
SELECT count(*)
FROM songs;

#numero di autori
SELECT count(DISTINCT memberid)
FROM songs;

#numero di commenti
SELECT count(*)
FROM songtree_messages
WHERE kind = 0;

#numero song che hanno ricevuto commenti (non sono considerati i commenti degli autori)
SELECT count(DISTINCT songid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId;

#numero autori che hanno ricevuto commenti sulle loro song
SELECT count(DISTINCT memberId)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId;

#numero di utenti che hanno commentato qualche canzone
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId;

#-------------------------------------------------------------------------------------------------------------------

#autori e commenti ricevuti
SELECT
  memberid                    AS author,
  count(songtree_messages.id) AS received_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberid
GROUP BY author;

#utenti e commenti inviati
SELECT
  senderid                    AS commenter,
  count(songtree_messages.id) AS sent_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberid
GROUP BY senderid;

#canzoni e commenti ricevuti
SELECT
  songid,
  count(songtree_messages.id) AS received_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId
GROUP BY songid;

#################################################   PER GENERE   #####################################################

#Archi pesati in base al numero di commenti tra due utenti (singolo GENERE)
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS num_comments
FROM songs
  INNER JOIN songtree_messages
    ON
      songs.id = songtree_messages.songid
WHERE songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid AND songs.genre = 'Rock'
GROUP BY source, target;

#Nodi e canzoni scritte (singolo GENERE)
SELECT
  memberId  AS id,
  count(id) AS written_songs
FROM songs
WHERE genre = 'Rock'
GROUP BY memberId;

#----------------------------------------------------------------------------------------------------------------------

#Numero totale di canzoni esistenti (per GENERE)
SELECT count(id) AS numero_canzoni
FROM songs
WHERE genre = 'Rock';

#numero di commenti ricevuti da ogni canzone (per GENERE)
SELECT count(songtree_messages.id)
FROM songs
  INNER JOIN songtree_messages
    ON songs.id = songtree_messages.songid AND kind = 0 AND songs.memberId != songtree_messages.senderid AND
       songs.genre = 'Rock';

#numero di autori (per GENERE)
SELECT count(DISTINCT memberId)
FROM songs
WHERE genre = 'Rock';

#----------------------------------------------------------------------------------------------------------------------

#utenti e numero di commenti inviati (per GENERE)
SELECT
  senderid                    AS user,
  count(songtree_messages.id) AS sent_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberid AND genre = 'Rock'
GROUP BY user;

#autori e numero di commenti ricevuti (per GENERE)
SELECT
  memberid                    AS user,
  count(songtree_messages.id) AS received_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberid AND genre = 'Rock'
GROUP BY user;

#canzoni e numero di commenti ricevuti (per GENERE)
SELECT
  songid,
  count(songtree_messages.id) AS received_comments
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId AND genre = 'Rock'
GROUP BY songid;

#----------------------------------------------------------------------------------------------------------------------

#Autori e numero canzoni scritte per ogni singolo genere
SELECT
  memberId,
  genre,
  count(*) AS num_songs
FROM songs
WHERE genre = 'Rock' OR genre = 'Pop' OR genre = 'Hip Hop' OR genre = 'Electronic' OR genre = 'Acoustic' OR
      genre = 'Alternative'
GROUP BY memberId, genre;

################################################    MISC    ####################################################


SELECT count(*)
FROM songs
WHERE memberId = 154699;

#utenti totali
SELECT id
FROM members
UNION SELECT memberId AS id
      FROM songs
UNION SELECT memberid AS id
      FROM account_creation_log
ORDER BY id ASC;

#numero di utenti totali
SELECT count(*)
FROM members
UNION SELECT memberId AS id
      FROM songs
UNION SELECT memberid AS id
      FROM account_creation_log;

#utenti che hanno commentato ma non hanno scritto canzoni
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid NOT IN (SELECT memberId
                                    FROM songs);

#utenti che hanno scritto canzoni ma non hanno commentato
SELECT DISTINCT memberId
FROM songs
WHERE memberId NOT IN (SELECT senderid
                       FROM songtree_messages
                       WHERE kind = 0);

#utenti che hanno commentato e scritto canzoni
SELECT DISTINCT memberId
FROM songs
WHERE memberId IN (SELECT senderid
                   FROM songtree_messages
                   WHERE kind = 0);

SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid IN (SELECT DISTINCT memberId
                                FROM songs);

#canzoni e overdub ricevuti
SELECT
  parentid,
  count(*) AS num_overdub
FROM songs
GROUP BY parentid;

################################################   ALTRO   ####################################################