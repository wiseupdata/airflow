# Prepare the env
cd $HOME/public/airflow/versions/2.7.3/docker-compose-custom-img/

mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env

# Init the Airflow
docker compose up airflow-init --build

# Run the Airflow
docker compose up

# Clean up
docker compose down --volumes --rmi all
docker rm $(docker ps -a -q) -f
docker image rm  $(docker image ls -a ) -f