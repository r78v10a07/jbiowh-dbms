SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 3.0.2 to 3.1.0
-- -----------------------------------------------------

ALTER TABLE `DrugBank` CHANGE COLUMN `Name` `Name` VARCHAR(255) NOT NULL  
, DROP INDEX `pk_Name` 
, ADD INDEX `pk_Name` USING BTREE (`Name` ASC) ;

ALTER TABLE `DrugBankExperimentalProperties` CHANGE COLUMN `Source` `Source` VARCHAR(255) NULL DEFAULT NULL  ;

ALTER TABLE `KEGGPathwayEntry` CHANGE COLUMN `Entry` `Entry` TEXT NOT NULL  , CHANGE COLUMN `Link` `Link` TEXT NULL DEFAULT NULL  
, DROP INDEX `pk_Entry` ;

CREATE  TABLE IF NOT EXISTS `GeneBank` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `LocusName` VARCHAR(25) NOT NULL ,
  `SeqLengh` INT(11) NOT NULL ,
  `MolType` VARCHAR(10) NOT NULL ,
  `Division` VARCHAR(5) NOT NULL ,
  `ModDate` DATETIME NOT NULL ,
  `Definition` TEXT NULL DEFAULT NULL ,
  `Version` VARCHAR(3) NULL DEFAULT NULL ,
  `Gi` INT(11) NOT NULL ,
  `TaxId` INT(11) NOT NULL ,
  `Location` VARCHAR(100) NOT NULL ,
  `Organism` TEXT NULL DEFAULT NULL ,
  `FileName` VARCHAR(45) NULL DEFAULT NULL ,
  `DataSet_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`WID`) ,
  UNIQUE INDEX `LocusName_UNIQUE` (`LocusName` ASC) ,
  UNIQUE INDEX `Gi_UNIQUE` (`Gi` ASC) ,
  INDEX `fk_GeneBank_DataSet1_idx` (`DataSet_WID` ASC) ,
  INDEX `TaxId_INDEX` (`TaxId` ASC) ,
  INDEX `Division_index` (`Division` ASC) ,
  INDEX `FileName_index` (`FileName` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankCDS` (
  `WID` BIGINT(20) NOT NULL ,
  `ProteinGi` INT(11) NULL DEFAULT NULL ,
  `Location` VARCHAR(100) NOT NULL ,
  `Product` VARCHAR(255) NULL DEFAULT NULL ,
  `ProteinId` VARCHAR(25) NULL DEFAULT NULL ,
  `GeneBank_WID` BIGINT(20) NOT NULL ,
  INDEX `fk_GeneBankCDS_GeneBank1_idx` (`GeneBank_WID` ASC) ,
  PRIMARY KEY (`WID`) ,
  INDEX `proteinId_index` (`ProteinId` ASC) ,
  INDEX `proteinGi_index` (`ProteinGi` ASC) ,
  INDEX `location_index` (`Location` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankFeatures` (
  `GeneBank_WID` BIGINT(20) NOT NULL ,
  `KeyName` VARCHAR(20) NOT NULL ,
  `Location` VARCHAR(100) NOT NULL ,
  `Gi` BIGINT(20) NULL DEFAULT NULL ,
  `Product` VARCHAR(255) NULL DEFAULT NULL ,
  `Gene` VARCHAR(50) NULL DEFAULT NULL ,
  INDEX `fk_GeneBankFeatures_GeneBank1_idx` (`GeneBank_WID` ASC) ,
  INDEX `key_index` (`KeyName` ASC) ,
  INDEX `gi_index` (`Gi` ASC) ,
  INDEX `location_index` (`Location` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankCDS_has_GeneInfo` (
  `GeneBankCDS_WID` BIGINT(20) NOT NULL ,
  `GeneInfo_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`GeneBankCDS_WID`, `GeneInfo_WID`) ,
  INDEX `fk_GeneBankCDS_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC) ,
  INDEX `fk_GeneBankCDS_has_GeneInfo_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankCDSDBXref` (
  `GeneBankCDS_WID` BIGINT(20) NOT NULL ,
  `DBXrefs` VARCHAR(50) NOT NULL ,
  `DBIdent` VARCHAR(45) NOT NULL ,
  INDEX `fk_GeneBankCDSDBXref_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC) ,
  INDEX `db_index` (`DBXrefs` ASC, `DBIdent` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankCDSTemp` (
  `WID` BIGINT(20) NOT NULL ,
  `ProteinGi` INT(11) NOT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `proteinGi_index` (`ProteinGi` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneBankAccession` (
  `GeneBank_WID` BIGINT(20) NOT NULL ,
  `Accession` VARCHAR(45) NOT NULL ,
  INDEX `fk_GeneBankAccession_GeneBank1_idx` (`GeneBank_WID` ASC) ,
  INDEX `accession_index` (`Accession` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneRNT` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `pFrom` BIGINT(20) NOT NULL ,
  `pTo` BIGINT(20) NOT NULL ,
  `Location` VARCHAR(100) NOT NULL ,
  `Strand` VARCHAR(50) NOT NULL ,
  `PLength` INT(11) NOT NULL ,
  `GenomicNucleotideGi` BIGINT(20) NOT NULL ,
  `GeneSymbol` VARCHAR(100) NULL DEFAULT NULL ,
  `GeneLocusTag` VARCHAR(100) NULL DEFAULT NULL ,
  `Code` VARCHAR(50) NULL DEFAULT NULL ,
  `COG` VARCHAR(50) NULL DEFAULT NULL ,
  `Product` VARCHAR(1000) NOT NULL ,
  `PTTFile` VARCHAR(50) NOT NULL ,
  `DataSetWID` BIGINT(20) NOT NULL ,
  INDEX `fk_GenomesPTT_DataSet_idx` (`DataSetWID` ASC) ,
  INDEX `pk_pFrom` (`pFrom` ASC) ,
  INDEX `pk_pTo` (`pTo` ASC) ,
  INDEX `pk_GeneSymbol` (`GeneSymbol` ASC) ,
  INDEX `pk_COG` (`COG` ASC) ,
  INDEX `pk_PTTFile` (`PTTFile` ASC) ,
  INDEX `pk_GenomicNucleotideGi` (`GenomicNucleotideGi` ASC) ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE  TABLE IF NOT EXISTS `GeneInfo_has_GeneRNT` (
  `GeneInfo_WID` BIGINT(20) NOT NULL ,
  `GeneRNT_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `GeneRNT_WID`) ,
  INDEX `fk_GeneInfo_has_GeneRNT_GeneRNT1_idx` (`GeneRNT_WID` ASC) ,
  INDEX `fk_GeneInfo_has_GeneRNT_GeneInfo1_idx` (`GeneInfo_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GeneRNT_has_Taxonomy` (
  `GeneRNT_WID` BIGINT(20) NOT NULL ,
  `Taxonomy_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`GeneRNT_WID`, `Taxonomy_WID`) ,
  INDEX `fk_GeneRNT_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC) ,
  INDEX `fk_GeneRNT_has_Taxonomy_GeneRNT1_idx` (`GeneRNT_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
