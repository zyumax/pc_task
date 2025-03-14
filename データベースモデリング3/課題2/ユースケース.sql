-- directory_id=1のドキュメントの順番を入れ替える
BEGIN;
UPDATE documents 
SET sort_order = 2
WHERE id = 3 AND deleted_at = '9999-12-31 23:59:59';

UPDATE documents 
SET sort_order = 1
WHERE id = 2 AND deleted_at = '9999-12-31 23:59:59';
COMMIT;