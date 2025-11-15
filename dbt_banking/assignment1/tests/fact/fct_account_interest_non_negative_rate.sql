select 
    *
from 
    {{ ref('fct_account_interest') }}
where 
    interest_rate_applied < 0
    or annual_interest_amount < 0
    or new_balance < original_balance