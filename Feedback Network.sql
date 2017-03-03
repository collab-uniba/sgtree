#######################################################################################################################
################################################   FEEDBACK NETWORK   #################################################
#######################################################################################################################

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

###########################################   FEEDBACK NETWORK (PER GENERE)   #########################################

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

############################################    FEEDBACK NETWORK PRUNED    ############################################

#Archi Pruned Social network
SELECT
  songtree_messages.senderid  AS commentator,
  songs.memberId              AS author,
  count(songtree_messages.id) AS num_comments
FROM songs
  INNER JOIN songtree_messages
WHERE
  songs.id = songtree_messages.songid AND songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid
GROUP BY commentator, author
HAVING count(num_comments) >= 150;

#######################################    FEEDBACK NETWORK PRUNED FOR GENRES   ######################################

#Archi Pruned Social network (PER GENERE)
SELECT
  songtree_messages.senderid  AS source,
  songs.memberId              AS target,
  count(songtree_messages.id) AS weight
FROM songs
  INNER JOIN songtree_messages
WHERE
  songs.id = songtree_messages.songid AND songtree_messages.kind = 0 AND songs.memberId != songtree_messages.senderid
  AND genre = 'Alternative'
GROUP BY source, target
HAVING count(num_comments) >= 30;