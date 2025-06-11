-- ユースケース
-- 自分が設定したタスク一覧を取得
SELECT * FROM tasks
WHERE user_id = 1;

-- 毎日のリマインダーを取得する
SELECT rf.task_id, rf.frequency_label, t.content FROM reminder_frequency rf
JOIN tasks t 
ON t.id = rf.task_id
WHERE rf.frequency_value = 1;

-- 自分宛のタスク一覧を取得
WITH reminder_to_user AS (
  SELECT task_id
  FROM reminders
  WHERE user_id = 3
)
SELECT u.name AS "送信者", t.content AS "内容" 
FROM tasks t
JOIN reminder_to_user ru ON t.id = ru.task_id
JOIN users u ON t.user_id = u.id;

-- リマインダーの数が3回以上のものを取得する
WITH send_reminder_user AS (
  SELECT t.id, u.name, t.content FROM tasks t
  JOIN users u ON t.user_id = u.id
)
SELECT su.name AS "送信者", su.content AS "内容"
FROM reminder_logs rl
JOIN send_reminder_user su ON rl.task_id = su.id
GROUP BY task_id
HAVING COUNT(task_id) >= 3;