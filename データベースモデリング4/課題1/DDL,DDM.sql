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

CREATE TABLE reminder_frequency (
  id INT AUTO_INCREMENT PRIMARY KEY,
  frequency VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59'
);

INSERT INTO reminder_frequency (frequency) VALUES
('毎日'),
('X日おき'),
('毎週X曜日'),
('毎月X日');

CREATE TABLE send_reminders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  reminder_frequency_id INT NOT NULL,
  content VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (reminder_frequency_id) REFERENCES reminder_frequency(id)
);

INSERT INTO send_reminders (user_id, reminder_frequency_id, content) VALUES
(1,1,'リマインダー1'),
(1,2,'リマインダー2'),
(1,3,'リマインダー3'),
(1,4,'リマインダー4'),
(2,1,'リマインダー5'),
(2,3,'リマインダー6'),
(2,4,'リマインダー7'),
(3,2,'リマインダー8');

CREATE TABLE get_reminders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  send_reminders_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  deleted_at DATETIME DEFAULT '9999-12-31 23:59:59',
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (send_reminders_id) REFERENCES send_reminders(id)
);

INSERT INTO get_reminders (user_id, send_reminders_id) VALUES
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

CREATE TABLE reminder_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  send_reminders_id INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (send_reminders_id) REFERENCES send_reminders(id)
);

INSERT INTO reminder_logs (send_reminders_id) VALUES
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