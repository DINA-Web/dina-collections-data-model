# Release checklist

Things to remember when making a new release of this repository.


1.  Create a GitHub "version branch" named after the release (e.g. `0.2.3`).
    All changes should then be comitted to this branch.

2.  Update the conceptual model image files:
    * `model/dina-collections-conceptual-model.png`
    * `model/dina-collections-conceptual-model.png` (draw.io xml file)

3. Update the new terms on the dina-project.net Wiki:
    * Change "Status" from `next version` to `accepted`.
    * Add current date for "Term updated".

4. Update the deprecated terms on the dina-project.net Wiki.
    * Add information for "Removed in version".
    * Add current date for "Term updated".

5. Export accepted and deprecated terms from the dina-project.net Wiki
    and store in the following files:
    * `model/entities.csv`
    * `model/attributes.csv`
    
6. Describe the changes to the data model in `CHANGELOG.md` in a non-technical way

7. Create pull request and merge the "version branch" into master.

8. Create a release of the repository with a new version number.
