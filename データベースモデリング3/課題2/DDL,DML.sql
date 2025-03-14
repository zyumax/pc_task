CREATE TABLE users (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59'
);

INSERT INTO users (name, email, password) VALUES
('ユーザー1', 'user1@example.com', SHA2('password', 256)),
('ユーザー2', 'user2@example.com', SHA2('password', 256)),
('ユーザー3', 'user3@example.com', SHA2('password', 256));

CREATE TABLE directories (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  directory_name VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59'
);

INSERT INTO directories (directory_name) VALUES
('ディレクトリ1'),
('ディレクトリ2'),
('ディレクトリ3'),
('ディレクトリ4'),
('ディレクトリ5');

CREATE TABLE directory_relations (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  ancestor_id INT NOT NULL,
  descendant_id INT NOT NULL,
  hierarchy_depth INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (ancestor_id) REFERENCES directories(id),
  FOREIGN KEY (descendant_id) REFERENCES directories(id),
  UNIQUE (ancestor_id, descendant_id)
);

INSERT INTO directory_relations (ancestor_id, descendant_id, hierarchy_depth) VALUES
(1,1,0),
(1,2,1),
(1,3,1),
(1,4,2),
(1,5,3),
(2,2,0),
(3,3,0),
(3,4,1),
(3,5,2),
(4,4,0),
(4,5,1),
(5,5,0);

CREATE TABLE directories_users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  directory_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (directory_id) REFERENCES directories(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE (directory_id, user_id)
);

INSERT INTO directories_users (directory_id, user_id) VALUES
(1,1),
(1,2),
(1,3),
(2,1),
(2,3),
(3,1),
(3,2),
(4,1),
(4,2),
(5,2);

CREATE TABLE documents (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  directory_id INT NOT NULL,
  user_id INT NOT NULL,
  parent_id INT DEFAULT NULL,
  documents_name VARCHAR(50) NOT NULL,
  content TEXT NOT NULL,
  sort_order INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (directory_id) REFERENCES directories(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_id) REFERENCES documents(id)
);

INSERT INTO documents (directory_id, user_id, parent_id, documents_name, content, sort_order) VALUES
(1, 1, NULL, 'ドキュメント1', 'サンプルテキスト1', 1),
(1, 1, NULL, 'ドキュメント2', 'サンプルテキスト2', 2),
(1, 2, 1, 'ドキュメント3', 'サンプルテキスト3', 1),
(2, 1, NULL, 'ドキュメント4', 'サンプルテキスト4', 1),
(2, 1, 4, 'ドキュメント5', 'サンプルテキスト5', 1),
(2, 1, 4, 'ドキュメント6', 'サンプルテキスト6', 1),
(3, 2, NULL, 'ドキュメント7', 'サンプルテキスト7', 1),
(3, 2, 7, 'ドキュメント8', 'サンプルテキスト8', 1),
(4, 2, NULL, 'ドキュメント9', 'サンプルテキスト9', 1),
(5, 2, NULL, 'ドキュメント10', 'サンプルテキスト10', 1);

-- ドキュメントが最新でないものはdeleted_atを入れる
UPDATE documents
SET deleted_at = NOW() WHERE id IN (1,4,5,7);


CREATE TABLE document_permissions (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  document_id INT NOT NULL,
  user_id INT NOT NULL,
  role TINYINT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (document_id) REFERENCES documents(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE (document_id, user_id)
);

INSERT INTO document_permissions (document_id, user_id, role) VALUES
(1,1,1),
(1,2,1),
(1,3,2),
(2,1,1),
(2,2,1),
(2,3,2),
(3,1,1),
(3,2,1),
(3,3,2),
(4,1,1),
(4,3,2),
(5,1,1),
(5,3,2),
(6,1,1),
(6,3,2),
(7,1,1),
(7,2,1),
(8,1,1),
(8,2,1),
(9,1,1),
(9,2,1),
(10,2,1);