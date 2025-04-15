CREATE TABLE users (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59'
);

INSERT INTO users (name, email) VALUES
('ユーザー1', 'user1@example.com'),
('ユーザー2', 'user2@example.com'),
('ユーザー3', 'user3@example.com');

CREATE TABLE articles (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  article_id INT NOT NULL,
  create_by INT NOT NULL,
  title VARCHAR(50),
  content TEXT,
  status TINYINT DEFAULT 1 COMMENT '1:最新,2:過去,3:削除',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (create_by) REFERENCES users(id)
);

INSERT INTO articles (article_id, create_by, title, content, status) VALUES
(1,1, 'タイトル1', '本文1', 2),
(1,1, 'タイトル1', '本文1_1', 2),
(1,2, 'タイトル1', '本文1_2', 2),
(1,3, 'タイトル1', '本文1_3', 1),
(2,2, 'タイトル2', '本文2', 2),
(2,3, 'タイトル2', '本文2_1', 2),
(2,2, 'タイトル2', '本文2_2', 1),
(3,1, 'タイトル3', '本文3', 2),
(3,1, 'タイトル3_1', '本文3', 2),
(3,2, 'タイトル3_2', '本文3_1', 1),
(4,2, 'タイトル4', '本文4', 2),
(4,3, 'タイトル4_1', '本文4_1', 1),
(5,1, 'タイトル5', '本文5', 1),
(6,1, 'タイトル6', '本文6', 3);