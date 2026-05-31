WITH car_stats AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(*) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
),
class_avg AS (
    SELECT
        car_class,
        AVG(average_position) AS class_avg_position
    FROM car_stats
    GROUP BY car_class
),
class_total_races AS (
    SELECT
        car_class,
        SUM(race_count) AS total_races
    FROM car_stats
    GROUP BY car_class
)
SELECT
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cl.country AS car_country,
    ctr.total_races
FROM car_stats cs
JOIN class_avg ca ON cs.car_class = ca.car_class
JOIN class_total_races ctr ON cs.car_class = ctr.car_class
JOIN Classes cl ON cs.car_class = cl.class
WHERE ca.class_avg_position = (
    SELECT MIN(class_avg_position) FROM class_avg
)
ORDER BY cs.car_name;