with source_data as (

    select
        AccountID,
        CustomerID,
        Balance,
        AccountType
    from 
        read_csv_auto('s3://lending-club/accounts.csv', HEADER=TRUE)

),

cleaned_data as (

    select

        trim(AccountID) as account_id,
        CustomerID as customer_id,
        case 
            when try_cast(Balance as float) is not null then try_cast(Balance as float)
            else 0
        end as balance,
        lower(trim(AccountType)) as account_type

    from source_data

)

select * from cleaned_data