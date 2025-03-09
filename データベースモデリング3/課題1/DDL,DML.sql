CREATE TABLE users (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME
);

INSERT INTO users (name, email, password) VALUES ('ユーザー1', 'user1@example.com', SHA2('password', 256)), ('ユーザー2', 'user2@example.com', SHA2('password', 256));

CREATE TABLE directories (  
  id INT AUTO_INCREMENT PRIMARY KEY,  
  directory_name VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME
);

INSERT INTO directories (directory_name) VALUES ('ディレクトリ1'),('ディレクトリ2'),('ディレクトリ3'),('ディレクトリ4'),('ディレクトリ5');

CREATE TABLE directory_relations (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  ancestor_id INT NOT NULL,
  descendant_id INT NOT NULL,
  path_length INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (ancestor_id) REFERENCES directories(id),
  FOREIGN KEY (descendant_id) REFERENCES directories(id),
  UNIQUE (ancestor_id, descendant_id)
);

INSERT INTO directory_relations (ancestor_id, descendant_id, path_length) VALUES (1,1,0),(1,2,1),(1,3,1),(1,4,2),(1,5,3),(2,2,0),(3,3,0),(3,4,1),(3,5,2),(4,4,0),(4,5,1),(5,5,0);

CREATE TABLE directories_users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  directory_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (directory_id) REFERENCES directories(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE (directory_id, user_id)
);

INSERT INTO directories_users (directory_id, user_id) VALUES (1,1),(1,2),(2,1),(3,1),(3,2),(4,1),(4,2),(5,2);

CREATE TABLE documents (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  directory_id INT NOT NULL,
  documents_name VARCHAR(50) NOT NULL,
  main_text TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME,
  FOREIGN KEY (directory_id) REFERENCES directories(id)
);

INSERT INTO documents (directory_id, documents_name, main_text) VALUES 
(1, 'ドキュメント1', 'サンプルテキスト1'),
(1, 'ドキュメント2', 'サンプルテキスト2'),
(1, 'ドキュメント3', 'サンプルテキスト3'),
(2, 'ドキュメント4', 'サンプルテキスト4'),
(2, 'ドキュメント5', 'サンプルテキスト5'),
(2, 'ドキュメント6', 'サンプルテキスト6'),
(3, 'ドキュメント7', 'サンプルテキスト7'),
(3, 'ドキュメント8', 'サンプルテキスト8'),
(4, 'ドキュメント9', 'サンプルテキスト9'),
(5, 'ドキュメント10', 'サンプルテキスト10');

CREATE TABLE documents_users (  
  id INT AUTO_INCREMENT PRIMARY KEY,
  document_id INT NOT NULL,
  user_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (document_id) REFERENCES documents(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE (document_id, user_id)
);

INSERT INTO documents_users (document_id, user_id) VALUES (1,1),(1,2),(2,1),(2,2),(3,1),(3,2),(4,1),(5,1),(6,1),(7,1),(7,2),(8,1),(8,2),(9,1),(9,2),(10,2);