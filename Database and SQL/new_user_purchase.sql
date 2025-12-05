SELECT
    u.id AS user_id,
    u.name AS user_name,
    o.id AS order_id,
    od.delivery_date,
    p.name AS product_name,
    p.price AS product_price,
    od.quantity
FROM ku_user u
JOIN ku_order o 
    ON o.user_id = u.id
JOIN ku_order_detail od 
    ON od.order_id = o.id
JOIN ku_order_detail_status ods 
    ON ods.id = od.status
JOIN ku_product p 
    ON p.id = od.product_id
WHERE 
    ods.name = 'success'
    AND od.delivery_date BETWEEN u.created_at 
                             AND u.created_at + INTERVAL '7 day'
ORDER BY 
    u.id,
    od.delivery_date,
    o.id;