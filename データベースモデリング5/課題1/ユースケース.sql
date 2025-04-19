-- 特定の記事の履歴を一覧表示できる
SELECT * FROM article_histories
WHERE article_id = 1;

-- 最新状態の記事を一覧表示できる
select * from article_histories
WHERE deleted_at = '9999-12-31 23:59:59';

-- 履歴を選択して過去の記事状態に戻す
-- article_id = 3の作成日時をrevが古い順に修正する(トランザクション以下のSQLがcreated_atで並び替えるため)
UPDATE article_histories SET created_at = NOW()
WHERE id = 8;
UPDATE article_histories SET created_at = NOW()
WHERE id = 9;
UPDATE article_histories SET created_at = NOW()
WHERE id = 10;

START TRANSACTION;
-- 最新IDを変数に格納する
SELECT id
FROM article_histories
WHERE article_id = 3
AND deleted_at = '9999-12-31 23:59:59'
ORDER BY created_at DESC
LIMIT 1
INTO @latest_id;
-- 2番目に新しいIDを変数に格納する
SELECT id
FROM article_histories
WHERE article_id = 3
AND NOT deleted_at = '9999-12-31 23:59:59'
AND NOT id = @latest_id
ORDER BY created_at DESC
LIMIT 1
INTO @second_latest_id;
-- 最新版を削除
UPDATE article_histories
SET deleted_at = NOW()
WHERE id = @latest_id;
-- 2番目に新しい記事を復活させる
UPDATE article_histories
SET deleted_at = '9999-12-31 23:59:59'
WHERE id = @second_latest_id;

COMMIT;