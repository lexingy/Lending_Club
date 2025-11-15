with accounts as (

    select
        account_id,
        customer_id,
        balance
    from 
        {{ ref('stg_accounts') }}
    where 
        account_type = 'savings'
        and balance > 0

),

customer as (

    select
        customer_id,
        customer_name,
        has_loan
    from 
        {{ ref('stg_customer') }}

)

select
    a.account_id,
    a.customer_id,
    a.balance,
    c.customer_name,
    coalesce(c.has_loan, 'No') as has_loan
from 
    accounts a
left join 
    customer c
on 
    a.customer_id = c.customer_id
