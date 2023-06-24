#########################################################
# Oficial Python Image based in Ubuntu
#########################################################
# Ubuntu 22.04.2 LTS
FROM wiseupdata/python:3.10

LABEL maintainer="silvio liborio"


###############################################################################
RUN echo "Initial setup and envs" 
##############################################################################
USER root

ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

ENV PYTHON_VERSION="3.10"
ENV AIRFLOW_VERSION=2.6.1
ARG AIRFLOW_HOME=/opt/airflow

RUN echo "Clean up unnecessary files and directories"

RUN rm -rf /tmp/* && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/*

RUN apt-get update && apt-get upgrade -y

RUN apt-get install netcat -y

##############################################################################
RUN echo "Creating and Managing the user Airflow"
##############################################################################
RUN adduser airflow --disabled-password && usermod -aG sudo airflow
RUN echo "airflow ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/airflow


##############################################################################
RUN echo "creating the directories"
##############################################################################
RUN mkdir $AIRFLOW_HOME \
    && mkdir $AIRFLOW_HOME/logs \
    && mkdir $AIRFLOW_HOME/dags \
    && mkdir $AIRFLOW_HOME/plugins


##############################################################################
RUN echo "preparing the artifacts and configures"
##############################################################################
COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/constraints-3.10.txt /constraints-3.10.txt
COPY config/requirements.txt $AIRFLOW_HOME/dags/requirements.txt

##############################################################################
RUN echo "installing the python dependencies"
##############################################################################
USER airflow

RUN pip install -r $AIRFLOW_HOME/dags/requirements.txt


##############################################################################
RUN echo "installing Apache Airflow"
##############################################################################
ARG CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
RUN pip install "apache-airflow[aws,crypto,celery,jira,amazon,postgres,http,jdbc,password,redis,ssh,google,databricks]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"


##############################################################################
RUN echo "Set PATH environment variable for all users"
##############################################################################
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /etc/profile


##############################################################################
RUN echo "ensuring the correct owner of the environment"
##############################################################################
USER root
RUN chown -R airflow: ${AIRFLOW_HOME}


##############################################################################
RUN echo "exposing the port for run the services"
##############################################################################
EXPOSE 8080 5555 8793


##############################################################################
RUN echo "Final steps"
##############################################################################
RUN  chmod a+x /entrypoint.sh

RUN rm -rf /tmp/* && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/*

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
CMD ["webserver"]
