WITH customer_stats AS (
    SELECT
        c.ID_customer,
        c.name,
        COUNT(b.ID_booking) AS total_bookings,
        COUNT(DISTINCT r.ID_hotel) AS unique_hotels,
        SUM(rm.price) AS total_spent
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room rm ON b.ID_room = rm.ID_room
    JOIN Hotel r ON rm.ID_hotel = r.ID_hotel
    GROUP BY c.ID_customer, c.name
),
frequent_customers AS (
    SELECT
        ID_customer,
        name,
        total_bookings,
        unique_hotels,
        total_spent
    FROM customer_stats
    WHERE total_bookings > 2
      AND unique_hotels > 1
),
high_spenders AS (
    SELECT
        ID_customer,
        name,
        total_spent,
        total_bookings
    FROM customer_stats
    WHERE total_spent > 500
)
SELECT
    f.ID_customer,
    f.name,
    f.total_bookings,
    ROUND(f.total_spent, 2) AS total_spent,
    f.unique_hotels
FROM frequent_customers f
JOIN high_spenders h
    ON f.ID_customer = h.ID_customer
ORDER BY total_spent ASC;