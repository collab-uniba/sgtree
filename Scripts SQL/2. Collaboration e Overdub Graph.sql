#######################################################################################################################
##############################################   COLLABORATION GRAPH   ################################################
#######################################################################################################################

#Archi. Seleziona gli alberi e gli utenti che vi hanno partecipato. Non vengono considerati i remix.
#Query inclusa in script Java.
SELECT
  tree_id,
  memberId
FROM songs
WHERE tree_id IS NOT NULL AND isremix = 0
GROUP BY tree_id, memberId;

######################################################
##################   ROCK E BLUES   ##################

CREATE VIEW rock_blues_trees AS
  SELECT DISTINCT tree_id
  FROM songs
  WHERE parentid = 0 AND
        (genre = 'Rock'
         OR genre = 'Religious'
         OR genre = 'Country'
         OR genre = 'Reggae'
         OR genre = 'Gospel'
         OR genre = 'Punk'
         OR genre = 'Heavy Metal'
         OR genre = 'Folk'
         OR genre = 'Pop'
         OR genre = 'Blues');

SELECT DISTINCT
  tree_id,
  memberid
FROM songs
WHERE isremix = 0 AND tree_id IN (SELECT tree_id
                                  FROM rock_blues_trees);

######################################################
##################   HIP HOP E R&B   #################

CREATE VIEW hiphop_rnb_trees AS
  SELECT DISTINCT tree_id
  FROM songs
  WHERE parentid = 0 AND
        (genre = 'Hip Hop'
         OR genre = 'Rap'
         OR genre = 'Dance'
         OR genre = 'R&B'
         OR genre = 'Soul'
         OR genre = 'Funky');

SELECT DISTINCT
  tree_id,
  memberid
FROM songs
WHERE isremix = 0 AND tree_id IN (SELECT tree_id
                                  FROM hiphop_rnb_trees);

##############################################################
################   ALTERNATIVE E ELECTRONIC   ################

CREATE VIEW alternative_electronic_trees AS
  SELECT DISTINCT tree_id
  FROM songs
  WHERE parentid = 0 AND
        (genre = 'Alternative'
         OR genre = 'Indie'
         OR genre = 'Electronic'
         OR genre = 'Acoustic');

SELECT DISTINCT
  tree_id,
  memberid
FROM songs
WHERE isremix = 0 AND tree_id IN (SELECT tree_id
                                  FROM alternative_electronic_trees);

##########################################################
##################   JAZZ E CLASSICAL   ##################

CREATE VIEW jazz_classical_trees AS
  SELECT DISTINCT tree_id
  FROM songs
  WHERE parentid = 0 AND
        (genre = 'Ambient'
         OR genre = 'Jazz'
         OR genre = 'Fusion'
         OR genre = 'Classical'
         OR genre = 'Soundtrack');

SELECT DISTINCT
  tree_id,
  memberid
FROM songs
WHERE isremix = 0 AND tree_id IN (SELECT tree_id
                                  FROM jazz_classical_trees);

#######################################################################################################################
###################################################   OVERDUB GRAPH   #################################################
#######################################################################################################################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano gli overdub che sono remix.
SELECT
  #id dell'utente che ha scritto l'overdub
  s1.memberId AS source,
  #id dell'utente che ha ricevuto l'overdub della song
  s2.memberId AS target,
  #numero di volte che source ha overdubbato song di target
  count(*)    AS weight
FROM songs AS s1
  INNER JOIN songs AS s2
    ON s1.parentid = s2.id
WHERE s1.isremix = 0
GROUP BY source, target;

#per i macro-generi si considera il genere del padre

######################################################
##################   ROCK E BLUES   ##################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano gli overdub che sono remix.
SELECT
  #id dell'utente che ha scritto l'overdub
  s1.memberId AS source,
  #id dell'utente che ha ricevuto l'overdub della song
  s2.memberId AS target,
  #numero di volte che source ha overdubbato song di target
  count(*)    AS weight
FROM songs AS s1
  INNER JOIN songs AS s2
    ON s1.parentid = s2.id
WHERE s1.isremix = 0 AND (s2.genre = 'Rock'
                          OR s2.genre = 'Religious'
                          OR s2.genre = 'Country'
                          OR s2.genre = 'Reggae'
                          OR s2.genre = 'Gospel'
                          OR s2.genre = 'Punk'
                          OR s2.genre = 'Heavy Metal'
                          OR s2.genre = 'Folk'
                          OR s2.genre = 'Pop'
                          OR s2.genre = 'Blues')
GROUP BY source, target;

######################################################
##################   HIP HOP E R&B   #################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano gli overdub che sono remix.
SELECT
  #id dell'utente che ha scritto l'overdub
  s1.memberId AS source,
  #id dell'utente che ha ricevuto l'overdub della song
  s2.memberId AS target,
  #numero di volte che source ha overdubbato song di target
  count(*)    AS weight
FROM songs AS s1
  INNER JOIN songs AS s2
    ON s1.parentid = s2.id
WHERE s1.isremix = 0 AND (s2.genre = 'Hip Hop'
                          OR s2.genre = 'Rap'
                          OR s2.genre = 'Dance'
                          OR s2.genre = 'R&B'
                          OR s2.genre = 'Soul'
                          OR s2.genre = 'Funky')
GROUP BY source, target;

##############################################################
################   ALTERNATIVE E ELECTRONIC   ################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano gli overdub che sono remix.
SELECT
  #id dell'utente che ha scritto l'overdub
  s1.memberId AS source,
  #id dell'utente che ha ricevuto l'overdub della song
  s2.memberId AS target,
  #numero di volte che source ha overdubbato song di target
  count(*)    AS weight
FROM songs AS s1
  INNER JOIN songs AS s2
    ON s1.parentid = s2.id
WHERE s1.isremix = 0 AND (s2.genre = 'Alternative'
                          OR s2.genre = 'Indie'
                          OR s2.genre = 'Electronic'
                          OR s2.genre = 'Acoustic')
GROUP BY source, target;

##########################################################
##################   JAZZ E CLASSICAL   ##################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano gli overdub che sono remix.
SELECT
  #id dell'utente che ha scritto l'overdub
  s1.memberId AS source,
  #id dell'utente che ha ricevuto l'overdub della song
  s2.memberId AS target,
  #numero di volte che source ha overdubbato song di target
  count(*)    AS weight
FROM songs AS s1
  INNER JOIN songs AS s2
    ON s1.parentid = s2.id
WHERE s1.isremix = 0 AND (s2.genre = 'Ambient'
                          OR s2.genre = 'Jazz'
                          OR s2.genre = 'Fusion'
                          OR s2.genre = 'Classical'
                          OR s2.genre = 'Soundtrack')
GROUP BY source, target;