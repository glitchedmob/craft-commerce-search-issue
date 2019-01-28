-- MySQL dump 10.13  Distrib 5.7.24, for osx10.14 (x86_64)
--
-- Host: localhost    Database: commercesearchissue
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_addresses`
--

DROP TABLE IF EXISTS `commerce_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countryId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `isStoreLocation` tinyint(1) NOT NULL DEFAULT '0',
  `attention` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `alternativePhone` varchar(255) DEFAULT NULL,
  `businessName` varchar(255) DEFAULT NULL,
  `businessTaxId` varchar(255) DEFAULT NULL,
  `businessId` varchar(255) DEFAULT NULL,
  `stateName` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_addresses_countryId_idx` (`countryId`),
  KEY `commerce_addresses_stateId_idx` (`stateId`),
  CONSTRAINT `commerce_addresses_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_addresses_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_countries`
--

DROP TABLE IF EXISTS `commerce_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `iso` varchar(2) NOT NULL,
  `isStateRequired` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_countries_name_unq_idx` (`name`),
  UNIQUE KEY `commerce_countries_iso_unq_idx` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=250 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customer_discountuses`
--

DROP TABLE IF EXISTS `commerce_customer_discountuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customer_discountuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `uses` int(11) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_customer_discountuses_customerId_discountId_unq_idx` (`customerId`,`discountId`),
  KEY `commerce_customer_discountuses_discountId_idx` (`discountId`),
  CONSTRAINT `commerce_customer_discountuses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_customer_discountuses_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customers`
--

DROP TABLE IF EXISTS `commerce_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `primaryBillingAddressId` int(11) DEFAULT NULL,
  `primaryShippingAddressId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_customers_userId_idx` (`userId`),
  KEY `commerce_customers_primaryBillingAddressId_idx` (`primaryBillingAddressId`),
  KEY `commerce_customers_primaryShippingAddressId_idx` (`primaryShippingAddressId`),
  CONSTRAINT `commerce_customers_primaryBillingAddressId_fk` FOREIGN KEY (`primaryBillingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_customers_primaryShippingAddressId_fk` FOREIGN KEY (`primaryShippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_customers_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_customers_addresses`
--

DROP TABLE IF EXISTS `commerce_customers_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_customers_addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `addressId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_customers_addresses_customerId_addressId_unq_idx` (`customerId`,`addressId`),
  KEY `commerce_customers_addresses_addressId_fk` (`addressId`),
  CONSTRAINT `commerce_customers_addresses_addressId_fk` FOREIGN KEY (`addressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_customers_addresses_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_categories`
--

DROP TABLE IF EXISTS `commerce_discount_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_discount_categories_discountId_categoryId_unq_idx` (`discountId`,`categoryId`),
  KEY `commerce_discount_categories_categoryId_idx` (`categoryId`),
  CONSTRAINT `commerce_discount_categories_categoryId_fk` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_discount_categories_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_purchasables`
--

DROP TABLE IF EXISTS `commerce_discount_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_purchasables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(11) NOT NULL,
  `purchasableId` int(11) NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_discount_purchasables_discountId_purchasableId_unq_idx` (`discountId`,`purchasableId`),
  KEY `commerce_discount_purchasables_purchasableId_idx` (`purchasableId`),
  CONSTRAINT `commerce_discount_purchasables_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_discount_purchasables_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discount_usergroups`
--

DROP TABLE IF EXISTS `commerce_discount_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discount_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(11) NOT NULL,
  `userGroupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_discount_usergroups_discountId_userGroupId_unq_idx` (`discountId`,`userGroupId`),
  KEY `commerce_discount_usergroups_userGroupId_idx` (`userGroupId`),
  CONSTRAINT `commerce_discount_usergroups_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_discount_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_discounts`
--

DROP TABLE IF EXISTS `commerce_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `code` varchar(255) DEFAULT NULL,
  `perUserLimit` int(11) unsigned NOT NULL DEFAULT '0',
  `perEmailLimit` int(11) unsigned NOT NULL DEFAULT '0',
  `totalUseLimit` int(11) unsigned NOT NULL DEFAULT '0',
  `totalUses` int(11) unsigned NOT NULL DEFAULT '0',
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `purchaseTotal` int(11) NOT NULL DEFAULT '0',
  `purchaseQty` int(11) NOT NULL DEFAULT '0',
  `maxPurchaseQty` int(11) NOT NULL DEFAULT '0',
  `baseDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentDiscount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageOffSubject` enum('original','discounted') NOT NULL,
  `excludeOnSale` tinyint(1) DEFAULT NULL,
  `freeShipping` tinyint(1) DEFAULT NULL,
  `allGroups` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_discounts_code_unq_idx` (`code`),
  KEY `commerce_discounts_dateFrom_idx` (`dateFrom`),
  KEY `commerce_discounts_dateTo_idx` (`dateTo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_email_discountuses`
--

DROP TABLE IF EXISTS `commerce_email_discountuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_email_discountuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `discountId` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `uses` int(11) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_email_discountuses_email_discountId_unq_idx` (`email`,`discountId`),
  KEY `commerce_email_discountuses_discountId_idx` (`discountId`),
  CONSTRAINT `commerce_email_discountuses_discountId_fk` FOREIGN KEY (`discountId`) REFERENCES `commerce_discounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_emails`
--

DROP TABLE IF EXISTS `commerce_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `recipientType` enum('customer','custom') DEFAULT 'custom',
  `to` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `attachPdf` tinyint(1) DEFAULT NULL,
  `templatePath` varchar(255) NOT NULL,
  `pdfTemplatePath` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_gateways`
--

DROP TABLE IF EXISTS `commerce_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_gateways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `settings` text,
  `paymentType` enum('authorize','purchase') NOT NULL DEFAULT 'purchase',
  `isFrontendEnabled` tinyint(1) DEFAULT NULL,
  `sendCartInfo` tinyint(1) DEFAULT NULL,
  `isArchived` tinyint(1) DEFAULT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_gateways_handle_idx` (`handle`),
  KEY `commerce_gateways_isArchived_idx` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_lineitems`
--

DROP TABLE IF EXISTS `commerce_lineitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_lineitems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `purchasableId` int(11) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `options` text,
  `optionsSignature` varchar(255) NOT NULL,
  `price` decimal(14,4) unsigned NOT NULL,
  `saleAmount` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `salePrice` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weight` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `height` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `length` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `width` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `subtotal` decimal(14,4) unsigned NOT NULL DEFAULT '0.0000',
  `total` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `qty` int(11) unsigned NOT NULL,
  `note` text,
  `snapshot` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_lineitems_orderId_purchasableId_optionsSignature_unq_id` (`orderId`,`purchasableId`,`optionsSignature`),
  KEY `commerce_lineitems_purchasableId_idx` (`purchasableId`),
  KEY `commerce_lineitems_taxCategoryId_idx` (`taxCategoryId`),
  KEY `commerce_lineitems_shippingCategoryId_idx` (`shippingCategoryId`),
  CONSTRAINT `commerce_lineitems_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_lineitems_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `elements` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `commerce_lineitems_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `commerce_lineitems_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderadjustments`
--

DROP TABLE IF EXISTS `commerce_orderadjustments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderadjustments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `lineItemId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `amount` decimal(14,4) NOT NULL,
  `included` tinyint(1) DEFAULT NULL,
  `sourceSnapshot` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_orderadjustments_orderId_idx` (`orderId`),
  CONSTRAINT `commerce_orderadjustments_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderhistories`
--

DROP TABLE IF EXISTS `commerce_orderhistories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderhistories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `customerId` int(11) NOT NULL,
  `prevStatusId` int(11) DEFAULT NULL,
  `newStatusId` int(11) DEFAULT NULL,
  `message` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_orderhistories_orderId_idx` (`orderId`),
  KEY `commerce_orderhistories_prevStatusId_idx` (`prevStatusId`),
  KEY `commerce_orderhistories_newStatusId_idx` (`newStatusId`),
  KEY `commerce_orderhistories_customerId_idx` (`customerId`),
  CONSTRAINT `commerce_orderhistories_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_orderhistories_newStatusId_fk` FOREIGN KEY (`newStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `commerce_orderhistories_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_orderhistories_prevStatusId_fk` FOREIGN KEY (`prevStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orders`
--

DROP TABLE IF EXISTS `commerce_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orders` (
  `id` int(11) NOT NULL,
  `billingAddressId` int(11) DEFAULT NULL,
  `shippingAddressId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `paymentSourceId` int(11) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `orderStatusId` int(11) DEFAULT NULL,
  `number` varchar(32) DEFAULT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `couponCode` varchar(255) DEFAULT NULL,
  `itemTotal` decimal(14,4) DEFAULT '0.0000',
  `totalPrice` decimal(14,4) DEFAULT '0.0000',
  `totalPaid` decimal(14,4) DEFAULT '0.0000',
  `paidStatus` enum('paid','partial','unpaid') DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `isCompleted` tinyint(1) DEFAULT NULL,
  `dateOrdered` datetime DEFAULT NULL,
  `datePaid` datetime DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `lastIp` varchar(255) DEFAULT NULL,
  `orderLanguage` varchar(12) NOT NULL,
  `message` text,
  `returnUrl` varchar(255) DEFAULT NULL,
  `cancelUrl` varchar(255) DEFAULT NULL,
  `shippingMethodHandle` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_orders_number_unq_idx` (`number`),
  KEY `commerce_orders_reference_idx` (`reference`),
  KEY `commerce_orders_billingAddressId_idx` (`billingAddressId`),
  KEY `commerce_orders_shippingAddressId_idx` (`shippingAddressId`),
  KEY `commerce_orders_gatewayId_idx` (`gatewayId`),
  KEY `commerce_orders_customerId_idx` (`customerId`),
  KEY `commerce_orders_orderStatusId_idx` (`orderStatusId`),
  KEY `commerce_orders_paymentSourceId_fk` (`paymentSourceId`),
  CONSTRAINT `commerce_orders_billingAddressId_fk` FOREIGN KEY (`billingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_orders_customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `commerce_customers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_orders_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_orders_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_orders_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `commerce_orders_paymentSourceId_fk` FOREIGN KEY (`paymentSourceId`) REFERENCES `commerce_paymentsources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_orders_shippingAddressId_fk` FOREIGN KEY (`shippingAddressId`) REFERENCES `commerce_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderstatus_emails`
--

DROP TABLE IF EXISTS `commerce_orderstatus_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderstatus_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderStatusId` int(11) NOT NULL,
  `emailId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_orderstatus_emails_orderStatusId_idx` (`orderStatusId`),
  KEY `commerce_orderstatus_emails_emailId_idx` (`emailId`),
  CONSTRAINT `commerce_orderstatus_emails_emailId_fk` FOREIGN KEY (`emailId`) REFERENCES `commerce_emails` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_orderstatus_emails_orderStatusId_fk` FOREIGN KEY (`orderStatusId`) REFERENCES `commerce_orderstatuses` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_orderstatuses`
--

DROP TABLE IF EXISTS `commerce_orderstatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_orderstatuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `color` enum('green','orange','red','blue','yellow','pink','purple','turquoise','light','grey','black') NOT NULL DEFAULT 'green',
  `isArchived` tinyint(1) NOT NULL DEFAULT '0',
  `dateArchived` datetime DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_orderstatuses_isArchived_idx` (`isArchived`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_paymentcurrencies`
--

DROP TABLE IF EXISTS `commerce_paymentcurrencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_paymentcurrencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` varchar(3) NOT NULL,
  `primary` tinyint(1) NOT NULL DEFAULT '0',
  `rate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_paymentcurrencies_iso_unq_idx` (`iso`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_paymentsources`
--

DROP TABLE IF EXISTS `commerce_paymentsources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_paymentsources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `gatewayId` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_paymentsources_gatewayId_fk` (`gatewayId`),
  KEY `commerce_paymentsources_userId_fk` (`userId`),
  CONSTRAINT `commerce_paymentsources_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_paymentsources_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_plans`
--

DROP TABLE IF EXISTS `commerce_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gatewayId` int(11) DEFAULT NULL,
  `planInformationId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `reference` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `planData` text,
  `isArchived` tinyint(1) NOT NULL,
  `dateArchived` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_plans_handle_unq_idx` (`handle`),
  KEY `commerce_plans_gatewayId_idx` (`gatewayId`),
  KEY `commerce_plans_reference_idx` (`reference`),
  KEY `commerce_plans_planInformationId_fk` (`planInformationId`),
  CONSTRAINT `commerce_plans_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_plans_planInformationId_fk` FOREIGN KEY (`planInformationId`) REFERENCES `elements` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_products`
--

DROP TABLE IF EXISTS `commerce_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_products` (
  `id` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `defaultVariantId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `promotable` tinyint(1) DEFAULT NULL,
  `availableForPurchase` tinyint(1) DEFAULT NULL,
  `freeShipping` tinyint(1) DEFAULT NULL,
  `defaultSku` varchar(255) DEFAULT NULL,
  `defaultPrice` decimal(14,4) DEFAULT NULL,
  `defaultHeight` decimal(14,4) DEFAULT NULL,
  `defaultLength` decimal(14,4) DEFAULT NULL,
  `defaultWidth` decimal(14,4) DEFAULT NULL,
  `defaultWeight` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_products_typeId_idx` (`typeId`),
  KEY `commerce_products_postDate_idx` (`postDate`),
  KEY `commerce_products_expiryDate_idx` (`expiryDate`),
  KEY `commerce_products_taxCategoryId_idx` (`taxCategoryId`),
  KEY `commerce_products_shippingCategoryId_idx` (`shippingCategoryId`),
  CONSTRAINT `commerce_products_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_products_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`),
  CONSTRAINT `commerce_products_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`),
  CONSTRAINT `commerce_products_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes`
--

DROP TABLE IF EXISTS `commerce_producttypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `variantFieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasDimensions` tinyint(1) DEFAULT NULL,
  `hasVariants` tinyint(1) DEFAULT NULL,
  `hasVariantTitleField` tinyint(1) DEFAULT NULL,
  `titleFormat` varchar(255) NOT NULL,
  `skuFormat` varchar(255) DEFAULT NULL,
  `descriptionFormat` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_producttypes_handle_unq_idx` (`handle`),
  KEY `commerce_producttypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `commerce_producttypes_variantFieldLayoutId_idx` (`variantFieldLayoutId`),
  CONSTRAINT `commerce_producttypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_producttypes_variantFieldLayoutId_fk` FOREIGN KEY (`variantFieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_shippingcategories`
--

DROP TABLE IF EXISTS `commerce_producttypes_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_shippingcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `shippingCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commer_productty_shippingcatego_productTyp_shippingCatego_un_id` (`productTypeId`,`shippingCategoryId`),
  KEY `commerce_producttypes_shippingcategories_shippingCategoryId_idx` (`shippingCategoryId`),
  CONSTRAINT `commerce_producttypes_shippingcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_producttypes_shippingcategories_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_sites`
--

DROP TABLE IF EXISTS `commerce_producttypes_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `hasUrls` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_producttypes_sites_productTypeId_siteId_unq_idx` (`productTypeId`,`siteId`),
  KEY `commerce_producttypes_sites_siteId_idx` (`siteId`),
  CONSTRAINT `commerce_producttypes_sites_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_producttypes_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_producttypes_taxcategories`
--

DROP TABLE IF EXISTS `commerce_producttypes_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_producttypes_taxcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productTypeId` int(11) NOT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerc_producttype_taxcategorie_productTypeI_taxCategoryI_unq_i` (`productTypeId`,`taxCategoryId`),
  KEY `commerce_producttypes_taxcategories_taxCategoryId_idx` (`taxCategoryId`),
  CONSTRAINT `commerce_producttypes_taxcategories_productTypeId_fk` FOREIGN KEY (`productTypeId`) REFERENCES `commerce_producttypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_producttypes_taxcategories_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_purchasables`
--

DROP TABLE IF EXISTS `commerce_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_purchasables` (
  `id` int(11) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `price` decimal(14,4) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_purchasables_sku_unq_idx` (`sku`),
  CONSTRAINT `commerce_purchasables_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_categories`
--

DROP TABLE IF EXISTS `commerce_sale_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(11) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_sale_categories_saleId_categoryId_unq_idx` (`saleId`,`categoryId`),
  KEY `commerce_sale_categories_categoryId_idx` (`categoryId`),
  CONSTRAINT `commerce_sale_categories_categoryId_fk` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_sale_categories_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_purchasables`
--

DROP TABLE IF EXISTS `commerce_sale_purchasables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_purchasables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(11) NOT NULL,
  `purchasableId` int(11) NOT NULL,
  `purchasableType` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_sale_purchasables_saleId_purchasableId_unq_idx` (`saleId`,`purchasableId`),
  KEY `commerce_sale_purchasables_purchasableId_idx` (`purchasableId`),
  CONSTRAINT `commerce_sale_purchasables_purchasableId_fk` FOREIGN KEY (`purchasableId`) REFERENCES `commerce_purchasables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_sale_purchasables_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sale_usergroups`
--

DROP TABLE IF EXISTS `commerce_sale_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sale_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `saleId` int(11) NOT NULL,
  `userGroupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_sale_usergroups_saleId_userGroupId_unq_idx` (`saleId`,`userGroupId`),
  KEY `commerce_sale_usergroups_userGroupId_idx` (`userGroupId`),
  CONSTRAINT `commerce_sale_usergroups_saleId_fk` FOREIGN KEY (`saleId`) REFERENCES `commerce_sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_sale_usergroups_userGroupId_fk` FOREIGN KEY (`userGroupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_sales`
--

DROP TABLE IF EXISTS `commerce_sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `dateFrom` datetime DEFAULT NULL,
  `dateTo` datetime DEFAULT NULL,
  `apply` enum('toPercent','toFlat','byPercent','byFlat') NOT NULL,
  `applyAmount` decimal(14,4) NOT NULL,
  `allGroups` tinyint(1) DEFAULT NULL,
  `allPurchasables` tinyint(1) DEFAULT NULL,
  `allCategories` tinyint(1) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `ignorePrevious` tinyint(1) DEFAULT NULL,
  `stopProcessing` tinyint(1) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingcategories`
--

DROP TABLE IF EXISTS `commerce_shippingcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_shippingcategories_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingmethods`
--

DROP TABLE IF EXISTS `commerce_shippingmethods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingmethods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_shippingmethods_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingrule_categories`
--

DROP TABLE IF EXISTS `commerce_shippingrule_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingrule_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingRuleId` int(11) DEFAULT NULL,
  `shippingCategoryId` int(11) DEFAULT NULL,
  `condition` enum('allow','disallow','require') NOT NULL,
  `perItemRate` decimal(14,4) DEFAULT NULL,
  `weightRate` decimal(14,4) DEFAULT NULL,
  `percentageRate` decimal(14,4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_shippingrule_categories_shippingRuleId_idx` (`shippingRuleId`),
  KEY `commerce_shippingrule_categories_shippingCategoryId_idx` (`shippingCategoryId`),
  CONSTRAINT `commerce_shippingrule_categories_shippingCategoryId_fk` FOREIGN KEY (`shippingCategoryId`) REFERENCES `commerce_shippingcategories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_shippingrule_categories_shippingRuleId_fk` FOREIGN KEY (`shippingRuleId`) REFERENCES `commerce_shippingrules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingrules`
--

DROP TABLE IF EXISTS `commerce_shippingrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) DEFAULT NULL,
  `methodId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT '0',
  `enabled` tinyint(1) DEFAULT NULL,
  `minQty` int(11) NOT NULL DEFAULT '0',
  `maxQty` int(11) NOT NULL DEFAULT '0',
  `minTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxTotal` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxWeight` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `baseRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `perItemRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `weightRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `percentageRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `minRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `maxRate` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_shippingrules_name_idx` (`name`),
  KEY `commerce_shippingrules_methodId_idx` (`methodId`),
  KEY `commerce_shippingrules_shippingZoneId_idx` (`shippingZoneId`),
  CONSTRAINT `commerce_shippingrules_methodId_fk` FOREIGN KEY (`methodId`) REFERENCES `commerce_shippingmethods` (`id`),
  CONSTRAINT `commerce_shippingrules_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzone_countries`
--

DROP TABLE IF EXISTS `commerce_shippingzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzone_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_shippingzone_countries_shippingZoneId_countryId_unq_idx` (`shippingZoneId`,`countryId`),
  KEY `commerce_shippingzone_countries_shippingZoneId_idx` (`shippingZoneId`),
  KEY `commerce_shippingzone_countries_countryId_idx` (`countryId`),
  CONSTRAINT `commerce_shippingzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_shippingzone_countries_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzone_states`
--

DROP TABLE IF EXISTS `commerce_shippingzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzone_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shippingZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_shippingzone_states_shippingZoneId_stateId_unq_idx` (`shippingZoneId`,`stateId`),
  KEY `commerce_shippingzone_states_shippingZoneId_idx` (`shippingZoneId`),
  KEY `commerce_shippingzone_states_stateId_idx` (`stateId`),
  CONSTRAINT `commerce_shippingzone_states_shippingZoneId_fk` FOREIGN KEY (`shippingZoneId`) REFERENCES `commerce_shippingzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_shippingzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_shippingzones`
--

DROP TABLE IF EXISTS `commerce_shippingzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_shippingzones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_shippingzones_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_states`
--

DROP TABLE IF EXISTS `commerce_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countryId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `abbreviation` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_states_countryId_name_unq_idx` (`countryId`,`name`),
  UNIQUE KEY `commerce_states_countryId_abbreviation_unq_idx` (`countryId`,`abbreviation`),
  KEY `commerce_states_countryId_idx` (`countryId`),
  CONSTRAINT `commerce_states_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_subscriptions`
--

DROP TABLE IF EXISTS `commerce_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_subscriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `planId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `orderId` int(11) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `subscriptionData` text,
  `trialDays` int(11) NOT NULL,
  `nextPaymentDate` datetime DEFAULT NULL,
  `isCanceled` tinyint(1) NOT NULL,
  `dateCanceled` datetime DEFAULT NULL,
  `isExpired` tinyint(1) NOT NULL,
  `dateExpired` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_subscriptions_reference_unq_idx` (`reference`),
  KEY `commerce_subscriptions_userId_idx` (`userId`),
  KEY `commerce_subscriptions_planId_idx` (`planId`),
  KEY `commerce_subscriptions_gatewayId_idx` (`gatewayId`),
  KEY `commerce_subscriptions_nextPaymentDate_idx` (`nextPaymentDate`),
  KEY `commerce_subscriptions_dateCreated_idx` (`dateCreated`),
  KEY `commerce_subscriptions_dateExpired_idx` (`dateExpired`),
  KEY `commerce_subscriptions_orderId_fk` (`orderId`),
  CONSTRAINT `commerce_subscriptions_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`),
  CONSTRAINT `commerce_subscriptions_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE SET NULL,
  CONSTRAINT `commerce_subscriptions_planId_fk` FOREIGN KEY (`planId`) REFERENCES `commerce_plans` (`id`),
  CONSTRAINT `commerce_subscriptions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxcategories`
--

DROP TABLE IF EXISTS `commerce_taxcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_taxcategories_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxrates`
--

DROP TABLE IF EXISTS `commerce_taxrates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxrates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) DEFAULT NULL,
  `isEverywhere` tinyint(1) DEFAULT NULL,
  `taxCategoryId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` decimal(14,10) NOT NULL,
  `include` tinyint(1) DEFAULT NULL,
  `isVat` tinyint(1) DEFAULT NULL,
  `taxable` enum('price','shipping','price_shipping','order_total_shipping','order_total_price') NOT NULL,
  `isLite` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_taxrates_taxZoneId_idx` (`taxZoneId`),
  KEY `commerce_taxrates_taxCategoryId_idx` (`taxCategoryId`),
  CONSTRAINT `commerce_taxrates_taxCategoryId_fk` FOREIGN KEY (`taxCategoryId`) REFERENCES `commerce_taxcategories` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `commerce_taxrates_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzone_countries`
--

DROP TABLE IF EXISTS `commerce_taxzone_countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzone_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) NOT NULL,
  `countryId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_taxzone_countries_taxZoneId_countryId_unq_idx` (`taxZoneId`,`countryId`),
  KEY `commerce_taxzone_countries_taxZoneId_idx` (`taxZoneId`),
  KEY `commerce_taxzone_countries_countryId_idx` (`countryId`),
  CONSTRAINT `commerce_taxzone_countries_countryId_fk` FOREIGN KEY (`countryId`) REFERENCES `commerce_countries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_taxzone_countries_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzone_states`
--

DROP TABLE IF EXISTS `commerce_taxzone_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzone_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `taxZoneId` int(11) NOT NULL,
  `stateId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_taxzone_states_taxZoneId_stateId_unq_idx` (`taxZoneId`,`stateId`),
  KEY `commerce_taxzone_states_taxZoneId_idx` (`taxZoneId`),
  KEY `commerce_taxzone_states_stateId_idx` (`stateId`),
  CONSTRAINT `commerce_taxzone_states_stateId_fk` FOREIGN KEY (`stateId`) REFERENCES `commerce_states` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_taxzone_states_taxZoneId_fk` FOREIGN KEY (`taxZoneId`) REFERENCES `commerce_taxzones` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_taxzones`
--

DROP TABLE IF EXISTS `commerce_taxzones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_taxzones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `isCountryBased` tinyint(1) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_taxzones_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_transactions`
--

DROP TABLE IF EXISTS `commerce_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `gatewayId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `hash` varchar(32) DEFAULT NULL,
  `type` enum('authorize','capture','purchase','refund') NOT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `paymentAmount` decimal(14,4) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `paymentCurrency` varchar(255) DEFAULT NULL,
  `paymentRate` decimal(14,4) DEFAULT NULL,
  `status` enum('pending','redirect','success','failed','processing') NOT NULL,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `message` text,
  `note` mediumtext,
  `response` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `commerce_transactions_parentId_idx` (`parentId`),
  KEY `commerce_transactions_gatewayId_idx` (`gatewayId`),
  KEY `commerce_transactions_orderId_idx` (`orderId`),
  KEY `commerce_transactions_userId_idx` (`userId`),
  CONSTRAINT `commerce_transactions_gatewayId_fk` FOREIGN KEY (`gatewayId`) REFERENCES `commerce_gateways` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `commerce_transactions_orderId_fk` FOREIGN KEY (`orderId`) REFERENCES `commerce_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_transactions_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `commerce_transactions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `commerce_transactions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `commerce_variants`
--

DROP TABLE IF EXISTS `commerce_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commerce_variants` (
  `id` int(11) NOT NULL,
  `productId` int(11) DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `isDefault` tinyint(1) DEFAULT NULL,
  `price` decimal(14,4) NOT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `width` decimal(14,4) DEFAULT NULL,
  `height` decimal(14,4) DEFAULT NULL,
  `length` decimal(14,4) DEFAULT NULL,
  `weight` decimal(14,4) DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `hasUnlimitedStock` tinyint(1) DEFAULT NULL,
  `minQty` int(11) DEFAULT NULL,
  `maxQty` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `commerce_variants_sku_unq_idx` (`sku`),
  KEY `commerce_variants_productId_idx` (`productId`),
  CONSTRAINT `commerce_variants_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `commerce_variants_productId_fk` FOREIGN KEY (`productId`) REFERENCES `commerce_products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrydrafts`
--

DROP TABLE IF EXISTS `entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entryversions`
--

DROP TABLE IF EXISTS `entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `config` mediumtext,
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagateEntries` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'commercesearchissue'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-28  9:14:32
-- MySQL dump 10.13  Distrib 5.7.24, for osx10.14 (x86_64)
--
-- Host: localhost    Database: commercesearchissue
-- ------------------------------------------------------
-- Server version	5.7.24

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
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_addresses`
--

LOCK TABLES `commerce_addresses` WRITE;
/*!40000 ALTER TABLE `commerce_addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_countries`
--

LOCK TABLES `commerce_countries` WRITE;
/*!40000 ALTER TABLE `commerce_countries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_countries` VALUES (1,'Andorra','AD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a0148055-d0b7-4e3b-a888-91ebe0e1bad7'),(2,'United Arab Emirates','AE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e5ac8df9-6809-40b4-ae88-3cb378d1c520'),(3,'Afghanistan','AF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','67ae8755-43bf-4207-989f-893f7137d197'),(4,'Antigua and Barbuda','AG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f2e70245-7c50-4ef9-aa5a-0afdf08d14ec'),(5,'Anguilla','AI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4f735a10-62f4-4b89-a8ab-c0bc597a5f9c'),(6,'Albania','AL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fdb768fc-3054-4536-8b69-a6e8216de771'),(7,'Armenia','AM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a5ec10cc-3a9a-4c5e-a765-641f6cba0ed5'),(8,'Angola','AO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2d1891a8-c381-4078-a5f0-ee9e93054e6f'),(9,'Antarctica','AQ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4915cc31-80f5-4e42-8918-f50c260c3e1b'),(10,'Argentina','AR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a490b239-705a-4f0f-8246-87d4e8e5ea3f'),(11,'American Samoa','AS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','618cc3f3-7f82-401f-9de5-4d9522668bd4'),(12,'Austria','AT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','cbfea03c-4962-4a25-8cde-4dee59869b4a'),(13,'Australia','AU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e6758c3f-a149-4689-8115-7269311f2da3'),(14,'Aruba','AW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8f6543d0-aeb6-4d46-8590-6c6f3c0c0283'),(15,'Aland Islands','AX',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8405bda8-f459-428f-bfe2-f0d334874494'),(16,'Azerbaijan','AZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fbb8ae03-a079-4b00-88cd-81e6e83659a2'),(17,'Bosnia and Herzegovina','BA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0d065925-f5df-4897-ac7c-06f1b7b59432'),(18,'Barbados','BB',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e4b0080d-c003-44ae-b593-20b49e845ec8'),(19,'Bangladesh','BD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a33d924e-789a-4df1-abe7-9550c784b5a3'),(20,'Belgium','BE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7ab47cd5-c309-4fc7-be2f-ee1d0ad56212'),(21,'Burkina Faso','BF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b130e387-6c18-48b2-b905-194734a94aae'),(22,'Bulgaria','BG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b36dcead-815e-4932-a5e2-84f8a43638fa'),(23,'Bahrain','BH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','dc35d893-e4c8-4282-8958-0bb8b902cb60'),(24,'Burundi','BI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a44d2ced-db1a-4f2e-b184-5f877bb2d56b'),(25,'Benin','BJ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','020a0a0f-ffbf-40cb-856e-fe11a1f72189'),(26,'Saint Barthelemy','BL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','24ead072-e7e8-4de8-a074-49a136feed81'),(27,'Bermuda','BM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9c4a2319-af3f-4199-8302-84b6cb17f42d'),(28,'Brunei Darussalam','BN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9048a08e-b109-4a31-b5f8-7c5f6ea7b532'),(29,'Bolivia','BO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','83516770-0a7f-4474-808f-a236c7b6288c'),(30,'Bonaire, Sint Eustatius and Saba','BQ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bd194742-0210-411b-9856-94d5e78a0c41'),(31,'Brazil','BR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2ad592b3-78a8-402f-a1c1-0290250f7983'),(32,'Bahamas','BS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','70ab2949-2f89-409e-83f7-4b19b2b507a2'),(33,'Bhutan','BT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','22a0f919-38ac-45d4-9698-027b4f497f34'),(34,'Bouvet Island','BV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0a2e444f-7d00-46c0-a27b-4aef4aa5b06a'),(35,'Botswana','BW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','40a8712b-b164-4905-8399-9a750e91eb73'),(36,'Belarus','BY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8c50df4e-c97f-4f19-8678-7583b3c982c5'),(37,'Belize','BZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4bb6793f-6d84-4b6b-8334-2d1ae897dc85'),(38,'Canada','CA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c60c4509-eba5-47b5-a32f-f61fb6b77ff3'),(39,'Cocos (Keeling) Islands','CC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e7005154-ec46-49e7-ba56-8489c710732c'),(40,'Democratic Republic of Congo','CD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','74a6b534-f1e9-42b8-b7cf-fdc5f0b42a88'),(41,'Central African Republic','CF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a55a510c-36c3-40c1-9002-e79b58ff13df'),(42,'Congo','CG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2e7d0c04-434f-445c-870d-b31f11fa08cc'),(43,'Switzerland','CH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bc6065c8-9b6a-41bd-98e1-d54a6582f4ea'),(44,'Ivory Coast','CI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','011c2145-4a77-444a-be2e-3664f7a0312d'),(45,'Cook Islands','CK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','99e70ac6-8af8-4da7-8982-3f270223451d'),(46,'Chile','CL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7acfef86-6324-48e3-8382-867a80b67a58'),(47,'Cameroon','CM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8dfd8237-2a22-464a-a592-bb0aba31505f'),(48,'China','CN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4c973d4e-59e1-4f51-a223-d920b9ae8f81'),(49,'Colombia','CO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bf13fc07-6341-448f-9379-f22e3e9fa5f0'),(50,'Costa Rica','CR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','13b49318-d043-4732-bc46-ffd62d54d196'),(51,'Cuba','CU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','eb70624b-c723-4786-a7c8-66a198f5bbf5'),(52,'Cape Verde','CV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b2ceb047-f526-4a77-9e42-6fdc6c71d6f2'),(53,'Curacao','CW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d4550322-d4e8-42f1-9247-94c8ef1137a8'),(54,'Christmas Island','CX',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','57a25560-6903-4367-9f62-0de850606ea2'),(55,'Cyprus','CY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','71689aab-8784-4e0a-ac89-5fcf41c5e647'),(56,'Czech Republic','CZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ce9e8e97-8e4e-4f40-954d-9fb6689093b0'),(57,'Germany','DE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bbc86e93-1bf5-43aa-be65-306b5657a3ff'),(58,'Djibouti','DJ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0abc5b75-967b-477e-9718-37db66d86be2'),(59,'Denmark','DK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1e9aecc3-e619-48b8-a26a-0eea01dc7bcd'),(60,'Dominica','DM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f494df88-17de-4266-816a-7d0fa7782fc4'),(61,'Dominican Republic','DO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','56adf3c5-87ec-44fe-b606-48832ea32c27'),(62,'Algeria','DZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1021a8f6-c238-4124-b9e2-133f78e9f94a'),(63,'Ecuador','EC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','3e85593d-347b-43b9-8be4-ed1c3f9ed0b4'),(64,'Estonia','EE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','54223023-ac7d-42c8-aada-804fb1437929'),(65,'Egypt','EG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5aadd69e-16e0-4be0-9c86-8e3e36d68400'),(66,'Western Sahara','EH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5e6387fc-ca2f-4bc1-8784-e028b334767d'),(67,'Eritrea','ER',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','07c318b3-4ec5-4b62-b8a5-87eb2a14f74f'),(68,'Spain','ES',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f3832597-8f15-4015-920e-8eeab5c120ba'),(69,'Ethiopia','ET',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6da4c906-08eb-447f-a52d-e7b632f37c6f'),(70,'Finland','FI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9c24182e-141c-4e48-a402-36879e86a45e'),(71,'Fiji','FJ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','288fec9e-7179-4c99-910c-6aa4b9c91f53'),(72,'Falkland Islands (Malvinas)','FK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bc87767f-6bbd-4e4f-ae35-2c51c8c08af5'),(73,'Micronesia','FM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7cf48ec3-9c66-4ebc-94ce-655df2dc7301'),(74,'Faroe Islands','FO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8cadf4dc-ac25-4028-ad0c-bd33b46a9603'),(75,'France','FR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8be4f7d3-7f48-426d-b5be-7a0dcd85e891'),(76,'Gabon','GA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5fb78ba5-1d02-4275-80c0-1fca14d50888'),(77,'United Kingdom','GB',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','20007d56-5ae4-4c30-bfe4-add0d9c2943b'),(78,'Grenada','GD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b71a2a3c-adc0-4cb1-b9dc-223f3e088807'),(79,'Georgia','GE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','64616c69-a095-43ec-aaf0-0007bbb25d10'),(80,'French Guiana','GF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','96f57a21-8a52-4a2d-96ab-b1c66d8328b8'),(81,'Guernsey','GG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d16c753b-4117-4354-9274-794fa601a46a'),(82,'Ghana','GH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a0768902-7d48-4bbd-93c2-8e27cdddb0de'),(83,'Gibraltar','GI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c7c5e75c-6804-45e7-8b63-9e9522a47f85'),(84,'Greenland','GL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','51562dba-a32d-4284-a04a-fbdf045c91e3'),(85,'Gambia','GM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b9f22ca3-4549-41ae-9aaa-c085499bb342'),(86,'Guinea','GN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1ecaec7c-90db-43db-8f4c-a6465ba0e8f8'),(87,'Guadeloupe','GP',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','82c225df-d014-40b6-af07-72c882b96db3'),(88,'Equatorial Guinea','GQ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4946f4a7-5a03-4cb3-b754-e713b46a5fcf'),(89,'Greece','GR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f9552ba2-26f7-4cd4-8b42-b70d5e03d204'),(90,'S. Georgia and S. Sandwich Isls.','GS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','55f449a4-171d-4eb2-aa8b-14e12e6997ec'),(91,'Guatemala','GT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c82f7797-6c0a-433f-9db1-d3efb58b5898'),(92,'Guam','GU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4aa73407-72a9-4aae-956f-546ac7336721'),(93,'Guinea-Bissau','GW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','658558a3-fe86-4340-b307-595acd5d2361'),(94,'Guyana','GY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b34975c7-31b8-4fbe-9cc6-778803e60ab9'),(95,'Hong Kong','HK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b85c1ed2-1ee8-44da-b611-d25378b3bb10'),(96,'Heard and McDonald Islands','HM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6944c92a-5451-45d8-acc3-3e094c8182f7'),(97,'Honduras','HN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','04315dda-14f6-4323-bfc0-b9e184b261a6'),(98,'Croatia (Hrvatska)','HR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','00c5f8e8-5248-47a3-a2ef-26d23ce05e53'),(99,'Haiti','HT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0a411368-8f62-4aa8-8f9b-ee9645b232a3'),(100,'Hungary','HU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b6304744-4507-4173-9162-e3c4ec84fd61'),(101,'Indonesia','ID',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','cf608121-d91b-4664-9c70-1dc8e1709b73'),(102,'Ireland','IE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','09f24523-dc1c-49fd-ad90-3a01035eb8ae'),(103,'Israel','IL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d47bb1d9-506b-462a-b170-d73eea4ba0ae'),(104,'Isle Of Man','IM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4e9582e2-05e1-4291-84d5-e33d7ecef275'),(105,'India','IN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','54d3bec8-05af-4c0a-8ec4-ca50acf442b4'),(106,'British Indian Ocean Territory','IO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ebee86ff-fed9-4fe3-baae-a2f08337b4b7'),(107,'Iraq','IQ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','62a09455-c4d5-48d2-babf-3a5f4ee00c61'),(108,'Iran','IR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','973650c4-a2de-4364-8fe8-85e4fe5b2764'),(109,'Iceland','IS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ad0e0e33-76b9-4728-a1a7-8b26e9c70ede'),(110,'Italy','IT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0da12ab4-e4b9-4129-b51f-740c9c1db8b9'),(111,'Jersey','JE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1c4e9974-a1c8-4647-a3d6-20cad5514cf2'),(112,'Jamaica','JM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','89dd811d-a090-4867-a018-84b2bd10e187'),(113,'Jordan','JO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2a2c5da5-d1f9-4f2a-ba33-7959c49a1afd'),(114,'Japan','JP',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a129b061-c61f-4a35-96b8-23662c376add'),(115,'Kenya','KE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1bed83a4-f0d3-43f3-800c-a409744164c2'),(116,'Kyrgyzstan','KG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','be9e0c67-dd9e-4484-ab8b-5bd18ee76406'),(117,'Cambodia','KH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','49ce4403-7945-4e77-9f36-05cbebaf2e0a'),(118,'Kiribati','KI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','39d1e7f6-c2d5-4f52-b02f-ef64471c065c'),(119,'Comoros','KM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ba7146b7-a35e-4e58-bc9f-52cbf203d41e'),(120,'Saint Kitts and Nevis','KN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f088d057-a4d1-4900-a7db-d085a5148930'),(121,'Korea (North)','KP',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a69584ef-8e08-4f83-9b2c-079b7e06e70a'),(122,'Korea (South)','KR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4ee9081f-8cd4-41a6-8c67-991ffae8c89c'),(123,'Kuwait','KW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','16966da8-a616-471a-bf97-08c30c73c581'),(124,'Cayman Islands','KY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2b8dcd37-a7c2-416f-bdfb-0539f679b753'),(125,'Kazakhstan','KZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','738bbb33-e707-4118-8c47-4714f2addb10'),(126,'Laos','LA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','77845b63-c3e3-479a-b7de-6b81114f5a52'),(127,'Lebanon','LB',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9645a3f2-e2e3-4567-bfbf-cefb6d3233b9'),(128,'Saint Lucia','LC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a45f23f9-670b-4310-b947-6e549e0144fd'),(129,'Liechtenstein','LI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','14b3e99c-2f46-4f1b-8f51-11f330f23007'),(130,'Sri Lanka','LK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ec035917-7591-4ed9-9396-78dda917f855'),(131,'Liberia','LR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','690f078c-b987-4e39-869e-c74660becc76'),(132,'Lesotho','LS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a781c64c-59d7-4b91-845c-6ff11302e0c4'),(133,'Lithuania','LT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','67eb9d12-e708-4f35-bb1c-5727c4450d24'),(134,'Luxembourg','LU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','43f5b1b8-7c23-4ae6-b1c3-3c0a6511c386'),(135,'Latvia','LV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e11add6f-6d4e-4e30-939c-4b10b65dd020'),(136,'Libya','LY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','cfa071fa-7319-44e0-acb5-d526d7e9598e'),(137,'Morocco','MA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','02d9aa7e-4439-4484-8bc5-b5db9514172c'),(138,'Monaco','MC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6eb31c5f-5511-48c7-bd0e-153c40be6070'),(139,'Moldova','MD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7850885e-ae8c-436d-9734-b7c7a5245ae2'),(140,'Montenegro','ME',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5ed8cf0e-9541-444a-9e8f-e9ea9eb7a289'),(141,'Saint Martin (French part)','MF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2c1a1585-6aea-4fe8-ac5f-995aca876cb3'),(142,'Madagascar','MG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f0a3764a-18ad-4604-9e97-9f091d247597'),(143,'Marshall Islands','MH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6e5e8b7f-9972-4833-8b5c-be3d11e4196f'),(144,'Macedonia','MK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','615e4c11-ea25-4039-9bdc-b41d45ff5722'),(145,'Mali','ML',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','46d82a42-870e-4208-aac3-74fceb61512f'),(146,'Burma (Myanmar)','MM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','24653130-4a79-4521-9816-dc2058a4ae9a'),(147,'Mongolia','MN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','cfa6e3b4-2c40-42ed-a95e-45f7014f58d0'),(148,'Macau','MO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9fec8b9d-3bb7-4985-b02f-9b421ae31d9c'),(149,'Northern Mariana Islands','MP',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f18d9cbb-a467-48bd-bd0b-6d28873b718b'),(150,'Martinique','MQ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4cc96545-b761-489e-867e-6843a1121089'),(151,'Mauritania','MR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d06b4c96-599f-4834-a0e7-45a4524e4947'),(152,'Montserrat','MS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c80e3b93-73c5-4c7c-9048-a51626088492'),(153,'Malta','MT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c89bb85c-08f2-4c31-a2b2-f5a2438fc006'),(154,'Mauritius','MU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5941dfb7-7dc2-451f-acc9-6d7bd795a543'),(155,'Maldives','MV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8fcf2224-53ec-4987-986b-5caf807a496d'),(156,'Malawi','MW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fc2a170b-c74c-4bad-af31-63535638984f'),(157,'Mexico','MX',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','e648de4c-631a-48c4-97c3-3d396aefe5c8'),(158,'Malaysia','MY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','2953500f-2528-4bbd-b163-a121d016b461'),(159,'Mozambique','MZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','822d3a1b-78f9-491d-878b-1fd7719a2c4b'),(160,'Namibia','NA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c349d023-1261-49ed-9365-7775572512c1'),(161,'New Caledonia','NC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','96d13b03-6fed-431d-8e17-17ee0359b260'),(162,'Niger','NE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5c541f68-323f-48f2-aa3e-b73941f2b31f'),(163,'Norfolk Island','NF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f7925ba6-a85a-4657-afe5-89dd73347f79'),(164,'Nigeria','NG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','195c69ce-a67d-4788-87c6-6039de6cc49d'),(165,'Nicaragua','NI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','01236b22-1512-4cb9-82ca-e762a37db46c'),(166,'Netherlands','NL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','175d8f43-3c14-4ef8-af49-31392c23f84e'),(167,'Norway','NO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','54d829a9-cfb6-4a92-98a6-f1e3fb5220bd'),(168,'Nepal','NP',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f30e50bc-bb4c-4b8d-990c-d6553f787c08'),(169,'Nauru','NR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','60f10da6-18e7-439b-be6b-960b428643c4'),(170,'Niue','NU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','aa8809cf-0da3-4f56-899c-ef3cdf5321ff'),(171,'New Zealand','NZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','954e0e45-4dc2-4e4f-8f67-a0e6fd6e981a'),(172,'Oman','OM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bcc499cf-28c7-4cd4-a72d-af4d775282ce'),(173,'Panama','PA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','26a74e53-dae6-483f-b467-fc8e04c3d18b'),(174,'Peru','PE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4a9f5346-0443-4fd7-9b10-db42f9e72d41'),(175,'French Polynesia','PF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d2734e82-a4c7-4aa3-b89f-48211931c863'),(176,'Papua New Guinea','PG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1b31dd8a-2116-40f4-a13e-c5eb571b4465'),(177,'Philippines','PH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','bb006046-807e-4d47-ba7e-ad48329332f3'),(178,'Pakistan','PK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c0417ca0-66a6-4867-b0b0-a0295673cf0d'),(179,'Poland','PL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','91d93267-b6cd-495c-bdc5-630a633f2822'),(180,'St. Pierre and Miquelon','PM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7225dbd2-4a72-4021-b70b-8ff0f1eacfed'),(181,'Pitcairn','PN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','94dd6f83-f1a0-4f8e-b489-ad68b829a458'),(182,'Puerto Rico','PR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','10cc5988-01e4-4a6c-b5d6-90d576e71c42'),(183,'Palestinian Territory, Occupied','PS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d46bc1ae-9d8a-42a1-8aa0-2700b76d5b55'),(184,'Portugal','PT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ff258304-6e25-4845-ad2a-81143d7a480b'),(185,'Palau','PW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f85c3a92-62bd-48ba-9cd5-c5c996bc63d0'),(186,'Paraguay','PY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','19a497a2-79ed-4f78-986a-491a1249d07f'),(187,'Qatar','QA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fe60262b-a787-49d8-821c-48cc1192dae5'),(188,'Reunion','RE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9fd01487-8bc6-4be8-a62e-3ff129e673b3'),(189,'Romania','RO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5d052391-f419-4646-a28e-dbb7b511a192'),(190,'Republic of Serbia','RS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','57d023a1-a7c9-4dea-847b-a2fedf759bb5'),(191,'Russia','RU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','1890105e-a9c6-4fda-81e2-9b29d822e54e'),(192,'Rwanda','RW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a8179cc7-ac53-4d19-b214-273af7909819'),(193,'Saudi Arabia','SA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','590c3b5b-aa9c-47d7-9a14-cb1539d33b9f'),(194,'Solomon Islands','SB',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7d1a865f-cf5b-4f58-ae15-4190c30af26a'),(195,'Seychelles','SC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6b44873f-23ba-4c68-bbc7-6e12974b9be5'),(196,'Sudan','SD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d9af8d13-52ec-42bf-95e9-efa0721be67c'),(197,'Sweden','SE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','8c871d95-8426-4ac0-be3c-2e1a93b553c7'),(198,'Singapore','SG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','84c6494a-6de1-4d01-9585-15ab619061d4'),(199,'St. Helena','SH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','980954f2-66bc-4acd-acc9-0b1591e00a16'),(200,'Slovenia','SI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','12a7a4bc-5d26-4d6a-ad20-c929938eb710'),(201,'Svalbard and Jan Mayen Islands','SJ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','16aa44c6-5010-459f-931b-a07683d895e0'),(202,'Slovak Republic','SK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','44b6f70f-fa96-4bdf-a0b3-34dea8e03638'),(203,'Sierra Leone','SL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','f3fecff5-40fb-441a-b015-943c47717ae6'),(204,'San Marino','SM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4b9de2d6-b213-40d9-be11-7697af17bfa2'),(205,'Senegal','SN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fdca6c17-dca1-49a4-8e19-51ea66a8df19'),(206,'Somalia','SO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0cd2bc03-19e4-4b33-a64e-337dc4133820'),(207,'Suriname','SR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','84291f69-d22b-47e5-bcbf-09a07a3d1a34'),(208,'South Sudan','SS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d84e513d-240d-468c-97b4-e8997b9acafc'),(209,'Sao Tome and Principe','ST',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','eb91e868-c44a-4eb5-b6ce-87f63c3144fe'),(210,'El Salvador','SV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','08946866-b1cb-4e6a-bd0b-f9649be7e227'),(211,'Sint Maarten (Dutch part)','SX',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6009fb28-ce5e-4901-9a87-0f648fa80928'),(212,'Syria','SY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','7026f543-26e6-4c7c-9a55-22b14ec3cfc9'),(213,'Swaziland','SZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0e7c9814-ea97-42f3-84d8-22ecc2774f06'),(214,'Turks and Caicos Islands','TC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','29eaea9a-6cac-4198-9902-0ac843b648ea'),(215,'Chad','TD',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c80ce05f-5f1b-4257-9fa5-b6cb38a0fd46'),(216,'French Southern Territories','TF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','acb0f929-8ab7-439c-87a5-519ab09b5f61'),(217,'Togo','TG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b0156d19-d053-4b8c-85ab-b0d1ee12e968'),(218,'Thailand','TH',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','530cd435-117c-4b2c-8ab8-2bc3706261a5'),(219,'Tajikistan','TJ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','371f5561-56f4-4009-a229-d89b553570d4'),(220,'Tokelau','TK',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','200339f1-2e9f-4f1b-96b1-50c656f9d969'),(221,'Timor-Leste','TL',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9bbfd9d5-c9a7-4484-a6cd-fd301dc89fdb'),(222,'Turkmenistan','TM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','becd19e4-7b9d-4617-aef0-72d1bceb7cc9'),(223,'Tunisia','TN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a84efe31-7f11-46d0-b6ee-6c3c78c9865b'),(224,'Tonga','TO',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','89d95dde-2ff0-4c00-b1d6-c3aebb2e06cc'),(225,'Turkey','TR',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fc8e6082-f1c9-4356-bc66-dce351f950e6'),(226,'Trinidad and Tobago','TT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5fe7473c-7aa5-40a0-af16-f35e9b01c86f'),(227,'Tuvalu','TV',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','07abf7c8-f9fa-4390-9806-609e168ba74c'),(228,'Taiwan','TW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','663237e4-6dc4-40d9-9a09-6839c6a77944'),(229,'Tanzania','TZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','4f494547-dd6b-4c14-b7b1-3e0a0e4f6aed'),(230,'Ukraine','UA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5391c30c-fb8e-458a-a2c6-6510e390cddd'),(231,'Uganda','UG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','b40a8907-47a5-42cb-a204-ffb700e789c3'),(232,'United States Minor Outlying Islands','UM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','076b2b0c-021b-4bd2-b622-62c04566dc5d'),(233,'United States','US',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d83066f3-9c5c-41bf-a82c-55c4e89a04e7'),(234,'Uruguay','UY',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','87dc6215-f713-4951-afc2-b5880b0ab8af'),(235,'Uzbekistan','UZ',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','c9ed178c-3d82-4ddb-aa1f-25c15838ea06'),(236,'Vatican City State (Holy See)','VA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','6f46d58a-6200-46b0-b3d6-45263d980580'),(237,'Saint Vincent and the Grenadines','VC',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a058ae74-0ce7-4c55-a0c9-2e5cbff87cae'),(238,'Venezuela','VE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','5835c849-a617-42f4-9bd0-8f2880860112'),(239,'Virgin Islands (British)','VG',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','45f88716-810f-4c02-b652-4a4167c73283'),(240,'Virgin Islands (U.S.)','VI',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d1b2efab-961f-422d-8f4e-7861fb769e07'),(241,'Viet Nam','VN',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','db7f45b0-3468-4a20-b8f3-cd58b6e2a258'),(242,'Vanuatu','VU',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','d510d49b-a3e9-4b78-89cd-2dfeaf658eef'),(243,'Wallis and Futuna Islands','WF',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','19944e1d-e894-4a79-89fc-00d0421bb0db'),(244,'Samoa','WS',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','74669858-785c-47c3-9b8a-42d9e869c070'),(245,'Yemen','YE',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','70ecf3a7-c7d5-40ca-baeb-9f9fd5caf4de'),(246,'Mayotte','YT',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','0f955080-00d8-4936-bd26-4fdd68af53a4'),(247,'South Africa','ZA',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','ee655b3c-c2d5-411e-b6b3-9a54503bf617'),(248,'Zambia','ZM',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','a94e844d-4f25-4fd9-9254-06b37a99ed93'),(249,'Zimbabwe','ZW',NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','9f6fede5-b7ea-46df-a1b1-2a3ab74db767');
/*!40000 ALTER TABLE `commerce_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customer_discountuses`
--

LOCK TABLES `commerce_customer_discountuses` WRITE;
/*!40000 ALTER TABLE `commerce_customer_discountuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_customer_discountuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customers`
--

LOCK TABLES `commerce_customers` WRITE;
/*!40000 ALTER TABLE `commerce_customers` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_customers` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_customers_addresses`
--

LOCK TABLES `commerce_customers_addresses` WRITE;
/*!40000 ALTER TABLE `commerce_customers_addresses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_customers_addresses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_categories`
--

LOCK TABLES `commerce_discount_categories` WRITE;
/*!40000 ALTER TABLE `commerce_discount_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_purchasables`
--

LOCK TABLES `commerce_discount_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_discount_purchasables` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discount_usergroups`
--

LOCK TABLES `commerce_discount_usergroups` WRITE;
/*!40000 ALTER TABLE `commerce_discount_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discount_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_discounts`
--

LOCK TABLES `commerce_discounts` WRITE;
/*!40000 ALTER TABLE `commerce_discounts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_discounts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_email_discountuses`
--

LOCK TABLES `commerce_email_discountuses` WRITE;
/*!40000 ALTER TABLE `commerce_email_discountuses` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_email_discountuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_emails`
--

LOCK TABLES `commerce_emails` WRITE;
/*!40000 ALTER TABLE `commerce_emails` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_emails` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_gateways`
--

LOCK TABLES `commerce_gateways` WRITE;
/*!40000 ALTER TABLE `commerce_gateways` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_gateways` VALUES (1,'craft\\commerce\\gateways\\Dummy','Dummy','dummy','[]','purchase',1,NULL,0,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','fb31884e-93ca-4c52-acbe-0e70f5189a11');
/*!40000 ALTER TABLE `commerce_gateways` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_lineitems`
--

LOCK TABLES `commerce_lineitems` WRITE;
/*!40000 ALTER TABLE `commerce_lineitems` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_lineitems` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderadjustments`
--

LOCK TABLES `commerce_orderadjustments` WRITE;
/*!40000 ALTER TABLE `commerce_orderadjustments` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderadjustments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderhistories`
--

LOCK TABLES `commerce_orderhistories` WRITE;
/*!40000 ALTER TABLE `commerce_orderhistories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderhistories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orders`
--

LOCK TABLES `commerce_orders` WRITE;
/*!40000 ALTER TABLE `commerce_orders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderstatus_emails`
--

LOCK TABLES `commerce_orderstatus_emails` WRITE;
/*!40000 ALTER TABLE `commerce_orderstatus_emails` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_orderstatus_emails` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_orderstatuses`
--

LOCK TABLES `commerce_orderstatuses` WRITE;
/*!40000 ALTER TABLE `commerce_orderstatuses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_orderstatuses` VALUES (1,'New','new','green',0,NULL,999,1,'2019-01-28 15:03:14','2019-01-28 15:03:14','8492ea7a-f6a3-4ccf-825b-80e7690a75c2'),(2,'Shipped','shipped','blue',0,NULL,999,0,'2019-01-28 15:03:14','2019-01-28 15:03:14','848867d7-12f3-47d4-ba46-10031d51026d');
/*!40000 ALTER TABLE `commerce_orderstatuses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_paymentcurrencies`
--

LOCK TABLES `commerce_paymentcurrencies` WRITE;
/*!40000 ALTER TABLE `commerce_paymentcurrencies` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_paymentcurrencies` VALUES (1,'USD',1,1.0000,'2019-01-28 15:03:14','2019-01-28 15:03:14','695a616d-0428-4824-9e58-502f8ad8d208');
/*!40000 ALTER TABLE `commerce_paymentcurrencies` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_paymentsources`
--

LOCK TABLES `commerce_paymentsources` WRITE;
/*!40000 ALTER TABLE `commerce_paymentsources` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_paymentsources` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_plans`
--

LOCK TABLES `commerce_plans` WRITE;
/*!40000 ALTER TABLE `commerce_plans` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_plans` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_products`
--

LOCK TABLES `commerce_products` WRITE;
/*!40000 ALTER TABLE `commerce_products` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_products` VALUES (2,1,1,1,3,'2019-01-28 15:03:14',NULL,1,1,NULL,'ANT-001',20.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','bf51fd9e-6b99-4b59-addc-b00b18886467'),(4,1,1,1,5,'2019-01-28 15:03:14',NULL,1,1,NULL,'PSB-001',30.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','5084d9d3-4f70-49d9-a192-a27a337b1b09'),(6,1,1,1,7,'2019-01-28 15:03:14',NULL,1,1,NULL,'RRE-001',40.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','bb2ec78b-73a5-470d-82ed-3c17aa7f02e1'),(8,1,1,1,9,'2019-01-28 15:03:14',NULL,1,1,NULL,'TFA-001',50.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','77152344-b69b-4d1d-b09c-1533f4d75a51'),(10,1,1,1,11,'2019-01-28 15:03:14',NULL,1,1,NULL,'LKH-001',60.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','5139169a-37c9-4e87-8e92-df60dacc2eab'),(12,1,1,1,13,'2019-01-26 15:30:00',NULL,1,1,0,'ALW-12',24.0000,0.0000,0.0000,0.0000,0.0000,'2019-01-28 15:10:57','2019-01-28 15:11:53','06826957-74f3-47ee-9b10-4e077e418ff4');
/*!40000 ALTER TABLE `commerce_products` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes`
--

LOCK TABLES `commerce_producttypes` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_producttypes` VALUES (1,NULL,NULL,'Clothing','clothing',1,0,0,'{product.title}','','','2019-01-28 15:03:14','2019-01-28 15:03:14','3ac51e77-a5b2-4288-b834-a5d41336feb8');
/*!40000 ALTER TABLE `commerce_producttypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_shippingcategories`
--

LOCK TABLES `commerce_producttypes_shippingcategories` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_shippingcategories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_producttypes_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_sites`
--

LOCK TABLES `commerce_producttypes_sites` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_producttypes_sites` VALUES (1,1,1,'shop/products/{slug}','shop/products/_product',1,'2019-01-28 15:03:14','2019-01-28 15:03:14','a7be834a-adda-4064-a1ca-4dd57d766aca');
/*!40000 ALTER TABLE `commerce_producttypes_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_producttypes_taxcategories`
--

LOCK TABLES `commerce_producttypes_taxcategories` WRITE;
/*!40000 ALTER TABLE `commerce_producttypes_taxcategories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_producttypes_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_purchasables`
--

LOCK TABLES `commerce_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_purchasables` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_purchasables` VALUES (3,'ANT-001',20.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','8e6e917c-4d6d-48e3-8cbf-15a4ec2b24e7'),(5,'PSB-001',30.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','44b34125-128e-4687-91fb-314a6f0cc68f'),(7,'RRE-001',40.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','f0d9ad7b-fe26-49b4-8b41-145f57111f7d'),(9,'TFA-001',50.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','292c7b22-405a-45b1-83ae-d5b9916f3695'),(11,'LKH-001',60.0000,'2019-01-28 15:03:14','2019-01-28 15:03:16','3814e371-39a1-4ea8-a0ac-e99cb5ec8e13'),(13,'ALW-12',24.0000,'2019-01-28 15:10:57','2019-01-28 15:11:53','bd01965d-81fd-400b-8ee6-f7a70f78da64');
/*!40000 ALTER TABLE `commerce_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_categories`
--

LOCK TABLES `commerce_sale_categories` WRITE;
/*!40000 ALTER TABLE `commerce_sale_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_purchasables`
--

LOCK TABLES `commerce_sale_purchasables` WRITE;
/*!40000 ALTER TABLE `commerce_sale_purchasables` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_purchasables` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sale_usergroups`
--

LOCK TABLES `commerce_sale_usergroups` WRITE;
/*!40000 ALTER TABLE `commerce_sale_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sale_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_sales`
--

LOCK TABLES `commerce_sales` WRITE;
/*!40000 ALTER TABLE `commerce_sales` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_sales` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingcategories`
--

LOCK TABLES `commerce_shippingcategories` WRITE;
/*!40000 ALTER TABLE `commerce_shippingcategories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingcategories` VALUES (1,'General','general',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:14','bcb71c76-f93c-48c9-b459-07d7360ff466');
/*!40000 ALTER TABLE `commerce_shippingcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingmethods`
--

LOCK TABLES `commerce_shippingmethods` WRITE;
/*!40000 ALTER TABLE `commerce_shippingmethods` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingmethods` VALUES (1,'Free Shipping','freeShipping',1,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','418bc403-8d88-4285-b298-e9b7db366e5c');
/*!40000 ALTER TABLE `commerce_shippingmethods` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingrule_categories`
--

LOCK TABLES `commerce_shippingrule_categories` WRITE;
/*!40000 ALTER TABLE `commerce_shippingrule_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingrule_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingrules`
--

LOCK TABLES `commerce_shippingrules` WRITE;
/*!40000 ALTER TABLE `commerce_shippingrules` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_shippingrules` VALUES (1,NULL,1,'Free Everywhere','All Countries, free shipping.',0,1,0,0,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,0.0000,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:14','39fd34af-74fd-4f12-9bfe-37be9fc53e60');
/*!40000 ALTER TABLE `commerce_shippingrules` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzone_countries`
--

LOCK TABLES `commerce_shippingzone_countries` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzone_countries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzone_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzone_states`
--

LOCK TABLES `commerce_shippingzone_states` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzone_states` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzone_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_shippingzones`
--

LOCK TABLES `commerce_shippingzones` WRITE;
/*!40000 ALTER TABLE `commerce_shippingzones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_shippingzones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_states`
--

LOCK TABLES `commerce_states` WRITE;
/*!40000 ALTER TABLE `commerce_states` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_states` VALUES (1,13,'Australian Capital Territory','ACT','2019-01-28 15:03:14','2019-01-28 15:03:14','6ae1bbcc-634e-4f66-add9-32f792703dfc'),(2,13,'New South Wales','NSW','2019-01-28 15:03:14','2019-01-28 15:03:14','23934cf9-4128-44ce-93fe-15fa2f65ec88'),(3,13,'Northern Territory','NT','2019-01-28 15:03:14','2019-01-28 15:03:14','5ff5ba5a-f448-4777-8987-e946506673be'),(4,13,'Queensland','QLD','2019-01-28 15:03:14','2019-01-28 15:03:14','e14cd25e-54cf-4ae5-b90f-120c3f46328b'),(5,13,'South Australia','SA','2019-01-28 15:03:14','2019-01-28 15:03:14','70100fb6-835b-4770-a391-a60999e9ff96'),(6,13,'Tasmania','TAS','2019-01-28 15:03:14','2019-01-28 15:03:14','fcfddb6e-ff45-4b85-938f-a0809994a14c'),(7,13,'Victoria','VIC','2019-01-28 15:03:14','2019-01-28 15:03:14','5afa51e3-bdbb-4396-a3b5-bc0e64b37958'),(8,13,'Western Australia','WA','2019-01-28 15:03:14','2019-01-28 15:03:14','ca83c4ea-fcfd-4b1a-9522-90fba6e4a9b0'),(9,38,'Alberta','AB','2019-01-28 15:03:14','2019-01-28 15:03:14','a983fed2-4d17-437d-9903-ad24c2d0a7dd'),(10,38,'British Columbia','BC','2019-01-28 15:03:14','2019-01-28 15:03:14','3e51f8da-2aea-43a4-96c1-f8d168c80d91'),(11,38,'Manitoba','MB','2019-01-28 15:03:14','2019-01-28 15:03:14','26ffa842-fa11-4b0e-a7ee-68f344d2cb17'),(12,38,'New Brunswick','NB','2019-01-28 15:03:14','2019-01-28 15:03:14','3c441110-0db2-4a8d-bae1-53eca2c929b7'),(13,38,'Newfoundland and Labrador','NL','2019-01-28 15:03:14','2019-01-28 15:03:14','34ae5bc4-3719-4333-b0f2-8480d6a61c1f'),(14,38,'Northwest Territories','NT','2019-01-28 15:03:14','2019-01-28 15:03:14','353039d6-e175-4d5b-9419-4184fc71b8fc'),(15,38,'Nova Scotia','NS','2019-01-28 15:03:14','2019-01-28 15:03:14','42b2c296-b66b-48fc-be1d-a320896e0407'),(16,38,'Nunavut','NU','2019-01-28 15:03:14','2019-01-28 15:03:14','063e5070-176b-4e49-957d-6ea814682495'),(17,38,'Ontario','ON','2019-01-28 15:03:14','2019-01-28 15:03:14','5def3c7a-a30a-489b-b3c6-a91a805564a6'),(18,38,'Prince Edward Island','PE','2019-01-28 15:03:14','2019-01-28 15:03:14','e18d3524-8d7e-4c41-8df2-9c91fc31f2bf'),(19,38,'Quebec','QC','2019-01-28 15:03:14','2019-01-28 15:03:14','c7faa0a1-9553-4ef8-9de0-b872a3a5279c'),(20,38,'Saskatchewan','SK','2019-01-28 15:03:14','2019-01-28 15:03:14','ba52f167-8c88-4a5b-a959-b05b77b24fed'),(21,38,'Yukon','YT','2019-01-28 15:03:14','2019-01-28 15:03:14','95285840-8399-4964-84f4-d591cf5dadb8'),(22,233,'Alabama','AL','2019-01-28 15:03:14','2019-01-28 15:03:14','b334752e-59f5-4ca0-81eb-a363b07667dd'),(23,233,'Alaska','AK','2019-01-28 15:03:14','2019-01-28 15:03:14','eb5d8280-a5c0-4bdb-a139-e2c8f8b22710'),(24,233,'Arizona','AZ','2019-01-28 15:03:14','2019-01-28 15:03:14','c656a4b8-472a-40f2-92ba-c217890a249d'),(25,233,'Arkansas','AR','2019-01-28 15:03:14','2019-01-28 15:03:14','63231072-92ce-4d1e-a27c-63c188083639'),(26,233,'California','CA','2019-01-28 15:03:14','2019-01-28 15:03:14','d226aec0-6737-452e-a759-dcbd0ff23201'),(27,233,'Colorado','CO','2019-01-28 15:03:14','2019-01-28 15:03:14','61687ce0-1473-4585-b8a6-983b8d571471'),(28,233,'Connecticut','CT','2019-01-28 15:03:14','2019-01-28 15:03:14','baba4617-ef36-4fe1-be17-c6d4384ec0b6'),(29,233,'Delaware','DE','2019-01-28 15:03:14','2019-01-28 15:03:14','491f5819-57cd-4f99-a593-ea8e3465989a'),(30,233,'District of Columbia','DC','2019-01-28 15:03:14','2019-01-28 15:03:14','4cb9cfad-0dc0-4655-b350-c59780847e24'),(31,233,'Florida','FL','2019-01-28 15:03:14','2019-01-28 15:03:14','050e1a37-2d9a-4e05-9c7e-a2ec8b6cf258'),(32,233,'Georgia','GA','2019-01-28 15:03:14','2019-01-28 15:03:14','aae89333-72c1-4789-b787-b0a753d897fe'),(33,233,'Hawaii','HI','2019-01-28 15:03:14','2019-01-28 15:03:14','57273011-58a4-4b49-becc-4fcdf5e69a0a'),(34,233,'Idaho','ID','2019-01-28 15:03:14','2019-01-28 15:03:14','d7cf210c-2676-4ee4-85b7-e4c55aacd976'),(35,233,'Illinois','IL','2019-01-28 15:03:14','2019-01-28 15:03:14','690dc7c0-2233-4986-b72b-8ebf43b7fa1a'),(36,233,'Indiana','IN','2019-01-28 15:03:14','2019-01-28 15:03:14','c8f9394c-1654-41aa-84c3-4516d80bfe51'),(37,233,'Iowa','IA','2019-01-28 15:03:14','2019-01-28 15:03:14','e1add533-0c46-4c9b-9e0e-6cd1dd6f6c8c'),(38,233,'Kansas','KS','2019-01-28 15:03:14','2019-01-28 15:03:14','f7d10cca-ac19-4f81-afdc-446920b1b761'),(39,233,'Kentucky','KY','2019-01-28 15:03:14','2019-01-28 15:03:14','9529928e-6534-477f-8e01-1ba71c3e8732'),(40,233,'Louisiana','LA','2019-01-28 15:03:14','2019-01-28 15:03:14','3b39a0ce-b83c-419c-9ba7-f287e0152616'),(41,233,'Maine','ME','2019-01-28 15:03:14','2019-01-28 15:03:14','1109547b-67d5-47fc-a440-03b8aaa6bdf6'),(42,233,'Maryland','MD','2019-01-28 15:03:14','2019-01-28 15:03:14','9f93bb38-ef52-4bc6-a21a-c4f3cce8cfdf'),(43,233,'Massachusetts','MA','2019-01-28 15:03:14','2019-01-28 15:03:14','704763d1-06d9-4f83-a4ff-81cee9cb9acd'),(44,233,'Michigan','MI','2019-01-28 15:03:14','2019-01-28 15:03:14','8476aa02-53ea-4b6f-a519-4b6dc1ee67ba'),(45,233,'Minnesota','MN','2019-01-28 15:03:14','2019-01-28 15:03:14','d1079ace-9a2f-4f8d-af87-c610f6419554'),(46,233,'Mississippi','MS','2019-01-28 15:03:14','2019-01-28 15:03:14','a83b49e5-1a55-4353-998b-54e91744b20d'),(47,233,'Missouri','MO','2019-01-28 15:03:14','2019-01-28 15:03:14','c1664ef0-474e-4077-bf2a-b7ae35ee8394'),(48,233,'Montana','MT','2019-01-28 15:03:14','2019-01-28 15:03:14','31fcdb77-a92b-42dc-8801-25f2c6173941'),(49,233,'Nebraska','NE','2019-01-28 15:03:14','2019-01-28 15:03:14','3d579670-aa14-4e9a-92db-1357469cd0e1'),(50,233,'Nevada','NV','2019-01-28 15:03:14','2019-01-28 15:03:14','d5360c7a-11a3-43b3-a038-7de80774307f'),(51,233,'New Hampshire','NH','2019-01-28 15:03:14','2019-01-28 15:03:14','fbc7b1e0-fe0c-495c-a339-a73585aeaa2a'),(52,233,'New Jersey','NJ','2019-01-28 15:03:14','2019-01-28 15:03:14','aefc8c53-006b-45c2-b690-f361707256c7'),(53,233,'New Mexico','NM','2019-01-28 15:03:14','2019-01-28 15:03:14','b32fbec3-32a1-4641-97a2-0ca7ce7b07b2'),(54,233,'New York','NY','2019-01-28 15:03:14','2019-01-28 15:03:14','372e0a08-e1bd-4f94-ac4c-76ab277c5593'),(55,233,'North Carolina','NC','2019-01-28 15:03:14','2019-01-28 15:03:14','fa26b6f8-ce49-4029-99f1-7f8aa8e9cb8d'),(56,233,'North Dakota','ND','2019-01-28 15:03:14','2019-01-28 15:03:14','e935680a-21a5-44bd-b8b1-bf6392951509'),(57,233,'Ohio','OH','2019-01-28 15:03:14','2019-01-28 15:03:14','076691d4-687c-4118-9f10-fef5d4c43753'),(58,233,'Oklahoma','OK','2019-01-28 15:03:14','2019-01-28 15:03:14','9d18977a-7f16-40ef-8729-37153e2ec84c'),(59,233,'Oregon','OR','2019-01-28 15:03:14','2019-01-28 15:03:14','bda5a72b-50a0-4948-9cd1-919e7d277c9a'),(60,233,'Pennsylvania','PA','2019-01-28 15:03:14','2019-01-28 15:03:14','d8c50fc0-0d2a-4500-b572-7fe157926ca0'),(61,233,'Rhode Island','RI','2019-01-28 15:03:14','2019-01-28 15:03:14','51cd3544-cb74-4a71-ba8f-11011b50b2e3'),(62,233,'South Carolina','SC','2019-01-28 15:03:14','2019-01-28 15:03:14','4eeb9b87-c388-47bc-acd3-da07ff5cfb96'),(63,233,'South Dakota','SD','2019-01-28 15:03:14','2019-01-28 15:03:14','ec07f26f-1b6f-4267-bd08-30d136a32c07'),(64,233,'Tennessee','TN','2019-01-28 15:03:14','2019-01-28 15:03:14','1fb73362-8742-4975-8b61-ad78b688f1a4'),(65,233,'Texas','TX','2019-01-28 15:03:14','2019-01-28 15:03:14','6d5faf4b-ffa3-4840-9b8a-625f8e2e2db5'),(66,233,'Utah','UT','2019-01-28 15:03:14','2019-01-28 15:03:14','8db8214c-5e68-47aa-842e-5234dcc68eb0'),(67,233,'Vermont','VT','2019-01-28 15:03:14','2019-01-28 15:03:14','45061473-d4a6-4e83-ae85-acaa9aad8ae4'),(68,233,'Virginia','VA','2019-01-28 15:03:14','2019-01-28 15:03:14','33d63e28-8af5-4df1-a4eb-c7ad78f0df4d'),(69,233,'Washington','WA','2019-01-28 15:03:14','2019-01-28 15:03:14','c65a1cbe-216e-4c5c-8468-61b54d224030'),(70,233,'West Virginia','WV','2019-01-28 15:03:14','2019-01-28 15:03:14','0fda1ce0-0684-4ce6-aaee-fe84c6fc8439'),(71,233,'Wisconsin','WI','2019-01-28 15:03:14','2019-01-28 15:03:14','d9d02d9f-9fc5-421a-9023-294962f9e283'),(72,233,'Wyoming','WY','2019-01-28 15:03:14','2019-01-28 15:03:14','59abd8f9-c60f-432a-8b52-5d9fa88cba84');
/*!40000 ALTER TABLE `commerce_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_subscriptions`
--

LOCK TABLES `commerce_subscriptions` WRITE;
/*!40000 ALTER TABLE `commerce_subscriptions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxcategories`
--

LOCK TABLES `commerce_taxcategories` WRITE;
/*!40000 ALTER TABLE `commerce_taxcategories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_taxcategories` VALUES (1,'General','general',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:14','09089f3c-8fa5-4dfb-a25a-84c58b747e99');
/*!40000 ALTER TABLE `commerce_taxcategories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxrates`
--

LOCK TABLES `commerce_taxrates` WRITE;
/*!40000 ALTER TABLE `commerce_taxrates` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxrates` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzone_countries`
--

LOCK TABLES `commerce_taxzone_countries` WRITE;
/*!40000 ALTER TABLE `commerce_taxzone_countries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzone_countries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzone_states`
--

LOCK TABLES `commerce_taxzone_states` WRITE;
/*!40000 ALTER TABLE `commerce_taxzone_states` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzone_states` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_taxzones`
--

LOCK TABLES `commerce_taxzones` WRITE;
/*!40000 ALTER TABLE `commerce_taxzones` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_taxzones` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_transactions`
--

LOCK TABLES `commerce_transactions` WRITE;
/*!40000 ALTER TABLE `commerce_transactions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `commerce_transactions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `commerce_variants`
--

LOCK TABLES `commerce_variants` WRITE;
/*!40000 ALTER TABLE `commerce_variants` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `commerce_variants` VALUES (3,2,'ANT-001',1,20.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:16','a5d82f2e-e515-46ee-99c9-de82ba37739d'),(5,4,'PSB-001',1,30.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:16','e0fdf656-20d3-484e-9fc2-d93c4dcc99b3'),(7,6,'RRE-001',1,40.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:16','dd730c4a-d9b5-412a-a93e-360ffc86c352'),(9,8,'TFA-001',1,50.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:16','d58392ca-c862-401b-922f-c98cab069bcc'),(11,10,'LKH-001',1,60.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:03:14','2019-01-28 15:03:16','51d53537-8069-4305-bd1e-b133f238abf1'),(13,12,'ALW-12',1,24.0000,1,NULL,NULL,NULL,NULL,0,1,NULL,NULL,'2019-01-28 15:10:57','2019-01-28 15:11:53','c2b6a615-ec0f-46c7-99bd-767814b33a58');
/*!40000 ALTER TABLE `commerce_variants` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,NULL,'2019-01-25 22:37:20','2019-01-25 22:37:20','64bcd50e-4cc1-4422-8978-fd8b9b33ed76'),(2,2,1,'A New Toga','2019-01-28 15:03:14','2019-01-28 15:03:16','ff697a70-7ccd-4ce1-9fad-aaa5b7ad0a9a'),(3,3,1,'A New Toga','2019-01-28 15:03:14','2019-01-28 15:03:16','6c328817-2980-4293-9269-f94aed4b4d4f'),(4,4,1,'Parka With Stripes On Back','2019-01-28 15:03:14','2019-01-28 15:03:16','e859a440-f110-428d-9c6a-e0d5bd76d8ff'),(5,5,1,'Parka With Stripes On Back','2019-01-28 15:03:14','2019-01-28 15:03:16','d2152f31-d143-4f2a-bed7-ab4c48aef62e'),(6,6,1,'Romper For A Red Eye','2019-01-28 15:03:14','2019-01-28 15:03:16','a9091f3e-4e93-4dd1-ae47-0f0de86d3074'),(7,7,1,'Romper For A Red Eye','2019-01-28 15:03:14','2019-01-28 15:03:16','366aba04-908a-4ea7-9fa1-48e78175ba05'),(8,8,1,'The Fleece Awakens','2019-01-28 15:03:14','2019-01-28 15:03:16','962971b7-1497-4e38-b9db-efd25392e8d7'),(9,9,1,'The Fleece Awakens','2019-01-28 15:03:14','2019-01-28 15:03:16','7c51388a-ac1e-4a7b-bcd0-4061347b775d'),(10,10,1,'The Last Knee-High','2019-01-28 15:03:14','2019-01-28 15:03:16','0d30047e-ec15-4d8f-b31d-d4c77cc6e2b9'),(11,11,1,'The Last Knee-High','2019-01-28 15:03:14','2019-01-28 15:03:16','7f7ca98d-7026-4303-ac5c-b8869c9d8fdc'),(12,12,1,'ALWAYS METAL SIGN','2019-01-28 15:10:57','2019-01-28 15:11:53','dcfec58a-3e72-45c8-a96e-b202029d99ac'),(13,13,1,'ALWAYS METAL SIGN','2019-01-28 15:10:57','2019-01-28 15:11:53','e458158e-9a23-4be4-9e26-5f779f343377');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-01-25 22:37:19','2019-01-25 22:37:19',NULL,'85a16631-b674-4ed8-873a-dc35f6c27fea'),(2,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'66f76484-3cf0-48b9-8e94-6d5298e44e4b'),(3,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'d89004c0-a167-472b-9093-22ad70684eb1'),(4,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'58b5c357-550f-4850-b604-621b1e9b20a4'),(5,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'7d2e89c2-fab4-4b35-aecf-e66f12bfee8d'),(6,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'8f3f33c0-a1eb-4610-920e-4eefaf895b69'),(7,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'91f72faf-40af-4c3c-9f2f-1e3f9893004f'),(8,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'e0478d31-e55b-46fe-9444-c9102b9806e5'),(9,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'5599ff57-cbf1-4b4f-94a5-1dd7ff3019e7'),(10,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'cab0456a-2eac-4606-a463-6494bf340e53'),(11,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:03:14','2019-01-28 15:03:16',NULL,'ca4dc143-dad6-4600-a2ce-d77f870dc867'),(12,NULL,'craft\\commerce\\elements\\Product',1,0,'2019-01-28 15:10:57','2019-01-28 15:11:53',NULL,'d34e0f2f-6633-488d-b980-1ead0844202a'),(13,NULL,'craft\\commerce\\elements\\Variant',1,0,'2019-01-28 15:10:57','2019-01-28 15:11:53',NULL,'37ca4075-9878-4473-82a7-bc9ea8241ba1');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-01-25 22:37:20','2019-01-25 22:37:20','b7bbf693-9bb4-4ad1-8de3-daa91ec492b6'),(2,2,1,'ant-001','shop/products/ant-001',1,'2019-01-28 15:03:14','2019-01-28 15:03:16','f9a44e58-8764-4be7-a108-a8b3f936afd1'),(3,3,1,'ant-001',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:16','df207c59-ed5e-4dee-894b-403111084fc5'),(4,4,1,'psb-001','shop/products/psb-001',1,'2019-01-28 15:03:14','2019-01-28 15:03:16','fe9b5193-981b-4134-aa9c-2c508d87c0b5'),(5,5,1,'psb-001',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:16','e96540e5-66c3-4717-86e7-a48ba60471d0'),(6,6,1,'rre-001','shop/products/rre-001',1,'2019-01-28 15:03:14','2019-01-28 15:03:16','7e767f7a-5d3a-4c46-a3ac-bda288b7b18e'),(7,7,1,'rre-001',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:16','2c0628bb-935a-4cbf-8c05-587c05560aa1'),(8,8,1,'tfa-001','shop/products/tfa-001',1,'2019-01-28 15:03:14','2019-01-28 15:03:16','876865b3-bcdb-4b76-9443-c9ed354a715c'),(9,9,1,'tfa-001',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:16','02cf5a32-d59f-4276-8004-f0aab9f4de75'),(10,10,1,'lkh-001','shop/products/lkh-001',1,'2019-01-28 15:03:14','2019-01-28 15:03:16','a87989dd-64ae-4036-b495-6700ac6eb19e'),(11,11,1,'lkh-001',NULL,1,'2019-01-28 15:03:14','2019-01-28 15:03:16','939c5360-9a33-44b4-ab34-ebf56c514935'),(12,12,1,'always-metal-sign','shop/products/always-metal-sign',1,'2019-01-28 15:10:57','2019-01-28 15:11:53','c91b4434-a171-4f59-bb86-84418f6de2d2'),(13,13,1,NULL,NULL,1,'2019-01-28 15:10:57','2019-01-28 15:11:53','f06c9947-c958-49ed-89f3-5beef47f6b5f');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrydrafts`
--

LOCK TABLES `entrydrafts` WRITE;
/*!40000 ALTER TABLE `entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entryversions`
--

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2019-01-25 22:37:19','2019-01-25 22:37:19','27401402-c455-4167-aa68-d4957d561113');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\commerce\\elements\\Order','2019-01-28 15:03:14','2019-01-28 15:03:14',NULL,'80369162-8f3b-492a-ae5c-fc8098cee6bf'),(2,'craft\\commerce\\elements\\Product','2019-01-28 15:03:14','2019-01-28 15:03:14',NULL,'0c6677f8-0841-4788-aece-bb43628cad21'),(3,'craft\\commerce\\elements\\Variant','2019-01-28 15:03:14','2019-01-28 15:03:14',NULL,'c216daf9-7290-4959-8d2f-09e1ab291312');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.1.5','3.1.23',0,'a:9:{s:5:\"email\";a:3:{s:9:\"fromEmail\";s:16:\"test@example.com\";s:8:\"fromName\";s:27:\"Craft Commerce Search Issue\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:11:\"fieldGroups\";a:1:{s:36:\"27401402-c455-4167-aa68-d4957d561113\";a:1:{s:4:\"name\";s:6:\"Common\";}}s:10:\"siteGroups\";a:1:{s:36:\"9f3f64a5-fd1c-4d9a-86fc-5db57dae119a\";a:1:{s:4:\"name\";s:27:\"Craft Commerce Search Issue\";}}s:5:\"sites\";a:1:{s:36:\"5fe5e661-b07a-4880-b9f2-e123ff4ab758\";a:8:{s:7:\"baseUrl\";s:4:\"@web\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:5:\"en-US\";s:4:\"name\";s:27:\"Craft Commerce Search Issue\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"9f3f64a5-fd1c-4d9a-86fc-5db57dae119a\";s:9:\"sortOrder\";i:1;}}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"live\";b:1;s:4:\"name\";s:27:\"Craft Commerce Search Issue\";s:13:\"schemaVersion\";s:6:\"3.1.23\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:12:\"photoSubpath\";s:0:\"\";s:14:\"photoVolumeUid\";N;s:24:\"requireEmailVerification\";b:1;}s:12:\"dateModified\";i:1548687794;s:8:\"commerce\";a:3:{s:13:\"orderStatuses\";a:2:{s:36:\"8492ea7a-f6a3-4ccf-825b-80e7690a75c2\";a:6:{s:4:\"name\";s:3:\"New\";s:6:\"handle\";s:3:\"new\";s:5:\"color\";s:5:\"green\";s:9:\"sortOrder\";N;s:7:\"default\";b:1;s:6:\"emails\";a:0:{}}s:36:\"848867d7-12f3-47d4-ba46-10031d51026d\";a:6:{s:4:\"name\";s:7:\"Shipped\";s:6:\"handle\";s:7:\"shipped\";s:5:\"color\";s:4:\"blue\";s:9:\"sortOrder\";N;s:7:\"default\";b:0;s:6:\"emails\";a:0:{}}}s:12:\"productTypes\";a:1:{s:36:\"3ac51e77-a5b2-4288-b834-a5d41336feb8\";a:11:{s:4:\"name\";s:8:\"Clothing\";s:6:\"handle\";s:8:\"clothing\";s:13:\"hasDimensions\";b:1;s:11:\"hasVariants\";b:0;s:20:\"hasVariantTitleField\";b:0;s:11:\"titleFormat\";s:15:\"{product.title}\";s:9:\"skuFormat\";s:0:\"\";s:17:\"descriptionFormat\";s:0:\"\";s:12:\"siteSettings\";a:1:{s:36:\"5fe5e661-b07a-4880-b9f2-e123ff4ab758\";a:3:{s:7:\"hasUrls\";b:1;s:9:\"uriFormat\";s:20:\"shop/products/{slug}\";s:8:\"template\";s:22:\"shop/products/_product\";}}s:19:\"productFieldLayouts\";a:0:{}s:19:\"variantFieldLayouts\";a:0:{}}}s:8:\"gateways\";a:1:{s:36:\"fb31884e-93ca-4c52-acbe-0e70f5189a11\";a:7:{s:4:\"name\";s:5:\"Dummy\";s:6:\"handle\";s:5:\"dummy\";s:4:\"type\";s:29:\"craft\\commerce\\gateways\\Dummy\";s:8:\"settings\";a:0:{}s:9:\"sortOrder\";N;s:11:\"paymentType\";s:8:\"purchase\";s:17:\"isFrontendEnabled\";b:1;}}}s:7:\"plugins\";a:1:{s:8:\"commerce\";a:3:{s:7:\"edition\";s:4:\"lite\";s:7:\"enabled\";b:1;s:13:\"schemaVersion\";s:6:\"2.0.57\";}}}','{\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"dateModified\":\"@config/project.yaml\",\"commerce\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\"}','2vJBxmqWmxxY','2019-01-25 22:37:19','2019-01-28 15:03:14','54ff1a4e-f775-4357-8234-c7baf38242a0');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','df7a2b83-4164-468d-93b3-30e3259b5f86'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','74284556-fce5-4e35-aa95-5c4adca6c613'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c7c7cc5e-33f6-4c56-886f-952c559a5d4b'),(4,NULL,'app','m150403_184533_field_version','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','de40bfde-cea8-4b79-b7cb-f3027dbef4e7'),(5,NULL,'app','m150403_184729_type_columns','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','04586dcb-ffb8-4c47-8e02-0a9a87748f17'),(6,NULL,'app','m150403_185142_volumes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','2ddcec58-d750-4276-835d-dfec3a07a28d'),(7,NULL,'app','m150428_231346_userpreferences','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','86bfcd46-4dfa-41aa-9a43-d928ecbde508'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','118ca929-5d88-4258-b607-42eaae2d5104'),(9,NULL,'app','m150617_213829_update_email_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','fc4b8667-e74c-4686-90e4-3aba1b71ae21'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','bb70e351-d2d5-4f78-8181-245ffb9c9ee1'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','085a0ddd-654f-4f03-9631-a3298948e554'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','363a7379-6066-403f-906e-274ecbca0147'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c7e030fb-0f50-414d-8e9c-2e822ba3b240'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','2a332094-08d4-4bc3-8411-db6d8fecef68'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','88b3b403-9693-42e1-9e13-19f15343c642'),(16,NULL,'app','m151209_000000_move_logo','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','65217cdd-21f0-4a9f-b949-ee75d314ed83'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','bb6cf8d3-1e4f-436e-8ffe-98e9d7b724a7'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','d7095576-4dac-4327-904a-ed2c061259a3'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','34bdad13-503e-4b09-a763-89e28315a659'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','8878f40b-089f-4744-92d4-ff92dc8c5152'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c2e6ee17-5fc3-4d47-9c57-f15d3853a013'),(22,NULL,'app','m160727_194637_column_cleanup','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','413b15d2-f4d4-438d-a358-e0e88bd292e7'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','3e6a22b1-2a5d-4d50-9604-0cb8e6bd1bef'),(24,NULL,'app','m160807_144858_sites','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','30c55b67-5cfe-42b1-a2f2-883b25a9f103'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','917e7d10-91fd-45b2-ad87-2abac8b3b295'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','76d0ac31-3429-4704-bdc1-fd03224b1e10'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','58ed1c22-84bb-4e05-bf62-203d0385bb67'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','dfdec2ce-a763-4476-b047-315fade361e6'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5573c9cc-6101-4f20-a948-cc6ac81b4812'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','4637fc59-074a-4aed-bb5c-40cfb5e5b7d9'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','df29bc58-d5f8-488c-9591-0a57cec10b00'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','a18f80eb-d5dc-44ac-8073-8caa14b4c8c2'),(33,NULL,'app','m161007_130653_update_email_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','090723d3-00a5-4294-8fcd-bdffb56f6ff8'),(34,NULL,'app','m161013_175052_newParentId','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','a35e3e68-5736-40ed-a45b-2661a2d75c35'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5f4f509e-fbef-4385-8594-0b025d282a07'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','3f498d71-2122-442f-b99c-52797e00f9b9'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','40cb5e6b-2947-4092-be61-17653e06a151'),(38,NULL,'app','m161029_124145_email_message_languages','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','ad355b0b-f1a8-4c88-ab2c-b9d64aedbbf7'),(39,NULL,'app','m161108_000000_new_version_format','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','47696977-78be-4d68-9c8d-a827d9d3db65'),(40,NULL,'app','m161109_000000_index_shuffle','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','88f40656-b3fe-4e94-91b1-f9941c905b8b'),(41,NULL,'app','m161122_185500_no_craft_app','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5c122979-49a1-4c16-bcdb-7817a75114e6'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','a93ded53-b0d3-4334-8d2c-c6e126c0cfd8'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','4979f6e4-d7df-4226-81bd-d99488901b08'),(44,NULL,'app','m170114_161144_udates_permission','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','66ad48d9-2a44-4795-be42-131a6f589c83'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','16c1ae7a-0c7b-44c7-bbe5-1e2bf3a09473'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9427f12a-ce28-4f7d-a386-f102f3f5a680'),(47,NULL,'app','m170206_142126_system_name','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','f8e39b81-d103-400a-8dbe-2280f423a705'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c6c4b45b-81a0-4af7-9e6d-f44490081266'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','e0e3cb33-e80e-4ebf-ab8b-c5b56dbc42a5'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','efcfedef-34ae-4e3a-a1a9-c9488d2fa7d5'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','468f99c0-3a85-439f-ac8a-78ed3d13b2fe'),(52,NULL,'app','m170228_171113_system_messages','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9083cb89-786d-441f-a7fa-dbdbbf3a6405'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','08937131-6bf8-4516-afce-186f6833037a'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','3cf3ea69-928f-4d2d-80db-581a1629c047'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','eab6e18f-bb49-44dc-897d-b7b19ccd4df1'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','f3d58a9f-dece-4427-ba3f-bf22942f9631'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','a5682714-8555-4371-a21b-245f42f2bcf8'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','387d9e08-e5ea-4f8a-86c0-12be42b99c5f'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','6e368f64-508f-4ea5-8f07-348497394f91'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','d761629b-23d9-43a2-a208-493ded507643'),(61,NULL,'app','m170704_134916_sites_tables','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c6cffb19-6d59-4597-9eb5-86e7afb551c4'),(62,NULL,'app','m170706_183216_rename_sequences','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','97586713-4d9f-41e7-84fb-35ec7f72b84e'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','187c639e-9480-453f-8e41-6c9ee1799296'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','734d55d5-806a-4722-a5be-e6439a807681'),(65,NULL,'app','m170810_201318_create_queue_table','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','90a3039b-c751-4e60-984d-f857c2f67289'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','e63e2e46-54e9-41ff-8aa2-5d9ee72ad9bb'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','1a30535a-2202-4284-8536-bb237929eb10'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9ed5fcca-2432-42df-a421-7e5b39848033'),(69,NULL,'app','m171011_214115_site_groups','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5f96258f-42c5-495c-b2b1-81a0f66f6c03'),(70,NULL,'app','m171012_151440_primary_site','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','96af95e0-3664-4844-8fd7-93e77620a7ce'),(71,NULL,'app','m171013_142500_transform_interlace','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','de3be9c5-f5a3-4f60-bc9d-b17a0cd8e76a'),(72,NULL,'app','m171016_092553_drop_position_select','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','8c09d256-5d82-4b3e-a3a3-7a825c4159f8'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9c34266b-b4d1-4580-9124-3547253ecd51'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','dc9da4a8-b5ad-40bd-8323-dfb6667b6c5c'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','0ff7bf1e-7bef-4629-bd44-7bb833ce67ec'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','32a4aaaa-0ffb-4852-bd0b-0a52cacad6e2'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','91eded62-75c4-4ca8-9303-39d0e30baec8'),(78,NULL,'app','m171202_004225_update_email_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','d4cd3359-59e4-4cc6-b6dc-3ca27c7b3c68'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','dbda3775-56a1-4964-82e6-0d6e20892bc9'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','eedb63f6-17f6-4476-81bf-bd4242b167e4'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','4f9529a6-129c-4c17-986c-3faee91b1578'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c6dfc4b7-9bf5-4a04-8418-acaa871fc7ad'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','e7567b73-be2c-49e7-a2b0-df6d5475f10a'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','1019a476-1bff-41d4-b231-389e11d6a312'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5b4aace8-7d3b-4e43-a2e0-3c8f4d606e7c'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','993ec2da-8590-41ca-95c1-8523f2361df1'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','ca729b70-25a5-4d4c-8648-410354c93933'),(88,NULL,'app','m180217_172123_tiny_ints','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','81528ea8-9604-4037-b87d-adf49e6560a7'),(89,NULL,'app','m180321_233505_small_ints','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','2b191ff8-5bba-41c4-897d-0c7de76b1a19'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','d7b8e9dc-8b17-48f3-8c8a-54661f7bfa1b'),(91,NULL,'app','m180404_182320_edition_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','84263cb8-1b52-4f7a-abe1-c0ff731fc591'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','60bdb8a5-cba8-43d6-af9d-8041e0004757'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','edd2748e-05ea-45b0-81cc-dece2da5f7fa'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','87a15504-7cf9-4f05-84a6-bbe1f2f49afc'),(95,NULL,'app','m180425_203349_searchable_fields','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','f07cfe77-573b-4383-ad22-6bf65821aae7'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5b1293ca-f0f4-42d3-87dd-801b31d17ae7'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9d3847bf-9f8d-4e4d-85a0-4c23dd000823'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','01335d32-e884-45a1-9411-f43589b63fba'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','130e3b4f-88b0-45c6-a272-d37888c10c41'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','8ad64a78-9f6d-458e-ba9c-47b18d917338'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5d938854-4171-4c32-a11a-cfee7ccc4da4'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','bf8addd9-aa80-40e3-9581-636e4c0c3fe4'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','f79a980c-d6ec-4b98-8a21-86f565b11be1'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5cc90fa7-dbc5-4fdc-a3eb-45c9e64c633c'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','8109b21c-b983-401d-9d12-1fe69744679d'),(106,NULL,'app','m180904_112109_permission_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','0f52e938-d480-4c43-ad04-94a756dcda6d'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','db47911e-4776-4e34-a4e1-5f3d49a7879e'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','0cd2a199-884c-4b71-95c1-78b499a98fd0'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','252e7f56-4e30-468c-8854-a84aa65da6d7'),(110,NULL,'app','m181017_225222_system_config_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','384048b1-2690-48e3-b4fd-0a73950c2c46'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','2ca8c84c-82c5-464f-994e-4d8b50feae24'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','a4e58863-aac6-415b-a0af-cd77b6db5e2c'),(113,NULL,'app','m181112_203955_sequences_table','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5452ef41-bc1b-4d0d-a88a-6e7a06b1f2c4'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','cf0efcd4-f230-4b4a-add9-1a9c4cb2ebd5'),(115,NULL,'app','m181128_193942_fix_project_config','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5d3753c5-ffe2-4a8f-8cef-dcca77761ac7'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','f91de8f1-1b06-4a3a-be76-0ee626fe209c'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','d139eca1-7059-4d55-a0b2-f4de31546da5'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','1ea64439-83f9-41be-ba86-62c59f370e2b'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','fd460031-5139-4352-8276-674ecfee7fd8'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','3c93f39c-ee06-4bd8-a160-c466dabb0a42'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','facdae60-2f18-48a4-a825-0016dca6d6e0'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9c82fec1-93e4-47d9-8657-1740f439d941'),(123,NULL,'app','m190109_172845_fix_colspan','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','c1a6fefb-da50-4a40-824f-e0741ea97f7d'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','5c2d434c-d0c7-4381-b492-47f56ffc4783'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','6f2bc687-c277-42db-8b14-c2f7dd82f0a5'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','e159dbe3-fb72-4e25-ab79-61a629b32a2f'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','95e3204d-e085-41e1-bc61-0fe438081567'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','7f1fc87a-cdf2-455b-b2ce-5c6666e592ce'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','9da9aad5-770a-49f3-bb76-b3ba64ff7223'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','6970a9c8-d9bd-4b28-8367-5a8fe9766ae0'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','85603738-fe89-4b72-b758-e8ac64cc8e72'),(132,NULL,'app','m190218_143000_element_index_settings_uid','2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-25 22:37:20','8e018c6a-fb51-4753-8ab2-0983e49bc176'),(133,1,'plugin','Install','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','07e36414-24e0-4be6-84c8-2698aa72061e'),(134,1,'plugin','m160531_154500_craft3_upgrade','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','e3207577-41e4-4579-9901-77f50f3fffa3'),(135,1,'plugin','m170616_154500_productTypeSites_upgrade','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','71687425-9f63-408a-ac4d-fb6bddfa2ae5'),(136,1,'plugin','m170705_154500_i18n_to_sites','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','55ba9f65-6d8b-4d86-8796-82cd7d1d05d2'),(137,1,'plugin','m170705_155000_order_shippingmethod_to_shippingmethodhandle','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','b8de4c92-b107-4742-99b4-ec3576e6b6cc'),(138,1,'plugin','m170718_150000_paymentmethod_class_to_type','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','388cbb68-5da0-4aef-8f53-fdc8f52b0fa7'),(139,1,'plugin','m170725_130000_paymentmethods_are_now_gateways','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','1678ab45-f899-428a-a647-0b2ecf66ef94'),(140,1,'plugin','m170810_130000_sendCartInfo_per_gateway','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','02fe7a55-6084-4b14-8dc6-b2fb3ca3930c'),(141,1,'plugin','m170828_130000_transaction_gatewayProcessing_flag','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','fc8db827-0b22-401d-827b-460da5cbe1a5'),(142,1,'plugin','m170830_130000_order_refactor','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','9aa1698c-754b-4587-9b3d-1420a3669d7f'),(143,1,'plugin','m170831_130000_paymentCurreny_primary_not_null','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','4a9875c2-348f-4f44-adda-32a5b938c1fe'),(144,1,'plugin','m170904_130000_processing_transactions','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','4e28d542-9203-4858-8721-47c949824f7d'),(145,1,'plugin','m171010_170000_stock_location','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','c9d8ff86-efcc-4ecd-84cb-510f518f3a66'),(146,1,'plugin','m171202_180000_promotions_for_all_purchasables','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','1fcf4ffb-7f30-46ba-a2be-f99397901029'),(147,1,'plugin','m171204_213000_payment_sources','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','ef06eff4-fbef-4166-a378-26728b168d28'),(148,1,'plugin','m171207_160000_order_can_store_payment_sources','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','0e01e4d8-2ae9-4e6b-ac9b-9932ad9f56f2'),(149,1,'plugin','m171221_120000_subscriptions','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','1bc493c2-1ab4-432d-a838-952009d8793e'),(150,1,'plugin','m171221_120500_missing_indexes','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','cb94d29a-a9c5-42df-98a3-2927592ffa00'),(151,1,'plugin','m180205_150646_create_state_abbreviation_index','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','77da13a7-bd0a-4afa-8826-347f8f2ba2c8'),(152,1,'plugin','m180209_115000_plan_description','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','75c9f5f7-7252-4f4c-ba85-7c9cd301eaa3'),(153,1,'plugin','m180216_130000_rename_store_location','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','e13c7794-fc04-46e5-a927-c9a147aabd23'),(154,1,'plugin','m180217_130000_sale_migration','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','dd60f726-e2dc-43a3-a981-afb91d0c29b9'),(155,1,'plugin','m180218_130000_sale_order','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','14bb0634-e4b4-40b0-bda0-2831f3c36275'),(156,1,'plugin','m180219_130000_sale_can_stop_processing','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','03dcdfd4-796e-4a83-ba98-95ecd7d05a2d'),(157,1,'plugin','m180220_130000_sale_can_ignore_previous','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','86142a2e-ab9e-405b-8777-812442915203'),(158,1,'plugin','m180221_130000_sale_fixSort','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','eb3c7fa0-ffdf-4976-b419-7f7d45a0f9a4'),(159,1,'plugin','m180222_130000_lineitemsubtotal','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','c6e7d597-25f9-4625-bb80-dafd0f0ec202'),(160,1,'plugin','m180306_130000_renamed','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','b3de084b-acbd-4336-a135-06110122b770'),(161,1,'plugin','m180307_130000_order_paid_status','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','0f84d761-1a77-450f-9c05-6b66ecc5096a'),(162,1,'plugin','m180308_130000_update_order_paid_status','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','ca4708a9-c4f5-4f25-8fef-2316e605041b'),(163,1,'plugin','m180308_130001_has_and_is','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','e3631123-31ab-4f3e-9a2f-09dbbeaaae79'),(164,1,'plugin','m180312_130001_countryBased','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','8e46f410-2279-4915-8216-cb833d5acd1c'),(165,1,'plugin','m180319_130001_fieldSettings','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','34ab92df-7892-496c-8d82-e63b3d0b1029'),(166,1,'plugin','m180326_130001_cascadeDeleteVariants','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','1238bb6f-f582-4586-8c43-5c43e7f9a89d'),(167,1,'plugin','m180329_161901_gateway_send_cart_info','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','31332d65-38b9-4514-a3a8-414c8d5fe4e9'),(168,1,'plugin','m180401_150701_primary_addresses','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','833cb35e-1351-4c6a-810d-65655167122d'),(169,1,'plugin','m180401_161901_first_last_name_optional','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','94726089-e639-4037-98d2-846c1e799de1'),(170,1,'plugin','m180402_161901_increase_size_of_snapshot','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','d06639f1-51c5-4a69-a5b1-5cbd4601c3f0'),(171,1,'plugin','m180402_161902_email_discount_usage','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','7a47944d-778b-43cd-bb1c-9e57721d969d'),(172,1,'plugin','m180402_161903_primary_customer_addresses_relations','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','9400560e-65b9-49ef-9fdb-8195d5beaf3a'),(173,1,'plugin','m180402_161904_order_addresses_relations','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','d0270564-7be0-4487-b296-9388e1fcddca'),(174,1,'plugin','m180417_161904_fix_purchasables','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','64b32895-692e-4a5e-b83e-3f99a0bbc60f'),(175,1,'plugin','m180421_161904_transaction_note','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','f68cab68-5be2-481b-a254-85ef029baf1d'),(176,1,'plugin','m180525_161904_available_for_purchase','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','6dc1f1c8-029a-4847-84b0-7a97b53bec2e'),(177,1,'plugin','m180601_161904_fix_orderLanguage','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','481bf8f3-549b-4a3f-9bf1-013fb3bf77ad'),(178,1,'plugin','m180620_161904_fix_primaryAddressCascade','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','5c0afb98-a91c-4569-a138-492cf0c0181c'),(179,1,'plugin','m180718_161906_add_orderPdfAttachment','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','20a69b20-2b66-4251-b732-91f2c2adc1b5'),(180,1,'plugin','m180818_161906_fix_discountPurchasableType','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','01aed569-a1ae-4d33-b2c9-e08995a2fe25'),(181,1,'plugin','m180818_161907_fix_orderPaidWithAddresses','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','3a476621-0c3a-482b-9a46-84c78d994277'),(182,1,'plugin','m180918_161907_fix_uniqueEmailDiscountsUses','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','a813ea6b-5025-46da-9b61-6ab542b341b2'),(183,1,'plugin','m180918_161908_fix_messageLengthOnOrder','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','669715ab-5622-465d-a25f-3d597bf9a060'),(184,1,'plugin','m181024_100600_gateway_project_config_support','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','25eb86e8-79b3-4a2d-ada6-efc2387b99f3'),(185,1,'plugin','m181113_161908_addReferenceToOrder','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','82f86808-982f-480b-a049-194852cd27ad'),(186,1,'plugin','m181119_100600_lite_shipping_and_tax','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','077cdba7-737c-4d06-b8ac-c7eb94dc0752'),(187,1,'plugin','m181203_130000_order_status_archivable','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','2a34cbde-75c7-472c-a7a6-2b4507ffae57'),(188,1,'plugin','m181203_162000_gateway_unique_index_drop','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','641de66f-87e0-457a-a549-287a27dff7cc'),(189,1,'plugin','m181206_120000_remaining_project_config_support','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','ffbfff12-b318-40db-a0dd-e4fad2d285ab'),(190,1,'plugin','m181221_120000_sort_order_for_plans','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','96f72fa5-6f1f-4772-9c87-38fc0d2335b0'),(191,1,'plugin','m190109_223402_set_edition','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','ef3132b0-b899-486c-b0aa-8ae1be0a1c7e'),(192,1,'plugin','m190111_161909_lineItemTotalCanBeNegative','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','145ce167-1078-497a-b0da-582399943b39'),(193,1,'plugin','m190117_161909_replace_product_ref_tags','2019-01-28 15:03:14','2019-01-28 15:03:14','2019-01-28 15:03:14','e9bf0bf9-a368-4970-b57b-c04abef3f928');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'commerce','2.0.2','2.0.57','invalid',NULL,'2019-01-28 15:03:10','2019-01-28 15:03:10','2019-01-28 15:14:13','975f6fbf-5ca7-4bcc-8901-2ed21aede12b');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('1e719e28','@craft/web/assets/updateswidget/dist'),('20cbdc46','@craft/web/assets/recententries/dist'),('22062f0','@lib/selectize'),('29089a19','@craft/web/assets/updater/dist'),('37b37e0f','@lib/timepicker'),('3f0ce66f','@craft/commerce/web/assets/commercecp/dist'),('40f47b9','@craft/web/assets/cp/dist'),('4eb64e8a','@lib/fileupload'),('51fa73b6','@lib/jquery-touch-events'),('565e4f74','@lib/picturefill'),('58fb6f25','@lib/d3'),('5efd7f73','@craft/web/assets/utilities/dist'),('6b4678a3','@lib/garnishjs'),('7e00ac9d','@lib/fabric'),('84c267a','@lib/xregexp'),('85d21f2b','@lib/jquery-ui'),('86405699','@craft/commerce/web/assets/editproduct/dist'),('86c85565','@craft/web/assets/feed/dist'),('b1dbdfec','@craft/web/assets/login/dist'),('b34a4f2d','@craft/web/assets/dbbackup/dist'),('b9dd6821','@craft/web/assets/craftsupport/dist'),('cb7b848e','@lib/velocity'),('d7477c4','@craft/web/assets/pluginstore/dist'),('d75c2b66','@lib/jquery.payment'),('d7cfcc9d','@craft/commerce/web/assets/productindex/dist'),('daf473f3','@bower/jquery/dist'),('e2deb20b','@lib'),('f564d806','@lib/element-resize-detector'),('ff8b73ae','@craft/web/assets/dashboard/dist');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' admin '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' test example com '),(1,'slug',0,1,''),(3,'sku',0,1,' ant 001 '),(3,'price',0,1,' 20 0000 '),(3,'width',0,1,''),(3,'height',0,1,''),(3,'length',0,1,''),(3,'weight',0,1,''),(3,'stock',0,1,' 0 '),(3,'hasunlimitedstock',0,1,' 1 '),(3,'minqty',0,1,''),(3,'maxqty',0,1,''),(3,'slug',0,1,' ant 001 '),(3,'title',0,1,' a new toga '),(2,'title',0,1,' a new toga '),(2,'defaultsku',0,1,' ant 001 '),(2,'sku',0,1,' ant 001 '),(2,'slug',0,1,' ant 001 '),(5,'sku',0,1,' psb 001 '),(5,'price',0,1,' 30 0000 '),(5,'width',0,1,''),(5,'height',0,1,''),(5,'length',0,1,''),(5,'weight',0,1,''),(5,'stock',0,1,' 0 '),(5,'hasunlimitedstock',0,1,' 1 '),(5,'minqty',0,1,''),(5,'maxqty',0,1,''),(5,'slug',0,1,' psb 001 '),(5,'title',0,1,' parka with stripes on back '),(4,'title',0,1,' parka with stripes on back '),(4,'defaultsku',0,1,' psb 001 '),(4,'sku',0,1,' psb 001 '),(4,'slug',0,1,' psb 001 '),(7,'sku',0,1,' rre 001 '),(7,'price',0,1,' 40 0000 '),(7,'width',0,1,''),(7,'height',0,1,''),(7,'length',0,1,''),(7,'weight',0,1,''),(7,'stock',0,1,' 0 '),(7,'hasunlimitedstock',0,1,' 1 '),(7,'minqty',0,1,''),(7,'maxqty',0,1,''),(7,'slug',0,1,' rre 001 '),(7,'title',0,1,' romper for a red eye '),(6,'title',0,1,' romper for a red eye '),(6,'defaultsku',0,1,' rre 001 '),(6,'sku',0,1,' rre 001 '),(6,'slug',0,1,' rre 001 '),(9,'sku',0,1,' tfa 001 '),(9,'price',0,1,' 50 0000 '),(9,'width',0,1,''),(9,'height',0,1,''),(9,'length',0,1,''),(9,'weight',0,1,''),(9,'stock',0,1,' 0 '),(9,'hasunlimitedstock',0,1,' 1 '),(9,'minqty',0,1,''),(9,'maxqty',0,1,''),(9,'slug',0,1,' tfa 001 '),(9,'title',0,1,' the fleece awakens '),(8,'title',0,1,' the fleece awakens '),(8,'defaultsku',0,1,' tfa 001 '),(8,'sku',0,1,' tfa 001 '),(8,'slug',0,1,' tfa 001 '),(11,'sku',0,1,' lkh 001 '),(11,'price',0,1,' 60 0000 '),(11,'width',0,1,''),(11,'height',0,1,''),(11,'length',0,1,''),(11,'weight',0,1,''),(11,'stock',0,1,' 0 '),(11,'hasunlimitedstock',0,1,' 1 '),(11,'minqty',0,1,''),(11,'maxqty',0,1,''),(11,'slug',0,1,' lkh 001 '),(11,'title',0,1,' the last knee high '),(10,'title',0,1,' the last knee high '),(10,'defaultsku',0,1,' lkh 001 '),(10,'sku',0,1,' lkh 001 '),(10,'slug',0,1,' lkh 001 '),(13,'sku',0,1,' alw 12 '),(13,'price',0,1,' 24 '),(13,'width',0,1,''),(13,'height',0,1,''),(13,'length',0,1,''),(13,'weight',0,1,''),(13,'stock',0,1,' 0 '),(13,'hasunlimitedstock',0,1,' 1 '),(13,'minqty',0,1,''),(13,'maxqty',0,1,''),(13,'slug',0,1,''),(13,'title',0,1,' always metal sign '),(12,'title',0,1,' always metal sign '),(12,'defaultsku',0,1,' alw 12 '),(12,'sku',0,1,' alw 12 '),(12,'slug',0,1,' always metal sign ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Craft Commerce Search Issue','2019-01-25 22:37:19','2019-01-25 22:37:19',NULL,'9f3f64a5-fd1c-4d9a-86fc-5db57dae119a');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Craft Commerce Search Issue','default','en-US',1,'@web',1,'2019-01-25 22:37:19','2019-01-25 22:37:19',NULL,'5fe5e661-b07a-4880-b9f2-e123ff4ab758');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (1,'admin',NULL,NULL,NULL,'test@example.com','$2y$13$UiybuMnJtnDOW04ueSQmOel5lIDt8vxLSF1JvGGUTV7tj.QQwsVDm',1,0,0,0,'2019-01-28 15:01:59',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-01-25 22:37:20','2019-01-25 22:37:20','2019-01-28 15:02:00','cd909bb5-f246-4132-8e45-86ca9b0acf5c');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-01-28 15:02:00','2019-01-28 15:02:00','2b4c865d-a879-48ec-96d2-32362a028268'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-01-28 15:02:00','2019-01-28 15:02:00','8d3ffcf9-27b4-4b5e-ba9c-d19bb0b0d474'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-01-28 15:02:00','2019-01-28 15:02:00','c267c219-b55c-4de2-94f0-398cd18c2a3a'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-01-28 15:02:00','2019-01-28 15:02:00','7a56ac0b-743d-4cdd-917d-a3a74aff8d3a');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'commercesearchissue'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-28  9:14:32
