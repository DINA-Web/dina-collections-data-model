## Data dictionary for schema development

This folder contains a manually created data dictionary that
describes the data elements (tables and columns) that are used/has
been used/will be used in the DINA collections data model. This data
dictionary is primarily intended to guide the development of the
database schema.

Data elements are approved for use in the model when they have a
specific version set (version_added) and they are then active until a
removed_version is set. When a version is set for a data element, all
mandatory information (according to the specification) should be set
for the element. If there is info that applies, "NA" should be used.

### Specification
The data dictionary is divided in two files, one for data columns and
one for tables.

* `version_added` - The version from which the data element is to be used.
  * Applies to: tables, columns

* `version_deprecated`– The version from which the data element is deprecated.
  * Applies to: tables, columns

* `version_removed` - The version from which the data element is no
  longer available.
  * Applies to: tables, columns

* `table_name` - The table name for this data element in the target schema.
  * Applies to: tables, columns

* `column_name` - The column name for this data element in the target table.
  * Applies to: columns
  * Optional

* `display_name` - Suggested default display name.
  * Applies to: tables, columns
  * Optional

* `description` - Description of the meaning of the data element.
  * Applies to: tables, columns

* `data_type` - Datatype of the element.
  * Applies to: columns

* `size` - The maximum field length as measured in characters and
  the number of decimal places that must be maintained in the database.
  * Applies to: columns

* `precision`  - The level to which the data element value will be
  reported (e.g. to 3 decimal places).
  * Applies to: columns

* `null_allowed` -  If fields must contain data or not. If null is
  allowed, use "Y", otherwise use "N".
  * Applies to: columns

* `default_value` - A value that is predetermined (could be NULL).
  * Applies to: columns
  * Optional

* `example_values` - Examples of values that may populate the element.
  * Applies to: columns
  * Optional

* `key` - If the element is a primary (P) or foreign key (FK).
  * Applies to: columns
  * Optional

* `referenced_system` - The referenced system for this foreign key
(could the be the current DINA system as well as an external one).
  * Applies to: columns
  * Optional without `key` value "FK"

* `referenced_schema` - The source schema for this foreign key.
  * Applies to: columns
  * Optional without `key` value "FK"

* `referenced_table`- The table in the referenced system for this
  foreign key.
  * Applies to: columns
  * Optional without `key` value "FK"

* `referenced_column` - The name of the column in the referenced
  table, for this foreign key.
  * Applies to: columns
  * Optional without `key` value "FK"

* `referenced_datatype` - The data type of the column in the referenced
  table, for this foreign key.
  * Applies to: columns
  * Optional without `key` value "FK"

* `comments` - Comments about the data element.
  * Applies to: tables, columns
  * Optional

* `term_reference` - URL reference to the DINA Collections term definition.
  * Applies to: tables, columns
  * Optional

* `date_modified` - Date when the data element was defined in present form.
  * Applies to: tables, columns
