SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.1.2 to 2.1.3
-- -----------------------------------------------------

ALTER TABLE `gene2ensembltemp` CHANGE COLUMN `EnsemblGeneIdentifier` `EnsemblGeneIdentifier` VARCHAR(20) NULL DEFAULT NULL  , CHANGE COLUMN `RNANucleotideAccession` `RNANucleotideAccession` VARCHAR(20) NULL DEFAULT NULL  , CHANGE COLUMN `EnsemblRNAIdentifier` `EnsemblRNAIdentifier` VARCHAR(20) NULL DEFAULT NULL  , CHANGE COLUMN `ProteinAccession` `ProteinAccession` VARCHAR(20) NULL DEFAULT NULL  , CHANGE COLUMN `EnsemblProteinIdentifier` `EnsemblProteinIdentifier` VARCHAR(20) NULL DEFAULT NULL  ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
