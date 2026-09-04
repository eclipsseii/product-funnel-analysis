WITH sessions AS (
    SELECT
        SessionID,
        MAX(DeviceType) AS device_type,
        MAX(ReferralSource) AS referral_source,
        MAX(CASE WHEN PageType = 'confirmation' THEN 1 ELSE 0 END) AS purchased
    FROM customer_journey
    GROUP BY SessionID
)

SELECT
    referral_source,
    COUNT(*) AS sessions,
    SUM(purchased) AS purchases,
    ROUND(100.0 * SUM(purchased) / COUNT(*), 2) AS conversion_rate
FROM sessions
GROUP BY referral_source
ORDER BY conversion_rate DESC;