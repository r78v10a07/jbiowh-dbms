SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 6.0.1 to 6.1.0
-- -----------------------------------------------------

ALTER TABLE `TaxonomyGenCode` 
CHANGE COLUMN `Code` `Code` VARCHAR(255) NULL DEFAULT NULL ;

ALTER TABLE `TaxonomySynonym` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Ontology` 
COLLATE = utf8_general_ci ;

ALTER TABLE `OntologyXRef` 
COLLATE = utf8_general_ci ;

ALTER TABLE `OntologySynonym` 
COLLATE = utf8_general_ci ;

ALTER TABLE `GeneInfo` 
COLLATE = utf8_general_ci ;

ALTER TABLE `GeneInfoSynonyms` 
COLLATE = utf8_general_ci ;

ALTER TABLE `GeneInfoDBXrefs` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Gene2Ensembl` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Gene2GO` 
COLLATE = utf8_general_ci ;

ALTER TABLE `GenePTT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinName` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinAccessionNumber` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinLongName` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinDBReference` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinGo` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinRefSeq` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinPMID` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinKEGG` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinBioCyc` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinPDB` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinIntAct` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinDIP` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinMINT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinDrugBank` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinComment` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinKeyword` 
COLLATE = utf8_general_ci ;

ALTER TABLE `ProteinPFAM` 
COLLATE = utf8_general_ci ;

ALTER TABLE `DrugBank` 
CHANGE COLUMN `Id` `Id` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Description` `Description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `Indication` `Indication` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `DrugBankCategory` 
CHANGE COLUMN `Category` `Category` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `ProteinGene` 
COLLATE = utf8_general_ci ;

ALTER TABLE `GeneRNT` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Gene2RNANucleotide` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Gene2ProteinAccession` 
COLLATE = utf8_general_ci ;

ALTER TABLE `Gene2GenomicNucleotide` 
COLLATE = utf8_general_ci ;

ALTER TABLE `PIRSF` 
CHANGE COLUMN `CurationStatus` `CurationStatus` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `COGFuncClassGroup` 
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ;

ALTER TABLE `COGFuncClass` 
CHANGE COLUMN `Letter` `Letter` CHAR CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ;

ALTER TABLE `COGOrthologousGroup` 
CHANGE COLUMN `Id` `Id` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `GroupFunction` `GroupFunction` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `GeneBankCDSLocation` 
CHANGE COLUMN `pTo` `pTo` INT(11) NULL DEFAULT NULL ;

CREATE TABLE IF NOT EXISTS `ProtClust` (
  `WID` BIGINT(20) NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  `Definition` TEXT NULL DEFAULT NULL,
  `Locus` VARCHAR(45) NULL DEFAULT NULL,
  `Status` VARCHAR(45) NULL DEFAULT NULL,
  `DataSet_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProtClust_DataSet1_idx` (`DataSet_WID` ASC),
  INDEX `entry` (`Entry` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClustXRef` (
  `Id` VARCHAR(50) NOT NULL,
  `ProtClust_WID` BIGINT(20) NOT NULL,
  INDEX `fk_ProtClustXRef_ProtClust1_idx` (`ProtClust_WID` ASC),
  INDEX `id` (`Id` ASC),
  PRIMARY KEY (`Id`, `ProtClust_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClustProteins` (
  `GeneGi` BIGINT(20) NULL DEFAULT NULL,
  `LocusName` VARCHAR(45) NULL DEFAULT NULL,
  `ProteinGi` BIGINT(20) NULL DEFAULT NULL,
  `ProteinName` VARCHAR(255) NULL DEFAULT NULL,
  `ProtClust_WID` BIGINT(20) NOT NULL,
  INDEX `fk_ProtClustProteins_ProtClust1_idx` (`ProtClust_WID` ASC),
  INDEX `gene` (`GeneGi` ASC),
  INDEX `locus` (`LocusName` ASC),
  INDEX `proteingi` (`ProteinGi` ASC),
  PRIMARY KEY (`ProtClust_WID`, `ProteinGi`, `GeneGi`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClust_has_GeneInfo` (
  `ProtClust_WID` BIGINT(20) NOT NULL,
  `GeneInfo_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ProtClust_WID`, `GeneInfo_WID`),
  INDEX `fk_ProtClust_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `fk_ProtClust_has_GeneInfo_ProtClust1_idx` (`ProtClust_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClust_has_Protein` (
  `ProtClust_WID` BIGINT(20) NOT NULL,
  `Protein_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ProtClust_WID`, `Protein_WID`),
  INDEX `fk_ProtClust_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `fk_ProtClust_has_Protein_ProtClust1_idx` (`ProtClust_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClust_has_Taxonomy` (
  `ProtClust_WID` BIGINT(20) NOT NULL,
  `Taxonomy_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ProtClust_WID`, `Taxonomy_WID`),
  INDEX `fk_ProtClust_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_ProtClust_has_Taxonomy_ProtClust1_idx` (`ProtClust_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClustPMID` (
  `PMID` BIGINT(20) NOT NULL,
  `ProtClust_WID` BIGINT(20) NOT NULL,
  INDEX `fk_ProtClustPMID_ProtClust1_idx` (`ProtClust_WID` ASC),
  PRIMARY KEY (`PMID`, `ProtClust_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClust_has_COGOrthologousGroup` (
  `ProtClust_WID` BIGINT(20) NOT NULL,
  `COGOrthologousGroup_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`ProtClust_WID`, `COGOrthologousGroup_WID`),
  INDEX `fk_ProtClust_has_COGOrthologousGroup_COGOrthologousGroup1_idx` (`COGOrthologousGroup_WID` ASC),
  INDEX `fk_ProtClust_has_COGOrthologousGroup_ProtClust1_idx` (`ProtClust_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `ProtClustEC` (
  `EC` VARCHAR(25) NOT NULL,
  `ProtClust_WID` BIGINT(20) NOT NULL,
  INDEX `fk_ProtClustEC_ProtClust1_idx` (`ProtClust_WID` ASC),
  PRIMARY KEY (`EC`, `ProtClust_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
