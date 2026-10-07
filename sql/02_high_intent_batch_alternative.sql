/* Diagnostic/batch alternative only.
   This is NOT the canonical Journey 2 entry mechanism.
   Journey 2 is modeled as a real-time API Event.
*/
SELECT
    b.EventID,
    b.CustomerKey,
    c.EmailAddress,
    c.FirstName,
    b.EventType,
    b.EventTimestamp,
    b.ProductCategory,
    b.ProductName,
    b.CartValue,
    'High_Intent_Event' AS Segment
FROM Behavioral_Events_DE b
INNER JOIN Customer_Master_DE c
    ON b.CustomerKey = c.CustomerKey
LEFT JOIN Abandonment_Status_DE s
    ON b.EventID = s.EventID
WHERE c.ConsentStatus = 'Opted_In'
  AND c.EmailsSentLast7Days < 3
  AND b.EventType IN ('Add_To_Cart', 'Checkout_Started')
  AND b.EventTimestamp >= DATEADD(day, -1, GETDATE())
  AND (s.EventID IS NULL OR s.ConvertedFlag = 0);
