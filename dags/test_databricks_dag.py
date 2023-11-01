import os

from airflow import DAG
from airflow.providers.databricks.operators.databricks import DatabricksRunNowOperator, DatabricksSubmitRunOperator
from airflow.utils.dates import days_ago


# Bypass connection
os.environ["no_proxy"] = "*"

# Default Arguments
default_args = {
    'owner': 'airflow'
}

# DAG initiation
with DAG('databricks_dag',
    start_date = days_ago(2),
    schedule_interval = None,
    default_args = default_args
) as dag:
    
    '''
        Tasks
    '''
    opr_run_now = DatabricksRunNowOperator(
        task_id = 'run_now',
        databricks_conn_id = 'databricks_default',
        job_id = 89983144669231
    )
    
    opr_submit_run = DatabricksSubmitRunOperator(
        task_id='submit_run',
        notebook_task={
            "notebook_path": "/Production Workflows/Test - Airflow Job",
            "source": "WORKSPACE",
            "base_parameters": {"greeting": "Submit Run operator!"}
        },
        existing_cluster_id='0710-082809-hskhlmf9'
    
    )
    
    '''
        Dependancy Flows
    '''
    opr_run_now >> opr_submit_run
