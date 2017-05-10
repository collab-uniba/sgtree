#######################################################################################################################
#################################################   STATISTICHE   #####################################################
#######################################################################################################################

############################################################################
##############################   GENERALE   ################################
############################################################################

############################################################################
#####################   ENTITA' MODELLO CONCETTUALE   ######################

#SONGS
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

#commenting authors
SELECT DISTINCT senderid
FROM songtree_messages
  INNER JOIN songs
    ON songtree_messages.songid = songs.id
WHERE kind = 0 AND senderid != songs.memberId AND senderid IN (SELECT DISTINCT memberid
                                                               FROM songs);

#da likers and reposters gli utenti che hanno scritto canzoni o hanno commentato
SELECT *
FROM likers_and_reposters
WHERE id NOT IN (SELECT DISTINCT memberId AS id
                 FROM songs
                 UNION SELECT id
                       FROM commenters_non_authors);

#active users
SELECT id
FROM
(SELECT id
FROM likers_and_reposters
UNION (SELECT id
       FROM commenters_non_authors)) as t
WHERE id NOT in (SELECT DISTINCT memberid FROM songs);

#utenti che hanno commentato canzoni di altri
SELECT count(DISTINCT senderid)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND memberId != senderid;

SELECT count(DISTINCT memberid)
FROM songs
WHERE memberId NOT IN (SELECT DISTINCT senderid
                       FROM songs
                         INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
                       WHERE kind = 0 AND senderid != songs.memberId);

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

############################################################################
####################   RELAZIONI MODELLO CONCETTUALE   #####################

SELECT count(*)
FROM songtree_messages
WHERE kind = 0;

SELECT count(*)
FROM repost;

SELECT count(*)
FROM songsRatings
WHERE rating >= 2.5;

SELECT count(*)
FROM songtree_favorites;

############################################################################
############################   MACRO GENERI   ##############################
############################################################################

######################################################
##################   ROCK E BLUES   ##################

#SONGS
SELECT count(*)
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
       OR genre = 'Blues');

#NEW SONGS
SELECT count(*)
FROM songs
WHERE parentid = 0 AND (genre = 'Rock'
                        OR genre = 'Religious'
                        OR genre = 'Country'
                        OR genre = 'Reggae'
                        OR genre = 'Gospel'
                        OR genre = 'Punk'
                        OR genre = 'Heavy Metal'
                        OR genre = 'Folk'
                        OR genre = 'Pop'
                        OR genre = 'Blues');

#OVERDUB
SELECT count(*)
FROM songs
WHERE parentid != 0 AND (genre = 'Rock'
                         OR genre = 'Religious'
                         OR genre = 'Country'
                         OR genre = 'Reggae'
                         OR genre = 'Gospel'
                         OR genre = 'Punk'
                         OR genre = 'Heavy Metal'
                         OR genre = 'Folk'
                         OR genre = 'Pop'
                         OR genre = 'Blues');

#COMMENTI
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND (genre = 'Rock'
                    OR genre = 'Religious'
                    OR genre = 'Country'
                    OR genre = 'Reggae'
                    OR genre = 'Gospel'
                    OR genre = 'Punk'
                    OR genre = 'Heavy Metal'
                    OR genre = 'Folk'
                    OR genre = 'Pop'
                    OR genre = 'Blues');

######################################################
##################   HIP HOP E R&B   #################

#SONGS
SELECT count(*)
FROM songs
WHERE (genre = 'Hip Hop'
       OR genre = 'Rap'
       OR genre = 'Dance'
       OR genre = 'R&B'
       OR genre = 'Soul'
       OR genre = 'Funky');

#NEW SONGS
SELECT count(*)
FROM songs
WHERE parentid = 0 AND (genre = 'Hip Hop'
                        OR genre = 'Rap'
                        OR genre = 'Dance'
                        OR genre = 'R&B'
                        OR genre = 'Soul'
                        OR genre = 'Funky');

#OVERDUB
SELECT count(*)
FROM songs
WHERE parentid != 0 AND (genre = 'Hip Hop'
                         OR genre = 'Rap'
                         OR genre = 'Dance'
                         OR genre = 'R&B'
                         OR genre = 'Soul'
                         OR genre = 'Funky');

#COMMENTI
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND (genre = 'Hip Hop'
                    OR genre = 'Rap'
                    OR genre = 'Dance'
                    OR genre = 'R&B'
                    OR genre = 'Soul'
                    OR genre = 'Funky');

##############################################################
################   ALTERNATIVE E ELECTRONIC   ################

#SONGS
SELECT count(*)
FROM songs
WHERE (genre = 'Alternative'
       OR genre = 'Indie'
       OR genre = 'Electronic'
       OR genre = 'Acoustic');

#NEW SONGS
SELECT count(*)
FROM songs
WHERE parentid = 0 AND (genre = 'Alternative'
                        OR genre = 'Indie'
                        OR genre = 'Electronic'
                        OR genre = 'Acoustic');

#OVERDUB
SELECT count(*)
FROM songs
WHERE parentid != 0 AND (genre = 'Alternative'
                         OR genre = 'Indie'
                         OR genre = 'Electronic'
                         OR genre = 'Acoustic');

#COMMENTI
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND (genre = 'Alternative'
                    OR genre = 'Indie'
                    OR genre = 'Electronic'
                    OR genre = 'Acoustic');

##########################################################
##################   JAZZ E CLASSICAL   ##################

#SONGS
SELECT count(*)
FROM songs
WHERE (genre = 'Ambient'
       OR genre = 'Jazz'
       OR genre = 'Fusion'
       OR genre = 'Classical'
       OR genre = 'Soundtrack');

#NEW SONGS
SELECT count(*)
FROM songs
WHERE parentid = 0 AND (genre = 'Ambient'
                        OR genre = 'Jazz'
                        OR genre = 'Fusion'
                        OR genre = 'Classical'
                        OR genre = 'Soundtrack');

#OVERDUB
SELECT count(*)
FROM songs
WHERE parentid != 0 AND (genre = 'Ambient'
                         OR genre = 'Jazz'
                         OR genre = 'Fusion'
                         OR genre = 'Classical'
                         OR genre = 'Soundtrack');

#COMMENTI
SELECT count(*)
FROM songs
  INNER JOIN songtree_messages ON songs.id = songtree_messages.songid
WHERE kind = 0 AND (genre = 'Ambient'
                    OR genre = 'Jazz'
                    OR genre = 'Fusion'
                    OR genre = 'Classical'
                    OR genre = 'Soundtrack');
