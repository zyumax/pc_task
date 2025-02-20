-- ユースケース
-- 特定のチャンネルIDに所属しているユーザーを見つける。
SELECT user_id AS "ユーザー" FROM channels_users
WHERE channel_id = 1;

-- 特定のチャンネルIDのメッセージとスレッドを見つける。
SELECT user_id AS "ユーザー", parent_id, post AS "投稿" FROM messages WHERE channel_id = 5;

-- ワークスペースごとのメッセージスレッドの投稿数をカウントする
SELECT c.workspace_id AS "ワークスペースID", COUNT(m.id) AS "投稿数" FROM messages AS m
JOIN channels AS c on m.channel_id = c.id
GROUP BY c.workspace_id;

-- ユーザーごとのメッセージスレッドの数を調べる
SELECT user_id, COUNT(messages.id) FROM messages GROUP BY user_id;

-- ワークスペースごとの参加ユーザー
SELECT ws.workspace_id as "ワークスペース名", COUNT(ws.user_id) "ユーザー数" FROM workspaces_users as ws
GROUP BY ws.workspace_id;