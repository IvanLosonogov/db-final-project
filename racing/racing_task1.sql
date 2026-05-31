WITH car_stats AS (
    SELECT
        c.name AS car_name,
        c.class AS car_class,
        AVG(r.position) AS average_position,
        COUNT(*) AS race_count
    FROM Cars c
    JOIN Results r ON c.name = r.car
    GROUP BY c.name, c.class
)
SELECT
    car_name,
    car_class,
    ROUND(average_position, 4) AS average_position,
    race_count
FROM car_stats cs
WHERE average_position = (
    SELECT MIN(cs2.average_position)
    FROM car_stats cs2
    WHERE cs2.car_class = cs.car_class
)
ORDER BY average_position, car_name;