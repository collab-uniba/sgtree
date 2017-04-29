#######################################################################################################################
#################################################   STATISTICHE   #####################################################
#######################################################################################################################

#########################################################
#####################   GENERALE   ######################
#########################################################

##############################################
##################   USER   ##################

#utenti totali
SELECT id
FROM members
UNION SELECT memberId AS id
      FROM songs
UNION SELECT memberid AS id
      FROM account_creation_log
UNION SELECT senderid AS id
      FROM songtree_messages
UNION SELECT receiverid AS id
      FROM songtree_messages
UNION SELECT memberId AS id
      FROM member_artist_optout
UNION SELECT memberid AS id
      FROM member_genre_optout
UNION SELECT memberid AS id
      FROM repost
UNION SELECT memberid AS id
      FROM songsRatings
UNION SELECT memberid AS id
      FROM songtree_favorites
UNION SELECT follower_id AS id
      FROM songtree_following
UNION SELECT followed_id AS id
      FROM songtree_following
ORDER BY id ASC;

#numero di autori
SELECT count(DISTINCT memberid)
FROM songs;

#autori di new songs
SELECT count(DISTINCT memberId)
FROM songs
WHERE parentid = 0;

#autori di overdub
SELECT count(DISTINCT memberId)
FROM songs
WHERE parentid != 0;

#autori di remix
SELECT count(DISTINCT memberId)
FROM songs
WHERE isremix = 1;

#autori di cover
SELECT count(DISTINCT memberId)
FROM songs
  INNER JOIN cover_songs ON songs.coverid = cover_songs.id;

#############################################
##################   SONG   #################

#numero di song
SELECT count(*)
FROM songs;

#numero di new songs
SELECT count(*)
FROM songs
WHERE parentid = 0;

#numero di overdubs
SELECT count(*)
FROM songs
WHERE parentid != 0;

#numero di remix
SELECT count(*)
FROM songs
WHERE isremix = 1;

#numero di canzoni cover
SELECT count(*)
FROM songs
  INNER JOIN cover_songs
    ON songs.coverid = cover_songs.id;

#numero di overdub da contest
SELECT count(*)
FROM songs
  INNER JOIN tree_info ON songs.tree_id = tree_info.id
WHERE parentid != 0;

#numero di root song da contest
SELECT count(*)
FROM songs
  INNER JOIN tree_info ON songs.tree_id = tree_info.id
WHERE parentid = 0;

#numero di canzoni chiuse
SELECT count(*)
FROM songs
WHERE isclosedsong = 1 OR isclosedsong = 2;

#################################################
##################   COMMENTS   #################

#numero di commenti
SELECT count(*)
FROM songtree_messages
WHERE kind = 0;

#numero di commenti (esclusi quelli degli autori della canzone)
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages
    ON songs.id = songtree_messages.songid
WHERE kind = 0 AND memberId != songtree_messages.senderid;

############################################################
##################   USER WRITES COMMENT   #################

#numero totale di utenti che hanno commentato
SELECT count(DISTINCT senderid)
FROM songtree_messages
WHERE kind = 0;

#numero di utenti che hanno commentato canzoni di altri utenti
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId;

#numero autori che hanno ricevuto commenti sulle loro song
SELECT count(DISTINCT memberId)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId;

#autori che hanno commentato le proprie song
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid = memberId;

#utenti che hanno commentato ma non hanno scritto canzoni
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid NOT IN (SELECT DISTINCT memberId
                                    FROM songs);

#utenti che hanno scritto canzoni ma non hanno commentato
SELECT DISTINCT memberId
FROM songs
WHERE memberId NOT IN (SELECT DISTINCT senderid
                       FROM songtree_messages
                       WHERE kind = 0);

#utenti che hanno commentato e scritto canzoni 1
SELECT DISTINCT memberId
FROM songs
WHERE memberId IN (SELECT senderid
                   FROM songtree_messages
                   WHERE kind = 0);

#utenti che hanno commentato e scritto canzoni 2
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid IN (SELECT DISTINCT memberId
                                FROM songs);

#numero totale di utenti che hanno commentato solo le proprie canzoni NON CORRETTA
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid NOT IN (SELECT DISTINCT senderid
                                    FROM songs
                                      INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
                                    WHERE kind = 0 AND senderid != memberId);

##############################################################
########################   GENERI   ##########################
##############################################################

###################################################
###################   AUTORI   ####################

#numero autori GENERE
SELECT count(DISTINCT memberId)
FROM songs
WHERE genre = 'Acoustic';

#numero autori new songs GENERE
SELECT count(DISTINCT memberId)
FROM songs
WHERE genre = 'Acoustic' AND parentid = 0;

#numero autori overdubs GENERE
SELECT count(DISTINCT memberId)
FROM songs
WHERE genre = 'Acoustic' AND parentid != 0 AND isremix = 0;

#numero autori remix GENERE
SELECT count(DISTINCT memberId)
FROM songs
WHERE genre = 'Acoustic' AND isremix = 1;

#autori di cover
SELECT count(DISTINCT memberId)
FROM songs
  INNER JOIN cover_songs ON songs.coverid = cover_songs.id
WHERE genre = 'Acoustic';

###############################################
##################   SONG   ###################

#numero song
SELECT count(*)
FROM songs
WHERE genre = 'Acoustic';

#numero new song
SELECT count(*)
FROM songs
WHERE genre = 'Acoustic' AND parentid = 0;

#numero overdubs
SELECT count(*)
FROM songs
WHERE genre = 'Acoustic' AND parentid != 0 AND isremix = 0;

#numero remix
SELECT count(*)
FROM songs
WHERE genre = 'Acoustic' AND isremix = 1;

#numero di canzoni cover
SELECT count(*)
FROM songs
  INNER JOIN cover_songs
    ON songs.coverid = cover_songs.id
WHERE genre = 'Acoustic';

#numero di overdub da contest
SELECT count(*)
FROM songs
  INNER JOIN tree_info ON songs.tree_id = tree_info.id
WHERE parentid != 0 AND genre = 'Acoustic';

#numero di root song da contest
SELECT count(*)
FROM songs
  INNER JOIN tree_info ON songs.tree_id = tree_info.id
WHERE parentid = 0 AND genre = 'Acoustic';

#numero di canzoni chiuse
SELECT count(*)
FROM songs
WHERE isclosedsong = 1 OR isclosedsong = 2 AND genre = 'Acoustic';

#################################################
##################   COMMENTI   #################

#numero di commenti
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND genre = 'Acoustic';

#numero di commenti (esclusi quelli degli autori della canzone)
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages
    ON songs.id = songtree_messages.songid
WHERE kind = 0 AND memberId != songtree_messages.senderid AND genre = 'Acoustic';

##################   USER WRITES COMMENT   #################

#numero totale di utenti che hanno commentato
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND genre = 'Acoustic';

#numero di utenti che hanno commentato canzoni di altri utenti
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId AND genre = 'Acoustic';

#numero autori che hanno ricevuto commenti sulle loro song
SELECT count(DISTINCT memberId)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid != memberId AND genre = 'Acoustic';

#autori che hanno commentato le proprie song
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND senderid = memberId AND genre = 'Acoustic';

#utenti che hanno commentato ma non hanno scritto canzoni
SELECT DISTINCT senderid
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND genre = 'Acoustic' AND senderid NOT IN (SELECT DISTINCT memberId
                                                           FROM songs
                                                           WHERE genre = 'Acoustic');

#utenti che hanno scritto canzoni ma non hanno commentato
SELECT DISTINCT memberId
FROM songs
WHERE genre = 'Acoustic' AND memberId NOT IN (SELECT DISTINCT senderid
                                              FROM songs
                                                INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
                                              WHERE kind = 0 AND genre = 'Acoustic');

#utenti che hanno commentato e scritto canzoni 1
SELECT DISTINCT memberId
FROM songs
WHERE genre = 'Acoustic' AND memberId IN (SELECT senderid
                                          FROM songs
                                            INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
                                          WHERE kind = 0 AND genre = 'Acoustic');

#utenti che hanno commentato e scritto canzoni 2
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid IN (SELECT DISTINCT memberId
                                FROM songs);

#numero totale di utenti che hanno commentato solo le proprie canzoni NON CORRETTA
SELECT DISTINCT senderid
FROM songtree_messages
WHERE kind = 0 AND senderid NOT IN (SELECT DISTINCT senderid
                                    FROM songs
                                      INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
                                    WHERE kind = 0 AND senderid != memberId);

#######################################################################################################################
#####################################################   MANOVA   #################################################
#######################################################################################################################

SELECT
  genre,
  count(*) AS num_songs
FROM songs
GROUP BY genre;

#########################################################
#####################    GENERI    ######################
#########################################################

#authors for every genre
INSERT INTO z1_ACOUSTIC_users (id)
  SELECT DISTINCT memberId
  FROM songs
  WHERE genre = 'Acoustic';

###########################################################

#GENRE, songs, new songs, overdubs, indegree, outdegree, normalized betweenness
SELECT
  'ACOUSTIC',
  memberId,
  songs,
  new_songs,
  overdubs,
  indegree,
  outdegree,
  norm_betweenness_und
FROM
  (SELECT
     memberId,
     count(songs.id) AS songs,
     sum(CASE WHEN parentid = 0
       THEN 1
         ELSE 0 END)    new_songs,
     sum(CASE WHEN parentid != 0
       THEN 1
         ELSE 0 END)    overdubs
   FROM songs
   WHERE genre = 'Acoustic'
   GROUP BY memberId) AS t1 INNER JOIN `2_all_users_feedback_net_3` ON t1.memberId = `2_all_users_feedback_net_3`.id;

#######################################################################################################################
############################################   SELF AND OTHER OVERDUB   ###############################################
#######################################################################################################################

#numero di SELF OVERDUB
SELECT count(s1.id)
FROM songs AS s1 INNER JOIN songs AS s2 ON s1.parentid = s2.id
WHERE s1.memberId = s2.memberId;

#numero di OTHER OVERDUB
SELECT count(s1.id)
FROM songs AS s1 INNER JOIN songs AS s2 ON s1.parentid = s2.id
WHERE s1.memberId != s2.memberId;

#numero di overdub con riferimenti mancanti alle song padri
SELECT count(*)
FROM songs
WHERE parentid != 0 AND parentid NOT IN (SELECT id
                                         FROM songs);

#numero totale overdub
SELECT count(*)
FROM songs
WHERE parentid != 0;