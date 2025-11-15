import dagster as dg
from dagster import asset, AssetExecutionContext, AssetKey
from dagster_dbt import dbt_assets, DbtCliResource

from dagster_project.resources.dbt_resource import dbt_project


@dbt_assets(manifest=dbt_project.manifest_path)
def dbt_models(context: dg.AssetExecutionContext, dbt: DbtCliResource):

    yield from dbt.cli(["build"], context=context).stream()


@asset(
    deps=[AssetKey("fct_account_interest")]  # depends on the dbt model asset
)
def fct_account_interest_csv(
    context: AssetExecutionContext,
    dbt: DbtCliResource,
):

    dbt.cli([
        "run-operation",
        "export_fct_account_interest",
        "--args",
        '{"output_path": "/dbt_banking/assignment1/exports/account_summary.csv"}',
    ]).wait()