# very simple installation of dbt core and dbt Postgres
# we don't do 'DBT RUN' while the container is being built because we need to wait for the Postgres DB to be live 

FROM python:3.10-slim-buster

workdir /usr

COPY . .

RUN pip install --upgrade pip
RUN pip install dbt-core dbt-postgres

# run the dependencies
RUN dbt deps
