WITH session_steps AS (
    SELECT
        SessionID,
        MAX(CASE WHEN PageType = 'home' THEN 1 ELSE 0 END) AS home,
        MAX(CASE WHEN PageType = 'product_page' THEN 1 ELSE 0 END) AS product_page,
        MAX(CASE WHEN PageType = 'cart' THEN 1 ELSE 0 END) AS cart,
        MAX(CASE WHEN PageType = 'checkout' THEN 1 ELSE 0 END) AS checkout,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END) AS confirmation
    FROM customer_journey
    GROUP BY SessionID
)

SELECT
    SUM(home) AS home_sessions,
    SUM(product_page) AS product_page_sessions,
    SUM(cart) AS cart_sessions,
    SUM(checkout) AS checkout_sessions,
    SUM(confirmation) AS confirmation_sessions
FROM session_steps;