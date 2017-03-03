#######################################################################################################################
############################################    CROSS CORRELATION    ##################################################
#######################################################################################################################


#######################################################################################################
############################################   GENERALE   #############################################

#correlazione canzoni - nuove canzoni
SELECT
  written_songs,
  CASE WHEN written_new_songs IS NULL
    THEN 0
  ELSE written_new_songs END written_new_songs
FROM `3_1_user_song`
  LEFT JOIN `3_2_user_new_songs` ON `3_1_user_song`.user = `3_2_user_new_songs`.user;

#correlazione canzoni - overdub
SELECT
  written_songs,
  CASE WHEN num_overdubbed_songs IS NULL
    THEN 0
  ELSE num_overdubbed_songs END num_overdubbed_songs
FROM `3_1_user_song`
  LEFT JOIN `3_3_user_overdubbed_songs` ON `3_1_user_song`.user = `3_3_user_overdubbed_songs`.user;

#correlazione canzoni - indegree
SELECT
  written_songs,
  indegree / 5520 AS normalized_indegree
FROM 2_all_users_feedback_net
WHERE written_songs > 0;

#correlazione canzoni - outdegree
SELECT
  written_songs,
  outdegree / 5520 AS normalized_outdegree
FROM 2_all_users_feedback_net
WHERE written_songs > 0;

#correlazione canzoni - betweenness
SELECT
  written_songs,
  betweenness_centrality
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#----------------------------------------------------------------------------------------------------------------------

#correlazione nuove canzoni - overdub
SELECT
  written_new_songs,
  CASE WHEN num_overdubbed_songs IS NULL
    THEN 0
  ELSE num_overdubbed_songs END num_overdubbed_songs
FROM `3_2_user_new_songs`
  LEFT JOIN `3_3_user_overdubbed_songs` ON `3_2_user_new_songs`.user = `3_3_user_overdubbed_songs`.user;

#correlazione nuove canzoni - indegree
SELECT
  written_new_songs,
  indegree / 4756 AS normalized_indegree
FROM `3_2_user_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_2_user_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - outdegree
SELECT
  written_new_songs,
  outdegree / 4756 AS normalized_outdegree
FROM `3_2_user_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_2_user_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - betweenness
SELECT
  written_new_songs,
  betweenness_centrality
FROM `3_2_user_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_2_user_new_songs`.user = `2_all_users_feedback_net`.id;

#---------------------------------------------------

#correlazione overdubs - indegree
SELECT
  num_overdubbed_songs,
  indegree / 1405 AS normalized_indegree
FROM `3_3_user_overdubbed_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_3_user_overdubbed_songs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - outdegree
SELECT
  num_overdubbed_songs,
  outdegree / 1405 AS normalized_outdegree
FROM `3_3_user_overdubbed_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_3_user_overdubbed_songs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - beetwenness
SELECT
  num_overdubbed_songs,
  betweenness_centrality
FROM `3_3_user_overdubbed_songs`
  INNER JOIN `2_all_users_feedback_net` ON `3_3_user_overdubbed_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione indegree - outdegree
SELECT
  indegree / 5520  AS normalized_indegree,
  outdegree / 5520 AS normalized_outdegree
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#correlazione indegree - betweenness
SELECT
  indegree / 5520 AS normalized_indegree,
  betweenness_centrality
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

#----------------------------------------------------------

#correlazione outdegree - betweenness
SELECT
  outdegree / 5520 AS normalized_outdegree,
  betweenness_centrality
FROM `2_all_users_feedback_net`
WHERE written_songs > 0;

########################################################################################################
############################################   PER GENERI   ############################################


######################################   ROCK   #################################

#correlazione canzoni - nuove canzoni
SELECT
  songs,
  CASE WHEN new_songs IS NULL
    THEN 0
  ELSE new_songs END new_songs
FROM `4_1_ROCK_users_songs`
  LEFT JOIN `4_2_ROCK_users_new_songs` ON `4_1_ROCK_users_songs`.user = `4_2_ROCK_users_new_songs`.user;

#correlazione canzoni - overdub
SELECT
  songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `4_1_ROCK_users_songs`
  LEFT JOIN `4_3_ROCK_users_overdubs` ON `4_1_ROCK_users_songs`.user = `4_3_ROCK_users_overdubs`.user;

#correlazione canzoni - indegree
SELECT
  songs,
  indegree / 430 AS normalized_indegree
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - outdegree
SELECT
  songs,
  outdegree / 430 AS normalized_outdegree
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - betweenness
SELECT
  songs,
  betweenness_centrality
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------

#correlazione nuove canzoni - overdub
SELECT
  new_songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `4_2_ROCK_users_new_songs`
  LEFT JOIN `4_3_ROCK_users_overdubs` ON `4_2_ROCK_users_new_songs`.user = `4_3_ROCK_users_overdubs`.user;

#correlazione nuove canzoni - indegree
SELECT
  new_songs,
  indegree / 327 AS normalized_indegree
FROM `4_2_ROCK_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_2_ROCK_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - outdegree
SELECT
  new_songs,
  outdegree / 327 AS normalized_outdegree
FROM `4_2_ROCK_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_2_ROCK_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - betweenness
SELECT
  new_songs,
  betweenness_centrality
FROM `4_2_ROCK_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_2_ROCK_users_new_songs`.user = `2_all_users_feedback_net`.id;

#---------------------------------------------------

#correlazione overdubs - indegree
SELECT
  overdubs,
  indegree / 178 AS normalized_indegree
FROM `4_3_ROCK_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `4_3_ROCK_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - outdegree
SELECT
  overdubs,
  outdegree / 178 AS normalized_outdegree
FROM `4_3_ROCK_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `4_3_ROCK_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - beetwenness
SELECT
  overdubs,
  betweenness_centrality
FROM `4_3_ROCK_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `4_3_ROCK_users_overdubs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione indegree - outdegree
SELECT
  indegree / 430  AS normalized_indegree,
  outdegree / 430 AS normalized_outdegree
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione indegree - betweenness
SELECT
  indegree / 430 AS normalized_indegree,
  betweenness_centrality
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione outdegree - betweenness
SELECT
  outdegree / 430 AS normalized_outdegree,
  betweenness_centrality
FROM `4_1_ROCK_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `4_1_ROCK_users_songs`.user = `2_all_users_feedback_net`.id;

############################################   ACOUSTIC   ############################################

#correlazione canzoni - nuove canzoni
SELECT
  songs,
  CASE WHEN new_songs IS NULL
    THEN 0
  ELSE new_songs END new_songs
FROM `5_1_ACOUSTIC_users_songs`
  LEFT JOIN `5_2_ACOUSTIC_users_new_songs` ON `5_1_ACOUSTIC_users_songs`.user = `5_2_ACOUSTIC_users_new_songs`.user;

#correlazione canzoni - overdub
SELECT
  songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `5_1_ACOUSTIC_users_songs`
  LEFT JOIN `5_3_ACOUSTIC_users_overdubs` ON `5_1_ACOUSTIC_users_songs`.user = `5_3_ACOUSTIC_users_overdubs`.user;

#correlazione canzoni - indegree
SELECT
  songs,
  indegree / 1464 AS normalized_indegree
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - outdegree
SELECT
  songs,
  outdegree / 1464 AS normalized_outdegree
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - betweenness
SELECT
  songs,
  betweenness_centrality
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------

#correlazione nuove canzoni - overdub
SELECT
  new_songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `5_2_ACOUSTIC_users_new_songs`
  LEFT JOIN `5_3_ACOUSTIC_users_overdubs` ON `5_2_ACOUSTIC_users_new_songs`.user = `5_3_ACOUSTIC_users_overdubs`.user;

#correlazione nuove canzoni - indegree
SELECT
  new_songs,
  indegree / 1341 AS normalized_indegree
FROM `5_2_ACOUSTIC_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_2_ACOUSTIC_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - outdegree
SELECT
  new_songs,
  outdegree / 1341 AS normalized_outdegree
FROM `5_2_ACOUSTIC_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_2_ACOUSTIC_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - betweenness
SELECT
  new_songs,
  betweenness_centrality
FROM `5_2_ACOUSTIC_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_2_ACOUSTIC_users_new_songs`.user = `2_all_users_feedback_net`.id;

#---------------------------------------------------

#correlazione overdubs - indegree
SELECT
  overdubs,
  indegree / 285 AS normalized_indegree
FROM `5_3_ACOUSTIC_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `5_3_ACOUSTIC_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - outdegree
SELECT
  overdubs,
  outdegree / 285 AS normalized_outdegree
FROM `5_3_ACOUSTIC_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `5_3_ACOUSTIC_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - beetwenness
SELECT
  overdubs,
  betweenness_centrality
FROM `5_3_ACOUSTIC_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `5_3_ACOUSTIC_users_overdubs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione indegree - outdegree
SELECT
  indegree / 1464  AS normalized_indegree,
  outdegree / 1464 AS normalized_outdegree
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione indegree - betweenness
SELECT
  indegree / 1464 AS normalized_indegree,
  betweenness_centrality
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione outdegree - betweenness
SELECT
  outdegree / 1464 AS normalized_outdegree,
  betweenness_centrality
FROM `5_1_ACOUSTIC_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `5_1_ACOUSTIC_users_songs`.user = `2_all_users_feedback_net`.id;

############################################   HIPHOP   ############################################

#correlazione canzoni - nuove canzoni
SELECT
  songs,
  CASE WHEN new_songs IS NULL
    THEN 0
  ELSE new_songs END new_songs
FROM `6_1_HIPHOP_users_songs`
  LEFT JOIN `6_2_HIPHOP_users_new_songs` ON `6_1_HIPHOP_users_songs`.user = `6_2_HIPHOP_users_new_songs`.user;

#correlazione canzoni - overdub
SELECT
  songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `6_1_HIPHOP_users_songs`
  LEFT JOIN `6_3_HIPHOP_users_overdubs` ON `6_1_HIPHOP_users_songs`.user = `6_3_HIPHOP_users_overdubs`.user;

#correlazione canzoni - indegree
SELECT
  songs,
  indegree / 1302 AS normalized_indegree
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - outdegree
SELECT
  songs,
  outdegree / 1302 AS normalized_outdegree
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione canzoni - betweenness
SELECT
  songs,
  betweenness_centrality
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------

#correlazione nuove canzoni - overdub
SELECT
  new_songs,
  CASE WHEN overdubs IS NULL
    THEN 0
  ELSE overdubs END overdubs
FROM `6_2_HIPHOP_users_new_songs`
  LEFT JOIN `6_3_HIPHOP_users_overdubs` ON `6_2_HIPHOP_users_new_songs`.user = `6_3_HIPHOP_users_overdubs`.user;

#correlazione nuove canzoni - indegree
SELECT
  new_songs,
  indegree / 1010 AS normalized_indegree
FROM `6_2_HIPHOP_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_2_HIPHOP_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - outdegree
SELECT
  new_songs,
  outdegree / 1010 AS normalized_outdegree
FROM `6_2_HIPHOP_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_2_HIPHOP_users_new_songs`.user = `2_all_users_feedback_net`.id;

#correlazione nuove canzoni - betweenness
SELECT
  new_songs,
  betweenness_centrality
FROM `6_2_HIPHOP_users_new_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_2_HIPHOP_users_new_songs`.user = `2_all_users_feedback_net`.id;

#---------------------------------------------------

#correlazione overdubs - indegree
SELECT
  overdubs,
  indegree / 413 AS normalized_indegree
FROM `6_3_HIPHOP_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `6_3_HIPHOP_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - outdegree
SELECT
  overdubs,
  outdegree / 413 AS normalized_outdegree
FROM `6_3_HIPHOP_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `6_3_HIPHOP_users_overdubs`.user = `2_all_users_feedback_net`.id;

#correlazione overdubs - beetwenness
SELECT
  overdubs,
  betweenness_centrality
FROM `6_3_HIPHOP_users_overdubs`
  INNER JOIN `2_all_users_feedback_net` ON `6_3_HIPHOP_users_overdubs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione indegree - outdegree
SELECT
  indegree / 1302  AS normalized_indegree,
  outdegree / 1302 AS normalized_outdegree
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#correlazione indegree - betweenness
SELECT
  indegree / 1302 AS normalized_indegree,
  betweenness_centrality
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;

#----------------------------------------------------------

#correlazione outdegree - betweenness
SELECT
  outdegree / 1302 AS normalized_outdegree,
  betweenness_centrality
FROM `6_1_HIPHOP_users_songs`
  INNER JOIN `2_all_users_feedback_net` ON `6_1_HIPHOP_users_songs`.user = `2_all_users_feedback_net`.id;