-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: localhost    Database: dina
-- ------------------------------------------------------
-- Server version	5.7.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cataloged_unit`
--

DROP TABLE IF EXISTS `cataloged_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cataloged_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `catalog_number` varchar(50) NOT NULL COMMENT 'A unique identifier for a unit within a catalog',
  `cataloged_by_text` varchar(255) DEFAULT NULL COMMENT 'A text string describing the name of the cataloger, in any chosen format',
  `takes_place_during_event_id` bigint(20) DEFAULT NULL COMMENT 'Key to the event during which this unit was cataloged.',
  PRIMARY KEY (`id`),
  KEY `cataloged_uint_event_id_idx` (`takes_place_during_event_id`),
  CONSTRAINT `cataloged_uint_event_id` FOREIGN KEY (`takes_place_during_event_id`) REFERENCES `collecting_event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cataloged_unit`
--

LOCK TABLES `cataloged_unit` WRITE;
/*!40000 ALTER TABLE `cataloged_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `cataloged_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collected_unit`
--

DROP TABLE IF EXISTS `collected_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collected_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `collected_unit_field_number` varchar(255) DEFAULT NULL COMMENT 'An identifier assigned by the collection to this collected unit at the collecting event.',
  `is_a_result_of_collecting_event_id` bigint(20) DEFAULT NULL COMMENT 'Key to the collecting event in which this collected unit was generated.',
  PRIMARY KEY (`id`),
  KEY `collected_unit_collecting_event_id_idx` (`is_a_result_of_collecting_event_id`),
  CONSTRAINT `collected_unit_collecting_event_id` FOREIGN KEY (`is_a_result_of_collecting_event_id`) REFERENCES `collecting_event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collected_unit`
--

LOCK TABLES `collected_unit` WRITE;
/*!40000 ALTER TABLE `collected_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `collected_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collecting_event`
--

DROP TABLE IF EXISTS `collecting_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collecting_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `collector_text` varchar(255) DEFAULT NULL COMMENT 'A text describing the name(s) of the collector(s) in any chosen format. Can be persons and/or organisations or groups.',
  `collecting_event_field_number` varchar(255) DEFAULT NULL COMMENT 'An identifier assigned by the collector to this collecting event, this might be called a field number or a station number or a collector number. The identifier applies to all the material collected during that same event.',
  `event_id` bigint(20) DEFAULT NULL COMMENT 'Key to this collecting event’s event.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `collecting_event_event_id_idx` (`event_id`),
  CONSTRAINT `collecting_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collecting_event`
--

LOCK TABLES `collecting_event` WRITE;
/*!40000 ALTER TABLE `collecting_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `collecting_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `end_day` int(11) DEFAULT NULL COMMENT 'The integer day of the month on which the event started.',
  `end_month` int(11) DEFAULT NULL COMMENT 'The integer month on which the event ended.',
  `end_year` varchar(45) DEFAULT NULL COMMENT 'The integer year on which the event ended.',
  `event_date_text` varchar(255) DEFAULT NULL COMMENT 'A text describing when this event took place in any chosen format.',
  `event_date_type` varchar(45) DEFAULT NULL,
  `locality_text` text NOT NULL COMMENT 'A text string describing where an event took place, in any chosen format.',
  `start_day` int(11) DEFAULT NULL COMMENT 'The integer day of the month on which the event started.',
  `start_month` int(11) DEFAULT NULL COMMENT 'The integer month on which the event started.',
  `start_year` int(11) DEFAULT NULL COMMENT 'The integer year on which the event started.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identifiable_unit`
--

DROP TABLE IF EXISTS `identifiable_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identifiable_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `belongs_to_cataloged_unit_id` bigint(20) DEFAULT NULL COMMENT 'Key to the cataloged unit to which this identifiable unit belongs.',
  `belongs_to_physical_unit_id` bigint(20) NOT NULL COMMENT 'Key to the physical unit to which this identifiable unit belongs.',
  `identifiable_unit_text` text COMMENT 'A text describing this identifiable unit, in any chosen format. For example it’s location in relation to other identifiable units.',
  `is_represented_by_individual_group_id` bigint(20) DEFAULT NULL COMMENT 'Key to the individual group this identifiable unit is represented by.',
  `parent_identifiable_unit_id` bigint(20) DEFAULT NULL COMMENT 'Key to the identifiable unit that is a parent of this identifiable unit.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `identifiable_unit_cataloged_unit_id_idx` (`belongs_to_cataloged_unit_id`),
  KEY `identifiable_unit_indivudl_group_id_idx` (`is_represented_by_individual_group_id`),
  KEY `identifiable_unit_physical_unit_id_idx` (`belongs_to_physical_unit_id`),
  KEY `identifiable_uint_parent_identifiable_unit_id_idx` (`parent_identifiable_unit_id`),
  CONSTRAINT `identifiable_uint_parent_identifiable_unit_id` FOREIGN KEY (`parent_identifiable_unit_id`) REFERENCES `identifiable_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifiable_unit_cataloged_unit_id` FOREIGN KEY (`belongs_to_cataloged_unit_id`) REFERENCES `cataloged_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifiable_unit_indivudl_group_id` FOREIGN KEY (`is_represented_by_individual_group_id`) REFERENCES `individual_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `identifiable_unit_physical_unit_id` FOREIGN KEY (`belongs_to_physical_unit_id`) REFERENCES `physical_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identifiable_unit`
--

LOCK TABLES `identifiable_unit` WRITE;
/*!40000 ALTER TABLE `identifiable_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `identifiable_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `identification`
--

DROP TABLE IF EXISTS `identification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `observation_id` bigint(20) NOT NULL COMMENT 'Key to his identification’s observation.',
  `is_original_identification_by_collector` tinyint(1) DEFAULT NULL COMMENT 'A boolean value indicating whether the identification is the original determination made by the collector(s).',
  `sequential_number` varchar(45) DEFAULT NULL COMMENT 'An integer, starting at 1, indicating the relative position in time for the identification event. The latest event has the highest value.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `identification_observation_id_idx` (`observation_id`),
  CONSTRAINT `identification_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `observation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `identification`
--

LOCK TABLES `identification` WRITE;
/*!40000 ALTER TABLE `identification` DISABLE KEYS */;
/*!40000 ALTER TABLE `identification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_group`
--

DROP TABLE IF EXISTS `individual_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `individual_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `individual_count` int(11) DEFAULT NULL COMMENT 'An integer representing the number of individuals in this individual group.',
  `individual_group_text` text COMMENT 'A text describing this individual group, in any chosen format.',
  `individual_group_type` varchar(255) DEFAULT NULL COMMENT 'A defined type of individual group.',
  `life_history` text COMMENT 'A text description of the life history for this individual group.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_group`
--

LOCK TABLES `individual_group` WRITE;
/*!40000 ALTER TABLE `individual_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_sample`
--

DROP TABLE IF EXISTS `material_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_sample` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `is_derived_from_collected_unit_id` bigint(20) DEFAULT NULL COMMENT 'Key to the collected unit that this material was derived from.',
  `physical_unit_id` bigint(20) NOT NULL COMMENT 'Key to this material sample’s physical unit.',
  `parts_count` int(11) DEFAULT NULL COMMENT 'An integer representing the number of parts in this material sample.',
  `parts_type_name` varchar(50) DEFAULT NULL COMMENT 'A text with the name of a defined parts type for this material sample.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `material_sample_collected_unit_id_idx` (`is_derived_from_collected_unit_id`),
  KEY `matefial_sample_physical_unit_id_idx` (`physical_unit_id`),
  CONSTRAINT `matefial_sample_physical_unit_id` FOREIGN KEY (`physical_unit_id`) REFERENCES `physical_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `material_sample_collected_unit_id` FOREIGN KEY (`is_derived_from_collected_unit_id`) REFERENCES `collected_unit` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_sample`
--

LOCK TABLES `material_sample` WRITE;
/*!40000 ALTER TABLE `material_sample` DISABLE KEYS */;
/*!40000 ALTER TABLE `material_sample` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observation`
--

DROP TABLE IF EXISTS `observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `is_current` tinyint(1) DEFAULT '0' COMMENT 'A boolean indicating whether an observation is current or not.',
  `applies_to_collecting_event_id` bigint(20) DEFAULT NULL COMMENT 'Key to the collecting_event to which this observation apply.',
  `takes_place_during_event_id` bigint(20) DEFAULT NULL COMMENT 'Key to the event during which this observation was made.',
  `applies_to_individual_group_id` bigint(20) DEFAULT NULL COMMENT 'Key to the individual group to which this observation apply.',
  `is_of_observation_type_id` bigint(20) NOT NULL COMMENT 'Key to the observation_type that this observation is of.',
  `is_documented_in_transcribed_content_id` bigint(20) DEFAULT NULL COMMENT 'Key to the transcribed content in which this observation is documented.',
  `observation_text` text COMMENT 'A text string describing the observation, in any chosen format.',
  `observed_by_text` varchar(255) DEFAULT NULL COMMENT 'A text describing the agent(s) (person(s), group(s), machine(s) etc.) that made an observation, in any chosen format.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `observation_collecting_event_id_idx` (`applies_to_collecting_event_id`),
  KEY `observation_event_id_idx` (`takes_place_during_event_id`),
  KEY `observation_individual_group_id_idx` (`applies_to_individual_group_id`),
  KEY `observation_observation_type_id_idx` (`is_of_observation_type_id`),
  KEY `observation_transcribed_content_id_idx` (`is_documented_in_transcribed_content_id`),
  CONSTRAINT `observation_collecting_event_id` FOREIGN KEY (`applies_to_collecting_event_id`) REFERENCES `collecting_event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `observation_event_id` FOREIGN KEY (`takes_place_during_event_id`) REFERENCES `event` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `observation_individual_group_id` FOREIGN KEY (`applies_to_individual_group_id`) REFERENCES `individual_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `observation_observation_type_id` FOREIGN KEY (`is_of_observation_type_id`) REFERENCES `observation_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `observation_transcribed_content_id` FOREIGN KEY (`is_documented_in_transcribed_content_id`) REFERENCES `transcribed_content` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observation`
--

LOCK TABLES `observation` WRITE;
/*!40000 ALTER TABLE `observation` DISABLE KEYS */;
/*!40000 ALTER TABLE `observation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observation_type`
--

DROP TABLE IF EXISTS `observation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observation_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `applies_to_entity` varchar(255) NOT NULL COMMENT 'The name of the entity to which this observation type applies.',
  `observation_type_name` varchar(50) NOT NULL COMMENT 'A text with the name of a defined observation type.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observation_type`
--

LOCK TABLES `observation_type` WRITE;
/*!40000 ALTER TABLE `observation_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `observation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_unit`
--

DROP TABLE IF EXISTS `physical_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_unit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `physical_unit_type_name` varchar(50) NOT NULL COMMENT 'A text string with the name of a defined physical unit type.',
  `sample_preparation_history_text` text COMMENT 'A text describing the history of this physical unit, in any chosen format.',
  `preparation_type_name` varchar(50) DEFAULT NULL COMMENT 'A text describing the compound type of preparation for this physical unit including it’s descendants.',
  `prepared_by_text` varchar(255) DEFAULT NULL COMMENT 'A text describing the agent(s) (person(s), group(s), etc.) that created this preparation, in any chosen format.',
  `prepared_date` date DEFAULT NULL COMMENT 'The date when this physical unit was created.',
  `storage_location_text` text COMMENT 'A text describing the normal physical storage location, in any chosen format.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_unit`
--

LOCK TABLES `physical_unit` WRITE;
/*!40000 ALTER TABLE `physical_unit` DISABLE KEYS */;
/*!40000 ALTER TABLE `physical_unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transcribed_content`
--

DROP TABLE IF EXISTS `transcribed_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcribed_content` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL DEFAULT '1',
  `is_of_transcribed_content_type` bigint(20) NOT NULL COMMENT 'Key to the transcribed content type that this transcribed content is of.',
  `transcript_text` text NOT NULL COMMENT 'A text that has been transcribed from any kind of original source (labels, field notebooks, phone calls, emails, etc.)',
  PRIMARY KEY (`id`),
  KEY `transcribed_content_transcribed_content_type_id_idx` (`is_of_transcribed_content_type`),
  CONSTRAINT `transcribed_content_transcribed_content_type_id` FOREIGN KEY (`is_of_transcribed_content_type`) REFERENCES `transcribed_content_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transcribed_content`
--

LOCK TABLES `transcribed_content` WRITE;
/*!40000 ALTER TABLE `transcribed_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `transcribed_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transcribed_content_type`
--

DROP TABLE IF EXISTS `transcribed_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transcribed_content_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Auto-incrementing surrogate primary key.',
  `transcribed_content_type_name` varchar(45) DEFAULT NULL COMMENT 'A text with the name of a defined transcribed content type.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transcribed_content_type`
--

LOCK TABLES `transcribed_content_type` WRITE;
/*!40000 ALTER TABLE `transcribed_content_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `transcribed_content_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-18  9:14:55
