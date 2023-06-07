# CTE vs Subqueries: Who gives a 🦆uck

See blog post: https://home.gerardbentley.com/blog/cte-subquery-who-gives-a-duck/ 

Or blog source for follow along: https://github.com/gerardrbentley/lost_crumbs/blob/main/docs/blog/cte-subquery-who-gives-a-duck.md

## Setup Commands

```sh
# spin up postgres in background
docker-compose up --build -d
# run postgres database init and data generation
docker-compose exec database psql --username demo_user --dbname demo -f /tmp/pg/init_db.sql

# MISC
# wipe postgres container
docker-compose down --volumes --remove-orphans
# follow logs
docker-compose logs -f
# rebuild duck image
docker-compose build duck-database

# bash in postgres container
docker-compose exec database bash
# bash in duckdb container
docker-compose run duck-database -i
```

## Query Commands

```sh
docker-compose exec database psql --username demo_user --dbname demo -f /tmp/pg/subquery.sql
docker-compose exec database psql --username demo_user --dbname demo -f /tmp/pg/cte.sql

docker-compose run --build duck-database entrypoint.sh duckdb -c ".read pg/subquery.sql"
docker-compose run --build duck-database entrypoint.sh duckdb -c ".read pg/cte.sql"

docker-compose run --build duck-database entrypoint.sh duckdb duck/students.db -c ".read pg/init_db_scan_cache.sql"
docker-compose run --build duck-database entrypoint.sh duckdb duck/students.db -c ".read pg/cte_cached.sql"
docker-compose run --build duck-database entrypoint.sh duckdb duck/students.db -c ".read pg/subquery_cached.sql"

# psql cli in postgres container
docker-compose exec database psql --username demo_user --dbname demo

# duckdb cli in duckdb container
docker-compose run --build duck-database entrypoint.sh duckdb duck/students.db
```

## YugabyteDB (Open Source PostgreSQL-compatible Distributed SQL database)

With the `yb-database` service started in the docker compose:

- schema creation:
```
docker-compose exec yb-database psql -e --username demo_user --dbname demo -f /tmp/pg/init_db.sql
```

Run the 3 queries:
```
for i in cte subquery window 
do 
docker-compose exec yb-database psql -e --username demo_user --dbname demo -f /tmp/pg/$i.sql 
done
```
