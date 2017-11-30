#!make

PWD=$(shell pwd)
DDL=https://raw.githubusercontent.com/DINA-Web/collections-data-model/master/src/main/resources/edu/harvard/huh/specify/datamodel/cco_poc/db/tables.sql

.PHONY: all

all: lint

lint:
	./lint_liquibase_sql.R -i $(DDL)

help-lint:
	./lint_liquibase_sql.R --help

docker-lint:
	@echo "Using Docker to execute command"
	docker build . -t dina/liquilint
	docker run -v $(PWD):/home/rstudio/lint -w /home/rstudio/lint \
		dina/liquilint Rscript \
		lint_liquibase_sql.R --input my_local_liquibase_ddl_file.sql