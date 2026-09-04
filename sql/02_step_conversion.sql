WITH funnel AS (
    SELECT
        COUNT(DISTINCT CASE WHEN PageType = 'home' THEN SessionID END) AS home,
        COUNT(DISTINCT CASE WHEN PageType = 'product_page' THEN SessionID END) AS product_page,
        COUNT(DISTINCT CASE WHEN PageType = 'cart' THEN SessionID END) AS cart,
        COUNT(DISTINCT CASE WHEN PageType = 'checkout' THEN SessionID END) AS checkout,
        COUNT(DISTINCT CASE WHEN PageType = 'confirmation' THEN SessionID END) AS confirmation
    FROM customer_journey
)

SELECT
    ROUND(100.0 * product_page / home, 2) AS home_to_product,
    ROUND(100.0 * cart / product_page, 2) AS product_to_cart,
    ROUND(100.0 * checkout / cart, 2) AS cart_to_checkout,
    ROUND(100.0 * confirmation / checkout, 2) AS checkout_to_confirmation,
    ROUND(100.0 * confirmation / home, 2) AS total_conversion
FROM funnel;