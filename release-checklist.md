# Release checklist

Things to remember when making a new release of this repository.


## Before sprint planning meeting

1.  Create a GitHub "version branch" named after the release (e.g. `0.2.3`).
    All changes should then be comitted to this branch.

2.  Update the conceptual model image files:
    * `model/dina-collections-conceptual-model.png`
    * `model/dina-collections-conceptual-model.png` (draw.io xml file)

3.  Export preliminary terms from the dina-project.net Wiki to the
    following files:

    * `model/suggested_tables.csv`
    * `model/suggested_attributes.csv`


## After sprint planning meeting

4.  Add new tables to the data dictionary:
    * `dictionary/collections-dictionary-tables.csv`

5.  Add new columns to the data dictionary:
    * `dictionary/collections-dictionary-tables.csv`

6.  Implement proposed changes in the schema by creating Liquibase
    changesets.

7.  Make sure that that the schema complies with proposed changes.
    This can be done manually or preferably with the Python script
    `validate_schema.py`in the directory `tools/validate_schema/`.


## After beta release of the collection manager

8. Describe the changes to the data model in `CHANGELOG.md`.

9. Update the new terms on the dina-project.net Wiki:
    * Change "Status" from `next version` to `accepted`.

10. Update the deprecated terms on the dina-project.net Wiki.
    * Add information for "Removed in version".

11. Export accepted and deprecated terms from the dina-project.net Wiki
    and store in the following files:
    * `model/entities.csv`
    * `model/attributes.csv`

12. Create pull request and merge the "version branch" into master.

13. Create a release of the repository with the same version number as
    the latest (beta) release of the collection manager.
