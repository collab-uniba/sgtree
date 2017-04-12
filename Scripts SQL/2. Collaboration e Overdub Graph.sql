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

#######################################################################################################################
###################################################   OVERDUB GRAPH   #################################################
#######################################################################################################################

#Archi. Vengono inclusi i casi in cui un utente overdubba la sua stessa canzone e non si considerano i remix.
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