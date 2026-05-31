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
class_stats AS (
    SELECT
        car_class,
        AVG(average_position) AS class_avg_position,
        COUNT(*) AS cars_in_class
    FROM car_stats
    GROUP BY car_class
)
SELECT
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cl.country AS car_country
FROM car_stats cs
JOIN class_stats cls ON cs.car_class = cls.car_class
JOIN Classes cl ON cs.car_class = cl.class
WHERE cls.cars_in_class >= 2
  AND cs.average_position < cls.class_avg_position
ORDER BY cs.car_class, cs.average_position;