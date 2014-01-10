SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 6.0.0 to 6.0.1
-- -----------------------------------------------------

ALTER TABLE `biowh`.`TaxonomySynonym` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Ontology` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`OntologyXRef` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`OntologySynonym` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`GeneInfo` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`GeneInfoSynonyms` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`GeneInfoDBXrefs` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Gene2Ensembl` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Gene2GO` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`GenePTT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinName` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinAccessionNumber` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinLongName` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinDBReference` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinGo` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinRefSeq` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinPMID` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinKEGG` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinBioCyc` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinPDB` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinIntAct` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinDIP` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinMINT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinDrugBank` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinComment` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinKeyword` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`ProteinPFAM` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`DrugBank` 
CHANGE COLUMN `Id` `Id` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Description` `Description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `Indication` `Indication` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`DrugBankCategory` 
CHANGE COLUMN `Category` `Category` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`ProteinGene` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`GeneRNT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Gene2RNANucleotide` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Gene2ProteinAccession` 
COLLATE = utf8_general_ci ;

ALTER TABLE `biowh`.`Gene2GenomicNucleotide` 
COLLATE = utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXML` (
  `WID` BIGINT(20) NOT NULL,
  `Origin` VARCHAR(255) NULL DEFAULT NULL,
  `OriginVersion` VARCHAR(255) NULL DEFAULT NULL,
  `Version` DECIMAL(20,10) NULL DEFAULT NULL,
  `DataSet_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `origin_index` (`Origin` ASC),
  INDEX `fk_OrthoXML_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLGroupGeneRefScore` (
  `Id` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `Value` DECIMAL(10,0) NULL DEFAULT NULL,
  `OrthoXMLGroupGeneRef_WID` BIGINT(20) NOT NULL,
  INDEX `fk_OrthoXMLGeneRefScore_OrthoXMLGroupGeneRef1_idx` (`OrthoXMLGroupGeneRef_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLGroup` (
  `WID` BIGINT(20) NOT NULL,
  `Id` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `isOrthologGroup` TINYINT(1) NULL DEFAULT '1',
  `OrthoXML_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OrthoXMLOrthologGroup_OrthoXML1_idx` (`OrthoXML_WID` ASC),
  INDEX `id_index` (`Id` ASC),
  INDEX `isOrthologGroup` (`isOrthologGroup` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLGroupGeneRef` (
  `WID` BIGINT(20) NOT NULL,
  `Id` INT(11) NULL DEFAULT NULL,
  `OrthoXMLGroup_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OrthoXMLGeneRef_OrthoXMLGroup1_idx` (`OrthoXMLGroup_WID` ASC),
  INDEX `fk_OrthoXMLGeneRef_Gene1_idx` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLGroupProperty` (
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Value` VARCHAR(255) NULL DEFAULT NULL,
  `OrthoXMLGroup_WID` BIGINT(20) NOT NULL,
  INDEX `fk_OrthoXMLOrthologGroupProperty_OrthoXMLGroup1_idx` (`OrthoXMLGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLGroupScore` (
  `Id` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `Value` DECIMAL(10,0) NULL DEFAULT NULL,
  `OrthoXMLGroup_WID` BIGINT(20) NOT NULL,
  INDEX `fk_OrthoXMLOrthologGroupScore_OrthoXMLGroup1_idx` (`OrthoXMLGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLScore` (
  `Id` VARCHAR(255) NULL DEFAULT NULL,
  `Desc_` VARCHAR(100) NULL DEFAULT NULL,
  `OrthoXML_WID` BIGINT(20) NOT NULL,
  INDEX `fk_OrthoXMLScore_OrthoXML1_idx` (`OrthoXML_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLSpecie` (
  `WID` BIGINT(20) NOT NULL,
  `TaxId` BIGINT(20) NULL DEFAULT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `OrthoXML_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OrthoXMLSpecies_OrthoXML1_idx` (`OrthoXML_WID` ASC),
  INDEX `taxId_index` (`TaxId` ASC),
  INDEX `name_index` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLSpeciesDatabase` (
  `WID` BIGINT(20) NOT NULL,
  `GeneLink` VARCHAR(255) NULL DEFAULT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `ProtLink` VARCHAR(255) NULL DEFAULT NULL,
  `TranscriptLink` VARCHAR(255) NULL DEFAULT NULL,
  `Version` VARCHAR(255) NULL DEFAULT NULL,
  `OrthoXMLSpecies_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OrthoXMLSpeciesDatabase_OrthoXMLSpecies1_idx` (`OrthoXMLSpecies_WID` ASC),
  INDEX `name_index` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`OrthoXMLSpeciesDatabaseGene` (
  `Id` INT(11) NULL DEFAULT NULL,
  `GeneId` VARCHAR(100) NULL DEFAULT NULL,
  `ProtId` VARCHAR(100) NULL DEFAULT NULL,
  `TranscriptId` VARCHAR(100) NULL DEFAULT NULL,
  `OrthoXMLSpeciesDatabase_WID` BIGINT(20) NOT NULL,
  INDEX `fk_Gene_OrthoXMLSpeciesDatabase1_idx` (`OrthoXMLSpeciesDatabase_WID` ASC),
  INDEX `geneId_index` (`GeneId` ASC),
  INDEX `protId_index` (`ProtId` ASC),
  INDEX `transcriptId_index` (`TranscriptId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

ALTER TABLE `biowh`.`PIRSF` 
CHANGE COLUMN `CurationStatus` `CurationStatus` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

CREATE TABLE IF NOT EXISTS `biowh`.`COGFuncClassGroup` (
  `WID` BIGINT(20) NOT NULL,
  `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGFuncClass` (
  `WID` BIGINT(20) NOT NULL,
  `Letter` CHAR CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `COGFuncClassGroup_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGOrthologousGroup` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `Id` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
  `GroupFunction` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL,
  `DataSet_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  UNIQUE INDEX `Id_UNIQUE` (`Id` ASC),
  INDEX `fk_COGOrthologous_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGMember` (
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  `Organism` VARCHAR(10) NULL DEFAULT NULL,
  `Id` VARCHAR(15) NOT NULL,
  INDEX `org_index` (`Organism` ASC),
  INDEX `id_index` (`Id` ASC),
  INDEX `fk_COGMember_COGOrthologousGroup1_idx` (`COGOrthologousGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGMember_has_Gi` (
  `Id` VARCHAR(15) NOT NULL,
  `Gi` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Id`, `Gi`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGMember_TaxId` (
  `Organism` VARCHAR(10) NOT NULL,
  `TaxId` BIGINT(20) NOT NULL,
  PRIMARY KEY (`Organism`, `TaxId`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGOrthologousGroup_has_GeneInfo` (
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  `GeneInfo_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`COGOrthologousGroup_WID`, `GeneInfo_WID`),
  INDEX `fk_COGOrthologousGroup_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `fk_COGOrthologousGroup_has_GeneInfo_COGOrthologousGroup1_idx` (`COGOrthologousGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGOrthologousGroup_has_Protein` (
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  `Protein_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`COGOrthologousGroup_WID`, `Protein_WID`),
  INDEX `fk_COGOrthologousGroup_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `fk_COGOrthologousGroup_has_Protein_COGOrthologousGroup1_idx` (`COGOrthologousGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGOrthologousGroup_has_Taxonomy` (
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  `Taxonomy_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`COGOrthologousGroup_WID`, `Taxonomy_WID`),
  INDEX `fk_COGOrthologousGroup_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_COGOrthologousGroup_has_Taxonomy_COGOrthologousGroup1_idx` (`COGOrthologousGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`COGOrthologousGroup_has_COGFuncClass` (
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  `COGFuncClass_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`COGOrthologousGroup_WID`, `COGFuncClass_WID`),
  INDEX `fk_COGOrthologousGroup_has_COGFuncClass_COGFuncClass1_idx` (`COGFuncClass_WID` ASC),
  INDEX `fk_COGOrthologousGroup_has_COGFuncClass_COGOrthologousGroup_idx` (`COGOrthologousGroup_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`GeneBankCOG` (
  `GeneBankCDS_WID` BIGINT(20) NOT NULL,
  `COGId` VARCHAR(10) NOT NULL,
  INDEX `fk_GeneBankCOG_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC),
  PRIMARY KEY (`GeneBankCDS_WID`, `COGId`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `biowh`.`GeneBankCDSLocation` (
  `GeneBankCDS_WID` BIGINT(20) NOT NULL,
  `pFrom` INT(11) NOT NULL,
  `pTo` INT(11) NULL DEFAULT NULL,
  INDEX `fk_GeneBankCDSLocation_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC),
  PRIMARY KEY (`GeneBankCDS_WID`, `pFrom`, `pTo`),
  INDEX `pFrom_index` (`pFrom` ASC),
  INDEX `pTo_index` (`pTo` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
