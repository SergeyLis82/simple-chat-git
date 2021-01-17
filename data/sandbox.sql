CREATE USER 'mysql'@'localhost' IDENTIFIED BY 'mysql';
GRANT SELECT,UPDATE,INSERT ON sandbox.* TO 'mysql'@'localhost';
CREATE TABLE IF NOT EXISTS `chat` (
  `id` int unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(32) NOT NULL,
  `message` varchar(255) NOT NULL,
  `created_at` int unsigned NOT NULL
) ENGINE='InnoDB';


