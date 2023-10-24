#########################################################
# Oficial Python Image based in Ubuntu
#########################################################
# Ubuntu 22.04.2 LTS
docker run -it --name python --rm wiseupdata/python:3.10 bash

maintainer="silvio liborio"


###############################################################################
echo "Initial setup and envs" 
##############################################################################
sudo su

DEBIAN_FRONTEND=noninteractive

PYTHON_VERSION="3.10"
AIRFLOW_VERSION=2.6.1
AIRFLOW_HOME=/opt/airflow

echo "Clean up unnecessary files and directories"

rm -rf /tmp/* && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/*

apt-get update && apt-get upgrade -y

apt-get install netcat -y

##############################################################################
echo "Creating and Managing the su airflow"
##############################################################################
addsu airflow --disabled-password && usermod -aG sudo airflow
echo "airflow ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/airflow


##############################################################################
echo "creating the directories"
##############################################################################
mkdir $AIRFLOW_HOME \
    && mkdir $AIRFLOW_HOME/logs \
    && mkdir $AIRFLOW_HOME/dags \
    && mkdir $AIRFLOW_HOME/plugins


##############################################################################
echo "preparing the artifacts and configures"
##############################################################################
COPY scripts/entrypoint.sh /entrypoint.sh
COPY config/constraints-3.10.txt /constraints-3.10.txt
COPY config/requirements.txt $AIRFLOW_HOME/dags/requirements.txt
sudo chown -R airflow:airflow ${AIRFLOW_HOME}

##############################################################################
echo "installing the python dependencies"
##############################################################################
su airflow

pip install -r $AIRFLOW_HOME/dags/requirements.txt


##############################################################################
echo "installing Apache Airflow"
##############################################################################
CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
pip install -i https://pypi.org/simple/ pyarrow
pip install "apache-airflow[aws,crypto,celery,jira,amazon,postgres,http,jdbc,password,redis,ssh,google,databricks]==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

export PATH="$PATH:/home/airflow/.local/bin"


# ##############################################################################
# echo "Set PATH environment variable for all users"
# ##############################################################################
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> /etc/profile


##############################################################################
echo "ensuring the correct owner of the environment"
##############################################################################
sudo su
chown -R airflow:airflow ${AIRFLOW_HOME}


##############################################################################
echo "exposing the port for the services"
##############################################################################
EXPOSE 8080 5555 8793


##############################################################################
echo "Final steps"
##############################################################################
 chmod a+x /entrypoint.sh

rm -rf /tmp/* && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/*

su airflow
cd ${AIRFLOW_HOME}
sh /entrypoint.sh
webserver
