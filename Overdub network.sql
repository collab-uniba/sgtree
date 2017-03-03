################################################   OVERDUB NETWORK   #################################################

#------------------ VERSIONE 1 ------------------

#Archi versione 1 - seleziona gli alberi e gli utenti che vi hanno collaborato
SELECT
  tree_id,
  memberId,
  count(*) AS num_songs
FROM songs
WHERE tree_id IS NOT NULL AND isremix = 0
GROUP BY tree_id, memberId;

#Non tiene conto del numero di volte che un utente scrive una canzone in un albero (DA NON CONSIDERARE)
SELECT
  tree_id,
  memberId
FROM songs
WHERE tree_id IS NOT NULL
GROUP BY tree_id, memberId;

#------------------ VERSIONE 3 ------------------

#Archi per il grafo
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
#vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e si eliminano i remix
WHERE s1.isremix = 0
GROUP BY source, target;

########################################################    ALTRO    ##################################################
#canzoni con tree id nullo (215)
SELECT
  id,
  tree_id,
  parentid
FROM songs
WHERE tree_id IS NULL OR parentid IS NULL;

#canzoni con parentid non valido (418)
SELECT DISTINCT
  id,
  parentid
FROM songs
WHERE parentid != 0 AND parentid NOT IN (SELECT id
                                         FROM songs);