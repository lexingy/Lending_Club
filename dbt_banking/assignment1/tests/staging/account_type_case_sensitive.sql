select *
from {{ ref('accounts') }}
where lower(trim(AccountType)) not in ('savings', 'checking')