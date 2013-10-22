SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.1.3 to 3.0.0
-- -----------------------------------------------------

UPDATE `DataSet` set `Application`='GenePTTLoader' where `Application`='GenomePTTLoader';
ALTER TABLE `GenomesPTTTaxonomy` RENAME TO  `GenePTTTaxonomy` ;
ALTER TABLE `GenomesPTT` RENAME TO  `GenePTT` ;
ALTER TABLE `GenomesPTTTemp` RENAME TO  `GenePTTTemp` ;

ALTER TABLE `GeneInfo_has_GenomesPTT` CHANGE COLUMN `GenomesPTT_ProteinGi` `GenePTT_ProteinGi` BIGINT(20) NOT NULL  
, DROP INDEX `fk_GeneInfo_has_GenomesPTT_GenomesPTT1_idx` 
, ADD INDEX `fk_GeneInfo_has_GenomesPTT_GenePTT1_idx` (`GenePTT_ProteinGi` ASC) 
, DROP INDEX `fk_GeneInfo_has_GenomesPTT_GeneInfo1_idx` 
, ADD INDEX `fk_GeneInfo_has_GenePTT_GeneInfo1_idx` (`GeneInfo_WID` ASC) , RENAME TO  `GeneInfo_has_GenePTT` ;

CREATE TABLE IF NOT EXISTS `Protein_has_GenePTT` (
  `Protein_WID` BIGINT(20) NOT NULL ,
  `GenePTT_ProteinGi` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `GenePTT_ProteinGi`) ,
  INDEX `fk_Protein_has_GenePTT_GenePTT1_idx` (`GenePTT_ProteinGi` ASC) ,
  INDEX `fk_Protein_has_GenePTT_Protein1_idx` (`Protein_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `GenePTT_has_Taxonomy` (
  `GenePTT_ProteinGi` BIGINT(20) NOT NULL ,
  `Taxonomy_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`GenePTT_ProteinGi`, `Taxonomy_WID`) ,
  INDEX `fk_GenePTT_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC) ,
  INDEX `fk_GenePTT_has_Taxonomy_GenePTT1_idx` (`GenePTT_ProteinGi` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

insert IGNORE into `Protein_has_GenePTT` (Protein_WID,GenePTT_ProteinGi)
  select pg.Protein_WID,gptt.GenePTT_ProteinGi from `GeneInfo_has_GenePTT` gptt 
      inner join `Protein_has_GeneInfo` pg on pg.GeneInfo_WID = gptt.GeneInfo_WID;

insert IGNORE into `GenePTT_has_Taxonomy` (GenePTT_ProteinGi,Taxonomy_WID) 
  select ptt.ProteinGi,t.WID from `GenePTT` ptt 
      inner join `GeneInfo_has_GenePTT` gptt on gptt.GenePTT_ProteinGI = ptt.ProteinGi 
      inner join `GeneInfo` g on g.WID = gptt.GeneInfo_WID 
      inner join `Taxonomy` t on t.TaxId = g.TaxId ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
