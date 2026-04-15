SELECT COUNT(*) FROM smartphone_addiction_analysis;

-- Addiction Rate
SELECT 
    AVG(addicted_label) * 100 AS addiction_percentage,
    COUNT(CASE WHEN addicted_label = 1 THEN 1 END) AS addicted_users,
    COUNT(CASE WHEN addicted_label = 0 THEN 1 END) AS non_addicted_users
FROM smartphone_addiction_analysis;

-- Average daily screen time
SELECT 
    addiction_level,
    ROUND(AVG(daily_screen_time_hours), 2) AS avg_screen_time_hours
FROM smartphone_addiction_analysis
GROUP BY addiction_level
ORDER BY avg_screen_time_hours DESC;

-- Total records and quick summary
SELECT 
    COUNT(*) AS total_users,
    ROUND(AVG(addicted_label) * 100, 1) AS addiction_rate_percent,
    ROUND(AVG(daily_screen_time_hours), 2) AS avg_daily_screen_time,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours
FROM smartphone_addiction_analysis;

-- Distribution by addiction level
SELECT 
    addiction_level,
    COUNT(*) AS user_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage,
    ROUND(AVG(daily_screen_time_hours), 2) AS avg_screen_time_hours,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep_hours
FROM smartphone_addiction_analysis
GROUP BY addiction_level
ORDER BY avg_screen_time_hours DESC;

-- Addiction rate by gender
SELECT 
    gender,
    COUNT(*) AS total_users,
    SUM(addicted_label) AS addicted_users,
    ROUND(AVG(addicted_label) * 100, 1) AS addiction_rate_percent
FROM smartphone_addiction_analysis
GROUP BY gender
ORDER BY addiction_rate_percent DESC;

-- Addiction by age group
SELECT 
    CASE 
        WHEN age < 20 THEN 'Teen (Under 20)'
        WHEN age BETWEEN 20 AND 24 THEN 'Young Adult (20-24)'
        WHEN age BETWEEN 25 AND 34 THEN 'Adult (25-34)'
        ELSE 'Senior (35+)'
    END AS age_group,
    COUNT(*) AS total_users,
    ROUND(AVG(addicted_label) * 100, 1) AS addiction_rate_percent
FROM smartphone_addiction_analysis
GROUP BY age_group
ORDER BY addiction_rate_percent DESC;

-- Average screen time, notifications, app opens by addicted vs non-addicted
SELECT 
    addicted_label,
    ROUND(AVG(daily_screen_time_hours), 2) AS avg_screen_time,
    ROUND(AVG(social_media_hours), 2) AS avg_social_media,
    ROUND(AVG(gaming_hours), 2) AS avg_gaming,
    ROUND(AVG(notifications_per_day), 0) AS avg_notifications,
    ROUND(AVG(app_opens_per_day), 0) AS avg_app_opens,
    ROUND(AVG(sleep_hours), 2) AS avg_sleep
FROM smartphone_addiction_analysis
GROUP BY addicted_label;

-- How addiction affects stress and academic/work life
SELECT 
    stress_level,
    ROUND(AVG(addicted_label) * 100, 1) AS addiction_rate_percent,
    COUNT(*) AS user_count
FROM smartphone_addiction_analysis
GROUP BY stress_level
ORDER BY addiction_rate_percent DESC;

SELECT 
    academic_work_impact,
    ROUND(AVG(addicted_label) * 100, 1) AS addiction_rate_percent
FROM smartphone_addiction_analysis
GROUP BY academic_work_impact;

SELECT 
    addicted_label,
    ROUND(AVG(daily_screen_time_hours), 2) AS avg_weekday_screen,
    ROUND(AVG(weekend_screen_time), 2) AS avg_weekend_screen,
    ROUND(AVG(weekend_screen_time - daily_screen_time_hours), 2) AS extra_weekend_hours
FROM smartphone_addiction_analysis
GROUP BY addicted_label;