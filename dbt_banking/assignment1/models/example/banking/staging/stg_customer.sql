with source_data as (

    select 
        CustomerID,
        Name,
        HasLoan
    from 
        read_csv_auto('s3://lending-club/Customer.csv', HEADER=TRUE)

),

cleaned_data as (

    select

        CustomerID as customer_id,
        lower(trim(name)) as customer_name,
        case 
            when lower(HasLoan) in ('yes') then 'Yes'
            when lower(HasLoan) in ('no', 'none') then 'No'
            else null
        end as has_loan

    from source_data

)

select * from cleaned_data