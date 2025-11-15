Lending Club Analytics Pipeline

A containerized dbt + Dagster pipeline for processing Lending Club–style data using Docker and MinIO.

🚀 Setup Instructions
1. Clone the repository
```bash
git clone https://github.com/lexingy/Lending_Club.git
cd Lending_Club/dbt_banking/assignment1/
```

2. Start Docker environment
```bash
docker compose up -d --build
```

This launches:

dbt_banking (dbt + Dagster)

MinIO (S3-compatible storage)

3. Upload source data to MinIO

Open http://localhost:9000

Login: minioadmin / minioadmin

Create a bucket named lending-club

Upload the two CSV files from source_data/

4. Build the dbt project
```bash
docker exec dbt_banking dbt build
```

This generates the manifest.json required for Dagster.

5. Materialize all Dagster assets
```bash
docker exec dbt_banking dagster asset materialize -m dagster_project --select "*"
```

This runs the full pipeline and generates:

exports/account_summary.csv

📝 Output

The final result is written to:

exports/account_summary.csv

🛑 Stop the environment
```bash
docker compose down
```