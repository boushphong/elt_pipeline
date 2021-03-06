#!/usr/bin/env bash

airflow db init

# Stop flooding my DAG UI
sed -i 's/load_examples = True/load_examples = False/' airflow.cfg

# Run the scheduler in background
airflow scheduler &> /dev/null &

# Create user
airflow users create -u admin -p admin -r Admin -e admin@admin.com -f Phong -l Bui

# Add Airbyte connection
airflow connections add --conn-host localhost --conn-port 8000 --conn-type airbyte airbyte_conn

# Run the web server in foreground (for docker logs)
exec airflow webserver
