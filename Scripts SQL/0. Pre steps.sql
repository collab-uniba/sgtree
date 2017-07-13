#ALL USERS

CREATE TABLE all_users (
  id INTEGER
);

INSERT INTO `all_users` (id)
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
        FROM songtree_following;

DELETE FROM all_users
WHERE id IS NULL;

