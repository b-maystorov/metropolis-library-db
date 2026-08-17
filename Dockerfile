FROM postgres:16

COPY schema.sql /docker-entrypoint-initdb.d/01-schema.sql
COPY sample_data.sql /docker-entrypoint-initdb.d/02-sample_data.sql