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

RUN pip install --upgrade pip
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" \
    lxml==5.3.2 \
    binance-connector==3.12.0 \
    python-binance==1.0.28 \
    websocket_client==1.8.0 \
    ta-lib==0.6.3 \
    pandas-ta==0.3.14b \
    dateparser==1.2.1 \
    pytz==2025.2 


# Apply the fix to squeeze_pro.py
#RUN sed -i "s|from numpy import NaN as npNaN|import numpy as np|" /home/airflow/.local/lib/python3.10/site-packages/pandas_ta/momentum/squeeze_pro.py

USER airflow

# Needed ta-lib-0.6.4 ta-lib - Application
# Needed ta-lib - Python wrapper -- 0.6 works with all 0.6 o<zx