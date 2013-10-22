SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.0.7 to 2.1.1
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `PfamBReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamB_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamBReg_PfamB1_idx` (`PfamB_WID` ASC) ,
  INDEX `fk_PfamBReg_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamClanDatabaseLinks` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamClans_WID` BIGINT(20) NOT NULL ,
  `db_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `comment` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `db_link` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `other_params` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  INDEX `fk_PfamClanDatabaseLinks_PfamClans1_idx` (`PfamClans_WID` ASC) ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamClans` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `clan_acc` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `clan_id` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `previous_id` VARCHAR(75) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `clan_description` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `clan_author` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `deposited_by` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT 'anon' ,
  `clan_comment` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `created` DATETIME NULL DEFAULT NULL ,
  `version` SMALLINT(5) NULL DEFAULT NULL ,
  `number_structures` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `number_archs` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `number_species` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `number_sequences` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `competed` TINYINT(1) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  UNIQUE INDEX `clan_acc` (`clan_acc` ASC) ,
  UNIQUE INDEX `clan_id` (`clan_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamCompleteProteomes` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `species` VARCHAR(256) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `grouping` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `num_distinct_regions` INT(10) UNSIGNED NOT NULL DEFAULT '0' ,
  `num_total_regions` INT(10) UNSIGNED NOT NULL DEFAULT '0' ,
  `num_proteins` INT(10) UNSIGNED NOT NULL DEFAULT '0' ,
  `sequence_coverage` INT(3) UNSIGNED NOT NULL DEFAULT '0' ,
  `residue_coverage` INT(3) UNSIGNED NOT NULL DEFAULT '0' ,
  `total_genome_proteins` INT(10) UNSIGNED NOT NULL DEFAULT '0' ,
  `total_aa_length` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0' ,
  `total_aa_covered` INT(10) UNSIGNED NULL DEFAULT '0' ,
  `total_seqs_covered` INT(10) UNSIGNED NULL DEFAULT '0' ,
  `TaxId` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `genome_species_grouping_idx` (`grouping` ASC) ,
  INDEX `pk_TaxId` (`TaxId` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamContextRegions` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `domain_score` DOUBLE(16,2) NOT NULL DEFAULT '0.00' ,
  INDEX `fk_PfamContextRegions_PfamA1_idx` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamContextRegions_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

ALTER TABLE `Gene2Accession` CHANGE COLUMN `ProteinGi` `ProteinGi` BIGINT(20) NULL DEFAULT NULL  
, DROP PRIMARY KEY 
, ADD PRIMARY KEY (`WID`, `GeneInfo_WID`) ;

CREATE  TABLE IF NOT EXISTS `gene_ontology` (
  `auto_pfamA` INT(5) NOT NULL DEFAULT '0' ,
  `go_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `term` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `category` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `auto_pfamA` (`auto_pfamA` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamA` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
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
  `DataSet_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`WID`) ,
  UNIQUE INDEX `pfamA_acc` (`pfamA_acc` ASC) ,
  UNIQUE INDEX `pfamA_id` (`pfamA_id` ASC) ,
  INDEX `fk_PfamA_DataSet1_idx` (`DataSet_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamADatabaseLinks` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `db_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `comment` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `db_link` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `other_params` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  INDEX `fk_PfamADatabaseLinks_PfamA1_idx` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamAInteractions` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `OtherPfamA_WID` BIGINT(20) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamANCBIReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `GeneId` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `ali_start` MEDIUMINT(8) NOT NULL ,
  `ali_end` MEDIUMINT(8) NOT NULL ,
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `domain_bits_score` DOUBLE(16,4) NOT NULL DEFAULT '0.0000' ,
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sequence_bits_score` DOUBLE(16,4) NOT NULL DEFAULT '0.0000' ,
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `in_full` TINYINT(4) NOT NULL DEFAULT '0' ,
  `tree_order` MEDIUMINT(9) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamANCBIReg_PfamA1_idx` (`PfamA_WID` ASC) ,
  INDEX `fk_GeneInfo_GeneId_idx` (`GeneId` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamAPDBReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamARegFullSignificant_WID` BIGINT(20) NOT NULL ,
  `chain` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `pdb_res_start` MEDIUMINT(8) NULL DEFAULT NULL ,
  `pdb_start_icode` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `pdb_res_end` MEDIUMINT(8) NULL DEFAULT NULL ,
  `pdb_end_icode` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `hex_colour` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamAPDBReg_PfamARegFullSignificant1_idx` (`PfamARegFullSignificant_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamARegFullInsignificant` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `Protein_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `domain_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00' ,
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sequence_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00' ,
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamARegFullInsignificant_PfamA1_idx` (`PfamA_WID` ASC) ,
  INDEX `fk_PfamARegFullInsignificant_Protein1_idx` (`Protein_WID` ASC) ,
  INDEX `pk_auto_pfamseq` (`auto_pfamseq` ASC) ,
  INDEX `pk_multiple` (`WID` ASC, `PfamA_WID` ASC, `Protein_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamARegFullSignificant` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `Protein_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `ali_start` MEDIUMINT(8) UNSIGNED NOT NULL ,
  `ali_end` MEDIUMINT(8) UNSIGNED NOT NULL ,
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `domain_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00' ,
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `sequence_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00' ,
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `in_full` TINYINT(4) NOT NULL DEFAULT '0' ,
  `tree_order` MEDIUMINT(9) NULL DEFAULT NULL ,
  `domain_order` MEDIUMINT(9) NULL DEFAULT NULL ,
  `domain_oder` TINYINT(4) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `in_full` (`in_full` ASC) ,
  INDEX `fk_PfamARegFullSignificant_PfamA1_idx` (`PfamA_WID` ASC) ,
  INDEX `fk_PfamARegFullSignificant_Protein1_idx` (`Protein_WID` ASC) ,
  INDEX `pk_auto_pfamseq` (`auto_pfamseq` ASC) ,
  INDEX `pk_multiple` (`WID` ASC, `PfamA_WID` ASC, `Protein_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamARegSeed` (
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(8) NOT NULL ,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `tree_order` MEDIUMINT(9) NOT NULL ,
  INDEX `fk_PfamARegSeed_PfamA1_idx` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`auto_pfamseq`, `PfamA_WID`, `tree_order`) ,
  INDEX `fk_PfamARegSeed_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamArchitecture` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `architecture` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `type_example` INT(10) NOT NULL DEFAULT '0' ,
  `no_seqs` INT(8) NOT NULL DEFAULT '0' ,
  `architecture_acc` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `architecture_type_example_idx` (`type_example` ASC) ,
  INDEX `architecture_architecture_idx` (`architecture`(255) ASC) ,
  INDEX `architecture_architecture_acc_idx` (`architecture_acc`(255) ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamB` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `pfamB_acc` CHAR(8) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT '' ,
  `pfamB_id` CHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT '' ,
  `number_archs` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `number_regions` INT(10) UNSIGNED NULL DEFAULT '0' ,
  `number_species` INT(8) UNSIGNED NULL DEFAULT NULL ,
  `number_structures` INT(8) UNSIGNED NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `pfamB_acc` (`pfamB_acc` ASC) ,
  INDEX `pfamB_id` (`pfamB_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamInterpro` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `interpro_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `abstract` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  INDEX `fk_PfamInterpro_PfamA1_idx` (`PfamA_WID` ASC) ,
  UNIQUE INDEX `PfamA_WID_UNIQUE` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`PfamA_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamLiteratureReferences` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `pmid` INT(10) NULL DEFAULT NULL ,
  `title` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `author` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `journal` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  UNIQUE INDEX `IX_literature_references_1` (`pmid` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamMarkupKey` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `label` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamNestedLocations` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `OtherPfamA_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `seq_version` TINYINT(4) NULL DEFAULT NULL ,
  `seq_start` MEDIUMINT(8) NULL DEFAULT NULL ,
  `seq_end` MEDIUMINT(8) NULL DEFAULT NULL ,
  INDEX `OtherPfamA_WID` (`OtherPfamA_WID` ASC) ,
  INDEX `fk_PfamNestedLocations_PfamA1_idx` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamNestedLocations_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamOtherReg` (
  `region_id` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `seq_end` MEDIUMINT(6) UNSIGNED NOT NULL DEFAULT '0' ,
  `type_id` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `source_id` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `score` DOUBLE(16,4) NULL DEFAULT NULL ,
  `orientation` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`region_id`) ,
  INDEX `other_reg_type_id_idx` (`type_id` ASC) ,
  INDEX `other_reg_source_id_idx` (`source_id` ASC) ,
  INDEX `fk_PfamOtherReg_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamPDB` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `pdb_id` VARCHAR(5) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `keywords` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `title` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `date` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `resolution` DECIMAL(5,2) NULL DEFAULT '0.00' ,
  `method` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `author` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `pdb_id_idx` (`pdb_id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamPDBResidueData` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `PfamPDB_WID` BIGINT(20) NOT NULL ,
  `chain` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `serial` INT(10) NOT NULL ,
  `pdb_res` CHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `pdb_seq_number` INT(10) NULL DEFAULT NULL ,
  `pdb_insert_code` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `observed` INT(1) NULL DEFAULT NULL ,
  `dssp_code` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `pfamseq_res` CHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  `pfamseq_seq_number` INT(10) NULL DEFAULT NULL ,
  INDEX `fk_PfamPDBResidueData_PfamPDB1_idx` (`PfamPDB_WID` ASC) ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamPDBResidueData_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamProteomeRegions` (
  `PfamCompleteProteomes_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `count` INT(10) UNSIGNED NOT NULL DEFAULT '0' ,
  INDEX `fk_PfamProteomeRegions_PfamCompleteProteomes1_idx` (`PfamCompleteProteomes_WID` ASC) ,
  INDEX `fk_PfamProteomeRegions_PfamA1_idx` (`PfamA_WID` ASC) ,
  PRIMARY KEY (`PfamCompleteProteomes_WID`, `auto_pfamseq`, `PfamA_WID`) ,
  INDEX `fk_PfamProteomeRegions_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamSeqDisulphide` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `bond_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `bond_end` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamSeqDisulphide_PfamSeq_has_Protein2_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

CREATE  TABLE IF NOT EXISTS `PfamMarkup_has_Protein` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `PfamMarkupKey_WID` BIGINT(20) NOT NULL ,
  `residue` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0' ,
  `annotation` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL ,
  INDEX `fk_PfamSeqMarkup_PfamMarkupKey1_idx` (`PfamMarkupKey_WID` ASC) ,
  PRIMARY KEY (`WID`) ,
  INDEX `fk_PfamMarkup_has_Protein_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;

ALTER TABLE `ProteinTaxId` COLLATE = utf8_bin ;

ALTER TABLE `ProteinPFAM` COLLATE = utf8_bin ;

ALTER TABLE `DrugBank` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankGeneralRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankSecondAccessionNumbers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankGroup` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTaxonomySubstructures` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankSynonyms` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankBrands` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankMixtures` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPackagers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankManufacturers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPrices` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCategories` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCategoriesTemp` COLLATE = utf8_bin ;

ALTER TABLE `DrugBank_has_DrugBankCategories` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankAffectedOrganisms` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDosages` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankATCCodes` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankAHFSCodes` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPatents` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPatentsTemp` COLLATE = utf8_bin ;

ALTER TABLE `DrugBank_has_DrugBankPatents` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankFoodInteractions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDrugInteractions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankProteinSequences` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCalculatedProperties` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExperimentalProperties` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExternalIdentifiers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExternalLinks` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTargets` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTargetsRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTargetsActions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankEnzymes` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankEnzymesRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankEnzymesActions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTransporters` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTransportersRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTransportersActions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCarriers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCarriersRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCarriersActions` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPartners` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPartnerRef` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPartnerExternalIdentifiers` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPartnerSynonyms` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPartnerPFam` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTaxonomy` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionOrthology` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeOrthology` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionRPair` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymePathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeClass` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeAllReac` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeClassTemp` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGEnzymeClass` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeSysName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeSubstrate` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeProduct` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeCofactor` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeGenes` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeDBLink` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeInhibitor` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeEffector` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Product` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Substrate` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Cofactor` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundDBLink` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionProduct` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionSubstrate` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycan` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanDBLink` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Product` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Substrate` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanClassTemp` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanClass` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycan_has_KEGGGlycanClass` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanOrthology` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Effector` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPair` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairCompound` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPair_has_KEGGCompound` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairRelatedPair` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairRelatedPairTemp` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGene` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneOrthology` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGenePathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDBLink` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDisease` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDrugTarget` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntry` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayRelation` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReactionSubstrate` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReactionProduct` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryGraphic` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryEnzyme` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryCompound` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryGene` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryOrthology` COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound_has_KEGGPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGene_has_KEGGPathway` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryReaction` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_Taxonomy` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayRelationSubType` COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanName` COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound_has_DrugBank` COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDrugInteractionsTemp` COLLATE = utf8_bin ;

ALTER TABLE `ProteinGene` COLLATE = utf8_bin ;

ALTER TABLE `ProteinGeneTemp` COLLATE = utf8_bin ;

ALTER TABLE `ProteinPFAMTemp` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_Protein` COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_GeneInfo` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMapTemp` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_GeneSymbol` COLLATE = utf8_bin ;

ALTER TABLE `OMIMMethod` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_OMIMMethod` COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap` COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap_has_GeneSymbol` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_OMIMMorbidMap` COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_GeneSymbolTemp` COLLATE = utf8_bin ;

ALTER TABLE `OMIMMethodTemp` COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap_has_GeneSymbolTemp` COLLATE = utf8_bin ;

ALTER TABLE `OMIM` COLLATE = utf8_bin ;

ALTER TABLE `OMIMTI` COLLATE = utf8_bin ;

ALTER TABLE `OMIMTX` COLLATE = utf8_bin , CHANGE COLUMN `TX` `TX` TEXT NOT NULL  ;

ALTER TABLE `OMIMRF` COLLATE = utf8_bin ;

ALTER TABLE `OMIMCS` COLLATE = utf8_bin ;

ALTER TABLE `OMIMCSData` COLLATE = utf8_bin ;

ALTER TABLE `OMIMCD` COLLATE = utf8_bin ;

ALTER TABLE `OMIMED` COLLATE = utf8_bin ;

ALTER TABLE `OMIMAV` COLLATE = utf8_bin ;

ALTER TABLE `OMIMCN` COLLATE = utf8_bin ;

ALTER TABLE `OMIMSA` COLLATE = utf8_bin ;

CREATE  TABLE IF NOT EXISTS `PfamA_has_PfamArchitecture` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `PfamArchitecture_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamA_WID`, `PfamArchitecture_WID`) ,
  INDEX `fk_PfamA_has_PfamArchitecture_PfamArchitecture1_idx` (`PfamArchitecture_WID` ASC) ,
  INDEX `fk_PfamA_has_PfamArchitecture_PfamA1_idx` (`PfamA_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamA_has_Ontology` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `Ontology_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamA_WID`, `Ontology_WID`) ,
  INDEX `fk_PfamA_has_Ontology_Ontology1_idx` (`Ontology_WID` ASC) ,
  INDEX `fk_PfamA_has_Ontology_PfamA1_idx` (`PfamA_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamA_has_PfamLiteratureReferences` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `PfamLiteratureReferences_WID` BIGINT(20) NOT NULL ,
  `order_added` TINYINT(4) NOT NULL ,
  `comment` TINYTEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`PfamA_WID`, `PfamLiteratureReferences_WID`, `order_added`) ,
  INDEX `fk_PfamA_has_PfamLiteratureReferences_PfamLiteratureReferen_idx` (`PfamLiteratureReferences_WID` ASC) ,
  INDEX `fk_PfamA_has_PfamLiteratureReferences_PfamA1_idx` (`PfamA_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamClans_has_PfamA` (
  `PfamClans_WID` BIGINT(20) NOT NULL ,
  `PfamA_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamClans_WID`, `PfamA_WID`) ,
  INDEX `fk_PfamClans_has_PfamA_PfamA1_idx` (`PfamA_WID` ASC) ,
  INDEX `fk_PfamClans_has_PfamA_PfamClans1_idx` (`PfamClans_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamClans_has_PfamArchitecture` (
  `PfamClans_WID` BIGINT(20) NOT NULL ,
  `PfamArchitecture_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamClans_WID`, `PfamArchitecture_WID`) ,
  INDEX `fk_PfamClans_has_PfamArchitecture_PfamArchitecture1_idx` (`PfamArchitecture_WID` ASC) ,
  INDEX `fk_PfamClans_has_PfamArchitecture_PfamClans1_idx` (`PfamClans_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamClans_has_PfamLiteratureReferences` (
  `PfamClans_WID` BIGINT(20) NOT NULL ,
  `PfamLiteratureReferences_WID` BIGINT(20) NOT NULL ,
  `order_added` TINYINT(4) NOT NULL DEFAULT 0 ,
  `comment` TINYTEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`PfamClans_WID`, `PfamLiteratureReferences_WID`, `order_added`) ,
  INDEX `fk_PfamClans_has_PfamLiteratureReferences_PfamLiteratureRef_idx` (`PfamLiteratureReferences_WID` ASC) ,
  INDEX `fk_PfamClans_has_PfamLiteratureReferences_PfamClans1_idx` (`PfamClans_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamA_has_Taxonomy` (
  `PfamA_WID` BIGINT(20) NOT NULL ,
  `Taxonomy_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamA_WID`, `Taxonomy_WID`) ,
  INDEX `fk_PfamA_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC) ,
  INDEX `fk_PfamA_has_Taxonomy_PfamA1_idx` (`PfamA_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamSeq_has_UniProtId` (
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `UniProt_Id` VARCHAR(12) NOT NULL ,
  PRIMARY KEY (`auto_pfamseq`) ,
  UNIQUE INDEX `UniProt_Id_UNIQUE` (`UniProt_Id` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamARegFullSignificantTemp` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT ,
  `auto_pfamA_reg_full` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`WID`, `auto_pfamA_reg_full`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamCompleteProteomes_has_PfamSeq` (
  `PfamCompleteProteomes_WID` BIGINT(20) NOT NULL ,
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`PfamCompleteProteomes_WID`, `auto_pfamseq`) ,
  INDEX `fk_PfamCompleteProteomes_has_PfamSeq_has_Protein_PfamComple_idx` (`PfamCompleteProteomes_WID` ASC) ,
  INDEX `fk_PfamCompleteProteomes_has_PfamSeq_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `PfamSeq_has_Protein` (
  `auto_pfamseq` BIGINT(20) NOT NULL ,
  `Protein_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`auto_pfamseq`, `Protein_WID`) ,
  INDEX `fk_PfamSeq_has_UniProtId_has_Protein_Protein1_idx` (`Protein_WID` ASC) ,
  INDEX `pk` (`Protein_WID` ASC, `auto_pfamseq` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE  TABLE IF NOT EXISTS `pfamA_ncbi` (
  `auto_pfamA` INT(5) NOT NULL ,
  `pfamA_acc` VARCHAR(7) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `pfamA_id` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL ,
  `ncbi_taxid` INT(10) UNSIGNED NULL DEFAULT '0' ,
  INDEX `auto_pfamA` (`auto_pfamA` ASC) ,
  INDEX `ncbi_taxid` (`ncbi_taxid` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
