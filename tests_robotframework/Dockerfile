FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# PREREQUISITE
RUN apt-get update
RUN apt-get -y install build-essential checkinstall libssl-dev libsqlite3-dev libncurses5-dev libreadline-dev libcurl4-openssl-dev python-dev
RUN apt-get -y install libpcap-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev tk-dev libdb4o-cil-dev
RUN apt-get -y install wget curl

# PYTHON 3.8.5

WORKDIR /opt

RUN wget https://www.python.org/ftp/python/3.8.5/Python-3.8.5.tgz
RUN tar xzf Python-3.8.5.tgz

WORKDIR /opt/Python-3.8.5
RUN ./configure --enable-optimizations
RUN make altinstall


# Update Python environment

RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.8 5
RUN update-alternatives --set python /usr/local/bin/python3.8


# PIP install

RUN apt-get -y install python3.8-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py --force-reinstall

ADD . /robotframework-tests

WORKDIR /robotframework-tests

RUN pip install -r requirements.txt

RUN chmod +x wait-for-it.sh


ENTRYPOINT [ "robot", "-v TEST_URL:https://10.51.3.177 -v TENANT_USERNAME:admin@cust001.com -v TENANT_PASSWORD:aerohive -v BROWSER:firefox" ]

