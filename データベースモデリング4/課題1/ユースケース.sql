-- ユースケース
-- 自分が設定したタスク一覧を取得
SELECT * FROM send_reminders
WHERE user_id = 1;

-- 毎週X曜日のリマインダーを取得する
SELECT * FROM reminder_frequency rf
JOIN send_reminders sr 
ON sr.reminder_frequency_id = rf.id
WHERE rf.id = 3;

-- 自分宛のタスク一覧を取得
WITH get_reminder_to_user AS (
  SELECT send_reminders_id
  FROM get_reminders
  WHERE user_id = 3
)
SELECT u.name AS "送信者", sr.content AS "内容" 
FROM send_reminders sr
JOIN get_reminder_to_user gu ON sr.id = gu.send_reminders_id
JOIN users u ON sr.user_id = u.id;

-- リマインダーの数が3回以上のものを取得する
WITH send_reminder_user AS (
  SELECT sr.id, u.name, sr.content FROM send_reminders sr
  JOIN users u ON sr.user_id = u.id
)
SELECT su.name AS "送信者", su.content AS "内容"
FROM reminder_logs rl
JOIN send_reminder_user su ON rl.send_reminders_id = su.id
GROUP BY send_reminders_id
HAVING COUNT(send_reminders_id) >= 3;