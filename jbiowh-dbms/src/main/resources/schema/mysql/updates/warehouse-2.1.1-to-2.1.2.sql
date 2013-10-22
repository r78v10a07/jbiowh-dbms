SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.1.1 to 2.1.2
-- -----------------------------------------------------

RENAME TABLE `PfamA` to `PfamAbioWH`;
RENAME TABLE `PfamB` to `PfamBbioWH`;

ALTER TABLE `OMIMTX` CHANGE COLUMN `TX` `TX` LONGTEXT NOT NULL  ;

CREATE  TABLE IF NOT EXISTS `pfamA` (
  `auto_pfamA` INT(5) NOT NULL AUTO_INCREMENT ,
  `pfamA_acc` VARCHAR(7) NOT NULL ,
  `pfamA_id` VARCHAR(16) NOT NULL ,
  `previous_id` TINYTEXT NULL DEFAULT NULL ,
  `description` VARCHAR(100) NOT NULL ,
  `author` TINYTEXT NOT NULL ,
  `deposited_by` VARCHAR(100) NOT NULL DEFAULT 'anon' ,
  `seed_source` TINYTEXT NOT NULL ,
  `type` ENUM('Family','Domain','Repeat','Motif') NOT NULL ,
  `comment` LONGTEXT NULL DEFAULT NULL ,
  `sequence_GA` DOUBLE(8,2) NOT NULL ,
  `domain_GA` DOUBLE(8,2) NOT NULL ,
  `sequence_TC` DOUBLE(8,2) NOT NULL ,
  `domain_TC` DOUBLE(8,2) NOT NULL ,
  `sequence_NC` DOUBLE(8,2) NOT NULL ,
  `domain_NC` DOUBLE(8,2) NOT NULL ,
  `buildMethod` TINYTEXT NOT NULL ,
  `model_length` MEDIUMINT(8) NOT NULL ,
  `searchMethod` TINYTEXT NOT NULL ,
  `msv_lambda` DOUBLE(8,2) NOT NULL ,
  `msv_mu` DOUBLE(8,2) NOT NULL ,
  `viterbi_lambda` DOUBLE(8,2) NOT NULL ,
  `viterbi_mu` DOUBLE(8,2) NOT NULL ,
  `forward_lambda` DOUBLE(8,2) NOT NULL ,
  `forward_tau` DOUBLE(8,2) NOT NULL ,
  `num_seed` INT(10) NULL DEFAULT NULL ,
  `num_full` INT(10) NULL DEFAULT NULL ,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `created` DATETIME NULL DEFAULT NULL ,
  `version` SMALLINT(5) NULL DEFAULT NULL ,
  `number_archs` INT(8) NULL DEFAULT NULL ,
  `number_species` INT(8) NULL DEFAULT NULL ,
  `number_structures` INT(8) NULL DEFAULT NULL ,
  `number_ncbi` INT(8) NULL DEFAULT NULL ,
  `number_meta` INT(8) NULL DEFAULT NULL ,
  `average_length` DOUBLE(6,2) NULL DEFAULT NULL ,
  `percentage_id` INT(3) NULL DEFAULT NULL ,
  `average_coverage` DOUBLE(6,2) NULL DEFAULT NULL ,
  `change_status` TINYTEXT NULL DEFAULT NULL ,
  `seed_consensus` TEXT NULL DEFAULT NULL ,
  `full_consensus` TEXT NULL DEFAULT NULL ,
  `number_shuffled_hits` INT(10) NULL DEFAULT NULL ,
  PRIMARY KEY (`auto_pfamA`) ,
  UNIQUE INDEX `pfamA_acc` (`pfamA_acc` ASC) ,
  UNIQUE INDEX `pfamA_id` (`pfamA_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
