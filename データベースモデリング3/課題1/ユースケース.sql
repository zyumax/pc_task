-- 特定のディレクトリにアクセス権のあるユーザーを取得
SELECT u.id, u.name FROM users u
JOIN directories_users ds ON ds.user_id = u.id
WHERE ds.directory_id = 2;

-- 特定のディレクトリのドキュメントを取得
SELECT * FROM documents
WHERE directory_id = 3;

-- 特定のドキュメントの編集可能なユーザーを取得
SELECT dp.user_id FROM document_permissions dp
WHERE dp.document_id = 5 and dp.role = 1;

-- ディレクトリを移動させる(4を1の直下にする)
UPDATE directory_relations 
SET hierarchy_depth = 1
WHERE id = 4;
UPDATE directory_relations 
SET hierarchy_depth = 2
WHERE id = 5;
DELETE FROM directory_relations WHERE id = 8;
DELETE FROM directory_relations WHERE id = 9;

-- ディレクトリごとのパス(文字列で)を取得する
-- サブクエリ使用
SELECT dp.descendant_id as id, group_concat(dp.directory_name order by dp.hierarchy_depth desc separator '/') as path
FROM (
  SELECT dr.ancestor_id, dr.descendant_id, hierarchy_depth, d.directory_name 
  FROM directory_relations dr
  JOIN directories d ON d.id = dr.ancestor_id
) as dp
GROUP BY dp.descendant_id
ORDER BY id;

-- サブクエリ不使用
SELECT dr.descendant_id as id, group_concat(d.directory_name order by dr.hierarchy_depth desc separator '/') as path
FROM directory_relations dr
JOIN directories d ON d.id = dr.ancestor_id
GROUP BY dr.descendant_id
ORDER BY id;

-- 参考
https://qiita.com/ssc-ynakamura/items/d288a195391df47b3c92