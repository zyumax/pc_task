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
  latest_revision INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59'
);

INSERT INTO articles (latest_revision) VALUES
(4),
(3),
(3),
(2),
(1),
(1);
-- articlesのid=6を削除(記事自体の削除を想定)
UPDATE articles 
SET deleted_at = NOW()
WHERE id = 6;

CREATE TABLE article_histories (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  article_id INT NOT NULL,
  user_id INT NOT NULL,
  revision INT NOT NULL,
  title VARCHAR(50),
  content TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (article_id) REFERENCES articles(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO article_histories (article_id, user_id, revision, title, content) VALUES
(1,1,1, 'タイトル1', '本文1'),
(1,1,2, 'タイトル1', '本文1_1'),
(1,2,3, 'タイトル1', '本文1_2'),
(1,3,4, 'タイトル1', '本文1_3'),
(2,2,1, 'タイトル2', '本文2'),
(2,3,2, 'タイトル2', '本文2_1'),
(2,2,3, 'タイトル2', '本文2_2'),
(3,1,1, 'タイトル3', '本文3'),
(3,1,2, 'タイトル3_1', '本文3'),
(3,2,3, 'タイトル3_2', '本文3_1'),
(4,2,1, 'タイトル4', '本文4'),
(4,3,2, 'タイトル4_1', '本文4_1'),
(5,1,1, 'タイトル5', '本文5'),
(6,1,1, 'タイトル6', '本文6');

UPDATE article_histories 
SET created_at = NOW()
WHERE id IN (4,7,10,12,13);