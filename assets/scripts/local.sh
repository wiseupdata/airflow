###############################################################################
RUN echo "Run the docker image local" 
##############################################################################

## Run the container base to debug the Dockerfile.
docker run -it --name python --rm wiseupdata/python:3.10 bash


## Run the container base to debug the Dockerfile.
docker run --name airflow_test -d --rm dockercompose-webserver bash run
docker exec -it airflow_test /bin/bash