FROM apache/airflow:2.10.5
USER root
RUN apt-get update \
  && apt-get install -y \
        make wget apt-transport-https ca-certificates curl file gettext git make procps sudo bash libc6 libpam-modules libnss3 procps gosu libsecret-1-dev libx11-dev libxkbfile-dev gnupg2 build-essential \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

##############################################################################
RUN echo "Creating and Managing the user Airflow"
##############################################################################
RUN echo "airflow ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/airflow


RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz

WORKDIR "${AIRFLOW_HOME}/ta-lib"
RUN ./configure --prefix=/usr
RUN make
RUN make install

WORKDIR "${AIRFLOW_HOME}"
USER airflow

RUN pip install --upgrade pip
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" \
    lxml==5.3.2 \
    numpy==2.2.4 \
    binance-connector==3.12.0 \
    websocket_client==1.8.0 \
    pandas-ta==0.3.14b0 \
    ta==0.11.0 \
    dateparser==1.2.1

USER airflow