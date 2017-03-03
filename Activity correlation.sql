####################################################################################################################
#############################################  ANALISI BIRD da cap 5   #############################################
####################################################################################################################


###################################################################################################################
#############################################  ACTIVITY CORRELATION   #############################################
###################################################################################################################

###############################################
#################   GENERALE   ################
###############################################

#utenti e song scritte
SELECT
  memberId AS id,
  count(*)
FROM songs
GROUP BY memberId;

#utenti e canzoni nuove scritte
SELECT
  memberId        AS id,
  count(songs.id) AS new_songs
FROM songs
WHERE parentid = 0
GROUP BY memberId;

#utenti e overdub fatti
SELECT
  memberId        AS id,
  count(songs.id) AS overdubbed_songs
FROM songs
WHERE parentid != 0
GROUP BY memberId;

#correlazione canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  written_songs
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#correlazione NUOVE canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  written_new_songs
FROM `3_2_user_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_2_user_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzone overdubbata - commenti inviati
SELECT
  weighted_outdegree,
  num_overdubbed_songs
FROM `3_3_user_overdubbed_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_3_user_overdubbed_songs`.user = `2_all_users_feedback_net`.id;

################################################
#################   PER GENERE   ###############
################################################

#utenti e canzoni scritte (PER GENERE)
SELECT
  memberId AS id,
  count(*) AS written_songs
FROM songs
WHERE genre = 'Hip Hop'
GROUP BY memberId;

#utenti e canzoni nuove scritte (PER GENERE)
SELECT
  memberId        AS id,
  count(songs.id) AS new_songs
FROM songs
WHERE parentid = 0 AND genre = 'Hip Hop'
GROUP BY memberId;

#utenti e overdub fatti (PER GENERE)
SELECT
  memberId        AS id,
  count(songs.id) AS overdubbed_songs
FROM songs
WHERE parentid != 0 AND genre = 'Hip Hop'
GROUP BY memberId;

#########################   ROCK   #########################

#correlazione canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  songs
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione NUOVE canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  new_songs
FROM `4_2_ROCK_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_2_ROCK_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni overdubbate - commenti inviati
SELECT
  weighted_outdegree,
  overdubs
FROM `4_3_ROCK_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `4_3_ROCK_users_overdubs`.user = `2_all_users_feedback_net`.id;


#########################   ACOUSTIC   #########################

#correlazione canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  songs
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione NUOVE canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  new_songs
FROM `5_2_ACOUSTIC_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_2_ACOUSTIC_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni overdubbate - commenti inviati
SELECT
  weighted_outdegree,
  overdubs
FROM `5_3_ACOUSTIC_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `5_3_ACOUSTIC_users_overdubs`.user = `2_all_users_feedback_net`.id;

#########################   HIP HOP   #########################

#correlazione canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  songs
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione NUOVE canzoni scritte - commenti inviati
SELECT
  weighted_outdegree,
  new_songs
FROM `6_2_HIPHOP_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_2_HIPHOP_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni overdubbate - commenti inviati
SELECT
  weighted_outdegree,
  overdubs
FROM `6_3_HIPHOP_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `6_3_HIPHOP_users_overdubs`.user = `2_all_users_feedback_net`.id;

#######################################################################################################################
###########################################    SN MEASURES (CAP 5.2)    ###############################################
#######################################################################################################################

#########################   GENERALE   #######################

#beetweenness media per gli autori
SELECT SUM(normalized_betweenness) / 5520
FROM `2_all_users_feedback_net_2`
WHERE written_songs > 0;

#numero di non autori (105756)
SELECT count(*)
FROM `2_all_users_feedback_net`
WHERE written_songs = 0;

#beetweenness media per i non autori
SELECT SUM(normalized_betweenness) / 105756
FROM `2_all_users_feedback_net_2`
WHERE written_songs = 0;

#utenti che hanno commentato ma non hanno scritto canzoni
SELECT DISTINCT
  senderid,
  betweenness_centrality
FROM songtree_messages
  INNER JOIN `2_all_users_feedback_net_2` ON songtree_messages.senderid = `2_all_users_feedback_net_2`.id
WHERE kind = 0 AND senderid NOT IN (SELECT DISTINCT memberId
                                    FROM songs);

#in degree medio per gli autori
SELECT SUM(indegree) / 5520
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#indegree medio per i non autori
SELECT SUM(indegree) / 105756
FROM `2_all_users_feedback_net`
WHERE written_songs = 0;

#in degree medi0 per gli autori
SELECT SUM(outdegree) / 5520
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#indegree medio per i non autori
SELECT SUM(outdegree) / 105756
FROM `2_all_users_feedback_net`
WHERE written_songs = 0;

###################   ROCK   ####################

SELECT count(*)
FROM `4_1_ROCK_users_songs`;

SELECT SUM(normalized_betweenness) / 430
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net_2` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net_2`.id;

SELECT SUM(indegree) / 430
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

SELECT SUM(outdegree) / 430
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

###################   ACOUSTIC   ####################
SELECT count(*)
FROM `5_1_ACOUSTIC_users_songs`;

SELECT sum(normalized_betweenness) / 1464
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net_2` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net_2`.id;

SELECT sum(indegree) / 1464
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

SELECT sum(outdegree) / 1464
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

###################   HIP HOP   ####################
SELECT count(*)
FROM `6_1_HIPHOP_users_songs`;

SELECT sum(normalized_betweenness) / 1302
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net_2` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net_2`.id;

SELECT sum(indegree) / 1302
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

SELECT sum(outdegree) / 1302
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;