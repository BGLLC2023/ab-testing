-- ============================================================
-- Author: Greg
-- Dataset: Kaggle Marketing AB Testing 
-- ============================================================
-- Business Goal: Increase conversions using the most effective marketing channel
-- H0: There will be no difference in conversion rates between ads and PSA
-- H1: Ads will be more effective in converting new customers than PSA

USE marketingab;

SELECT * FROM marketing_ab ORDER BY test_group ASC LIMIT 5;

-- Which days of the week have the most conversions 
SELECT
	DISTINCT most_ads_day,
	COUNT(converted) OVER (PARTITION BY most_ads_day) AS daily_conversion_sum
FROM marketing_ab
WHERE converted = 'True'
ORDER BY daily_conversion_sum DESC;

-- Total number of ads and PSA
SELECT
	DISTINCT test_group,
	COUNT(test_group) OVER(PARTITION BY test_group) AS total
FROM marketing_ab;

-- Total number of conversions for ads and PSA
SELECT
	DISTINCT test_group,
	COUNT(converted) OVER (PARTITION BY test_group) AS total_conversions
FROM marketing_ab
WHERE converted = 'True';

-- Total number of non-conversions for ads and PSA
SELECT
	DISTINCT test_group,
	COUNT(converted) OVER (PARTITION BY test_group) AS total_conversions
FROM marketing_ab
WHERE converted = 'False';

-- Conversion rate
SELECT 
    test_group,
    COUNT(*) AS conversions,
    (SELECT COUNT(*) FROM marketing_ab WHERE converted = 'True') AS total_conversions,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM marketing_ab WHERE converted = 'True') AS conversion_rate
FROM marketing_ab
WHERE converted = 'True'
GROUP BY test_group;

-- converion rate by test group

SELECT
    test_group,
    COUNT(*) AS total,
    SUM(converted = 'True') AS conversions,
    (SUM(converted = 'True') / COUNT(*)) * 100 AS conversion_rate
FROM marketing_ab
GROUP BY test_group;











