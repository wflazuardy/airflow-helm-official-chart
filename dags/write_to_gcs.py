
"""DAG with a custom operator that creates and writes example data to GCS. """

from datetime import datetime
from custom_operators.gcs_operators import ExampleDataToGCSOperator

from airflow import DAG
from airflow.utils.dates import days_ago


with DAG(
    'create_and_write_example_data_to_gcs',
    start_date=days_ago(2),
    schedule_interval=None
) as dag:

    create_and_write_example_data = ExampleDataToGCSOperator(
        task_id='create_example_data',
        run_date='{{ ds }}',
        gcp_conn_id='airflow_gke_gcs_conn_id',
        gcs_bucket='example-data-bucket'
    )

    create_and_write_example_data