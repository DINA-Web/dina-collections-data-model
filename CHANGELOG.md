# Changelog


## 0.2.0 ##

This is the initial release of the data model for DINA-Web.
The model comprises 7 entities, 10 attributes and 7 relations (see below).


### New entities

* CatalogedUnit.0
* FeatureObservation.0
* FeatureObservationType.0
* Identification.0
* IndividualGroup.0
* Occurrence.0
* PhysicalUnit.0


### New attributes

* CatalogedUnit.CatalogNumber.0
* FeatureObservation.FeatureObservationText.0
* FeatureObservationType.FeatureObservationTypeName.0
* Identification.IdentificationText.0
* IndividualGroup.IndividualGroupText.0
* Occurrence.CollectorsText.0
* Occurrence.LocalityText.0
* Occurrence.OccurrenceDateText.0
* PhysicalUnit.PhysicalUnitText.0
* PhysicalUnit.NormalStorageLocation.0


### New relations


#### CatalogedUnit <-> PhysicalUnit

* One and only One CatalogedUnit *groups* One to Many PhysicalUnit.
* One to Many PhysicalUnit *belongs to* One and only One CatalogedUnit.


#### FeatureObservation <-> FeatureObservationType

* One to Many FeatureObservation *is of* FeatureObservationType.
* One and only One FeatureObservationType *classifies* One to Many FeatureObservation.


#### FeatureObservation <-> IndividualGroup

* Zero to Many FeatureObservation *applies to* One and only One IndividualGroup.
* One and only One IndividualGroup *has* Zero to Many FeatureObservation.


#### Identification <-> IndividualGroup

* Zero to Many Identification *applies to* One and only One IndividualGroup.
* One and only One IndividualGroup *has* Zero to Many Identification.


#### IndividualGroup <-> Occurrence

* One and only One IndividualGroup *participates in* Zero to Many Occurrence.
* Zero to Many Occurrence *involves* One and only One IndividualGroup.


#### IndividualGroup <-> PhysicalUnit

* Zero to One IndividualGroup *is represented by* Zero to Many PhysicalUnit.
* Zero to Many PhysicalUnit *represents* Zero to One IndividualGroup.


#### Occurrence <-> PhysicalUnit

* Zero to One Occurrence *is origin for* Zero to Many PhysicalUnit.
* Zero to Many PhysicalUnit *is collected at* Zero to One Occurrence.


Released: 2017-11-30
