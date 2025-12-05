SELECT
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    u.phone AS user_phone,
    od.delivery_date,
    p.name AS product_name,
    STRING_AGG(c.name, ', ') AS product_categories,
    od.quantity,
    ul.address AS delivery_address,
    SUM(od.quantity) OVER (
        PARTITION BY u.id
        ORDER BY od.delivery_date, u.id, od.id
    ) AS total
FROM ku_order_detail od
JOIN ku_order_detail_status ods 
    ON ods.id = od.status
JOIN ku_order o 
    ON o.id = od.order_id
JOIN ku_user u 
    ON u.id = o.user_id
JOIN ku_user_location ul 
    ON ul.id = od.user_location_id
JOIN ku_product p 
    ON p.id = od.product_id
LEFT JOIN ku_product_category pc 
    ON pc.product_id = p.id
LEFT JOIN ku_category c 
    ON c.id = pc.category_id
WHERE 
    ods.name = 'success'
    AND od.delivery_date >= DATE '2025-09-01'
    AND od.delivery_date <  DATE '2025-10-01'
GROUP BY
    u.id, u.name, u.email, u.phone,
    od.delivery_date, p.name, od.quantity, ul.address, od.id
ORDER BY 
    od.delivery_date,
    u.id,
    od.id;