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

-- 横断検索機能(メッセージとスレッドメッセージを横断的に検索できること（例えば「hoge」と検索したら、この文字列を含むメッセージとスレッドメッセージを両方とも取得できること）
WITH
 workspaces_channels AS (
  SELECT cu.channel_id FROM channels_users cu
  JOIN channels c ON cu.channel_id = c.id
  JOIN workspaces w ON c.workspace_id = w.id
  WHERE cu.user_id = 1 AND w.id = 1
 )
SELECT m.user_id, m.post, m.channel_id FROM messages m
JOIN workspaces_channels wc ON m.channel_id = wc.channel_id
WHERE MATCH(post) AGAINST('こんばんは' IN NATURAL LANGUAGE MODE);