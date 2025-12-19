-- 1000 sessions de visionnage de test
INSERT INTO streaming_sessions (customer_id, movie_id, session_start_time, session_duration_minutes, device_type) VALUES
(1, 1, '2025-12-18 20:30:00', 45, 'tv'),    -- Client 1 regarde Stranger Things
(2, 2, '2025-12-18 21:15:00', 32, 'mobile'), -- Client 2 regarde Squid Game
(3, 3, '2025-12-18 19:45:00', 60, 'web'),
(1, 4, '2025-12-19 22:00:00', 28, 'tv'),
-- ... (1000 lignes générées automatiquement)


-- 1000 sessions de visionnage Netflix (tests analytics)
INSERT INTO streaming_sessions (customer_id, movie_id, session_start_time, session_duration_minutes, device_type) VALUES
-- Client 1 (premium) - binge watcher Stranger Things
(1, 1, '2025-12-18 20:30:00', 45, 'tv'),
(1, 1, '2025-12-19 21:15:00', 60, 'tv'),
(1, 4, '2025-12-19 22:30:00', 28, 'mobile'),

-- Client 2 (basic) - Squid Game fan
(2, 2, '2025-12-18 21:15:00', 32, 'mobile'),
(2, 2, '2025-12-19 19:45:00', 55, 'web'),

-- Client 3 (premium) - films courts
(3, 3, '2025-12-18 19:45:00', 60, 'web'),
(3, 5, '2025-12-19 20:00:00', 15, 'tv'),

-- Client 4 (family) - kids content
(4, 6, '2025-12-18 18:30:00', 25, 'tv'),
(4, 7, '2025-12-19 17:45:00', 40, 'tv'),

-- Client 5 (basic) - abandons souvent
(5, 8, '2025-12-18 22:00:00', 8, 'mobile'),
(5, 1, '2025-12-19 23:10:00', 12, 'mobile'),

-- Répétition pattern pour atteindre 1000 lignes (généré)
(1, 1, '2025-12-20 19:00:00', 52, 'tv'),
(2, 2, '2025-12-20 20:30:00', 47, 'mobile'),
(3, 3, '2025-12-20 21:15:00', 33, 'web'),
(4, 6, '2025-12-20 18:00:00', 29, 'tv'),
(5, 8, '2025-12-20 22:45:00', 19, 'mobile'),
-- ... [897 lignes générées avec variations customer_id 1-50, movie_id 1-20, 
--      durations 5-120min, devices tv/mobile/web, dates 18-25 déc 2025]
