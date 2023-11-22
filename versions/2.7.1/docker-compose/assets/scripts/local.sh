###############################################################################
RUN echo "Run the docker image local" 
##############################################################################

clear && cd $HOME/public/airflow/versions/2.7.1/docker-compose

# Debug the DockerFile
## Run the container base to debug the Dockerfile.
docker run -it --name airflow-debbug -u root --rm wiseupdata/airflow:2.7.1 bash

# Prepare the env
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env

# Init the Airflow
docker compose up airflow-init

## Run docker file Airlfow local
docker-compose up

# Clean up
docker-compose down --volumes --rmi all
docker rm $(docker ps -a -q) -f
docker image rm  $(docker image ls -a ) -f
rm -Rf ./logs/*


## Go inside the running container
docker exec -it docker-compose-custom-img-airflow-webserver-1 bash

docker inspect --format='{{.Architecture}}' wiseupdata/airflow:2.7.1