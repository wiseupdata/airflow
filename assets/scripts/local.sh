###############################################################################
RUN echo "Run the docker image local" 
##############################################################################

## Run the container base to debug the Dockerfile.
docker run -it --name python --rm wiseupdata/python:3.10 bash