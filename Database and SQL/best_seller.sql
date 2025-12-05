SELECT
    p.name AS product_name,
    SUM(p.price * od.quantity) AS total_gmv,
    SUM(od.quantity) AS total_quantity,
    COUNT(DISTINCT o.user_id) AS unique_user_count
FROM ku_order_detail od
JOIN ku_order_detail_status ods 
    ON ods.id = od.status
JOIN ku_order o 
    ON o.id = od.order_id
JOIN ku_product p 
    ON p.id = od.product_id
WHERE 
    ods.name = 'success'
    AND od.delivery_date >= DATE '2025-07-01'
    AND od.delivery_date <  DATE '2025-10-01'
GROUP BY 
    p.name
ORDER BY 
    total_gmv DESC,
    total_quantity DESC;