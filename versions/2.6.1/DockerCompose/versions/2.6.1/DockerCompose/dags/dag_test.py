from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator

# Define default_args dictionary to specify the default parameters of the DAG
default_args = {
    'owner': 'your_name',
    'start_date': datetime(2023, 1, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG and its parameters
dag = DAG(
    'hello_world_dag',
    default_args=default_args,
    description='A simple DAG for Hello World',
    schedule_interval=timedelta(days=1),  # Run the DAG daily
)

# Define the Python function to be executed
def hello_world():
    print("Hello, World!")

# Define the task that calls the hello_world function
hello_task = PythonOperator(
    task_id='hello_task',
    python_callable=hello_world,
    dag=dag,
)

# Set the task execution sequence
hello_task

if __name__ == "__main__":
    dag.cli()