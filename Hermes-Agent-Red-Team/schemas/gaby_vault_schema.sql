/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gaby_vault
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_models_config`
--

DROP TABLE IF EXISTS `ai_models_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_models_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` int(11) NOT NULL,
  `model_name` varchar(255) NOT NULL,
  `provider` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audi_listings`
--

DROP TABLE IF EXISTS `audi_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audi_listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(50) NOT NULL,
  `listing_id` varchar(255) NOT NULL,
  `title` text DEFAULT NULL,
  `price` varchar(100) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `url` text DEFAULT NULL,
  `seller_name` varchar(255) DEFAULT NULL,
  `seller_phone` varchar(50) DEFAULT NULL,
  `seller_wa` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `year` varchar(20) DEFAULT NULL,
  `mileage` varchar(50) DEFAULT NULL,
  `transmission` varchar(50) DEFAULT NULL,
  `fuel_type` varchar(50) DEFAULT NULL,
  `scraped_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_listing` (`platform`,`listing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audi_prospects`
--

DROP TABLE IF EXISTS `audi_prospects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audi_prospects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(50) DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `prospect_name` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `budget_min` bigint(20) DEFAULT NULL,
  `budget_max` bigint(20) DEFAULT NULL,
  `preferred_models` text DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `intent_text` text DEFAULT NULL,
  `scraped_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_phone` (`phone`),
  KEY `idx_wa` (`whatsapp`),
  KEY `idx_location` (`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audi_sellers`
--

DROP TABLE IF EXISTS `audi_sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audi_sellers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(50) DEFAULT NULL,
  `listing_id` varchar(255) DEFAULT NULL,
  `seller_name` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `whatsapp` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `total_listings` int(11) DEFAULT 1,
  `is_dealer` tinyint(1) DEFAULT 0,
  `last_seen` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_seller` (`platform`,`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer_prospects`
--

DROP TABLE IF EXISTS `buyer_prospects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer_prospects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(30) DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `buyer_name` varchar(200) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `whatsapp` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `social_handle` varchar(100) DEFAULT NULL,
  `interested_brand` varchar(100) DEFAULT NULL,
  `comment_text` text DEFAULT NULL,
  `intent_score` int(11) DEFAULT 0,
  `intent_markers` varchar(300) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `scraped_at` datetime DEFAULT NULL,
  `is_qualified` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_phone` (`phone`),
  KEY `idx_score` (`intent_score`),
  KEY `idx_qualified` (`is_qualified`)
) ENGINE=InnoDB AUTO_INCREMENT=536 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flipper_multi_tool`
--

DROP TABLE IF EXISTS `flipper_multi_tool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `flipper_multi_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(100) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_features`
--

DROP TABLE IF EXISTS `gaby_features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `feature_name` varchar(100) NOT NULL,
  `category` varchar(50) NOT NULL,
  `hardware_used` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `vs_flipper_zero` varchar(50) DEFAULT NULL,
  `vs_flipper_one` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_firmware`
--

DROP TABLE IF EXISTS `gaby_firmware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_firmware` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `firmware_name` varchar(100) NOT NULL,
  `repo_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `features` text DEFAULT NULL,
  `install_method` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_hardware`
--

DROP TABLE IF EXISTS `gaby_hardware`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_hardware` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `component` varchar(100) NOT NULL,
  `quantity` int(11) DEFAULT 1,
  `unit_price` int(11) DEFAULT 0,
  `total_price` int(11) DEFAULT 0,
  `specs` text DEFAULT NULL,
  `source` varchar(50) DEFAULT 'tokopedia',
  `status` varchar(20) DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_pin_mapping`
--

DROP TABLE IF EXISTS `gaby_pin_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_pin_mapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `esp32_gpio` varchar(20) NOT NULL,
  `target_device` varchar(50) NOT NULL,
  `target_pin` varchar(20) NOT NULL,
  `function` varchar(50) NOT NULL,
  `cable_type` varchar(20) DEFAULT 'M-F Jumper',
  `color_code` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_tools`
--

DROP TABLE IF EXISTS `gaby_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_tools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `tool_name` varchar(100) NOT NULL,
  `frequency` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `attack_type` varchar(50) DEFAULT NULL,
  `command_example` text DEFAULT NULL,
  `firmware_required` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gaby_wiring`
--

DROP TABLE IF EXISTS `gaby_wiring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gaby_wiring` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) NOT NULL,
  `section` varchar(50) NOT NULL,
  `from_device` varchar(50) NOT NULL,
  `from_pin` varchar(30) NOT NULL,
  `to_device` varchar(50) NOT NULL,
  `to_pin` varchar(30) NOT NULL,
  `cable_color` varchar(20) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hack_daily_nakal`
--

DROP TABLE IF EXISTS `hack_daily_nakal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hack_daily_nakal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `frequency` text DEFAULT NULL,
  `target` text DEFAULT NULL,
  `esp32_module` text DEFAULT NULL,
  `use_case` text DEFAULT NULL,
  `price` text DEFAULT NULL,
  `status` text DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hack_file_arsenal`
--

DROP TABLE IF EXISTS `hack_file_arsenal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hack_file_arsenal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source_type` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `local_path` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `size` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` text DEFAULT 'saved',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hack_tool_arsenal`
--

DROP TABLE IF EXISTS `hack_tool_arsenal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hack_tool_arsenal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ts` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `platform` text DEFAULT NULL,
  `features` text DEFAULT NULL,
  `deep_notes` text DEFAULT NULL COMMENT 'Full tool analysis — architecture, wiring, firmware dependencies, attack vectors, integration possibilities',
  `source_url` text DEFAULT NULL,
  `price` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hack_vuln_tracker`
--

DROP TABLE IF EXISTS `hack_vuln_tracker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hack_vuln_tracker` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cve_id` text DEFAULT NULL,
  `severity` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cvss_score` float DEFAULT NULL,
  `published_date` text DEFAULT NULL,
  `source` text DEFAULT NULL,
  `status` text DEFAULT 'new',
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hardware_integration`
--

DROP TABLE IF EXISTS `hardware_integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware_integration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component` varchar(255) DEFAULT NULL,
  `detail` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hardware_integration_manual`
--

DROP TABLE IF EXISTS `hardware_integration_manual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware_integration_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(100) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `details` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hardware_manual`
--

DROP TABLE IF EXISTS `hardware_manual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hardware_manuals`
--

DROP TABLE IF EXISTS `hardware_manuals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hardware_manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intel_market`
--

DROP TABLE IF EXISTS `intel_market`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `intel_market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ts` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `item` text DEFAULT NULL,
  `price` text DEFAULT NULL,
  `source` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intel_mission_logs`
--

DROP TABLE IF EXISTS `intel_mission_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `intel_mission_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` text DEFAULT NULL,
  `history` text DEFAULT NULL,
  `timestamp` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intel_vault`
--

DROP TABLE IF EXISTS `intel_vault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `intel_vault` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `content` text DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_hardware_bom`
--

DROP TABLE IF EXISTS `iot_hardware_bom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_hardware_bom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) DEFAULT NULL,
  `project_name` text DEFAULT NULL,
  `component` text DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price_unit` text DEFAULT NULL,
  `price_total` text DEFAULT NULL,
  `source` text DEFAULT NULL,
  `status` text DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_hardware_manuals`
--

DROP TABLE IF EXISTS `iot_hardware_manuals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_hardware_manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_integration`
--

DROP TABLE IF EXISTS `iot_integration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_integration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(50) DEFAULT NULL,
  `bus_type` varchar(20) DEFAULT NULL,
  `power_req` varchar(50) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_manual`
--

DROP TABLE IF EXISTS `iot_manual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_manual` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topic` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_manuals`
--

DROP TABLE IF EXISTS `iot_manuals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_project_files`
--

DROP TABLE IF EXISTS `iot_project_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_project_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` varchar(50) DEFAULT NULL,
  `file_name` text DEFAULT NULL,
  `file_path` text DEFAULT NULL,
  `file_size` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `status` text DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `iot_specs`
--

DROP TABLE IF EXISTS `iot_specs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `iot_specs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(255) DEFAULT NULL,
  `interface` varchar(50) DEFAULT NULL,
  `voltage` float DEFAULT NULL,
  `current_ma` float DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_books`
--

DROP TABLE IF EXISTS `manual_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manual_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manuals`
--

DROP TABLE IF EXISTS `manuals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `platform` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `steps` text DEFAULT NULL,
  `tools` text DEFAULT NULL,
  `status` text DEFAULT 'active',
  `version` varchar(10) DEFAULT 'v1.0',
  `updated_reason` text DEFAULT NULL,
  `last_verified` timestamp NULL DEFAULT NULL,
  `version_history` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_analysis`
--

DROP TABLE IF EXISTS `trading_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` text DEFAULT NULL,
  `analysis_type` text DEFAULT NULL,
  `strategies` text DEFAULT NULL,
  `top_assets` text DEFAULT NULL,
  `risk_management` text DEFAULT NULL,
  `session_timing` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_asset_analysis`
--

DROP TABLE IF EXISTS `trading_asset_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_asset_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text DEFAULT NULL,
  `ticker` text DEFAULT NULL,
  `trend_direction` text DEFAULT NULL,
  `key_levels` text DEFAULT NULL,
  `volatility` text DEFAULT NULL,
  `liquidity` text DEFAULT NULL,
  `setup` text DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_market_analysis`
--

DROP TABLE IF EXISTS `trading_market_analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_market_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` text DEFAULT NULL,
  `asset` text DEFAULT NULL,
  `timeframe` text DEFAULT NULL,
  `analysis` text DEFAULT NULL,
  `volatility_score` double DEFAULT NULL,
  `potential` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_methodologies`
--

DROP TABLE IF EXISTS `trading_methodologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_methodologies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `timeframe` text DEFAULT NULL,
  `entry_rules` text DEFAULT NULL,
  `exit_rules` text DEFAULT NULL,
  `formulas` text DEFAULT NULL,
  `risk_management` text DEFAULT NULL,
  `position_sizing` text DEFAULT NULL,
  `backtest_metrics` text DEFAULT NULL,
  `market_regime_filter` text DEFAULT NULL,
  `source_url` text DEFAULT NULL,
  `source_repo` text DEFAULT NULL,
  `win_rate` text DEFAULT NULL,
  `asset_class` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_research`
--

DROP TABLE IF EXISTS `trading_research`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_research` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `research_type` text DEFAULT NULL,
  `asset_class` text DEFAULT NULL,
  `asset_symbol` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trading_strategies`
--

DROP TABLE IF EXISTS `trading_strategies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `trading_strategies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `strategy_name` varchar(255) DEFAULT NULL,
  `source_url` varchar(500) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `key_parameters` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `timeframe` varchar(50) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `source_type` varchar(50) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_credentials`
--

DROP TABLE IF EXISTS `user_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_credentials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vauto_listings`
--

DROP TABLE IF EXISTS `vauto_listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vauto_listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `platform` varchar(30) DEFAULT NULL,
  `lid` varchar(255) NOT NULL,
  `make` varchar(30) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `price` bigint(20) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `mileage` varchar(40) DEFAULT NULL,
  `trans` varchar(20) DEFAULT NULL,
  `fuel` varchar(20) DEFAULT NULL,
  `loc` varchar(100) DEFAULT NULL,
  `seller` varchar(150) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `whatsapp` varchar(40) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `active_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq` (`platform`,`lid`),
  KEY `idx_make` (`make`),
  KEY `idx_model` (`model`),
  KEY `idx_price` (`price`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_knowledge_base`
--

DROP TABLE IF EXISTS `web_knowledge_base`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `web_knowledge_base` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=517 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `whale_movements`
--

DROP TABLE IF EXISTS `whale_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `whale_movements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT current_timestamp(),
  `alert_type` varchar(50) DEFAULT NULL,
  `severity` varchar(20) DEFAULT NULL,
  `amount_btc` decimal(20,8) DEFAULT NULL,
  `amount_usd` decimal(20,2) DEFAULT NULL,
  `amount_idr` decimal(25,2) DEFAULT NULL,
  `direction` varchar(20) DEFAULT NULL,
  `source_exchange` varchar(100) DEFAULT NULL,
  `destination_exchange` varchar(100) DEFAULT NULL,
  `wallet_type` varchar(50) DEFAULT NULL,
  `price_at_time` decimal(20,2) DEFAULT NULL,
  `btc_price_usd` decimal(20,2) DEFAULT NULL,
  `btc_price_idr` decimal(25,2) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `triggered_action` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `writing_skills`
--

DROP TABLE IF EXISTS `writing_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `writing_skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ts` timestamp NULL DEFAULT current_timestamp(),
  `topic` varchar(255) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `authors` text DEFAULT NULL,
  `journal` varchar(255) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `deep_notes` text DEFAULT NULL COMMENT 'Unlimited learning notes — full paper breakdown, implementation guide, lessons learned, anti-AI detection techniques, formal Indonesian patterns',
  `source_url` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-24 15:34:31
