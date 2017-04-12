## Data dictionary for schema development

This folder contains a manually created data dictionary that describes the data elements (tables and columns) that are used/has been used/will be used in the DINA collections data model. This data dictionary is primarily intended to guide the development of the database schema.

Data elements are approved for use in the model when they have a specific version set (not "suggestion next" or "future") and they are then active until a removed_version is set. When a version is set for a data element, all mandatory information (according to the specification) should be set for the element.

### Specification
The data dictionary is divided in two files, one for data columns and one for tables.

* `version` - The version from which the data element is used. If no version is decided, use "future". If the element is a suggestion for the next upciming version, use "next".
  * Applies to: tables, columns

* `removed_version` - The version from which the data element is no longer used.
    * Applies to: tables, columns

* `table_name` - The table name for this data element in the target schema.
  * Applies to: tables, columns

* `column_name` - The column name for this data element in the target table.
  * Applies to: tables, columns
  * Optional

* `display_name` - Suggested default display name. Not mandatory.
  * Applies to: tables, columns
  * Optional

* `description` - Description of the meaning of the data element.
  * Applies to: tables, columns

* `datatype` - Datatype of the element.
  * Applies to: columns

* `size` - The maximum field length as measured in characters and the number of
decimal places that must be maintained in the database.
  * Applies to: columns

* `precision`  - The level to which the data element value will be reported (e.g.
to 3 decimal places).
  * Applies to: columns

* `null_allowed` -  If fields must contain data or not. If null is allowed, use "Y", otherwise use "N".
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

* `source_system` -
  * Applies to: columns
  * Optional without `key` value "FK"

* `source_schema`
  * Applies to: columns
  * Optional without `key` value "FK"

* `source_table`
  * Applies to: columns
  * Optional without `key` value "FK"

* `source_field_name`
  * Applies to: columns
  * Optional without `key` value "FK"

* `source_datatype`
  * Applies to: columns
  * Optional without `key` value "FK"

* `comments` - Comments about the data element.
  * Applies to: tables, columns
  * Optional

* `history_references` - References to superseded data elements, etc.
  * Applies to: tables, columns
  * Optional

* `date_modified` - Date when the data element was defined in present form.
  * Applies to: tables, columns
