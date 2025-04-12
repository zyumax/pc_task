CREATE TABLE slack_workspaces (
  id INT AUTO_INCREMENT PRIMARY KEY,
  access_token VARCHAR(255),
  team_id VARCHAR(100),
  team_name VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO slack_workspaces (access_token, team_id, team_name) VALUES
('アクセストークン1', 'T9TK3CUKW', 'Slack Pickleball Team'),
('アクセストークン2', 'T8LK4QJSD', 'Slack Baseball Team'),
('アクセストークン3', 'T7SG9LAQZ', 'Slack Soccer Team');

CREATE TABLE users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  slack_workspace_id INT NOT NULL,  
  name VARCHAR(50) NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (slack_workspace_id) REFERENCES slack_workspaces(id),
  UNIQUE KEY (slack_workspace_id, user_id)
);

INSERT INTO users (slack_workspace_id, name, user_id) VALUES
(1, 'ユーザー1', U1234),
(1, 'ユーザー2', U2345),
(2, 'ユーザー3', U3456);

CREATE TABLE tasks (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  slack_workspace_id INT NOT NULL,
  content VARCHAR(255),
  channel_id VARCHAR(100),
  create_slack_timestamp INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (slack_workspace_id) REFERENCES slack_workspaces(id)
);

INSERT INTO tasks (user_id, slack_workspace_id, content, channel_id, create_slack_timestamp) VALUES
(1,1,'リマインダー1', 'C12345', 1049122800),
(1,2,'リマインダー2', 'C23456', 1741528602),
(1,3,'リマインダー3', 'C34567', 1745157415),
(1,1,'リマインダー4', 'C12345', 1831832047),
(2,2,'リマインダー5', 'C23456', 1894990447),
(2,3,'リマインダー6', 'C34567', 1987006447),
(2,1,'リマインダー7', 'C45678', 2113236847),
(3,2,'リマインダー8', 'C56789', 2146587247);

CREATE TABLE reminders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  task_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (task_id) REFERENCES tasks(id)
);

INSERT INTO reminders (user_id, task_id) VALUES
(2,1),
(3,1),
(2,2),
(3,3),
(2,4),
(3,4),
(1,5),
(3,5),
(3,6),
(1,7),
(1,8),
(2,8);

CREATE TABLE reminder_frequency (
  id INT AUTO_INCREMENT PRIMARY KEY,
  task_id INT NOT NULL,
  frequency_label VARCHAR(100),
  frequency_value INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (task_id) REFERENCES tasks(id)
);

INSERT INTO reminder_frequency (task_id, frequency_label, frequency_value) VALUES
(1, '毎日', 1),
(2, '2日おき', 2),
(3, '毎週X曜日', 3),
(4, '毎月X日', 4),
(5, '毎日', 1),
(6, '2日おき', 2),
(7, '4日おき', 5),
(8, '5時間おき', 6);

CREATE TABLE reminder_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  task_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (task_id) REFERENCES tasks(id)
);

INSERT INTO reminder_logs (task_id) VALUES
(1),
(1),
(1),
(1),
(2),
(2),
(2),
(3),
(3),
(4),
(4),
(5),
(5),
(5),
(6),
(7);