select
    tier_id,
    min_balance,
    max_balance,
    interest_rate   
from 
    {{ ref('interest_rate_rules') }}