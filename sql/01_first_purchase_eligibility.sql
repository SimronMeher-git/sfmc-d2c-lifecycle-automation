/* Journey 1: current first-purchase eligibility audience
   Portfolio SQL pattern for an Automation Studio Query Activity.
   Target: Journey_Audience_DE
   Target action: Overwrite
*/
SELECT
    c.CustomerKey,
    c.EmailAddress,
    c.FirstName,
    c.PreferredCategory,
    c.SignupDate,
    c.TotalOrders,
    'First_Purchase_Prospect' AS Segment
FROM Customer_Master_DE c
WHERE c.CustomerKey IS NOT NULL
  AND c.EmailAddress IS NOT NULL
  AND LEN(LTRIM(RTRIM(c.EmailAddress))) > 0
  AND c.ConsentStatus = 'Opted_In'
  AND c.TotalOrders = 0
  AND c.EmailsSentLast7Days < 3
  AND c.SignupDate >= DATEADD(day, -30, GETDATE())
  AND c.SignupDate <= GETDATE();
