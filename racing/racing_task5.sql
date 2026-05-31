WITH car_stats AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        cl.country AS car_country,
        AVG(r.position) AS average_position,
        COUNT(r.race) AS race_count
    FROM Cars c
    JOIN Classes cl ON c.class = cl.class
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class, cl.country
),
class_stats AS (
    SELECT
        car_class,
        COUNT(*) AS low_position_count,
        SUM(race_count) AS total_races
    FROM car_stats
    GROUP BY car_class
)
SELECT
    cs.car_name,
    cs.car_class,
    ROUND(cs.average_position, 4) AS average_position,
    cs.race_count,
    cs.car_country,
    cls.total_races,
    cls.low_position_count
FROM car_stats cs
JOIN class_stats cls
    ON cs.car_class = cls.car_class
WHERE cs.average_position > 3
ORDER BY
    cls.low_position_count DESC,
    cs.average_position ASC;