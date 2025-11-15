with savings as (
    select
        customer_id,
        account_id,
        balance     as original_balance,
        has_loan
    from 
        {{ ref('int_savings_accounts') }}
),

rules as (
    select
        tier_id,
        min_balance,
        max_balance,
        interest_rate
    from 
        {{ ref('stg_interest_rate_rules') }}
),

savings_with_rate as (
    -- Join each savings account to correct interest tier based on balance
    select
        s.customer_id,
        s.account_id,
        s.original_balance,
        s.has_loan,
        r.interest_rate as base_interest_rate
    from 
        savings s
    join 
        rules r
    on 
        s.original_balance >= r.min_balance
    and (
            s.original_balance <= r.max_balance
            or r.max_balance is null
        )   
),

result as (
    select
        customer_id,
        account_id,
        original_balance,

        -- +0.5% interest to the base if the customer has a loan, potential problem since the value is hardcoded
        base_interest_rate + 
        case when has_loan then 0.5 else 0.0 end as interest_rate_applied,

        round(
            original_balance
            * (base_interest_rate + case when has_loan then 0.5 else 0.0 end)
            / 100.0,
            2
        ) as annual_interest_amount,

        round(
            original_balance
            + original_balance
            * (base_interest_rate + case when has_loan then 0.5 else 0.0 end)
            / 100.0,
            2
        ) as new_balance
    from savings_with_rate
)

select
    customer_id,
    account_id,
    original_balance,
    interest_rate_applied,
    annual_interest_amount,
    new_balance
from 
    result
order by 
    customer_id, 
    account_id