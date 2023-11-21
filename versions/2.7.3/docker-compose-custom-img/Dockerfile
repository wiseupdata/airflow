FROM apache/airflow:2.7.3
USER root
RUN apt-get update \
  && apt-get install -y \
        make wget apt-transport-https ca-certificates curl file gettext git make procps sudo bash libc6 libpam-modules libnss3 procps gosu libsecret-1-dev libx11-dev libxkbfile-dev gnupg2 build-essential \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

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
    lxml \
    numpy==1.21.4 \
    binance-connector==1.10.0 \
    websocket_client==1.2.3 \
    pandas-ta==0.3.14b0 \
    ta \
    dateparser

USER airflow