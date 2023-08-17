-- Model to extract the data from the seed output
-- POSTGRES SYNTAX
-- CAST strings into the proper format
-- Creation of a category based on the transaction details 
-- creation of a column to directly identify if it's a deposit or a withdrawal

select "Account No" as account_no, 
gen_random_uuid() as transaction_id,
"TRANSACTION DETAILS" as transaction_details,
CAST("CHQNO" AS INTEGER) as chq_no,
TO_DATE("DATE",'Mon DD, YYYY') + INTERVAL '2000 year' as date,
TO_DATE("VALUE DATE",'Mon DD, YYYY') + INTERVAL '2000 year' as value_date,
CAST(" WITHDRAWAL AMT " AS FLOAT) as withdrawal_amt,
CAST(" DEPOSIT AMT " AS FLOAT) as deposit_amt,
CAST("BALANCE AMT" AS FLOAT) as balance_amt, 

CASE 
WHEN "TRANSACTION DETAILS" like '%Indiaforensic%' THEN 'Indiaforensic'
WHEN "TRANSACTION DETAILS" like '%CASHDEP%' THEN 'Cash deposit'
WHEN "TRANSACTION DETAILS" like '%RTGS%' THEN 'Real-time Gross Settlement'
WHEN "TRANSACTION DETAILS" like '%IMPS%' THEN 'Immediate Payment Service'
WHEN "TRANSACTION DETAILS" like '%RUPAY%' THEN 'RUPAY'
WHEN "TRANSACTION DETAILS" like '%NEFT%' THEN 'NEFT'
WHEN "TRANSACTION DETAILS" like '%FDRL%' THEN 'FDRL'
WHEN "TRANSACTION DETAILS" like '%CHQ DEP%' THEN 'Check deposit'
WHEN "TRANSACTION DETAILS" like '%AEPS%' THEN 'Aadhaar Enabled Payment System'
WHEN "TRANSACTION DETAILS" like '%INTERNAL FUND%' THEN 'Internal fund transfer'
ELSE 'Others'
END  as category, 

CASE 
WHEN " WITHDRAWAL AMT " > 0  THEN 'withdrawal'
WHEN " DEPOSIT AMT " > 0  THEN 'deposit'

END  as type

from postgres.public.transactions_data