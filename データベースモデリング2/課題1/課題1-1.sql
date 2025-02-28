CREATE DATABASE db2;

CREATE TABLE users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  image_id INT,
  name VARCHAR(100) NOT NULL,  
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  status TINYINT NOT NULL,
  created_at DATETIME,  
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME 
);

INSERT INTO users (name, image_id, email, password, status, created_at, updated_at) VALUES ('ユーザー1', 1, 'user1@example.com', SHA2('password', 256), 1, NOW(), NOW()), ('ユーザー2', NULL, 'user2@example.com', SHA2('password', 256), 2, NOW(), NOW());

CREATE TABLE images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  file_path VARCHAR(255),
  mime_type VARCHAR(255),
  file_size VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO images (user_id, file_path, mime_type, file_size) VALUES (1, 'profile_image', 'image/png', 50);

CREATE TABLE workspaces (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  name VARCHAR(100) NOT NULL,  
  created_at DATETIME,  
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO workspaces (name, created_at, updated_at) VALUES ('ワークスペース1', '2025-02-19 23:00:00', '2025-02-19 23:00:00'), ('ワークスペース2', '2025-02-19 23:30:00', '2025-02-19 23:30:00'), ('ワークスペース3', '2025-02-19 23:15:00', '2025-02-19 23:15:00');

CREATE TABLE channels (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  workspace_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,  
  created_at DATETIME,  
  updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id)
);

INSERT INTO channels (workspace_id, name, created_at, updated_at) VALUES (1, 'チャンネル1-1', '2025/2/19 22:00:00', '20250219220000'),(1, 'チャンネル1-2', '2025/2/19 23:00:00', '20250219230000'),(1, 'チャンネル1-3', '2025/2/19 21:30:00', '20250219213000'),(2, 'チャンネル2-1', '2025/2/19 22:30:00', '20250219223000'),(2, 'チャンネル2-2', '2025/2/19 23:30:00', '20250219233000'),(3, 'チャンネル3-1', '2025/2/19 23:40:00', '20250219234000');

CREATE TABLE messages (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  channel_id INT NOT NULL,
  parent_id INT DEFAULT NULL,
  post text NOT NULL,  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME,
  FULLTEXT (post) WITH PARSER ngram,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id),
  FOREIGN KEY (parent_id) REFERENCES messages(id)
);

INSERT INTO messages (user_id, channel_id, parent_id, post) VALUES (1, 1, NULL, 'おはよう'),(1, 1, NULL, 'こんにちは'),(2, 1, 2, 'こんにちは！'), (1, 1, NULL, 'こんばんは'),(2, 1, 4, 'こんばんは！'), (1, 4, NULL, '今日の天気は？'),(2, 5, NULL, '明日の予定は？'),(1, 5, 7, 'スポーツします'),(2, 5, NULL, '仕事は何してる？'),(1, 5, 9, '漁師です'),(1, 4, NULL, 'メッセージ1'),(2, 1, NULL, 'メッセージ2'),(2, 1, 12, 'スレッド1'),(2, 1, 12, 'スレッド2');

CREATE TABLE workspaces_users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  workspace_id INT NOT NULL,
  user_id INT NOT NULL,  
  role TINYINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (workspace_id) REFERENCES workspaces(id)
);

INSERT INTO workspaces_users (workspace_id, user_id, role, is_active) VALUES (2, 1, 1, 1),(2, 2, 2, 1),(1, 1, 1, 1),(1, 2, 2, 0),(3, 1, 1, 1);

CREATE TABLE channels_users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  channel_id INT NOT NULL,
  user_id INT NOT NULL,  
  role TINYINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (channel_id) REFERENCES channels(id)
);

INSERT INTO channels_users (channel_id, user_id, role, is_active) VALUES (4, 1, 1, 1),(5, 2, 1, 1),(1, 1, 2, 1),(1, 2, 1, 1),(6, 1, 2, 0),(5, 1, 2, 1);