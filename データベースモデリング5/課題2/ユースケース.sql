-- 特定の記事の履歴を一覧表示できる
SELECT * FROM articles
WHERE article_id = 1;

-- 最新状態の記事を一覧表示できる
select * from articles
WHERE status = 1;

-- 履歴を選択して過去の記事状態に戻す
START TRANSACTION;
-- 最新版を削除
UPDATE articles
SET status = 2
WHERE id = 10;
-- 2番目に新しい記事を復活させる
UPDATE articles
SET status = 1
WHERE id = 8;
COMMIT;