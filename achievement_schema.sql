-- ============================================
-- ACHIEVEMENT SYSTEM SCHEMA
-- ============================================

-- 1. Tabel Master Achievement (Definisi Achievement)
CREATE TABLE IF NOT EXISTS achievements (
  `achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(50) NOT NULL DEFAULT '⭐',
  `badge_color` varchar(50) NOT NULL DEFAULT 'blue',
  `milestone_type` enum('booking','community','product','premium') NOT NULL,
  `milestone_value` int(11) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`achievement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 2. Tabel User Achievement (Track Achievement User)
CREATE TABLE IF NOT EXISTS user_achievements (
  `user_achievement_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `achievement_id` int(11) NOT NULL,
  `unlocked_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_achievement_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  FOREIGN KEY (`achievement_id`) REFERENCES `achievements` (`achievement_id`) ON DELETE CASCADE,
  UNIQUE KEY `unique_user_achievement` (`user_id`, `achievement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================
-- INSERT MASTER ACHIEVEMENTS
-- ============================================

INSERT INTO achievements (name, description, icon, badge_color, milestone_type, milestone_value) VALUES
('First Booking', 'Lakukan booking pertama kali', '🎫', 'blue', 'booking', 1),
('Court Regular', 'Sudah booking 5 kali', '🎾', 'green', 'booking', 5),
('Booking Master', 'Sudah booking 20 kali', '👑', 'gold', 'booking', 20),
('Community Starter', 'Buat komunitas pertama', '🚀', 'purple', 'community', 1),
('Social Player', 'Join 3 komunitas', '👥', 'pink', 'community', 3),
('Popular Member', 'Jadi member di 5+ komunitas', '⭐', 'orange', 'community', 5),
('Shopper', 'Beli produk pertama kali', '🛍️', 'red', 'product', 1),
('Gear Collector', 'Beli 5 produk berbeda', '🎒', 'cyan', 'product', 5),
('Premium Player', 'Upgrade ke premium member', '💎', 'gold', 'premium', 1);
