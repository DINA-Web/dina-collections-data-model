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