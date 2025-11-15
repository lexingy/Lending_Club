from dagster import Definitions

from dagster_project.assets.dbt_assets import dbt_models, fct_account_interest_csv
from dagster_project.resources.dbt_resource import dbt_resource


defs = Definitions(
    assets=[
        dbt_models,
        fct_account_interest_csv, # CSV export asset
    ],
    resources={"dbt": dbt_resource},
)