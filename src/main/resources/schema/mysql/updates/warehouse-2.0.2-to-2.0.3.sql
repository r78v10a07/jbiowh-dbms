SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.0.2 to 2.0.3
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `GeneInfo_has_GenomesPTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_GenomesPTT` ;

CREATE  TABLE IF NOT EXISTS `GeneInfo_has_GenomesPTT` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `GenomesPTT_ProteinGi` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `GenomesPTT_ProteinGi`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_GeneInfo_has_GenomesPTT_GenomesPTT1` ON `GeneInfo_has_GenomesPTT` (`GenomesPTT_ProteinGi` ASC) ;

CREATE INDEX `fk_GeneInfo_has_GenomesPTT_GeneInfo1` ON `GeneInfo_has_GenomesPTT` (`GeneInfo_WID` ASC) ;


insert into GeneInfo_has_GenomesPTT (GeneInfo_WID,GenomesPTT_ProteinGi) 
select g.WID,t.ProteinGI from GeneInfo g 
inner join Gene2Accession a on a.GeneInfo_WID = g.WID 
inner join GenomesPTT t on t.ProteinGi = a.ProteinGi;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;