FROM python:3.11-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash git curl unzip build-essential ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# install DuckDB cli
ARG DUCKDB_VERSION=1.1.0
RUN curl -L -o /tmp/duckdb.zip \
      https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-aarch64.zip \
  && unzip /tmp/duckdb.zip -d /usr/local/bin \
  && chmod +x /usr/local/bin/duckdb \
  && rm /tmp/duckdb.zip

RUN pip install --no-cache-dir \
      dbt-core==1.8.7 \
      dbt-duckdb==1.8.2 \
      duckdb==1.1.0 \
      boto3==1.35.81 \
      dagster==1.12.2 \
      dagster-webserver==1.12.2 \
      dagster-dbt==0.28.2

WORKDIR /dbt_banking

ENV DAGSTER_HOME=/opt/dagster 

# Create Dagster home
RUN mkdir -p $DAGSTER_HOME

# Default to bash; docker-compose will override to run Dagster
CMD ["bash"]