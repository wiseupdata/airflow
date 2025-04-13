FROM apache/airflow:2.10.5-python3.10
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

# Download and extract ta-lib
RUN wget https://github.com/ta-lib/ta-lib/releases/download/v0.6.4/ta-lib-0.6.4-src.tar.gz \
  && tar -xzf ta-lib-0.6.4-src.tar.gz \
  && mv ta-lib-0.6.4 ta-lib

WORKDIR "${AIRFLOW_HOME}/ta-lib"
RUN ./configure --prefix=/usr
RUN make
RUN make install

WORKDIR "${AIRFLOW_HOME}"
USER airflow

# Install importlib-metadata explicitly for compatibility
RUN pip install --upgrade pip
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" \
    llvmlite==0.44.0 \
    numba==0.61.0 \
    numpy==2.1.3 \
    setuptools==78.1.0 \
    six==1.17.0 \
    pandas==2.2.3 \
    lxml==5.3.2 \
    binance-connector==3.12.0 \
    websocket_client==1.8.0 \
    python-binance==1.0.28 \
    dateparser==1.2.1 \
    pytz==2025.2 \
    psycopg-binary==3.2.6 \
    ta-lib==0.6.3 \
    pandas-ta-openbb==0.4.21 \
    importlib-metadata==6.8.0 \
    setuptools>=42

USER airflow

# Needed ta-lib-0.6.4 ta-lib - Application
# Needed ta-lib - Python wrapper -- 0.6 works with all 0.6 app