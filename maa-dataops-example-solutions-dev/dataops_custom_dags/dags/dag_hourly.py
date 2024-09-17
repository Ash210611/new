import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.operators.python_operator import PythonOperator

# Using filename as the DAG_ID
DAG_ID = os.path.basename(__file__).replace(".py", "")

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2018, 1, 1),
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
    "retry_delay": timedelta(minutes=5),
}


def sample_print_statement():
    print("Hello World!")


with DAG(
    dag_id=DAG_ID,
    max_active_runs=100,
    schedule_interval="0 * * * * ",  # Run Hourly
    default_args=default_args,
    catchup=False,
) as dag:
    print_sample_statement = PythonOperator(
        task_id="test_print", python_callable=sample_print_statement, dag=dag
    )

    print_sample_statement
