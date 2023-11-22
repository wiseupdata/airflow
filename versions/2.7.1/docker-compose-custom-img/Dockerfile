FROM apache/airflow:2.7.1
USER root

###############################################################################
RUN echo "Updating and Ignoring diff time zone!" 
##############################################################################
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update


###############################################################################
RUN echo "Installing essencials" 
##############################################################################
RUN apt-get install -y make wget apt-transport-https ca-certificates curl file gettext git make procps sudo bash libc6 libpam-modules libnss3 procps gosu libsecret-1-dev libx11-dev libxkbfile-dev gnupg2 build-essential


###############################################################################
RUN echo "Installing TA-Lib" 
##############################################################################
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
RUN tar -xzf ta-lib-0.4.0-src.tar.gz

WORKDIR "${AIRFLOW_HOME}/ta-lib"

RUN wget -O config.guess 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess'
RUN wget -O config.sub 'http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub'
RUN chmod +x config.guess config.sub

RUN ./configure --prefix=/usr
RUN make
RUN make install


###############################################################################
RUN echo "Installing Python dependencies" 
##############################################################################
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
