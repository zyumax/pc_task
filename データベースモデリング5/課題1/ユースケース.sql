-- 特定の記事の履歴を一覧表示できる
SELECT * FROM article_histories
WHERE article_id = 1;

-- 最新状態の記事を一覧表示できる
SELECT *
FROM (
    SELECT ah.*,
           ROW_NUMBER() OVER (PARTITION BY ah.article_id ORDER BY ah.created_at DESC) AS wd
    FROM article_histories ah
    JOIN articles a ON a.id = ah.article_id
    WHERE a.deleted_at = '9999-12-31 23:59:59'
) ranked
WHERE wd = 1;

-- 履歴を選択して過去の記事状態に戻す
UPDATE articles
SET latest_revision = 2
WHERE id = 3;