WITH hotel_categories AS (
    SELECT
        h.ID_hotel,
        h.name AS hotel_name,
        CASE
            WHEN AVG(r.price) < 175 THEN 'Дешевый'
            WHEN AVG(r.price) <= 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS hotel_type
    FROM Hotel h
    JOIN Room r ON h.ID_hotel = r.ID_hotel
    GROUP BY h.ID_hotel, h.name
),
customer_hotels AS (
    SELECT
        c.ID_customer,
        c.name,
        hc.hotel_name,
        hc.hotel_type
    FROM Customer c
    JOIN Booking b ON c.ID_customer = b.ID_customer
    JOIN Room r ON b.ID_room = r.ID_room
    JOIN hotel_categories hc ON r.ID_hotel = hc.ID_hotel
)
SELECT
    ID_customer,
    name,
    CASE
        WHEN SUM(hotel_type = 'Дорогой') > 0 THEN 'Дорогой'
        WHEN SUM(hotel_type = 'Средний') > 0 THEN 'Средний'
        ELSE 'Дешевый'
    END AS preferred_hotel_type,
    GROUP_CONCAT(DISTINCT hotel_name ORDER BY hotel_name SEPARATOR ',') AS visited_hotels
FROM customer_hotels
GROUP BY ID_customer, name
ORDER BY
    CASE
        WHEN SUM(hotel_type = 'Дорогой') > 0 THEN 3
        WHEN SUM(hotel_type = 'Средний') > 0 THEN 2
        ELSE 1
    END,
    ID_customer;