from dagster_dbt import DbtCliResource, DbtProject

DBT_PROJECT_DIR = "/dbt_banking/assignment1/"
DBT_PROFILES_DIR = "/dbt_banking/assignment1/.dbt"

dbt_project = DbtProject(project_dir=DBT_PROJECT_DIR)

dbt_resource = DbtCliResource(
    project_dir=dbt_project,
    profiles_dir=DBT_PROFILES_DIR,
)