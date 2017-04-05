# liquilint

This directory contains a tool for simple linting of liquibase DDL expressed in SQL from the command line. 

Right now the tool is embryonic, so it does not support all rules suggested in the guidelines, it just checks for reserved words, expecting to be given input in [liquibase sql format](http://www.liquibase.org/documentation/sql_format.html), for example like using a text format that looks like this for each table and its fields:

    --liquibase formatted sql
    
    --changeset nvoxland:1
    create table test1 (
        id int primary key,
        name varchar(255)
    );
    
In the example above the liniting would report one of the fields to clash with the list of reserved words.

## Usage

The `Makefile` shows some ways to use `lint_liquibase_sql.R` from the commandline:

		# example invocation using the default DDL (url at top of Makefile, can be edited)
		make
		
		# example using other DDL (from external public url)
		make lint DDL=https://raw.githubusercontent.com/chicoreus/cco_poc/master/src/main/resources/edu/harvard/huh/specify/datamodel/cco_full/db/tables.sql

		# example invocation using Docker (see details in Makefile)
		make docker-lint

		# example invocation using local file
		make lint DDL=my_local_liquibase_ddl_file.sql

This means the DDL / schema can be expressed in liquiqbase sql, say named to my\_local\_liquibasei\_ddl\_file.sql with content such as in the example below, with DDL describing a couple of example tables:

    CREATE TABLE biologicalindividual (
      -- Definition: An individual organism that is specifically known and identified and known as that individual to have been observed or sampled.
      biologicalindividual_id bigint not null primary key auto_increment, -- surrogate numeric primary key
      biologicalindividual_guid varchar(900), -- guid for the biological individual darwinsw:{term}
      name varchar(900), -- human readable identifier for the biological individual
      modified_by_agent_id bigint not null default 1, -- agent to last modify row in this table
      remarks text
    )

    CREATE TABLE catalogeditem (
      -- Definition: the application of a catalog number out of some catalog number series.
      catalogeditem_id bigint not null primary key auto_increment, -- surrogate numeric primary key
      catalognumberseries_id bigint not null, -- The catalog number series from which the catalog_number comes.
      catalog_number varchar(255) not null,
      date_cataloged_eventdate_id bigint,
      cataloger_agent_id bigint,  -- The agent who cataloged the cataloged item
      accession_id bigint not null,  -- The accession in which ownership of this cataloged item was taken
      collection_id bigint not null,  -- The collection within which this item is cataloged (catalog number series doesn't uniquely idenitify collections).
      modified_by_agent_id bigint not null default 1 -- agent to last modify row in this table
    )

The tool can then lint this content. Since two regexpes are used in the tool to extract table names (`"create table (\\w+) [(]"`) and field names (`"\\s+ (\\w+) (\\w+).*"`) it can be expressed even shorter in a text file as long as tables can be extracted using those patterns.

## Report

The simple linting tool reports if any tables or columns/fields have names that conflict with the list of reserved words from [Drupal's list of SQL reserved words](https://www.drupal.org/docs/develop/coding-standards/list-of-sql-reserved-words).

As an example, a report can look like this when running `make lint DDL=my_local_liquibase_ddl_file.sql:

    Inappropriate fields/columns:
    	name

When using a bigger more full fledged model as input, the result can look like this:

    Inappropriate tables:
    	storage
    Inappropriate fields/columns:
    	name
    	table_name
    	value
    	status
    	method
    	source
    	number
    	section
    	role
    	prefix
    	type
    	text
    	foreign
    	language
    	scope
    	action

