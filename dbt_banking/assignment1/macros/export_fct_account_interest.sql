{% macro export_fct_account_interest(output_path) %}
    {# Build the query against your model #}
    {% set query %}
        select *
        from {{ ref('fct_account_interest') }}
    {% endset %}

    {% if execute %}
        {# DuckDB: COPY (query) TO 'file.csv' WITH (HEADER, DELIMITER ','); #}

        {% set copy_sql %}
            COPY (
                {{ query }}
            )
            TO '{{ output_path }}'
            WITH (HEADER, DELIMITER ',');
        {% endset %}

        {# Actually run the COPY statement #}
        {% do run_query(copy_sql) %}

        {% do log("Wrote CSV to " ~ output_path, info=True) %}
    {% else %}
        {# Compile-time, just log #}
        {% do log("Would export fct_account_interest to " ~ output_path, info=True) %}
    {% endif %}
{% endmacro %}