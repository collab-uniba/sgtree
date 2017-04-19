#######################################################################################################################
#################################################   STATISTICHE   #####################################################
#######################################################################################################################

############################################################################
#####################   ENTITA' MODELLO CONCETTUALE   ######################
############################################################################

SELECT count(*)
FROM songs;

#NEW SONGS
SELECT count(*)
FROM songs
WHERE parentid = 0;

#OVERDUB
SELECT count(*)
FROM songs
WHERE parentid != 0;

#(likers e reposters)
CREATE VIEW likers_and_reposters AS
  SELECT DISTINCT memberId AS id
  FROM repost
  UNION (SELECT DISTINCT memberId
         FROM songsRatings
         WHERE rating >= 2.5);

#VIEW commenters non authors
CREATE VIEW commenters_non_authors AS
  SELECT DISTINCT senderid AS id
  FROM songtree_messages
    INNER JOIN songs ON songtree_messages.songid = songs.id
  WHERE kind = 0 AND senderid != songs.memberId AND senderid NOT IN (SELECT DISTINCT memberId
                                                                     FROM songs);

#da likers and reposters gli utenti che hanno scritto canzoni o hanno commentato
SELECT *
FROM likers_and_reposters
WHERE id NOT IN (SELECT DISTINCT memberId AS id
                 FROM songs
                 UNION SELECT id
                       FROM commenters_non_authors);

#Coloro che hanno effettuato qualche attività nella comunity. Le attività comprendono: scrittura, invio di messaggi,
#bookmark, ascolto di canzoni, repost, following, like, direct messages.
SELECT DISTINCT memberId AS id
FROM songs
UNION SELECT DISTINCT senderid AS id
      FROM songtree_messages
        INNER JOIN songs ON songtree_messages.songid = songs.id
      WHERE kind = 0 AND memberId != senderid
UNION SELECT DISTINCT memberId AS id
      FROM songtree_favorites
UNION SELECT DISTINCT userid AS id
      FROM songplays
UNION SELECT DISTINCT follower_id AS id
      FROM songtree_following
UNION SELECT DISTINCT memberId AS id
      FROM repost
UNION SELECT DISTINCT memberId AS id
      FROM songsRatings
      WHERE rating >= 2.5
UNION SELECT DISTINCT senderid AS id
      FROM songtree_messages
      WHERE kind = 1;