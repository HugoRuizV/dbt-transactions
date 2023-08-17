
### OBJECTIVE

Set up a self sustained DBT project extracting data from a csv seed
Storage into a Local Postgres 
Data viz on a local Metabase 

### DBT 
In this study, I used Seeds to spin up the CSV data. This works well for a local development, however in production and if we expect frequent changes in that data, I would rather store the csv file on the cloud in a readable format for DBT

The tests are done by using plain DBT functions for completeness and calogica/dbt_expectations package for data type check and are hosted in the transaction model schema.yml

## POSTGRES
The deployment is straight forward and uses basic functions. The main complexity was to make sure the postgres DB would be ready before DBT or Metabase starts to access it 
That's why DBT RUN commands are not written directly in the docker file but in the entry point - there is probably a more optimized way of setting this up but 'wait for it.sh' https://github.com/vishnubob/wait-for-it or depends_on service healthy were not working https://docs.docker.com/compose/startup-order/ 

## METABASE
Deployment straight forward as well, the 2 complexities being making sure Postgres would be live before Metabase and saving the Metabase data locally in '/metabase-data' external volume

### HOW TO USE:
- Clone the repo on your own machine 
Make sure the '/metabase' is directly on the root, OR change MB_DB_FILE and the volume path in the docker compose file 
- CD into the folder 'docker compose folder' 
- Run 'docker-compose up' and wait untill the containers are built and deployed
- Go to http://localhost:3000 to connect on the metabase service
- login: hugo.ruiz.verastegui@gmail.com
- password: Tocos307
- Go through the 'Ours Analytics' colelction and open 'tocos dash'

### NEXT STEPS
- Move the metabase storage from h2 to postgres
- Move the local postgres to a cloud DB

## DATA LAKEHOUSE VS. DATA MESH
Lakehouse fits better less mature companies with centralized data teams
Mesh would be a better option for more mature companies with decentralized data teams
In Tocos case I'd recommend starting with a lakehouse and upgrade to a data mesh approach when the central data team becomes a bottleneck