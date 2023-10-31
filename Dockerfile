
FROM apache/airflow:latest-python3.10

WORKDIR ${AIRFLOW_HOME}

COPY plugins/ plugins/
COPY requirements.txt .

RUN pip3 install -r requirements.txt