###############################################################################
RUN echo "Run the docker image local" 
##############################################################################

cd $HOME/public/airflow/versions/2.6.1/DockerCompose

## Run the container base to debug the Dockerfile.
docker run -it --name python --rm wiseupdata/python:3.10 bash


docker run -it --name python --rm f03f29b11662 bash


## Run the container base to debug the Dockerfile.
docker run --name airflow_test -d --rm dockercompose-webserver bash run
docker exec -it airflow_test /bin/bash


## Run docker file Airlfow local
docker rm $(docker ps -a -q) -f
docker image rm  $(docker image ls -a ) -f
docker-compose -f local-airflow.yml up --build
docker-compose -f local-airflow.yml down




cd $HOME/public/airflow/versions/2.7.3/docker-compose
docker-compose -f airflow.yml up

