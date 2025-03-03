-- 特定のディレクトリにアクセス権のあるユーザーを取得
SELECT u.id, u.name FROM users u
JOIN directories_users ds ON ds.user_id = u.id
WHERE ds.directory_id = 2;

-- 特定のディレクトリのドキュメントを取得
SELECT * FROM documents
WHERE directory_id = 3;

-- 特定のドキュメントの編集可能なユーザーを取得
SELECT du.user_id FROM documents_users du
WHERE du.document_id = 5;

-- ディレクトリを移動させる(4を1の直下にする)
UPDATE directory_relations 
SET path_length = 1
WHERE id = 4;
UPDATE directory_relations 
SET path_length = 2
WHERE id = 5;
DELETE FROM directory_relations WHERE id = 8;
DELETE FROM directory_relations WHERE id = 9;

-- ディレクトリごとのパス(文字列で)を取得する
-- サブクエリ使用
SELECT dp.descendant_id as id, group_concat(dp.directory_name order by dp.path_length desc separator '/') as path
FROM (
  SELECT dr.ancestor_id, dr.descendant_id, path_length, d.directory_name 
  FROM directory_relations dr
  JOIN directories d ON d.id = dr.ancestor_id
) as dp
GROUP BY dp.descendant_id
ORDER BY id;

-- サブクエリ不使用
SELECT dr.descendant_id as id, group_concat(d.directory_name order by dr.path_length desc separator '/') as path
FROM directory_relations dr
JOIN directories d ON d.id = dr.ancestor_id
GROUP BY dr.descendant_id
ORDER BY id;

-- 参考
https://qiita.com/ssc-ynakamura/items/d288a195391df47b3c92