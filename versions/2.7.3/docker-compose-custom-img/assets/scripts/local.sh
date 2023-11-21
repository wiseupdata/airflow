###############################################################################
RUN echo "Run the docker image local" 
##############################################################################

clear && cd $HOME/public/airflow/versions/2.7.3/docker-compose-custom-img

# Debug the DockerFile
## Run the container base to debug the Dockerfile.
docker run -it --name airflow-debbug -u root --rm apache/airflow:2.7.3 bash

# Prepare the env
mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env

# Init the Airflow
docker compose up airflow-init --build

## Run docker file Airlfow local
docker-compose up

# Clean up
docker-compose down --volumes --rmi all
docker rm $(docker ps -a -q) -f
docker image rm  $(docker image ls -a ) -f
rm -Rf ./logs/*


## Go inside the running container
docker exec -it docker-compose-custom-img-airflow-webserver-1 bash