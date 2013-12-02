SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `WIDTable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WIDTable` ;

CREATE TABLE IF NOT EXISTS `WIDTable` (
  `WID` BIGINT NOT NULL DEFAULT 1,
  `PreviousWID` BIGINT NOT NULL DEFAULT 1000000,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `PfamBbioWH`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamBbioWH` ;

CREATE TABLE IF NOT EXISTS `PfamBbioWH` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pfamB_acc` CHAR(8) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT '',
  `pfamB_id` CHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT '',
  `number_archs` INT(8) UNSIGNED NULL DEFAULT NULL,
  `number_regions` INT(10) UNSIGNED NULL DEFAULT '0',
  `number_species` INT(8) UNSIGNED NULL DEFAULT NULL,
  `number_structures` INT(8) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pfamB_acc` (`pfamB_acc` ASC),
  INDEX `pfamB_id` (`pfamB_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `DataSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataSet` ;

CREATE TABLE IF NOT EXISTS `DataSet` (
  `WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Version` VARCHAR(50) NULL DEFAULT NULL,
  `ReleaseDate` DATETIME NULL DEFAULT NULL,
  `LoadDate` DATETIME NOT NULL,
  `ChangeDate` DATETIME NULL DEFAULT NULL,
  `HomeURL` VARCHAR(255) NULL DEFAULT NULL,
  `LoadedBy` VARCHAR(255) NULL DEFAULT NULL,
  `Application` VARCHAR(255) NULL DEFAULT NULL,
  `ApplicationVersion` VARCHAR(255) NULL DEFAULT NULL,
  `Status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `NAME` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein` ;

CREATE TABLE IF NOT EXISTS `Protein` (
  `WID` BIGINT NOT NULL,
  `Version` INT NULL DEFAULT NULL,
  `Modified` DATETIME NULL DEFAULT NULL,
  `Created` DATETIME NULL DEFAULT NULL,
  `DataSet` VARCHAR(10) NULL DEFAULT NULL,
  `Existence` VARCHAR(50) NULL DEFAULT NULL,
  `SeqLength` INT NULL DEFAULT NULL,
  `Mass` INT NULL DEFAULT NULL,
  `Checksum` VARCHAR(255) NULL DEFAULT NULL,
  `SeqModified` DATETIME NULL DEFAULT NULL,
  `SeqVersion` INT NULL DEFAULT NULL,
  `Precursor` VARCHAR(10) NULL DEFAULT NULL,
  `Fragment` VARCHAR(10) NULL DEFAULT NULL,
  `Seq` TEXT NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_Protein_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_DataSet` (`DataSet` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `PfamSeq_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamSeq_has_Protein` ;

CREATE TABLE IF NOT EXISTS `PfamSeq_has_Protein` (
  `auto_pfamseq` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  PRIMARY KEY (`auto_pfamseq`, `Protein_WID`),
  INDEX `fk_PfamSeq_has_UniProtId_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk` (`Protein_WID` ASC, `auto_pfamseq` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `PfamBReg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamBReg` ;

CREATE TABLE IF NOT EXISTS `PfamBReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `PfamB_WID` BIGINT(20) NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamBReg_PfamB1_idx` (`PfamB_WID` ASC),
  INDEX `fk_PfamBReg_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamClans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamClans` ;

CREATE TABLE IF NOT EXISTS `PfamClans` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `clan_acc` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `clan_id` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `previous_id` VARCHAR(75) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `clan_description` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `clan_author` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `deposited_by` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL DEFAULT 'anon',
  `clan_comment` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` DATETIME NULL DEFAULT NULL,
  `version` SMALLINT(5) NULL DEFAULT NULL,
  `number_structures` INT(8) UNSIGNED NULL DEFAULT NULL,
  `number_archs` INT(8) UNSIGNED NULL DEFAULT NULL,
  `number_species` INT(8) UNSIGNED NULL DEFAULT NULL,
  `number_sequences` INT(8) UNSIGNED NULL DEFAULT NULL,
  `competed` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  UNIQUE INDEX `clan_acc` (`clan_acc` ASC),
  UNIQUE INDEX `clan_id` (`clan_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamClanDatabaseLinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamClanDatabaseLinks` ;

CREATE TABLE IF NOT EXISTS `PfamClanDatabaseLinks` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `PfamClans_WID` BIGINT(20) NOT NULL,
  `db_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `comment` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `db_link` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `other_params` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  INDEX `fk_PfamClanDatabaseLinks_PfamClans1_idx` (`PfamClans_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamCompleteProteomes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamCompleteProteomes` ;

CREATE TABLE IF NOT EXISTS `PfamCompleteProteomes` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `species` VARCHAR(256) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `grouping` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `num_distinct_regions` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `num_total_regions` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `num_proteins` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `sequence_coverage` INT(3) UNSIGNED NOT NULL DEFAULT '0',
  `residue_coverage` INT(3) UNSIGNED NOT NULL DEFAULT '0',
  `total_genome_proteins` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `total_aa_length` BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
  `total_aa_covered` INT(10) UNSIGNED NULL DEFAULT '0',
  `total_seqs_covered` INT(10) UNSIGNED NULL DEFAULT '0',
  `TaxId` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `genome_species_grouping_idx` (`grouping` ASC),
  INDEX `pk_TaxId` (`TaxId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamAbioWH`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamAbioWH` ;

CREATE TABLE IF NOT EXISTS `PfamAbioWH` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pfamA_acc` VARCHAR(7) NOT NULL,
  `pfamA_id` VARCHAR(16) NOT NULL,
  `previous_id` TINYTEXT NULL DEFAULT NULL,
  `description` VARCHAR(100) NOT NULL,
  `author` TINYTEXT NOT NULL,
  `deposited_by` VARCHAR(100) NOT NULL DEFAULT 'anon',
  `seed_source` TINYTEXT NOT NULL,
  `type` ENUM('Family','Domain','Repeat','Motif') NOT NULL,
  `comment` LONGTEXT NULL DEFAULT NULL,
  `sequence_GA` DOUBLE(8,2) NOT NULL,
  `domain_GA` DOUBLE(8,2) NOT NULL,
  `sequence_TC` DOUBLE(8,2) NOT NULL,
  `domain_TC` DOUBLE(8,2) NOT NULL,
  `sequence_NC` DOUBLE(8,2) NOT NULL,
  `domain_NC` DOUBLE(8,2) NOT NULL,
  `buildMethod` TINYTEXT NOT NULL,
  `model_length` MEDIUMINT(8) NOT NULL,
  `searchMethod` TINYTEXT NOT NULL,
  `msv_lambda` DOUBLE(8,2) NOT NULL,
  `msv_mu` DOUBLE(8,2) NOT NULL,
  `viterbi_lambda` DOUBLE(8,2) NOT NULL,
  `viterbi_mu` DOUBLE(8,2) NOT NULL,
  `forward_lambda` DOUBLE(8,2) NOT NULL,
  `forward_tau` DOUBLE(8,2) NOT NULL,
  `num_seed` INT(10) NULL DEFAULT NULL,
  `num_full` INT(10) NULL DEFAULT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` DATETIME NULL DEFAULT NULL,
  `version` SMALLINT(5) NULL DEFAULT NULL,
  `number_archs` INT(8) NULL DEFAULT NULL,
  `number_species` INT(8) NULL DEFAULT NULL,
  `number_structures` INT(8) NULL DEFAULT NULL,
  `number_ncbi` INT(8) NULL DEFAULT NULL,
  `number_meta` INT(8) NULL DEFAULT NULL,
  `average_length` DOUBLE(6,2) NULL DEFAULT NULL,
  `percentage_id` INT(3) NULL DEFAULT NULL,
  `average_coverage` DOUBLE(6,2) NULL DEFAULT NULL,
  `change_status` TINYTEXT NULL DEFAULT NULL,
  `seed_consensus` TEXT NULL DEFAULT NULL,
  `full_consensus` TEXT NULL DEFAULT NULL,
  `number_shuffled_hits` INT(10) NULL DEFAULT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  UNIQUE INDEX `pfamA_acc` (`pfamA_acc` ASC),
  UNIQUE INDEX `pfamA_id` (`pfamA_id` ASC),
  INDEX `fk_PfamA_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamContextRegions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamContextRegions` ;

CREATE TABLE IF NOT EXISTS `PfamContextRegions` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `auto_pfamseq` BIGINT NOT NULL,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `domain_score` DOUBLE(16,2) NOT NULL DEFAULT '0.00',
  INDEX `fk_PfamContextRegions_PfamA1_idx` (`PfamA_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamContextRegions_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `DivisionTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DivisionTemp` ;

CREATE TABLE IF NOT EXISTS `DivisionTemp` (
  `id` INT NOT NULL,
  `Code` VARCHAR(4) NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  `Comment` VARCHAR(255) NULL DEFAULT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyDivision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyDivision` ;

CREATE TABLE IF NOT EXISTS `TaxonomyDivision` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `id` INT NOT NULL,
  `Code` VARCHAR(4) NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  `Comment` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Id` (`id` ASC),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GenCodeTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenCodeTemp` ;

CREATE TABLE IF NOT EXISTS `GenCodeTemp` (
  `GenCodeId` INT NOT NULL,
  `Abbreviation` VARCHAR(50) NULL DEFAULT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Code` VARCHAR(255) NOT NULL,
  `Start` VARCHAR(100) NULL DEFAULT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyGenCode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyGenCode` ;

CREATE TABLE IF NOT EXISTS `TaxonomyGenCode` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `GenCodeId` INT NOT NULL,
  `Abbreviation` VARCHAR(50) NULL DEFAULT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Code` VARCHAR(255) NOT NULL,
  `Start` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_GeneCodeId` (`GenCodeId` ASC),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `CitTax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CitTax` ;

CREATE TABLE IF NOT EXISTS `CitTax` (
  `cit_id` INT NULL DEFAULT NULL,
  `tax_id` INT NULL DEFAULT NULL,
  INDEX `pk_cit_id` (`cit_id` ASC),
  INDEX `pk_tax_id` (`tax_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `NCBICitationTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NCBICitationTemp` ;

CREATE TABLE IF NOT EXISTS `NCBICitationTemp` (
  `cit_id` INT NOT NULL,
  `cit_key` VARCHAR(500) NOT NULL,
  `pubmed_id` INT NULL DEFAULT NULL,
  `medline_id` INT NULL DEFAULT NULL,
  `url` VARCHAR(255) NULL DEFAULT NULL,
  `text` VARCHAR(5000) NULL DEFAULT NULL,
  `taxid_list` TEXT NULL DEFAULT NULL,
  INDEX `pk_cit_id` (`cit_id` ASC),
  INDEX `pk_medline_id` (`medline_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyUnParseCitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyUnParseCitation` ;

CREATE TABLE IF NOT EXISTS `TaxonomyUnParseCitation` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `CitId` INT NOT NULL,
  `CitKey` VARCHAR(500) NULL DEFAULT NULL,
  `URL` VARCHAR(255) NULL DEFAULT NULL,
  `Text` VARCHAR(5000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_CitId` (`CitId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Names` ;

CREATE TABLE IF NOT EXISTS `Names` (
  `tax_id` INT NOT NULL,
  `name_txt` VARCHAR(255) NOT NULL,
  `unique_name` VARCHAR(100) NOT NULL,
  `name_class` VARCHAR(100) NOT NULL,
  INDEX `pk_name_class` (`name_class` ASC),
  INDEX `pk_tax_id` (`tax_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Nodes` ;

CREATE TABLE IF NOT EXISTS `Nodes` (
  `tax_id` INT NOT NULL,
  `parent` INT NOT NULL,
  `rank_name` VARCHAR(100) NOT NULL,
  `embl` VARCHAR(10) NULL DEFAULT NULL,
  `division` INT NOT NULL,
  `inherited_div_flag` INT NOT NULL,
  `genetic` INT NOT NULL,
  `inherited_GC` INT NOT NULL,
  `mitochondrial` INT NOT NULL,
  `inherited_MGC` INT NOT NULL,
  `GenBank` INT NOT NULL,
  `hidden` INT NOT NULL,
  `Comment` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `pk_tax_id` (`tax_id` ASC),
  INDEX `pk_division` (`division` ASC),
  INDEX `pk_genetic` (`genetic` ASC),
  INDEX `pk_mitochondrial` (`mitochondrial` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Taxonomy` ;

CREATE TABLE IF NOT EXISTS `Taxonomy` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `TaxId` BIGINT NOT NULL,
  `ParentTaxId` BIGINT NOT NULL,
  `Rank` VARCHAR(100) NULL DEFAULT NULL,
  `EMBLCode` VARCHAR(5) NULL DEFAULT NULL,
  `TaxonomyDivision_WID` BIGINT NOT NULL,
  `InheritedDivision` VARCHAR(1) NULL DEFAULT NULL,
  `TaxonomyGenCode_WID` BIGINT NOT NULL,
  `InheritedGencode` VARCHAR(1) NULL DEFAULT NULL,
  `TaxonomyMCGenCode_WID` BIGINT NOT NULL,
  `InheritedMCGencode` VARCHAR(1) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_Taxonomy_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_TaxId` (`TaxId` ASC),
  INDEX `pk_ParentTaxId` (`ParentTaxId` ASC),
  INDEX `fk_Taxonomy_TaxonomyDivision1_idx` (`TaxonomyDivision_WID` ASC),
  INDEX `fk_Taxonomy_TaxonomyGenCode1_idx` (`TaxonomyGenCode_WID` ASC),
  INDEX `fk_Taxonomy_TaxonomyGenCode2_idx` (`TaxonomyMCGenCode_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomySynonymNameClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomySynonymNameClass` ;

CREATE TABLE IF NOT EXISTS `TaxonomySynonymNameClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `NameClass` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomySynonym` ;

CREATE TABLE IF NOT EXISTS `TaxonomySynonym` (
  `Taxonomy_WID` BIGINT NOT NULL,
  `Synonym` VARCHAR(255) NOT NULL,
  `TaxonomySynonymNameClass_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Taxonomy_WID`, `Synonym`, `TaxonomySynonymNameClass_WID`),
  INDEX `fk_TaxonomySynonym_TaxonomySynonymNameClass1_idx` (`TaxonomySynonymNameClass_WID` ASC),
  INDEX `synonym_index` (`Synonym` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyPMID` ;

CREATE TABLE IF NOT EXISTS `TaxonomyPMID` (
  `Taxonomy_WID` BIGINT NOT NULL,
  `PMID` BIGINT NOT NULL,
  PRIMARY KEY (`Taxonomy_WID`, `PMID`),
  INDEX `fk_TaxonomyPMID_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `pk_PMID` (`PMID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Taxonomy_has_TaxonomyUnParseCitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Taxonomy_has_TaxonomyUnParseCitation` ;

CREATE TABLE IF NOT EXISTS `Taxonomy_has_TaxonomyUnParseCitation` (
  `Taxonomy_WID` BIGINT NOT NULL,
  `TaxonomyUnParseCitation_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Taxonomy_WID`, `TaxonomyUnParseCitation_WID`),
  INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_TaxonomyUnParseCita_idx` (`TaxonomyUnParseCitation_WID` ASC),
  INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_Taxonomy1_idx` (`Taxonomy_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `OntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologySubset` ;

CREATE TABLE IF NOT EXISTS `OntologySubset` (
  `WID` BIGINT NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_id` (`Id` ASC),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology` ;

CREATE TABLE IF NOT EXISTS `Ontology` (
  `WID` BIGINT NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `NameSpace` VARCHAR(25) NOT NULL,
  `Def` VARCHAR(5000) NULL DEFAULT NULL,
  `Comment` VARCHAR(1000) NULL DEFAULT NULL,
  `IsObsolete` TINYINT(1) NOT NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_Ontology_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_id` (`Id` ASC),
  INDEX `pk_Name` (`Name` ASC),
  INDEX `pk_IsObsolete` (`IsObsolete` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDXRefTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDXRefTemp` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDXRefTemp` (
  `OntologyWID` BIGINT NOT NULL,
  `ACC` VARCHAR(255) NULL,
  `DBName` VARCHAR(255) NULL,
  `Name` VARCHAR(255) NULL,
  `Type` VARCHAR(25) NULL,
  INDEX `pk_OntologyWID` (`OntologyWID` ASC),
  INDEX `all_index` (`ACC` ASC, `Type` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyXRef` ;

CREATE TABLE IF NOT EXISTS `OntologyXRef` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `ACC` VARCHAR(255) NOT NULL,
  `DBName` VARCHAR(255) NOT NULL,
  `Name` VARCHAR(255) NULL,
  `Type` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_ACC` USING BTREE (`ACC` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDOntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDOntologySubset` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDOntologySubset` (
  `OntologyWID` BIGINT NOT NULL,
  `Subset` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`OntologyWID`, `Subset`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyAlternativeId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyAlternativeId` ;

CREATE TABLE IF NOT EXISTS `OntologyAlternativeId` (
  `Ontology_WID` BIGINT NOT NULL,
  `AltId` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `AltId`),
  INDEX `fk_OntologyAlternativeId_Ontology1_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDSynonymTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDSynonymTemp` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDSynonymTemp` (
  `OntologyWID` BIGINT NOT NULL,
  `Synonym` VARCHAR(1000) NOT NULL,
  `Scope` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `pk_OntologyWID` (`OntologyWID` ASC),
  INDEX `pk_Synonym` USING HASH (`Synonym`(255) ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologySynonym` ;

CREATE TABLE IF NOT EXISTS `OntologySynonym` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Synonym` VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Synonym` USING BTREE (`Synonym`(255) ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyRelation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyRelation` ;

CREATE TABLE IF NOT EXISTS `OntologyRelation` (
  `Ontology_WID` BIGINT NOT NULL,
  `OtherOntology_WID` BIGINT NOT NULL,
  `Type` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `OtherOntology_WID`),
  INDEX `fk_OntologyRelation_Ontology2_idx` (`OtherOntology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyIsA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyIsA` ;

CREATE TABLE IF NOT EXISTS `OntologyIsA` (
  `Ontology_WID` BIGINT NOT NULL,
  `IsAOntology_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `IsAOntology_WID`),
  INDEX `fk_IsAOntology_Ontology` (`IsAOntology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyToConsider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyToConsider` ;

CREATE TABLE IF NOT EXISTS `OntologyToConsider` (
  `Ontology_WID` BIGINT NOT NULL,
  `ToConsiderOntology_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `ToConsiderOntology_WID`),
  INDEX `fk_OntologyToConsider_Ontology2_idx` (`ToConsiderOntology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDIsATemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDIsATemp` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDIsATemp` (
  `OntologyWID` BIGINT NOT NULL,
  `isA` VARCHAR(25) NOT NULL,
  INDEX `pk_OntologyWID` (`OntologyWID` ASC),
  INDEX `pk_IsA` (`isA` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDRelationTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDRelationTemp` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDRelationTemp` (
  `OntologyWID` BIGINT NOT NULL,
  `Type` VARCHAR(25) NOT NULL,
  `OtherId` VARCHAR(25) NOT NULL,
  INDEX `pk_OntologyWID` (`OntologyWID` ASC),
  INDEX `pk_OtherId` (`OtherId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyWIDToConsiderTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDToConsiderTemp` ;

CREATE TABLE IF NOT EXISTS `OntologyWIDToConsiderTemp` (
  `OntologyWID` BIGINT NOT NULL,
  `OtherId` VARCHAR(25) NOT NULL,
  INDEX `pk_OntologyWID` (`OntologyWID` ASC),
  INDEX `pk_OtherId` (`OtherId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyPMID` ;

CREATE TABLE IF NOT EXISTS `OntologyPMID` (
  `Ontology_WID` BIGINT NOT NULL,
  `PMID` BIGINT NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `PMID`),
  INDEX `fk_OntologyPMID_Ontology1_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologySubset` ;

CREATE TABLE IF NOT EXISTS `Ontology_has_OntologySubset` (
  `Ontology_WID` BIGINT NOT NULL,
  `OntologySubset_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `OntologySubset_WID`),
  INDEX `fk_Ontology_has_OntologySubset_OntologySubset1_idx` (`OntologySubset_WID` ASC),
  INDEX `fk_Ontology_has_OntologySubset_Ontology1_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologyXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologyXRef` ;

CREATE TABLE IF NOT EXISTS `Ontology_has_OntologyXRef` (
  `Ontology_WID` BIGINT NOT NULL,
  `OntologyXRef_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `OntologyXRef_WID`),
  INDEX `fk_Ontology_has_OntologyXRef_OntologyXRef1_idx` (`OntologyXRef_WID` ASC),
  INDEX `fk_Ontology_has_OntologyXRef_Ontology1_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologySynonym` ;

CREATE TABLE IF NOT EXISTS `Ontology_has_OntologySynonym` (
  `Ontology_WID` BIGINT NOT NULL,
  `OntologySynonym_WID` BIGINT NOT NULL,
  `Scope` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Ontology_WID`, `OntologySynonym_WID`, `Scope`),
  INDEX `fk_Ontology_has_OntologySynonym_OntologySynonym1_idx` (`OntologySynonym_WID` ASC),
  INDEX `fk_Ontology_has_OntologySynonym_Ontology1_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo` ;

CREATE TABLE IF NOT EXISTS `GeneInfo` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `GeneID` BIGINT NOT NULL,
  `TaxID` BIGINT NOT NULL,
  `Symbol` VARCHAR(50) NULL DEFAULT NULL,
  `LocusTag` VARCHAR(100) NULL DEFAULT NULL,
  `Chromosome` VARCHAR(25) NULL DEFAULT NULL,
  `MapLocation` VARCHAR(100) NULL DEFAULT NULL,
  `Description` VARCHAR(5000) NULL DEFAULT NULL,
  `TypeOfGene` VARCHAR(25) NULL DEFAULT NULL,
  `SymbolFromNomenclature` VARCHAR(25) NULL DEFAULT NULL,
  `FullNameFromNomenclatureAuthority` VARCHAR(255) NULL DEFAULT NULL,
  `NomenclatureStatus` VARCHAR(2) NULL DEFAULT NULL,
  `OtherDesignations` VARCHAR(5000) NULL DEFAULT NULL,
  `ModificationDate` DATETIME NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  UNIQUE INDEX `pk_GeneId` (`GeneID` ASC),
  INDEX `pk_Symbol` (`Symbol` ASC),
  INDEX `fk_GeneInfo_DataSet_idx` (`DataSetWID` ASC),
  INDEX `fk_GeneInfo_Taxonomy_idx` (`TaxID` ASC),
  INDEX `pk_LocusTag` (`LocusTag` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneInfoSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoSynonyms` ;

CREATE TABLE IF NOT EXISTS `GeneInfoSynonyms` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `Synonyms` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `Synonyms`),
  INDEX `fk_GeneInfoSynonyms_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_Synonym` (`Synonyms` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneInfoDBXrefs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoDBXrefs` ;

CREATE TABLE IF NOT EXISTS `GeneInfoDBXrefs` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `DBName` VARCHAR(50) NOT NULL,
  `ID` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `DBName`, `ID`),
  INDEX `fk_GeneInfoDBXrefs_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_DBName` (`DBName` ASC),
  INDEX `pk_ID` (`ID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Gene2Ensembl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2Ensembl` ;

CREATE TABLE IF NOT EXISTS `Gene2Ensembl` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `EnsemblGeneIdentifier` VARCHAR(20) NULL DEFAULT NULL,
  `RNANucleotideAccession` VARCHAR(20) NULL DEFAULT NULL,
  `EnsemblRNAIdentifier` VARCHAR(20) NULL DEFAULT NULL,
  `ProteinAccession` VARCHAR(20) NULL DEFAULT NULL,
  `EnsemblProteinIdentifier` VARCHAR(20) NULL DEFAULT NULL,
  INDEX `fk_Gene2Ensembl_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_RNANucleotideAccession` (`RNANucleotideAccession` ASC),
  INDEX `pk_EnsemblRNAIdentifier` (`EnsemblRNAIdentifier` ASC),
  INDEX `pk_ProteinAccession` (`ProteinAccession` ASC),
  INDEX `pk_EnsemblProteinIdentifier` (`EnsemblProteinIdentifier` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Gene2GO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2GO` ;

CREATE TABLE IF NOT EXISTS `Gene2GO` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `GOID` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `GOID`),
  INDEX `fk_Gene2GO_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_GOID` (`GOID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Gene2PMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2PMID` ;

CREATE TABLE IF NOT EXISTS `Gene2PMID` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `PMID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `PMID`),
  INDEX `fk_Gene2PMID_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_PMID` (`PMID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Gene2STS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2STS` ;

CREATE TABLE IF NOT EXISTS `Gene2STS` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `UniSTSID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `UniSTSID`),
  INDEX `fk_Gene2STS_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_UniSTSID` (`UniSTSID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Gene2UniGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2UniGene` ;

CREATE TABLE IF NOT EXISTS `Gene2UniGene` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `UniGene` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `UniGene`),
  INDEX `fk_Gene2UniGene_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_UniGene` (`UniGene` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneGroup` ;

CREATE TABLE IF NOT EXISTS `GeneGroup` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `Relationship` VARCHAR(25) NOT NULL,
  `OtherGeneInfo_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `OtherGeneInfo_WID`, `Relationship`),
  INDEX `fk_GeneGroup_GeneInfo2_idx` (`OtherGeneInfo_WID` ASC),
  INDEX `fk_GeneGroup_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `pk_RelationShip` (`Relationship` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneHistory` ;

CREATE TABLE IF NOT EXISTS `GeneHistory` (
  `TaxID` BIGINT NOT NULL,
  `GeneID` BIGINT NULL,
  `DiscontinuedGeneID` BIGINT NOT NULL,
  `DiscontinuedSymbol` VARCHAR(50) NOT NULL,
  `DiscontinueDate` DATETIME NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`DiscontinuedGeneID`),
  INDEX `pk_TaxId` (`TaxID` ASC),
  INDEX `pk_GeneId` (`GeneID` ASC),
  INDEX `pk_DiscontinuedGeneId` (`DiscontinuedGeneID` ASC),
  INDEX `pk_DiscontinuedSymbol` (`DiscontinuedSymbol` ASC),
  INDEX `fk_GeneHistory_DataSet_idx` (`DataSetWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneRefseqUniProt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneRefseqUniProt` ;

CREATE TABLE IF NOT EXISTS `GeneRefseqUniProt` (
  `ProteinAccession` VARCHAR(50) NOT NULL,
  `UniProtKBProteinAccession` VARCHAR(50) NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`ProteinAccession`, `UniProtKBProteinAccession`),
  INDEX `pk_ProteinAccession1` (`ProteinAccession` ASC),
  INDEX `pk_UniProtKBProteinAccession1` (`UniProtKBProteinAccession` ASC),
  INDEX `fk_GeneRefseqUniProt_DataSet1` (`DataSetWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_info` ;

CREATE TABLE IF NOT EXISTS `gene_info` (
  `GeneID` BIGINT NOT NULL,
  `Synonyms` TEXT NOT NULL,
  `dbXrefs` TEXT NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneInfoWIDSynonymsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoWIDSynonymsTemp` ;

CREATE TABLE IF NOT EXISTS `GeneInfoWIDSynonymsTemp` (
  `GeneID` BIGINT NOT NULL,
  `Synonyms` VARCHAR(100) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneInfoWIDDBXrefsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoWIDDBXrefsTemp` ;

CREATE TABLE IF NOT EXISTS `GeneInfoWIDDBXrefsTemp` (
  `GeneID` BIGINT NOT NULL,
  `DBName` VARCHAR(50) NOT NULL,
  `ID` VARCHAR(50) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2accessiontemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2accessiontemp` ;

CREATE TABLE IF NOT EXISTS `gene2accessiontemp` (
  `GeneID` BIGINT NOT NULL,
  `Status` VARCHAR(50) NULL,
  `RNANucleotideAccession` VARCHAR(50) NULL,
  `RNANucleotideGi` VARCHAR(50) NULL,
  `ProteinAccession` VARCHAR(50) NULL,
  `ProteinGi` VARCHAR(50) NULL,
  `GenomicNucleotideAccession` VARCHAR(50) NULL,
  `GenomicNucleotideGi` VARCHAR(50) NULL,
  `StartPositionOnTheGenomicAccession` VARCHAR(50) NULL,
  `EndPositionOnTheGenomicAccession` VARCHAR(50) NULL,
  `Orientation` VARCHAR(50) NULL,
  `Assembly` VARCHAR(50) NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC),
  INDEX `rna_index` (`RNANucleotideGi` ASC),
  INDEX `protein_index` (`ProteinGi` ASC),
  INDEX `genomic_index` (`GenomicNucleotideGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2ensembltemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2ensembltemp` ;

CREATE TABLE IF NOT EXISTS `gene2ensembltemp` (
  `GeneID` BIGINT NOT NULL,
  `EnsemblGeneIdentifier` VARCHAR(20) NULL,
  `RNANucleotideAccession` VARCHAR(20) NULL,
  `EnsemblRNAIdentifier` VARCHAR(20) NULL,
  `ProteinAccession` VARCHAR(20) NULL,
  `EnsemblProteinIdentifier` VARCHAR(20) NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2gotemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2gotemp` ;

CREATE TABLE IF NOT EXISTS `gene2gotemp` (
  `GeneID` BIGINT NOT NULL,
  `GOID` VARCHAR(15) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2pubmedtemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2pubmedtemp` ;

CREATE TABLE IF NOT EXISTS `gene2pubmedtemp` (
  `GeneID` BIGINT NOT NULL,
  `PMID` VARCHAR(255) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2ststemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2ststemp` ;

CREATE TABLE IF NOT EXISTS `gene2ststemp` (
  `GeneID` BIGINT NOT NULL,
  `UniSTSID` BIGINT NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene2unigenetemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2unigenetemp` ;

CREATE TABLE IF NOT EXISTS `gene2unigenetemp` (
  `GeneID` BIGINT NOT NULL,
  `UniGene` VARCHAR(25) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_group` ;

CREATE TABLE IF NOT EXISTS `gene_group` (
  `GeneID` BIGINT NOT NULL,
  `Relationship` VARCHAR(25) NOT NULL,
  `OtherGeneID` BIGINT NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `gene_ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_ontology` ;

CREATE TABLE IF NOT EXISTS `gene_ontology` (
  `auto_pfamA` INT(5) NOT NULL DEFAULT '0',
  `go_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `term` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `category` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  INDEX `auto_pfamA` (`auto_pfamA` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `gene_refseq_uniprotkb_collab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_refseq_uniprotkb_collab` ;

CREATE TABLE IF NOT EXISTS `gene_refseq_uniprotkb_collab` (
  `ProteinAccession` VARCHAR(50) NOT NULL,
  `UniProtKBProteinAccession` VARCHAR(50) NOT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `mim2gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mim2gene` ;

CREATE TABLE IF NOT EXISTS `mim2gene` (
  `MIM` BIGINT NOT NULL,
  `GeneID` BIGINT NOT NULL,
  `Type` VARCHAR(10) NOT NULL,
  INDEX `pk_Gene_Id` (`GeneID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GenePTTTaxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenePTTTaxonomy` ;

CREATE TABLE IF NOT EXISTS `GenePTTTaxonomy` (
  `TaxId` BIGINT NOT NULL,
  `Synonym` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`TaxId`),
  INDEX `fk_GenomesPPTTaxonomy_Taxonomy_idx` (`TaxId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBank` ;

CREATE TABLE IF NOT EXISTS `GeneBank` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `LocusName` VARCHAR(25) NOT NULL,
  `SeqLengh` INT NOT NULL,
  `MolType` VARCHAR(10) NOT NULL,
  `Division` VARCHAR(5) NULL,
  `ModDate` DATETIME NOT NULL,
  `Definition` TEXT NULL,
  `Version` VARCHAR(3) NULL,
  `Gi` INT NOT NULL,
  `TaxId` INT NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Source` VARCHAR(255) NOT NULL,
  `Organism` TEXT NULL,
  `Seq` TEXT NULL,
  `FileName` VARCHAR(45) NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_GeneBank_DataSet1_idx` (`DataSet_WID` ASC),
  INDEX `TaxId_INDEX` (`TaxId` ASC),
  INDEX `Division_index` (`Division` ASC),
  INDEX `FileName_index` (`FileName` ASC),
  UNIQUE INDEX `LocusName_UNIQUE` (`LocusName` ASC),
  UNIQUE INDEX `Gi_UNIQUE` (`Gi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankCDS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankCDS` ;

CREATE TABLE IF NOT EXISTS `GeneBankCDS` (
  `WID` BIGINT NOT NULL,
  `ProteinGi` INT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Product` VARCHAR(255) NULL,
  `ProteinId` VARCHAR(25) NULL,
  `Gene` VARCHAR(45) NULL,
  `Locus_Tag` VARCHAR(45) NULL,
  `Translation` TINYINT(1) NULL,
  `GeneBank_WID` BIGINT NOT NULL,
  INDEX `fk_GeneBankCDS_GeneBank1_idx` (`GeneBank_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `proteinId_index` (`ProteinId` ASC),
  INDEX `proteinGi_index` (`ProteinGi` ASC),
  INDEX `location_index` (`Location` ASC),
  UNIQUE INDEX `ProteinGi_UNIQUE` (`ProteinGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GenePTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenePTT` ;

CREATE TABLE IF NOT EXISTS `GenePTT` (
  `pFrom` BIGINT NOT NULL,
  `pTo` BIGINT NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Strand` VARCHAR(50) NOT NULL,
  `PLength` INT NOT NULL,
  `ProteinGi` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(100) NULL,
  `GeneLocusTag` VARCHAR(100) NULL,
  `Code` VARCHAR(50) NULL,
  `COG` VARCHAR(50) NULL,
  `Product` VARCHAR(1000) NOT NULL,
  `PTTFile` VARCHAR(50) NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`ProteinGi`),
  INDEX `fk_GenomesPTT_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_pFrom` (`pFrom` ASC),
  INDEX `pk_pTo` (`pTo` ASC),
  INDEX `pk_GeneSymbol` (`GeneSymbol` ASC),
  INDEX `pk_COG` (`COG` ASC),
  INDEX `pk_PTTFile` (`PTTFile` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GenePTTTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenePTTTemp` ;

CREATE TABLE IF NOT EXISTS `GenePTTTemp` (
  `Location` VARCHAR(100) NOT NULL,
  `Strand` VARCHAR(50) NOT NULL,
  `PLength` INT NOT NULL,
  `ProteinGi` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(100) NOT NULL,
  `GeneLocusTag` VARCHAR(100) NOT NULL,
  `Code` VARCHAR(50) NOT NULL,
  `COG` VARCHAR(50) NOT NULL,
  `Product` VARCHAR(1000) NOT NULL,
  `PTTFile` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ProteinGi`),
  INDEX `pk_PTTFile` (`PTTFile` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `PfamADatabaseLinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamADatabaseLinks` ;

CREATE TABLE IF NOT EXISTS `PfamADatabaseLinks` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `db_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `comment` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `db_link` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `other_params` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  INDEX `fk_PfamADatabaseLinks_PfamA1_idx` (`PfamA_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamAInteractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamAInteractions` ;

CREATE TABLE IF NOT EXISTS `PfamAInteractions` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `OtherPfamA_WID` BIGINT(20) NOT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamANCBIReg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamANCBIReg` ;

CREATE TABLE IF NOT EXISTS `PfamANCBIReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `GeneId` BIGINT NOT NULL,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `ali_start` MEDIUMINT(8) NOT NULL,
  `ali_end` MEDIUMINT(8) NOT NULL,
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `domain_bits_score` DOUBLE(16,4) NOT NULL DEFAULT '0.0000',
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `sequence_bits_score` DOUBLE(16,4) NOT NULL DEFAULT '0.0000',
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `in_full` TINYINT(4) NOT NULL DEFAULT '0',
  `tree_order` MEDIUMINT(9) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamANCBIReg_PfamA1_idx` (`PfamA_WID` ASC),
  INDEX `fk_GeneInfo_GeneId_idx` (`GeneId` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamARegFullSignificant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamARegFullSignificant` ;

CREATE TABLE IF NOT EXISTS `PfamARegFullSignificant` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `ali_start` MEDIUMINT(8) UNSIGNED NOT NULL,
  `ali_end` MEDIUMINT(8) UNSIGNED NOT NULL,
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `domain_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00',
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `sequence_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00',
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `in_full` TINYINT(4) NOT NULL DEFAULT '0',
  `tree_order` MEDIUMINT(9) NULL DEFAULT NULL,
  `domain_order` MEDIUMINT(9) NULL DEFAULT NULL,
  `domain_oder` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `in_full` (`in_full` ASC),
  INDEX `fk_PfamARegFullSignificant_PfamA1_idx` (`PfamA_WID` ASC),
  INDEX `fk_PfamARegFullSignificant_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_auto_pfamseq` (`auto_pfamseq` ASC),
  INDEX `pk_multiple` (`WID` ASC, `PfamA_WID` ASC, `Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamAPDBReg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamAPDBReg` ;

CREATE TABLE IF NOT EXISTS `PfamAPDBReg` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `PfamARegFullSignificant_WID` BIGINT(20) NOT NULL,
  `chain` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `pdb_res_start` MEDIUMINT(8) NULL DEFAULT NULL,
  `pdb_start_icode` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `pdb_res_end` MEDIUMINT(8) NULL DEFAULT NULL,
  `pdb_end_icode` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `hex_colour` VARCHAR(6) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamAPDBReg_PfamARegFullSignificant1_idx` (`PfamARegFullSignificant_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamARegFullInsignificant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamARegFullInsignificant` ;

CREATE TABLE IF NOT EXISTS `PfamARegFullInsignificant` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `model_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `model_end` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `domain_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00',
  `domain_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `sequence_bits_score` DOUBLE(8,2) NOT NULL DEFAULT '0.00',
  `sequence_evalue_score` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamARegFullInsignificant_PfamA1_idx` (`PfamA_WID` ASC),
  INDEX `fk_PfamARegFullInsignificant_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_auto_pfamseq` (`auto_pfamseq` ASC),
  INDEX `pk_multiple` (`WID` ASC, `PfamA_WID` ASC, `Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamARegSeed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamARegSeed` ;

CREATE TABLE IF NOT EXISTS `PfamARegSeed` (
  `auto_pfamseq` BIGINT NOT NULL,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `seq_start` MEDIUMINT(8) NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(8) NOT NULL,
  `cigar` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `tree_order` MEDIUMINT(9) NOT NULL,
  INDEX `fk_PfamARegSeed_PfamA1_idx` (`PfamA_WID` ASC),
  PRIMARY KEY (`auto_pfamseq`, `PfamA_WID`, `tree_order`),
  INDEX `fk_PfamARegSeed_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamArchitecture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamArchitecture` ;

CREATE TABLE IF NOT EXISTS `PfamArchitecture` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `architecture` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `type_example` INT(10) NOT NULL DEFAULT '0',
  `no_seqs` INT(8) NOT NULL DEFAULT '0',
  `architecture_acc` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `architecture_type_example_idx` (`type_example` ASC),
  INDEX `architecture_architecture_idx` (`architecture`(255) ASC),
  INDEX `architecture_architecture_acc_idx` (`architecture_acc`(255) ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamInterpro`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamInterpro` ;

CREATE TABLE IF NOT EXISTS `PfamInterpro` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `interpro_id` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `abstract` LONGTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  INDEX `fk_PfamInterpro_PfamA1_idx` (`PfamA_WID` ASC),
  UNIQUE INDEX `PfamA_WID_UNIQUE` (`PfamA_WID` ASC),
  PRIMARY KEY (`PfamA_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamLiteratureReferences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamLiteratureReferences` ;

CREATE TABLE IF NOT EXISTS `PfamLiteratureReferences` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pmid` INT(10) NULL DEFAULT NULL,
  `title` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `author` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `journal` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  UNIQUE INDEX `IX_literature_references_1` (`pmid` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamMarkupKey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamMarkupKey` ;

CREATE TABLE IF NOT EXISTS `PfamMarkupKey` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `label` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamNestedLocations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamNestedLocations` ;

CREATE TABLE IF NOT EXISTS `PfamNestedLocations` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `OtherPfamA_WID` BIGINT(20) NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  `seq_version` TINYINT(4) NULL DEFAULT NULL,
  `seq_start` MEDIUMINT(8) NULL DEFAULT NULL,
  `seq_end` MEDIUMINT(8) NULL DEFAULT NULL,
  INDEX `OtherPfamA_WID` (`OtherPfamA_WID` ASC),
  INDEX `fk_PfamNestedLocations_PfamA1_idx` (`PfamA_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamNestedLocations_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamOtherReg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamOtherReg` ;

CREATE TABLE IF NOT EXISTS `PfamOtherReg` (
  `region_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `auto_pfamseq` BIGINT NOT NULL,
  `seq_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `seq_end` MEDIUMINT(6) UNSIGNED NOT NULL DEFAULT '0',
  `type_id` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `source_id` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `score` DOUBLE(16,4) NULL,
  `orientation` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`region_id`),
  INDEX `other_reg_type_id_idx` (`type_id` ASC),
  INDEX `other_reg_source_id_idx` (`source_id` ASC),
  INDEX `fk_PfamOtherReg_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamPDB`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamPDB` ;

CREATE TABLE IF NOT EXISTS `PfamPDB` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `pdb_id` VARCHAR(5) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `keywords` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `title` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `date` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `resolution` DECIMAL(5,2) NULL DEFAULT '0.00',
  `method` TINYTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `author` MEDIUMTEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pdb_id_idx` (`pdb_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamPDBResidueData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamPDBResidueData` ;

CREATE TABLE IF NOT EXISTS `PfamPDBResidueData` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `auto_pfamseq` BIGINT NOT NULL,
  `PfamPDB_WID` BIGINT(20) NOT NULL,
  `chain` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `serial` INT(10) NOT NULL,
  `pdb_res` CHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `pdb_seq_number` INT(10) NULL DEFAULT NULL,
  `pdb_insert_code` VARCHAR(1) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `observed` INT(1) NULL DEFAULT NULL,
  `dssp_code` VARCHAR(4) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `pfamseq_res` CHAR(3) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `pfamseq_seq_number` INT(10) NULL DEFAULT NULL,
  INDEX `fk_PfamPDBResidueData_PfamPDB1_idx` (`PfamPDB_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamPDBResidueData_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamProteomeRegions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamProteomeRegions` ;

CREATE TABLE IF NOT EXISTS `PfamProteomeRegions` (
  `PfamCompleteProteomes_WID` BIGINT(20) NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  `PfamA_WID` BIGINT(20) NOT NULL,
  `count` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  INDEX `fk_PfamProteomeRegions_PfamCompleteProteomes1_idx` (`PfamCompleteProteomes_WID` ASC),
  INDEX `fk_PfamProteomeRegions_PfamA1_idx` (`PfamA_WID` ASC),
  PRIMARY KEY (`PfamCompleteProteomes_WID`, `auto_pfamseq`, `PfamA_WID`),
  INDEX `fk_PfamProteomeRegions_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamSeqDisulphide`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamSeqDisulphide` ;

CREATE TABLE IF NOT EXISTS `PfamSeqDisulphide` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `auto_pfamseq` BIGINT NOT NULL,
  `bond_start` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `bond_end` MEDIUMINT(8) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamSeqDisulphide_PfamSeq_has_Protein2_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `PfamMarkup_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamMarkup_has_Protein` ;

CREATE TABLE IF NOT EXISTS `PfamMarkup_has_Protein` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `auto_pfamseq` BIGINT NOT NULL,
  `PfamMarkupKey_WID` BIGINT(20) NOT NULL,
  `residue` MEDIUMINT(8) UNSIGNED NOT NULL DEFAULT '0',
  `annotation` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  INDEX `fk_PfamSeqMarkup_PfamMarkupKey1_idx` (`PfamMarkupKey_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `fk_PfamMarkup_has_Protein_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `ProteinName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinName` ;

CREATE TABLE IF NOT EXISTS `ProteinName` (
  `Protein_WID` BIGINT NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  `OrderNumber` INT NOT NULL,
  INDEX `fk_ProteinName_Protein1_idx` (`Protein_WID` ASC),
  PRIMARY KEY (`Protein_WID`, `Name`),
  INDEX `name_index` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinAccessionNumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinAccessionNumber` ;

CREATE TABLE IF NOT EXISTS `ProteinAccessionNumber` (
  `Protein_WID` BIGINT NOT NULL,
  `AccessionNumber` VARCHAR(10) NOT NULL,
  `OrderNumber` INT NOT NULL,
  INDEX `fk_ProteinAccessionNumber_Protein1_idx` (`Protein_WID` ASC),
  INDEX `main_index` (`AccessionNumber` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinLongName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinLongName` ;

CREATE TABLE IF NOT EXISTS `ProteinLongName` (
  `Protein_WID` BIGINT NOT NULL,
  `ProteinNameDef` VARCHAR(30) NOT NULL,
  `Type` VARCHAR(10) NULL DEFAULT 'fullName',
  `Component` TINYINT(1) NULL DEFAULT 0,
  `Domain` TINYINT(1) NULL DEFAULT 0,
  `Name` VARCHAR(500) NOT NULL,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL,
  `Status` VARCHAR(15) NULL DEFAULT NULL,
  INDEX `pk_Name` USING HASH (`Name`(255) ASC),
  INDEX `pk_ProteinNameDef` (`ProteinNameDef` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `fk_ProteinLongName_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinGeneName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneName` ;

CREATE TABLE IF NOT EXISTS `ProteinGeneName` (
  `Protein_WID` BIGINT NOT NULL,
  `GeneNameType` VARCHAR(15) NOT NULL,
  `Name` VARCHAR(50) NOT NULL,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL,
  INDEX `fk_ProteinGeneName_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_GeneNameType` (`GeneNameType` ASC),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinDBReference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDBReference` ;

CREATE TABLE IF NOT EXISTS `ProteinDBReference` (
  `WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  `Type` VARCHAR(100) NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  `Evidence` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProteinDBReference_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinGo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGo` ;

CREATE TABLE IF NOT EXISTS `ProteinGo` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinRefSeq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinRefSeq` ;

CREATE TABLE IF NOT EXISTS `ProteinRefSeq` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinRefSeq_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPMID` ;

CREATE TABLE IF NOT EXISTS `ProteinPMID` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinPMID_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinKEGG`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKEGG` ;

CREATE TABLE IF NOT EXISTS `ProteinKEGG` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinKEGG_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinEC`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinEC` ;

CREATE TABLE IF NOT EXISTS `ProteinEC` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinEC_Protein1_idx` (`Protein_WID` ASC),
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `id_index` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinBioCyc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinBioCyc` ;

CREATE TABLE IF NOT EXISTS `ProteinBioCyc` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinBioCyc_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinPDB`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPDB` ;

CREATE TABLE IF NOT EXISTS `ProteinPDB` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinPDB_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinIntAct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIntAct` ;

CREATE TABLE IF NOT EXISTS `ProteinIntAct` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinIntAct_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinDIP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDIP` ;

CREATE TABLE IF NOT EXISTS `ProteinDIP` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinDIP_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinMINT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinMINT` ;

CREATE TABLE IF NOT EXISTS `ProteinMINT` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinMINT_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinDrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDrugBank` ;

CREATE TABLE IF NOT EXISTS `ProteinDrugBank` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinDrugBank_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinDBReferenceProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDBReferenceProperty` ;

CREATE TABLE IF NOT EXISTS `ProteinDBReferenceProperty` (
  `ProteinDBReference_WID` BIGINT NOT NULL,
  `AttribType` VARCHAR(100) NOT NULL,
  `AttribValue` VARCHAR(255) NULL,
  PRIMARY KEY (`ProteinDBReference_WID`, `AttribType`),
  INDEX `fk_ProteinDBReferenceProperty_ProteinDBReference1_idx` (`ProteinDBReference_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinGeneLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneLocation` ;

CREATE TABLE IF NOT EXISTS `ProteinGeneLocation` (
  `Protein_WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Type` VARCHAR(255) NULL DEFAULT NULL,
  `Status` VARCHAR(15) NULL DEFAULT NULL,
  INDEX `fk_ProteinGeneLocation_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_Name` (`Name` ASC),
  INDEX `pk_Type` (`Type` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinComment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinComment` ;

CREATE TABLE IF NOT EXISTS `ProteinComment` (
  `WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  `Name` VARCHAR(100) NULL DEFAULT NULL,
  `Mass` FLOAT NULL DEFAULT NULL,
  `Error` VARCHAR(255) NULL DEFAULT NULL,
  `Method` VARCHAR(255) NULL DEFAULT NULL,
  `Type` VARCHAR(30) NULL DEFAULT NULL,
  `LocationType` VARCHAR(255) NULL DEFAULT NULL,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL,
  `Text` TEXT NULL DEFAULT NULL,
  `TextEvidence` VARCHAR(255) NULL DEFAULT NULL,
  `TextStatus` VARCHAR(15) NULL DEFAULT NULL,
  `Molecule` VARCHAR(255) NULL DEFAULT NULL,
  `OrganismsDiffer` VARCHAR(25) NULL DEFAULT NULL,
  `Experiments` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProteinComment_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_Type` (`Type` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinOtherLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinOtherLocation` ;

CREATE TABLE IF NOT EXISTS `ProteinOtherLocation` (
  `WID` BIGINT NOT NULL,
  `OtherWID` BIGINT NOT NULL,
  `BeginPos` INT NULL DEFAULT -1,
  `BeginStatus` VARCHAR(15) NULL DEFAULT NULL,
  `EndPos` INT NULL DEFAULT -1,
  `EndStatus` VARCHAR(15) NULL DEFAULT NULL,
  `Position` INT NULL DEFAULT -1,
  `PositionStatus` VARCHAR(15) NULL DEFAULT NULL,
  `Sequence` VARCHAR(1000) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProteinOtherLocation_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_OtherWID` (`OtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentSubCellularLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentSubCellularLocation` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentSubCellularLocation` (
  `ProteinComment_WID` BIGINT NOT NULL,
  `Data` VARCHAR(255) NULL DEFAULT NULL,
  `Element` VARCHAR(15) NULL DEFAULT NULL,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL,
  `Status` VARCHAR(15) NULL DEFAULT NULL,
  INDEX `fk_ProteinCommentSubCellularLocation_ProteinComment1_idx` (`ProteinComment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentConflict`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentConflict` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentConflict` (
  `ProteinComment_WID` BIGINT NOT NULL,
  `Type` VARCHAR(40) NOT NULL,
  `SeqVersion` INT NULL DEFAULT NULL,
  `SeqResource` VARCHAR(25) NULL DEFAULT NULL,
  `SeqID` VARCHAR(25) NULL DEFAULT NULL,
  INDEX `fk_ProteinCommentConflict_ProteinComment1_idx` (`ProteinComment_WID` ASC),
  INDEX `type_index` (`Type` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentLink` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentLink` (
  `ProteinComment_WID` BIGINT NOT NULL,
  `URI` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`ProteinComment_WID`, `URI`),
  INDEX `fk_ProteinCommentLink_ProteinComment1_idx` (`ProteinComment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentEvent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentEvent` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentEvent` (
  `ProteinComment_WID` BIGINT NOT NULL,
  `EventType` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ProteinComment_WID`, `EventType`),
  INDEX `fk_ProteinCommentEvent_ProteinComment1_idx` (`ProteinComment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentIsoform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentIsoform` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentIsoform` (
  `WID` BIGINT NOT NULL,
  `ProteinComment_WID` BIGINT NOT NULL,
  `SeqType` VARCHAR(25) NULL DEFAULT NULL,
  `SeqRef` VARCHAR(255) NULL DEFAULT NULL,
  `Note` TEXT NULL DEFAULT NULL,
  `NoteEvidence` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProteinCommentIsoform_ProteinComment1_idx` (`ProteinComment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinIsoformId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIsoformId` ;

CREATE TABLE IF NOT EXISTS `ProteinIsoformId` (
  `ProteinCommentIsoform_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ProteinCommentIsoform_WID`, `Id`),
  INDEX `fk_ProteinIsoformId_ProteinCommentIsoform1_idx` (`ProteinCommentIsoform_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinIsoformName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIsoformName` ;

CREATE TABLE IF NOT EXISTS `ProteinIsoformName` (
  `ProteinCommentIsoform_WID` BIGINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Evidence` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`ProteinCommentIsoform_WID`, `Name`),
  INDEX `fk_ProteinIsoformName_ProteinCommentIsoform1_idx` (`ProteinCommentIsoform_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinCommentInteract`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentInteract` ;

CREATE TABLE IF NOT EXISTS `ProteinCommentInteract` (
  `ProteinComment_WID` BIGINT NOT NULL,
  `IntactID` VARCHAR(25) NOT NULL,
  `Id` VARCHAR(25) NULL DEFAULT NULL,
  `Label` VARCHAR(25) NULL DEFAULT NULL,
  INDEX `fk_ProteinCommentInteract_ProteinComment1_idx` (`ProteinComment_WID` ASC),
  INDEX `pk_IntactID` (`IntactID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinWIDKeywordTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinWIDKeywordTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinWIDKeywordTemp` (
  `ProteinWID` BIGINT NOT NULL,
  `Evidence` VARCHAR(100) NULL DEFAULT NULL,
  `Id` VARCHAR(100) NULL DEFAULT NULL,
  `Keyword` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinKeyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKeyword` ;

CREATE TABLE IF NOT EXISTS `ProteinKeyword` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Id` VARCHAR(100) NULL DEFAULT NULL,
  `Keyword` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinFeature` ;

CREATE TABLE IF NOT EXISTS `ProteinFeature` (
  `WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  `Type` VARCHAR(40) NULL DEFAULT NULL,
  `Status` VARCHAR(25) NULL DEFAULT NULL,
  `Id` VARCHAR(25) NULL DEFAULT NULL,
  `Description` TEXT NULL DEFAULT NULL,
  `Evidence` VARCHAR(255) NULL DEFAULT NULL,
  `Ref` VARCHAR(100) NULL DEFAULT NULL,
  `Original` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_ProteinFeature_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinFeatureVariation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinFeatureVariation` ;

CREATE TABLE IF NOT EXISTS `ProteinFeatureVariation` (
  `ProteinFeature_WID` BIGINT NOT NULL,
  `Variation` TEXT NULL DEFAULT NULL,
  INDEX `fk_ProteinFeatureVariation_ProteinFeature1_idx` (`ProteinFeature_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Protein_has_ProteinKeyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_ProteinKeyword` ;

CREATE TABLE IF NOT EXISTS `Protein_has_ProteinKeyword` (
  `Protein_WID` BIGINT NOT NULL,
  `ProteinKeyword_WID` BIGINT NOT NULL,
  `Evidence` VARCHAR(100) NULL,
  PRIMARY KEY (`Protein_WID`, `ProteinKeyword_WID`),
  INDEX `fk_Protein_has_ProteinKeyword_ProteinKeyword1_idx` (`ProteinKeyword_WID` ASC),
  INDEX `fk_Protein_has_ProteinKeyword_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_GeneInfo` ;

CREATE TABLE IF NOT EXISTS `Protein_has_GeneInfo` (
  `Protein_WID` BIGINT NOT NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `GeneInfo_WID`),
  INDEX `fk_Protein_has_Gene_Protein_idx` (`Protein_WID` ASC),
  INDEX `fk_Protein_has_Gene_Gene_idx` (`GeneInfo_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_Ontology` ;

CREATE TABLE IF NOT EXISTS `Protein_has_Ontology` (
  `Protein_WID` BIGINT NOT NULL,
  `Ontology_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Ontology_WID`),
  INDEX `fk_Protein_has_Ontology_Protein_idx` (`Protein_WID` ASC),
  INDEX `fk_Protein_has_Ontology_Ontology_idx` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneInfo_has_Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_Ontology` ;

CREATE TABLE IF NOT EXISTS `GeneInfo_has_Ontology` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `Ontology_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `Ontology_WID`),
  INDEX `fk_GeneInfo_has_Ontology_GeneInfo1` (`GeneInfo_WID` ASC),
  INDEX `fk_GeneInfo_has_Ontology_Ontology` (`Ontology_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `MIFEntrySet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySet` ;

CREATE TABLE IF NOT EXISTS `MIFEntrySet` (
  `WID` BIGINT NOT NULL,
  `Level` INT NULL,
  `Version` INT NULL,
  `MinorVersion` INT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntrySet_DataSet_idx` (`DataSetWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `MIFEntrySetEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySetEntry` ;

CREATE TABLE IF NOT EXISTS `MIFEntrySetEntry` (
  `WID` BIGINT NOT NULL,
  `MIFEntrySet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntrySetEntry_MIFEntrySet1_idx` (`MIFEntrySet_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFEntrySource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySource` ;

CREATE TABLE IF NOT EXISTS `MIFEntrySource` (
  `WID` BIGINT NOT NULL,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL,
  `ReleaseValue` VARCHAR(100) NULL DEFAULT NULL,
  `ReleaseDate` DATETIME NULL DEFAULT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntrySource_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherAlias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAlias` ;

CREATE TABLE IF NOT EXISTS `MIFOtherAlias` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `Alias` VARCHAR(1000) NULL DEFAULT NULL,
  `TypeAc` VARCHAR(50) NULL DEFAULT NULL,
  `Type` VARCHAR(50) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherAlias_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_TypeAc` (`TypeAc` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAttribute` ;

CREATE TABLE IF NOT EXISTS `MIFOtherAttribute` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `Attribute` VARCHAR(1000) NULL DEFAULT NULL,
  `NameAc` VARCHAR(50) NULL DEFAULT NULL,
  `Name` VARCHAR(50) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherAttribute_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_NameAc` (`NameAc` ASC),
  INDEX `pk_Name` (`Name` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherBibRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherBibRef` ;

CREATE TABLE IF NOT EXISTS `MIFOtherBibRef` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherBibRef_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRef` ;

CREATE TABLE IF NOT EXISTS `MIFOtherXRef` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NULL DEFAULT NULL,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL,
  `Id` VARCHAR(50) NULL DEFAULT NULL,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL,
  `Version` VARCHAR(100) NULL DEFAULT NULL,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherXRef_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC),
  INDEX `pk_DB` (`DB` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_PrimaryRef` (`PrimaryRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherXRefGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefGO` ;

CREATE TABLE IF NOT EXISTS `MIFOtherXRefGO` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NULL DEFAULT NULL,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL,
  `Id` VARCHAR(50) NULL DEFAULT NULL,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL,
  `Version` VARCHAR(100) NULL DEFAULT NULL,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherXRefGO_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWIF` (`MIFOtherWID` ASC),
  INDEX `pk_DB` (`DB` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_PrimaryRef` (`PrimaryRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherXRefPubMed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefPubMed` ;

CREATE TABLE IF NOT EXISTS `MIFOtherXRefPubMed` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NULL DEFAULT NULL,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL,
  `Id` VARCHAR(50) NULL DEFAULT NULL,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL,
  `Version` VARCHAR(100) NULL DEFAULT NULL,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherXRefPubMed_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC),
  INDEX `pk_DB` (`DB` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_PrimaryRef` (`PrimaryRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherXRefRefSeq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefRefSeq` ;

CREATE TABLE IF NOT EXISTS `MIFOtherXRefRefSeq` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NULL DEFAULT NULL,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL,
  `Id` VARCHAR(50) NULL DEFAULT NULL,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL,
  `Version` VARCHAR(100) NULL DEFAULT NULL,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherXRefRefSeq_DateSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC),
  INDEX `pk_DB` (`DB` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_PrimaryRef` (`PrimaryRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherXRefUniprot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefUniprot` ;

CREATE TABLE IF NOT EXISTS `MIFOtherXRefUniprot` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NULL DEFAULT NULL,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL,
  `Id` VARCHAR(50) NULL DEFAULT NULL,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL,
  `Version` VARCHAR(100) NULL DEFAULT NULL,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherXRefUniprot_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC),
  INDEX `pk_DB` (`DB` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_PrimaryRef` (`PrimaryRef` ASC),
  INDEX `pk_RefType` USING HASH (`RefType`(255) ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherAvailability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAvailability` ;

CREATE TABLE IF NOT EXISTS `MIFOtherAvailability` (
  `MIFOtherWID` BIGINT NOT NULL,
  `Availability` VARCHAR(255) NOT NULL,
  `Id` INT NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`MIFOtherWID`, `Availability`),
  INDEX `fk_MIFOtherAvailability_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFEntryExperiment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryExperiment` ;

CREATE TABLE IF NOT EXISTS `MIFEntryExperiment` (
  `WID` BIGINT NOT NULL,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL,
  `Id` INT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntryExperiment_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC),
  INDEX `pk_id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherBioSourceType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherBioSourceType` ;

CREATE TABLE IF NOT EXISTS `MIFOtherBioSourceType` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `TaxId` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherBioSourceType_DataSet_idx` (`DataSetWID` ASC),
  INDEX `fk_MIFOtherBioSourceType_Taxonomy_idx` (`TaxId` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeCellType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeCellType` ;

CREATE TABLE IF NOT EXISTS `MIFBioSourceTypeCellType` (
  `WID` BIGINT NOT NULL,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFBioSourceTypeCellType_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeCompartment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeCompartment` ;

CREATE TABLE IF NOT EXISTS `MIFBioSourceTypeCompartment` (
  `WID` BIGINT NOT NULL,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFBioSourceTypeCompartment_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeTissue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeTissue` ;

CREATE TABLE IF NOT EXISTS `MIFBioSourceTypeTissue` (
  `WID` BIGINT NOT NULL,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFBioSourceTypeTissue_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFExperimentInterDetecMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentInterDetecMethod` ;

CREATE TABLE IF NOT EXISTS `MIFExperimentInterDetecMethod` (
  `WID` BIGINT NOT NULL,
  `MIFEntryExperiment_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFExperimentInterDetecMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFExperimentPartIdentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentPartIdentMethod` ;

CREATE TABLE IF NOT EXISTS `MIFExperimentPartIdentMethod` (
  `WID` BIGINT NOT NULL,
  `MIFEntryExperiment_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFExperimentPartIdentMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFExperimentFeatDetecMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentFeatDetecMethod` ;

CREATE TABLE IF NOT EXISTS `MIFExperimentFeatDetecMethod` (
  `WID` BIGINT NOT NULL,
  `MIFEntryExperiment_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFExperimentFeatDetecMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherConfidence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherConfidence` ;

CREATE TABLE IF NOT EXISTS `MIFOtherConfidence` (
  `WID` BIGINT NOT NULL,
  `MIFOtherWID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  `ValueVal` VARCHAR(1000) NULL DEFAULT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFOtherConfidence_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_MIFOtherWID` (`MIFOtherWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFOtherExperimentRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherExperimentRef` ;

CREATE TABLE IF NOT EXISTS `MIFOtherExperimentRef` (
  `MIFOtherWID` BIGINT NOT NULL,
  `ExperimentRef` INT NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  PRIMARY KEY (`MIFOtherWID`, `ExperimentRef`),
  INDEX `fk_MIFOtherExperimentRef_DataSet_idx` (`DataSetWID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFEntryInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryInteractor` ;

CREATE TABLE IF NOT EXISTS `MIFEntryInteractor` (
  `WID` BIGINT NOT NULL,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  `Sequence` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntryInteractor_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFInteractorInteractorType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractorInteractorType` ;

CREATE TABLE IF NOT EXISTS `MIFInteractorInteractorType` (
  `WID` BIGINT NOT NULL,
  `MIFEntryInteractor_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFInteractorInteractorType_MIFEntryInteractor1_idx` (`MIFEntryInteractor_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFEntryInteraction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryInteraction` ;

CREATE TABLE IF NOT EXISTS `MIFEntryInteraction` (
  `WID` BIGINT NOT NULL,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL,
  `ImexId` VARCHAR(50) NULL DEFAULT NULL,
  `Id` INT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  `AvailabilityRef` INT NULL DEFAULT 0,
  `Modelled` VARCHAR(10) NULL DEFAULT NULL,
  `IntraMolecular` VARCHAR(10) NULL DEFAULT NULL,
  `Negative` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFEntryInteraction_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC),
  INDEX `pk_ImedId` (`ImexId` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Modelled` (`Modelled` ASC),
  INDEX `pk_Negative` (`Negative` ASC),
  INDEX `pk_IntraMolecular` (`IntraMolecular` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFInteractionParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionParticipant` ;

CREATE TABLE IF NOT EXISTS `MIFInteractionParticipant` (
  `WID` BIGINT NOT NULL,
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  `InteractorRef` INT NULL DEFAULT NULL,
  `InteractionRef` INT NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFInteractionParticipant_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_InteractorRef` (`InteractorRef` ASC),
  INDEX `pk_InteractionRef` (`InteractionRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantPartIdentMeth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantPartIdentMeth` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantPartIdentMeth` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantPartIdentMeth_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantBiologicalRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantBiologicalRole` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantBiologicalRole` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantBiologicalRole_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalRole` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantExperimentalRole` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantExperimentalRole_MIFInteractionParticipant_idx` (`MIFInteractionParticipant_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalPreparation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalPreparation` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantExperimentalPreparation` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantExperimentalPreparation_MIFInteractionPart_idx` (`MIFInteractionParticipant_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalInteractor` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantExperimentalInteractor` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `InteractorRef` INT NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantExperimentalInteractor_MIFInteractionParti_idx` (`MIFInteractionParticipant_WID` ASC),
  INDEX `pk_InteractorRef` (`InteractorRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantFeature` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantFeature` (
  `WID` BIGINT NOT NULL,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `Id` INT NULL DEFAULT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFParticipantFeature_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatureType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatureType` ;

CREATE TABLE IF NOT EXISTS `MIFFeatureFeatureType` (
  `WID` BIGINT NOT NULL,
  `MIFParticipantFeature_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFFeatureFeatureType_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatDetMeth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatDetMeth` ;

CREATE TABLE IF NOT EXISTS `MIFFeatureFeatDetMeth` (
  `WID` BIGINT NOT NULL,
  `MIFParticipantFeature_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFFeatureFeatDetMeth_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatureRange`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatureRange` ;

CREATE TABLE IF NOT EXISTS `MIFFeatureFeatureRange` (
  `WID` BIGINT NOT NULL,
  `MIFParticipantFeature_WID` BIGINT NOT NULL,
  `StartShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `StartFullName` VARCHAR(1000) NULL DEFAULT NULL,
  `EndShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `EndFullName` VARCHAR(1000) NULL DEFAULT NULL,
  `BeginPosition` INT NULL DEFAULT -1,
  `BeginIntervalBegin` INT NULL DEFAULT -1,
  `BeginIntervalEnd` INT NULL DEFAULT -1,
  `EndPosition` INT NULL DEFAULT -1,
  `EndIntervalBegin` INT NULL DEFAULT -1,
  `EndIntervalEnd` INT NULL DEFAULT -1,
  `IsLink` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFFeatureFeatureRange_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFParticipantParameter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantParameter` ;

CREATE TABLE IF NOT EXISTS `MIFParticipantParameter` (
  `MIFInteractionParticipant_WID` BIGINT NOT NULL,
  `ExperimentRef` INT NOT NULL,
  `Term` VARCHAR(100) NULL,
  `TermAc` VARCHAR(100) NOT NULL,
  `Unit` VARCHAR(100) NULL,
  `UnitAc` VARCHAR(100) NULL,
  `Base` FLOAT NULL,
  `Exponent` FLOAT NULL,
  `Factor` FLOAT NULL,
  `Uncertainty` FLOAT NULL,
  INDEX `fk_MIFParticipantParameter_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC),
  INDEX `pk_ExperimentRef` (`ExperimentRef` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFInteractionInferredInteraction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionInferredInteraction` ;

CREATE TABLE IF NOT EXISTS `MIFInteractionInferredInteraction` (
  `WID` BIGINT NOT NULL,
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFInteractionInferredInteraction_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFInferredInteractionParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInferredInteractionParticipant` ;

CREATE TABLE IF NOT EXISTS `MIFInferredInteractionParticipant` (
  `MIFInteractionInferredInteraction_WID` BIGINT NOT NULL,
  `Participant` INT NOT NULL,
  `ParticipantType` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`MIFInteractionInferredInteraction_WID`, `Participant`),
  INDEX `fk_MIFInferredInteractionParticipant_MIFInteractionInferred_idx` (`MIFInteractionInferredInteraction_WID` ASC),
  INDEX `pk_ParticipantType` (`ParticipantType` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `MIFInteractionInteractionType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionInteractionType` ;

CREATE TABLE IF NOT EXISTS `MIFInteractionInteractionType` (
  `WID` BIGINT NOT NULL,
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_MIFInteractionInteractionType_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `Protein_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_Taxonomy` ;

CREATE TABLE IF NOT EXISTS `Protein_has_Taxonomy` (
  `Protein_WID` BIGINT NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Taxonomy_WID`),
  INDEX `fk_Protein_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_Protein_has_Taxonomy_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_TaxonomyHost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_TaxonomyHost` ;

CREATE TABLE IF NOT EXISTS `Protein_has_TaxonomyHost` (
  `Protein_WID` BIGINT NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Taxonomy_WID`),
  INDEX `fk_Protein_has_Taxonomy1_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_Protein_has_Taxonomy1_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `ProteinTaxId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinTaxId` ;

CREATE TABLE IF NOT EXISTS `ProteinTaxId` (
  `Protein_WID` BIGINT NOT NULL,
  `TaxId` BIGINT NOT NULL,
  `IsHost` INT NOT NULL DEFAULT 0,
  INDEX `pk_Protein_WID` (`Protein_WID` ASC),
  INDEX `pk_TaxId` (`TaxId` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `ProteinPFAM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPFAM` ;

CREATE TABLE IF NOT EXISTS `ProteinPFAM` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Protein_WID`, `Id`),
  INDEX `fk_ProteinPFAM_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `MIFInteraction_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteraction_has_Protein` ;

CREATE TABLE IF NOT EXISTS `MIFInteraction_has_Protein` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  INDEX `fk_MIFInteraction_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC),
  PRIMARY KEY (`MIFEntryInteraction_WID`, `Protein_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `MIFInteractionCount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionCount` ;

CREATE TABLE IF NOT EXISTS `MIFInteractionCount` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  `Count` INT NOT NULL,
  INDEX `fk_MIFInteractionCount_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC),
  PRIMARY KEY (`MIFEntryInteraction_WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `MIFInteraction_has_Protein_Temp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteraction_has_Protein_Temp` ;

CREATE TABLE IF NOT EXISTS `MIFInteraction_has_Protein_Temp` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  INDEX `fk_MIFInteraction_has_Protein_Protein1` (`Protein_WID` ASC),
  INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1` (`MIFEntryInteraction_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntry` ;

CREATE TABLE IF NOT EXISTS `UniRefEntry` (
  `WID` BIGINT NOT NULL,
  `Id` VARCHAR(45) NOT NULL,
  `Updated` DATETIME NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `TaxId` BIGINT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Name` (`Name` ASC),
  INDEX `fk_UniRefEntry_Taxonomy1_idx` (`TaxId` ASC),
  INDEX `fk_UniRefEntry_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefEntryProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntryProperty` ;

CREATE TABLE IF NOT EXISTS `UniRefEntryProperty` (
  `WID` BIGINT NOT NULL,
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Value` VARCHAR(100) NULL,
  INDEX `fk_UniRefCommonProperty_UniRefEntry1_idx` (`UniRefEntry_WID` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Value` (`Value` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMember` ;

CREATE TABLE IF NOT EXISTS `UniRefMember` (
  `WID` BIGINT NOT NULL,
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NULL,
  `TaxId` BIGINT NULL,
  `Type` VARCHAR(45) NULL,
  `Id` VARCHAR(100) NULL,
  `IsRepresentative` TINYINT(1) NULL,
  INDEX `fk_UniRefMember_UniRefEntry1_idx` (`UniRefEntry_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `fk_UniRefMember_Taxonomy1_idx` (`TaxId` ASC),
  INDEX `fk_UniRefMember_Protein1_idx` (`Protein_WID` ASC),
  INDEX `pk_IsRepresentative` (`IsRepresentative` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefMemberProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberProperty` ;

CREATE TABLE IF NOT EXISTS `UniRefMemberProperty` (
  `WID` BIGINT NOT NULL,
  `UniRefMember_WID` BIGINT NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Value` VARCHAR(100) NULL,
  INDEX `fk_UniRefMemberProperty_UniRefMember1_idx` (`UniRefMember_WID` ASC),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Value` (`Value` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp` ;

CREATE TABLE IF NOT EXISTS `UniRefMemberTemp` (
  `WID` BIGINT NOT NULL,
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NULL,
  `TaxId` BIGINT NULL,
  `Type` VARCHAR(45) NULL,
  `Id` VARCHAR(100) NULL,
  `IsRepresentative` TINYINT(1) NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_UniRefEntry_Protein_WID` USING BTREE (`UniRefEntry_WID` ASC, `Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp1` ;

CREATE TABLE IF NOT EXISTS `UniRefMemberTemp1` (
  `WID` BIGINT NOT NULL,
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NULL,
  `TaxId` BIGINT NULL,
  `Type` VARCHAR(45) NULL,
  `Id` VARCHAR(100) NULL,
  `IsRepresentative` TINYINT(1) NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_UniRefEntry_Id` USING BTREE (`UniRefEntry_WID` ASC, `Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp2` ;

CREATE TABLE IF NOT EXISTS `UniRefMemberTemp2` (
  `WID` BIGINT NOT NULL,
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NULL,
  `TaxId` BIGINT NULL,
  `Type` VARCHAR(45) NULL,
  `Id` VARCHAR(100) NULL,
  `IsRepresentative` TINYINT(1) NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Type` (`Type` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_UniRefEntry_Id` USING BTREE (`UniRefEntry_WID` ASC, `Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank` ;

CREATE TABLE IF NOT EXISTS `DrugBank` (
  `WID` BIGINT NOT NULL,
  `Id` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` TEXT NULL,
  `CASNumber` VARCHAR(20) NULL,
  `SynthesisRef` TEXT NULL,
  `Indication` TEXT NULL,
  `Pharmacology` TEXT NULL,
  `MechanismOfAction` TEXT NULL,
  `Toxicity` TEXT NULL,
  `Biotransformation` TEXT NULL,
  `Absorption` TEXT NULL,
  `HalfLife` TEXT NULL,
  `ProteinBinding` TEXT NULL,
  `RouteOfElimination` TEXT NULL,
  `VolumeOfDistribution` TEXT NULL,
  `Clearance` TEXT NULL,
  `Type` VARCHAR(25) NULL,
  `Version` VARCHAR(25) NULL,
  `Updated` DATETIME NULL,
  `Created` DATETIME NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Name` USING BTREE (`Name` ASC),
  INDEX `pk_CASNumber` (`CASNumber` ASC),
  INDEX `fk_DrugBank_DataSet1_idx` (`DataSet_WID` ASC),
  INDEX `pk_Type` (`Type` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankGeneralRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankGeneralRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankGeneralRef` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankGeneralRef_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankSecondAccessionNumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankSecondAccessionNumbers` ;

CREATE TABLE IF NOT EXISTS `DrugBankSecondAccessionNumbers` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `AccessionNumber` VARCHAR(45) NULL,
  INDEX `fk_DrugBankSecondAccessionNumbers_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_AccessionNumber` (`AccessionNumber` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankGroup` ;

CREATE TABLE IF NOT EXISTS `DrugBankGroup` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `GroupName` VARCHAR(25) NULL,
  INDEX `fk_DrugBankGroup_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTaxonomySubstructures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTaxonomySubstructures` ;

CREATE TABLE IF NOT EXISTS `DrugBankTaxonomySubstructures` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `DrugBank_WID` BIGINT NOT NULL,
  `Substructure` VARCHAR(255) NULL,
  `Class` VARCHAR(25) NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_DrugBankTaxonomySubstructures_DrugBank1_idx` (`DrugBank_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankSynonyms` ;

CREATE TABLE IF NOT EXISTS `DrugBankSynonyms` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Synonym` VARCHAR(100) NULL,
  INDEX `fk_DrugBankSynonyms_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankBrands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankBrands` ;

CREATE TABLE IF NOT EXISTS `DrugBankBrands` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Brand` VARCHAR(100) NULL,
  INDEX `fk_DrugBankBrands_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankMixtures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankMixtures` ;

CREATE TABLE IF NOT EXISTS `DrugBankMixtures` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Name` VARCHAR(50) NULL,
  `Ingredients` TEXT NULL,
  INDEX `fk_DrugBankMixtures_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Name` (`Name` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPackagers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPackagers` ;

CREATE TABLE IF NOT EXISTS `DrugBankPackagers` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Name` VARCHAR(50) NULL,
  `URL` TEXT NULL,
  INDEX `fk_DrugBankPackagers_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankManufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankManufacturers` ;

CREATE TABLE IF NOT EXISTS `DrugBankManufacturers` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Manufacturer` VARCHAR(50) NULL,
  `Generic` VARCHAR(10) NULL,
  INDEX `fk_DrugBankManufacturers_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPrices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPrices` ;

CREATE TABLE IF NOT EXISTS `DrugBankPrices` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Description` TEXT NULL,
  `Cost` VARCHAR(25) NULL,
  `Currency` VARCHAR(6) NULL,
  `Unit` VARCHAR(10) NULL,
  INDEX `fk_DrugBankPrices_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCategories` ;

CREATE TABLE IF NOT EXISTS `DrugBankCategories` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Category` VARCHAR(50) NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Category` USING BTREE (`Category` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCategoriesTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCategoriesTemp` ;

CREATE TABLE IF NOT EXISTS `DrugBankCategoriesTemp` (
  `DrugBank_WID` BIGINT NOT NULL,
  `Category` VARCHAR(50) NULL,
  INDEX `pk_Category` USING BTREE (`Category` ASC),
  INDEX `fk_DrugBankCategoriesTemp_DrugBank1_idx` (`DrugBank_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBank_has_DrugBankCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank_has_DrugBankCategories` ;

CREATE TABLE IF NOT EXISTS `DrugBank_has_DrugBankCategories` (
  `DrugBank_WID` BIGINT NOT NULL,
  `DrugBankCategories_WID` BIGINT NOT NULL,
  PRIMARY KEY (`DrugBank_WID`, `DrugBankCategories_WID`),
  INDEX `fk_DrugBank_has_DrugBankCategories_DrugBankCategories1_idx` (`DrugBankCategories_WID` ASC),
  INDEX `fk_DrugBank_has_DrugBankCategories_DrugBank1_idx` (`DrugBank_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankAffectedOrganisms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankAffectedOrganisms` ;

CREATE TABLE IF NOT EXISTS `DrugBankAffectedOrganisms` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `AffectedOrganisms` TEXT NULL,
  INDEX `fk_DrugBankAffectedOrganisms_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankDosages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDosages` ;

CREATE TABLE IF NOT EXISTS `DrugBankDosages` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Form` VARCHAR(25) NULL,
  `Route` VARCHAR(25) NULL,
  `Strength` VARCHAR(25) NULL,
  INDEX `fk_DrugBankDosages_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankATCCodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankATCCodes` ;

CREATE TABLE IF NOT EXISTS `DrugBankATCCodes` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `ATCCode` VARCHAR(25) NULL,
  INDEX `fk_DrugBankATCCodes_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_ATCCode` (`ATCCode` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankAHFSCodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankAHFSCodes` ;

CREATE TABLE IF NOT EXISTS `DrugBankAHFSCodes` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `AHFSCodes` VARCHAR(25) NULL,
  INDEX `fk_DrugBankAHFSCodes_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_AHFSCodes` (`AHFSCodes` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPatents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPatents` ;

CREATE TABLE IF NOT EXISTS `DrugBankPatents` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Number` BIGINT NOT NULL,
  `Country` VARCHAR(255) NULL,
  `Approved` DATETIME NULL,
  `Expires` DATETIME NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Number` (`Number` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPatentsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPatentsTemp` ;

CREATE TABLE IF NOT EXISTS `DrugBankPatentsTemp` (
  `DrugBank_WID` BIGINT NOT NULL,
  `Number` BIGINT NOT NULL,
  `Country` VARCHAR(255) NULL,
  `Approved` DATETIME NULL,
  `Expires` DATETIME NULL,
  INDEX `fk_DrugBankPatentsTemp_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Number` (`Number` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBank_has_DrugBankPatents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank_has_DrugBankPatents` ;

CREATE TABLE IF NOT EXISTS `DrugBank_has_DrugBankPatents` (
  `DrugBank_WID` BIGINT NOT NULL,
  `DrugBankPatents_WID` BIGINT NOT NULL,
  PRIMARY KEY (`DrugBank_WID`, `DrugBankPatents_WID`),
  INDEX `fk_DrugBank_has_DrugBankPatents_DrugBankPatents1_idx` (`DrugBankPatents_WID` ASC),
  INDEX `fk_DrugBank_has_DrugBankPatents_DrugBank1_idx` (`DrugBank_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankFoodInteractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankFoodInteractions` ;

CREATE TABLE IF NOT EXISTS `DrugBankFoodInteractions` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `FoodInteractions` TEXT NULL,
  INDEX `fk_DrugBankFoodInteractions_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankDrugInteractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDrugInteractions` ;

CREATE TABLE IF NOT EXISTS `DrugBankDrugInteractions` (
  `DrugBank_WID` BIGINT NOT NULL,
  `Drug` BIGINT NOT NULL,
  `Description` TEXT NULL,
  INDEX `fk_DrugBankDrugInteractions_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`DrugBank_WID`, `Drug`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankProteinSequences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankProteinSequences` ;

CREATE TABLE IF NOT EXISTS `DrugBankProteinSequences` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Header` VARCHAR(100) NULL,
  `Chain` TEXT NULL,
  INDEX `fk_DrugBankProteinSequences_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCalculatedProperties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCalculatedProperties` ;

CREATE TABLE IF NOT EXISTS `DrugBankCalculatedProperties` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Kind` VARCHAR(25) NULL,
  `Value` VARCHAR(255) NULL,
  `Source` VARCHAR(25) NULL,
  INDEX `fk_DrugBankCalculatedProperties_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Kind` (`Kind` ASC),
  INDEX `pk_Source` (`Source` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankExperimentalProperties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExperimentalProperties` ;

CREATE TABLE IF NOT EXISTS `DrugBankExperimentalProperties` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Kind` VARCHAR(25) NULL,
  `Value` VARCHAR(255) NULL,
  `Source` VARCHAR(255) NULL,
  INDEX `fk_DrugBankCalculatedProperties_DrugBank1` (`DrugBank_WID` ASC),
  INDEX `pk_Kind` (`Kind` ASC),
  INDEX `pk_Source` (`Source` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankExternalIdentifiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExternalIdentifiers` ;

CREATE TABLE IF NOT EXISTS `DrugBankExternalIdentifiers` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Resource` VARCHAR(50) NULL,
  `Identifier` VARCHAR(25) NULL,
  INDEX `fk_DrugBankExternalIdentifiers_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Resource_Identifier` USING BTREE (`Resource` ASC, `Identifier` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankExternalLinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExternalLinks` ;

CREATE TABLE IF NOT EXISTS `DrugBankExternalLinks` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Resource` VARCHAR(50) NULL,
  `URL` TEXT NULL,
  INDEX `fk_DrugBankExternalLinks_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Resource` (`Resource` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTargets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargets` ;

CREATE TABLE IF NOT EXISTS `DrugBankTargets` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Partner` INT NOT NULL,
  `Position` INT NULL,
  `KnownAction` VARCHAR(10) NULL,
  INDEX `fk_DrugBankTargets_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `pk_Partner` (`Partner` ASC),
  PRIMARY KEY (`WID`),
  INDEX `pk_KnownAction` (`KnownAction` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTargetsRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargetsRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankTargetsRef` (
  `WID` BIGINT NOT NULL,
  `DrugBankTargets_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankTargetsRef_DrugBankTargets1_idx` (`DrugBankTargets_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTargetsActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargetsActions` ;

CREATE TABLE IF NOT EXISTS `DrugBankTargetsActions` (
  `WID` BIGINT NOT NULL,
  `DrugBankTargets_WID` BIGINT NOT NULL,
  `Action` VARCHAR(50) NULL,
  INDEX `fk_DrugBankTargetsActions_DrugBankTargets1_idx` (`DrugBankTargets_WID` ASC),
  INDEX `pk_Action` (`Action` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankEnzymes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymes` ;

CREATE TABLE IF NOT EXISTS `DrugBankEnzymes` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Partner` INT NOT NULL,
  `Position` INT NULL,
  INDEX `fk_DrugBankEnzymes_DrugBank1` (`DrugBank_WID` ASC),
  INDEX `pk_Partner` (`Partner` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankEnzymesRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymesRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankEnzymesRef` (
  `WID` BIGINT NOT NULL,
  `DrugBankEnzymes_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankEnzymesRef_DrugBankEnzymes1_idx` (`DrugBankEnzymes_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankEnzymesActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymesActions` ;

CREATE TABLE IF NOT EXISTS `DrugBankEnzymesActions` (
  `WID` BIGINT NOT NULL,
  `DrugBankEnzymes_WID` BIGINT NOT NULL,
  `Action` VARCHAR(50) NULL,
  INDEX `pk_Action` (`Action` ASC),
  INDEX `fk_DrugBankEnzymesActions_DrugBankEnzymes1_idx` (`DrugBankEnzymes_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTransporters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransporters` ;

CREATE TABLE IF NOT EXISTS `DrugBankTransporters` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Partner` INT NOT NULL,
  `Position` INT NULL,
  INDEX `fk_DrugBankTransporters_DrugBank1` (`DrugBank_WID` ASC),
  INDEX `pk_Partner` (`Partner` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTransportersRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransportersRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankTransportersRef` (
  `WID` BIGINT NOT NULL,
  `DrugBankTransporters_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankTransportersRef_DrugBankTransporters1_idx` (`DrugBankTransporters_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTransportersActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransportersActions` ;

CREATE TABLE IF NOT EXISTS `DrugBankTransportersActions` (
  `WID` BIGINT NOT NULL,
  `DrugBankTransporters_WID` BIGINT NOT NULL,
  `Action` VARCHAR(50) NULL,
  INDEX `pk_Action` (`Action` ASC),
  INDEX `fk_DrugBankTransportersActions_DrugBankTransporters1_idx` (`DrugBankTransporters_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCarriers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriers` ;

CREATE TABLE IF NOT EXISTS `DrugBankCarriers` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Partner` INT NOT NULL,
  `Position` INT NULL,
  INDEX `fk_DrugBankCarriers_DrugBank1` (`DrugBank_WID` ASC),
  INDEX `pk_Partner` (`Partner` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCarriersRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriersRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankCarriersRef` (
  `WID` BIGINT NOT NULL,
  `DrugBankCarriers_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankCarriersRef_DrugBankCarriers1_idx` (`DrugBankCarriers_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankCarriersActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriersActions` ;

CREATE TABLE IF NOT EXISTS `DrugBankCarriersActions` (
  `WID` BIGINT NOT NULL,
  `DrugBankCarriers_WID` BIGINT NOT NULL,
  `Action` VARCHAR(50) NULL,
  INDEX `pk_Action` (`Action` ASC),
  INDEX `fk_DrugBankCarriersActions_DrugBankCarriers1_idx` (`DrugBankCarriers_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPartners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartners` ;

CREATE TABLE IF NOT EXISTS `DrugBankPartners` (
  `WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `GeneralFunction` TEXT NULL,
  `SpecificFunction` TEXT NULL,
  `GeneName` VARCHAR(45) NULL,
  `Locus` VARCHAR(45) NULL,
  `Reaction` TEXT NULL,
  `Signals` TEXT NULL,
  `CellularLocation` TEXT NULL,
  `TransmembraneRegions` TEXT NULL,
  `TheoreticalPi` FLOAT NULL,
  `MolecularWeight` FLOAT NULL,
  `Chromosome` VARCHAR(100) NULL,
  `Essentiality` VARCHAR(25) NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `fk_DrugBankPartners_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBank` ;

CREATE TABLE IF NOT EXISTS `Protein_has_DrugBank` (
  `Protein_WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`),
  INDEX `fk_Protein_has_DrugBank_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `fk_Protein_has_DrugBank_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `DrugBankPartnerRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerRef` ;

CREATE TABLE IF NOT EXISTS `DrugBankPartnerRef` (
  `WID` BIGINT NOT NULL,
  `DrugBankPartners_WID` BIGINT NOT NULL,
  `Cite` TEXT NULL,
  `Link` TEXT NULL,
  INDEX `fk_DrugBankPartnerRef_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPartnerExternalIdentifiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerExternalIdentifiers` ;

CREATE TABLE IF NOT EXISTS `DrugBankPartnerExternalIdentifiers` (
  `WID` BIGINT NOT NULL,
  `DrugBankPartners_WID` BIGINT NOT NULL,
  `Resource` VARCHAR(50) NULL,
  `Identifier` VARCHAR(25) NULL,
  INDEX `fk_DrugBankPartnerExternalIdentifiers_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC),
  INDEX `pk_Resource` (`Resource` ASC),
  INDEX `pk_Identifier` (`Identifier` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPartnerSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerSynonyms` ;

CREATE TABLE IF NOT EXISTS `DrugBankPartnerSynonyms` (
  `WID` BIGINT NOT NULL,
  `DrugBankPartners_WID` BIGINT NOT NULL,
  `Synonym` VARCHAR(100) NULL,
  INDEX `fk_DrugBankPartnerSynonyms_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankPartnerPFam`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerPFam` ;

CREATE TABLE IF NOT EXISTS `DrugBankPartnerPFam` (
  `WID` BIGINT NOT NULL,
  `DrugBankPartners_WID` BIGINT NOT NULL,
  `Identifier` VARCHAR(25) NULL,
  `Name` VARCHAR(50) NULL,
  INDEX `fk_DrugBankPartnerRef_DrugBankPartners1` (`DrugBankPartners_WID` ASC),
  INDEX `pk_Identifier` (`Identifier` ASC),
  INDEX `pk_Name` (`Name` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `DrugBankTaxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTaxonomy` ;

CREATE TABLE IF NOT EXISTS `DrugBankTaxonomy` (
  `WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  `Kingdom` VARCHAR(100) NULL,
  INDEX `fk_DrugBankTaxonomy_DrugBank1_idx` (`DrugBank_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsEnzyme` ;

CREATE TABLE IF NOT EXISTS `Protein_has_DrugBankAsEnzyme` (
  `Protein_WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`),
  INDEX `fk_Protein_has_DrugBank1_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `fk_Protein_has_DrugBank1_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsTransporters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsTransporters` ;

CREATE TABLE IF NOT EXISTS `Protein_has_DrugBankAsTransporters` (
  `Protein_WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`),
  INDEX `fk_Protein_has_DrugBank1_DrugBank2_idx` (`DrugBank_WID` ASC),
  INDEX `fk_Protein_has_DrugBank1_Protein2_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsCarriers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsCarriers` ;

CREATE TABLE IF NOT EXISTS `Protein_has_DrugBankAsCarriers` (
  `Protein_WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`),
  INDEX `fk_Protein_has_DrugBank1_DrugBank3_idx` (`DrugBank_WID` ASC),
  INDEX `fk_Protein_has_DrugBank1_Protein3_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `KEGGReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NULL,
  `Comment` TEXT NULL,
  `Definition` TEXT NULL,
  `Equation` TEXT NULL,
  `Remark` VARCHAR(255) NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGReaction_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(20) NOT NULL,
  `Comment` TEXT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGEnzyme_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionName` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionName` (
  `WID` BIGINT NOT NULL,
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  INDEX `fk_KEGGReactionName_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeName` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeName` (
  `WID` BIGINT NOT NULL,
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeName_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Name` (`Name` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionOrthology` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionOrthology` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGReactionOrthology_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeOrthology` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeOrthology` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGEnzymeOrthology_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC),
  PRIMARY KEY (`KEGGEnzyme_WID`, `Entry`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionRPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionRPair` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionRPair` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(10) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGReactionRPair_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionPathway` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGReactionPathway_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymePathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymePathway` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymePathway` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGEnzymePathway_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionEnzyme` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Enzyme` VARCHAR(16) NOT NULL,
  INDEX `fk_KEGGReactionEnzyme_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Enzyme` (`Enzyme` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGEnzyme` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGEnzyme_WID`),
  INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGReaction1_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeClass` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Class` VARCHAR(255) NULL,
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeAllReac`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeAllReac` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeAllReac` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `AllReac` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeAllReac_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeClassTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeClassTemp` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeClassTemp` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Class` VARCHAR(255) NULL,
  INDEX `fk_KEGGEnzymeClass_KEGGEnzyme1` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Class` (`Class` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGEnzymeClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGEnzymeClass` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGEnzymeClass` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `KEGGEnzymeClass_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGEnzymeClass_WID`),
  INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzymeClass1_idx` (`KEGGEnzymeClass_WID` ASC),
  INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeSysName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeSysName` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeSysName` (
  `WID` BIGINT NOT NULL,
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `SySName` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeSysName_KEGGEnzyme1` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_SysName` (`SySName` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeReaction` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Reaction` TEXT NOT NULL,
  INDEX `fk_KEGGEnzymeReaction_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeSubstrate` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeSubstrate` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGEnzymeSubstrate_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeProduct` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeProduct` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGEnzymeProduct_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeCofactor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeCofactor` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeCofactor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeCofactor_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeGenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeGenes` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeGenes` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Organism` VARCHAR(4) NULL,
  `Genes` VARCHAR(255) NULL,
  INDEX `fk_KEGGEnzymeGenes_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Organism` (`Organism` ASC),
  INDEX `pk_Genes` (`Genes` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeDBLink` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeDBLink` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGEnzymeDBLink_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  PRIMARY KEY (`KEGGEnzyme_WID`, `DB`, `Id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeInhibitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeInhibitor` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeInhibitor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeInhibitor_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeEffector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeEffector` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzymeEffector` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGEnzymeEffector_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound` ;

CREATE TABLE IF NOT EXISTS `KEGGCompound` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Comment` TEXT NULL,
  `Mass` FLOAT NULL,
  `Remark` VARCHAR(255) NULL,
  `Formula` VARCHAR(255) NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGCompound_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompoundName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundName` ;

CREATE TABLE IF NOT EXISTS `KEGGCompoundName` (
  `WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGCompoundName_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompoundReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGCompoundReaction` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `Reaction` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGCompoundReaction_KEGGCompound1_idx` (`KEGGCompound_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompoundEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGCompoundEnzyme` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGCompoundEnzyme_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompoundPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGCompoundPathway` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGCompoundPathway_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGCompound_as_Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGCompound_as_Product` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGCompound_as_Product` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction1_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGCompound_as_Substrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGCompound_as_Substrate` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGCompound_as_Substrate` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound2_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction2_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Cofactor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Cofactor` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Cofactor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Inhibitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound2_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme2_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompoundDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundDBLink` ;

CREATE TABLE IF NOT EXISTS `KEGGCompoundDBLink` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGCompoundDBLink_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  PRIMARY KEY (`KEGGCompound_WID`, `DB`, `Id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionProduct` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionProduct` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGReactionProduct_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReactionSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionSubstrate` ;

CREATE TABLE IF NOT EXISTS `KEGGReactionSubstrate` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGReactionSubstrate_KEGGReaction1_idx` (`KEGGReaction_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycan` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycan` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Comment` TEXT NULL,
  `Mass` VARCHAR(25) NULL,
  `Remark` VARCHAR(255) NULL,
  `Composition` TEXT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGGlycan_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanDBLink` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanDBLink` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGGlycanDBLink_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  PRIMARY KEY (`KEGGGlycan_WID`, `DB`, `Id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanEnzyme` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NULL,
  INDEX `fk_KEGGGlycanEnzyme_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanPathway` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGGlycanPathway_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanReaction` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGGlycanReaction_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGGlycan_as_Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGGlycan_as_Product` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGGlycan_as_Product` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGGlycan_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGGlycan_WID`),
  INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction1_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGGlycan_as_Substrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGGlycan_as_Substrate` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGGlycan_as_Substrate` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGGlycan_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGGlycan_WID`),
  INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan2_idx` (`KEGGGlycan_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction2_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanClassTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanClassTemp` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanClassTemp` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Class` VARCHAR(255) NOT NULL,
  INDEX `fk_KEGGGlycanClassTemp_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Class` (`Class` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanClass` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Class` VARCHAR(255) NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Class` (`Class` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycan_has_KEGGGlycanClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycan_has_KEGGGlycanClass` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycan_has_KEGGGlycanClass` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `KEGGGlycanClass_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGGlycan_WID`, `KEGGGlycanClass_WID`),
  INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycanClass1_idx` (`KEGGGlycanClass_WID` ASC),
  INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanOrthology` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanOrthology` (
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGGlycanOrthology_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Effector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Effector` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Effector` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound3_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme3_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPair` ;

CREATE TABLE IF NOT EXISTS `KEGGRPair` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(15) NOT NULL,
  `Type` VARCHAR(15) NOT NULL,
  `RClass` VARCHAR(8) NOT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `pk_RClass` (`RClass` ASC),
  INDEX `fk_KEGGRPair_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPairCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairCompound` ;

CREATE TABLE IF NOT EXISTS `KEGGRPairCompound` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NULL,
  INDEX `fk_KEGGRPairCompound_KEGGRPair1_idx` (`KEGGRPair_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPair_has_KEGGCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPair_has_KEGGCompound` ;

CREATE TABLE IF NOT EXISTS `KEGGRPair_has_KEGGCompound` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `KEGGCompound_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGRPair_WID`, `KEGGCompound_WID`),
  INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC),
  INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGRPair1_idx` (`KEGGRPair_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPairRelatedPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairRelatedPair` ;

CREATE TABLE IF NOT EXISTS `KEGGRPairRelatedPair` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `KEGGRPair_Other_WID` BIGINT NOT NULL,
  INDEX `fk_KEGGRPair_KEGGRPair1_idx` (`KEGGRPair_WID` ASC),
  PRIMARY KEY (`KEGGRPair_WID`, `KEGGRPair_Other_WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPairRelatedPairTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairRelatedPairTemp` ;

CREATE TABLE IF NOT EXISTS `KEGGRPairRelatedPairTemp` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGRPairTemp_KEGGRPair1_idx` (`KEGGRPair_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPairEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGRPairEnzyme` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGRPairEnzyme_KEGGRPair1_idx` (`KEGGRPair_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGRPairReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGRPairReaction` (
  `KEGGRPair_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  INDEX `fk_KEGGRPairReaction_KEGGRPair1_idx` (`KEGGRPair_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGene` ;

CREATE TABLE IF NOT EXISTS `KEGGGene` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  `Definition` TEXT NULL,
  `PositionStart` INT NULL,
  `PositionEnd` INT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGGene_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGeneName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneName` ;

CREATE TABLE IF NOT EXISTS `KEGGGeneName` (
  `WID` BIGINT NOT NULL,
  `KEGGGene_WID` BIGINT NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGGeneName_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGeneOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneOrthology` ;

CREATE TABLE IF NOT EXISTS `KEGGGeneOrthology` (
  `KEGGGene_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGGeneOrthology_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC),
  PRIMARY KEY (`KEGGGene_WID`, `Entry`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGenePathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGenePathway` ;

CREATE TABLE IF NOT EXISTS `KEGGGenePathway` (
  `KEGGGene_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(8) NOT NULL,
  `Name` VARCHAR(255) NULL,
  INDEX `fk_KEGGGenePathway_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGeneDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDBLink` ;

CREATE TABLE IF NOT EXISTS `KEGGGeneDBLink` (
  `KEGGGene_WID` BIGINT NOT NULL,
  `DB` VARCHAR(100) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGGeneDBLink_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  PRIMARY KEY (`KEGGGene_WID`, `DB`, `Id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGeneDisease`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDisease` ;

CREATE TABLE IF NOT EXISTS `KEGGGeneDisease` (
  `WID` BIGINT NOT NULL,
  `KEGGGene_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  `Disease` VARCHAR(255) NULL,
  INDEX `fk_KEGGGeneDisease_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGeneDrugTarget`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDrugTarget` ;

CREATE TABLE IF NOT EXISTS `KEGGGeneDrugTarget` (
  `KEGGGene_WID` BIGINT NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  `Entries` TEXT NULL,
  INDEX `fk_KEGGGeneDrugTarget_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  INDEX `pk_Name` (`Name` ASC),
  PRIMARY KEY (`KEGGGene_WID`, `Name`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGPathway` (
  `WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  `Org` VARCHAR(5) NULL,
  `Number` VARCHAR(25) NOT NULL,
  `Title` VARCHAR(255) NULL,
  `Image` VARCHAR(255) NULL,
  `Link` VARCHAR(255) NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `fk_KEGGPathway_DataSet1_idx` (`DataSet_WID` ASC),
  INDEX `pk_Org` (`Org` ASC),
  INDEX `pk_Number` (`Number` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntry` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntry` (
  `WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `Entry` TEXT NOT NULL,
  `Type` VARCHAR(25) NOT NULL,
  `Reaction` VARCHAR(255) NULL,
  `Link` TEXT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_KEGGPathwayEntry_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayRelation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayRelation` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayRelation` (
  `WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Id1` INT NOT NULL,
  `Id2` INT NOT NULL,
  `Type` VARCHAR(25) NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_KEGGPathwayRelation_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Id1` (`Id1` ASC),
  INDEX `pk_Id2` (`Id2` ASC),
  INDEX `pk_Type` (`Type` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayReaction` (
  `WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  `Type` VARCHAR(25) NULL,
  INDEX `fk_KEGGPathwayReaction_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  PRIMARY KEY (`WID`),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Entry` (`Entry` ASC),
  INDEX `pk_Type` (`Type` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayReactionSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReactionSubstrate` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayReactionSubstrate` (
  `KEGGPathwayReaction_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayReactionSubstrate_KEGGPathwayReaction1_idx` (`KEGGPathwayReaction_WID` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayReactionProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReactionProduct` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayReactionProduct` (
  `KEGGPathwayReaction_WID` BIGINT NOT NULL,
  `Id` INT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayReactionProduct_KEGGPathwayReaction1_idx` (`KEGGPathwayReaction_WID` ASC),
  INDEX `pk_Id` (`Id` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryGraphic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryGraphic` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryGraphic` (
  `WID` BIGINT NOT NULL,
  `KEGGPathwayEntry_WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `FGColor` VARCHAR(25) NULL,
  `BGColor` VARCHAR(25) NULL,
  `Type` VARCHAR(25) NULL,
  `X` INT NULL,
  `Y` INT NULL,
  `Coord` VARCHAR(255) NULL,
  `Width` INT NULL,
  `Height` INT NULL,
  INDEX `fk_KEGGPathwayEntryGraphic_KEGGPathwayEntry1_idx` (`KEGGPathwayEntry_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryEnzyme` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryEnzyme` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayEntryMap_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryCompound` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryCompound` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayEntryCompound_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryGene` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryGene` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayEntryGene_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryOrthology` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryOrthology` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayEntryOrthology_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGPathway` (
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGPathway_WID`),
  INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompound_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound_has_KEGGPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGCompound_has_KEGGPathway` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGCompound_WID`, `KEGGPathway_WID`),
  INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGCompound1_idx` (`KEGGCompound_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGReaction_has_KEGGPathway` (
  `KEGGReaction_WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGPathway_WID`),
  INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGReaction1_idx` (`KEGGReaction_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGene_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGene_has_KEGGPathway` ;

CREATE TABLE IF NOT EXISTS `KEGGGene_has_KEGGPathway` (
  `KEGGGene_WID` BIGINT NOT NULL,
  `KEGGPathway_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGGene_WID`, `KEGGPathway_WID`),
  INDEX `fk_KEGGGene_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `fk_KEGGGene_has_KEGGPathway_KEGGGene1_idx` (`KEGGGene_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryReaction` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayEntryReaction` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Entry` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayEntryReaction_KEGGPathway1_idx` (`KEGGPathway_WID` ASC),
  INDEX `pk_Entry` (`Entry` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_Taxonomy` ;

CREATE TABLE IF NOT EXISTS `KEGGPathway_has_Taxonomy` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGPathway_WID`, `Taxonomy_WID`),
  INDEX `fk_KEGGPathway_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_KEGGPathway_has_Taxonomy_KEGGPathway1_idx` (`KEGGPathway_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathwayRelationSubType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayRelationSubType` ;

CREATE TABLE IF NOT EXISTS `KEGGPathwayRelationSubType` (
  `KEGGPathwayRelation_WID` BIGINT NOT NULL,
  `Name` VARCHAR(25) NOT NULL,
  `Value` VARCHAR(25) NOT NULL,
  INDEX `fk_KEGGPathwayRelationSubType_KEGGPathwayRelation1_idx` (`KEGGPathwayRelation_WID` ASC),
  INDEX `pk_Name` (`Name` ASC),
  INDEX `Value` (`Value` ASC),
  PRIMARY KEY (`KEGGPathwayRelation_WID`, `Name`, `Value`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGGlycanName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanName` ;

CREATE TABLE IF NOT EXISTS `KEGGGlycanName` (
  `WID` BIGINT NOT NULL,
  `KEGGGlycan_WID` BIGINT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_KEGGGlycanName_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC),
  INDEX `pk_Name` (`Name` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGCompound_has_DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound_has_DrugBank` ;

CREATE TABLE IF NOT EXISTS `KEGGCompound_has_DrugBank` (
  `KEGGCompound_WID` BIGINT NOT NULL,
  `DrugBank_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGCompound_WID`, `DrugBank_WID`),
  INDEX `fk_KEGGCompound_has_DrugBank_DrugBank1_idx` (`DrugBank_WID` ASC),
  INDEX `fk_KEGGCompound_has_DrugBank_KEGGCompound1_idx` (`KEGGCompound_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Protein_has_KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_KEGGEnzyme` ;

CREATE TABLE IF NOT EXISTS `Protein_has_KEGGEnzyme` (
  `Protein_WID` BIGINT NOT NULL,
  `KEGGEnzyme_WID` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `KEGGEnzyme_WID`),
  INDEX `fk_Protein_has_KEGGEnzyme_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC),
  INDEX `fk_Protein_has_KEGGEnzyme_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneInfo_has_KEGGGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_KEGGGene` ;

CREATE TABLE IF NOT EXISTS `GeneInfo_has_KEGGGene` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `KEGGGene_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `KEGGGene_WID`),
  INDEX `fk_GeneInfo_has_KEGGGene_KEGGGene1_idx` (`KEGGGene_WID` ASC),
  INDEX `fk_GeneInfo_has_KEGGGene_GeneInfo1_idx` (`GeneInfo_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `ProteinPDBTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPDBTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinPDBTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinPDB_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `DrugBankDrugInteractionsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDrugInteractionsTemp` ;

CREATE TABLE IF NOT EXISTS `DrugBankDrugInteractionsTemp` (
  `DrugBank_WID` BIGINT NOT NULL,
  `Id` VARCHAR(10) NOT NULL,
  `Description` TEXT NULL,
  INDEX `fk_DrugBankDrugInteractions_DrugBank1` (`DrugBank_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `ProteinPMIDTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPMIDTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinPMIDTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinPMID_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinKEGGTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKEGGTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinKEGGTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinKEGG_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinGoTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGoTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinGoTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(10) NOT NULL,
  INDEX `pk_Protein_WID` (`Protein_WID` ASC, `Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinRefSeqTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinRefSeqTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinRefSeqTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinRefSeq_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinMINTTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinMINTTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinMINTTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinMINT_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGene` ;

CREATE TABLE IF NOT EXISTS `ProteinGene` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinGene_Protein2_idx` (`Protein_WID` ASC),
  PRIMARY KEY (`Protein_WID`, `Id`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `ProteinGeneTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinGeneTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinGene_Protein2` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `ProteinDIPTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDIPTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinDIPTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinDIP_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinPFAMTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPFAMTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinPFAMTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinPFAM_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `ProteinIntActTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIntActTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinIntActTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinIntAct_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinECTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinECTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinECTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinEC_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinBioCycTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinBioCycTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinBioCycTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinBioCyc_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinDrugBankTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDrugBankTemp` ;

CREATE TABLE IF NOT EXISTS `ProteinDrugBankTemp` (
  `Protein_WID` BIGINT NOT NULL,
  `Id` VARCHAR(100) NOT NULL,
  INDEX `fk_ProteinDrugBank_Protein1` (`Protein_WID` ASC),
  INDEX `pk_Id` (`Id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_Protein` ;

CREATE TABLE IF NOT EXISTS `KEGGPathway_has_Protein` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGPathway_WID`, `Protein_WID`),
  INDEX `fk_KEGGPathway_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `fk_KEGGPathway_has_Protein_KEGGPathway1_idx` (`KEGGPathway_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_GeneInfo` ;

CREATE TABLE IF NOT EXISTS `KEGGPathway_has_GeneInfo` (
  `KEGGPathway_WID` BIGINT NOT NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  PRIMARY KEY (`KEGGPathway_WID`, `GeneInfo_WID`),
  INDEX `fk_KEGGPathway_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `fk_KEGGPathway_has_GeneInfo_KEGGPathway1_idx` (`KEGGPathway_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMapTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMapTemp` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMapTemp` (
  `Number` VARCHAR(10) NULL DEFAULT NULL,
  `Month` VARCHAR(5) NULL DEFAULT NULL,
  `Day` VARCHAR(5) NULL DEFAULT NULL,
  `Year` VARCHAR(5) NULL DEFAULT NULL,
  `CytogLoc` VARCHAR(25) NULL DEFAULT NULL,
  `GeneSymbol` VARCHAR(100) NULL DEFAULT NULL,
  `GeneStatus` VARCHAR(5) NULL DEFAULT NULL,
  `Title` VARCHAR(255) NULL DEFAULT NULL,
  `TitleCont` VARCHAR(255) NULL DEFAULT NULL,
  `MIMNumber` BIGINT NULL DEFAULT NULL,
  `Method` VARCHAR(100) NULL DEFAULT NULL,
  `Comments` VARCHAR(255) NULL DEFAULT NULL,
  `CommentsCont` VARCHAR(255) NULL DEFAULT NULL,
  `Disorders` TEXT NULL DEFAULT NULL,
  `DisordersCont1` TEXT NULL DEFAULT NULL,
  `DisordersCont2` TEXT NULL DEFAULT NULL,
  `MouseCorr` VARCHAR(25) NULL DEFAULT NULL,
  `Reference` VARCHAR(100) NULL DEFAULT NULL)
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_GeneSymbol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_GeneSymbol` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMap_has_GeneSymbol` (
  `OMIMGeneMap_WID` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`GeneSymbol`, `OMIMGeneMap_WID`),
  INDEX `fk_OMIMGeneMap_has_GeneSymbol_OMIMGeneMap1` (`OMIMGeneMap_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMethod` ;

CREATE TABLE IF NOT EXISTS `OMIMMethod` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Method` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Method` (`Method` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_OMIMMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_OMIMMethod` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMap_has_OMIMMethod` (
  `OMIMGeneMap_WID` BIGINT NOT NULL,
  `OMIMMethod_WID` BIGINT NOT NULL,
  PRIMARY KEY (`OMIMGeneMap_WID`, `OMIMMethod_WID`),
  INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMMethod1_idx` (`OMIMMethod_WID` ASC),
  INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMGeneMap1` (`OMIMGeneMap_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_OMIMMorbidMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_OMIMMorbidMap` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMap_has_OMIMMorbidMap` (
  `OMIMGeneMap_WID` BIGINT NOT NULL,
  `OMIMMorbidMap_WID` BIGINT NOT NULL,
  PRIMARY KEY (`OMIMGeneMap_WID`, `OMIMMorbidMap_WID`),
  INDEX `fk_OMIMGeneMap_has_OMIMMorbidMap_OMIMMorbidMap1` (`OMIMMorbidMap_WID` ASC),
  INDEX `fk_OMIMGeneMap_has_OMIMMorbidMap_OMIMGeneMap1` (`OMIMGeneMap_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMap` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `Number` VARCHAR(10) NOT NULL,
  `Month` VARCHAR(5) NULL DEFAULT NULL,
  `Day` VARCHAR(5) NULL DEFAULT NULL,
  `Year` VARCHAR(5) NULL DEFAULT NULL,
  `CytogLoc` VARCHAR(25) NULL DEFAULT NULL,
  `GeneStatus` VARCHAR(5) NULL DEFAULT NULL,
  `Title` TEXT NULL DEFAULT NULL,
  `MIMNumber` BIGINT NULL DEFAULT NULL,
  `Comments` TEXT NULL DEFAULT NULL,
  `MouseCorr` VARCHAR(25) NULL DEFAULT NULL,
  `Reference` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_Number` (`Number` ASC),
  INDEX `pk_MIMNumber` (`MIMNumber` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap_has_GeneSymbol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap_has_GeneSymbol` ;

CREATE TABLE IF NOT EXISTS `OMIMMorbidMap_has_GeneSymbol` (
  `OMIMMorbidMap_WID` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`OMIMMorbidMap_WID`, `GeneSymbol`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap` ;

CREATE TABLE IF NOT EXISTS `OMIMMorbidMap` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `OMIM_ID` BIGINT NULL DEFAULT NULL,
  `Disorder` VARCHAR(100) NOT NULL,
  `MIMNumber` BIGINT NULL DEFAULT NULL,
  `CytogLog` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_OMIM_ID` (`OMIM_ID` ASC),
  INDEX `pk_Disorder` (`Disorder` ASC),
  INDEX `pk_MIMNumber` (`MIMNumber` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_GeneSymbolTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_GeneSymbolTemp` ;

CREATE TABLE IF NOT EXISTS `OMIMGeneMap_has_GeneSymbolTemp` (
  `OMIMGeneMap_WID` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(25) NOT NULL,
  INDEX `fk_OMIMGeneMap_has_GeneSymbol_OMIMGeneMap1` (`OMIMGeneMap_WID` ASC),
  INDEX `pk_GeneSymbol` (`GeneSymbol` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMethodTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMethodTemp` ;

CREATE TABLE IF NOT EXISTS `OMIMMethodTemp` (
  `WID` BIGINT NOT NULL,
  `Method` VARCHAR(25) NOT NULL,
  INDEX `pk_WID` (`WID` ASC),
  INDEX `pk_Method` (`Method` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap_has_GeneSymbolTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap_has_GeneSymbolTemp` ;

CREATE TABLE IF NOT EXISTS `OMIMMorbidMap_has_GeneSymbolTemp` (
  `OMIMMorbidMap_WID` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(25) NOT NULL,
  INDEX `pk_OMIMMorbidMap` (`OMIMMorbidMap_WID` ASC),
  INDEX `pk_GeneSymbol` (`GeneSymbol` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIM` ;

CREATE TABLE IF NOT EXISTS `OMIM` (
  `WID` BIGINT NOT NULL,
  `OMIM_ID` BIGINT NOT NULL,
  `TX` TEXT NULL,
  `DataSet_WID` BIGINT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `pk_OMIM_ID` (`OMIM_ID` ASC),
  INDEX `fk_OMIM_DataSet1_idx` (`DataSet_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMTI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMTI` ;

CREATE TABLE IF NOT EXISTS `OMIMTI` (
  `OMIM_WID` BIGINT NOT NULL,
  `TI` VARCHAR(255) NOT NULL,
  INDEX `fk_OMIMTitle_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`OMIM_WID`, `TI`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMTX`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMTX` ;

CREATE TABLE IF NOT EXISTS `OMIMTX` (
  `OMIM_WID` BIGINT NOT NULL,
  `Tag` VARCHAR(100) NOT NULL,
  `TX` LONGTEXT NOT NULL,
  INDEX `fk_OMIMTX_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`OMIM_WID`, `Tag`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMRF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMRF` ;

CREATE TABLE IF NOT EXISTS `OMIMRF` (
  `WID` BIGINT NOT NULL,
  `OMIM_WID` BIGINT NOT NULL,
  `Reference` TEXT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OMIMRF_OMIM1_idx` (`OMIM_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMCS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCS` ;

CREATE TABLE IF NOT EXISTS `OMIMCS` (
  `WID` BIGINT NOT NULL,
  `OMIM_WID` BIGINT NOT NULL,
  `CS` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OMIMCS_OMIM1_idx` (`OMIM_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMCSData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCSData` ;

CREATE TABLE IF NOT EXISTS `OMIMCSData` (
  `WID` BIGINT NOT NULL,
  `OMIMCS_WID` BIGINT NOT NULL,
  `Data` TEXT NOT NULL,
  INDEX `fk_OMIMCSData_OMIMCS1_idx` (`OMIMCS_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMCD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCD` ;

CREATE TABLE IF NOT EXISTS `OMIMCD` (
  `OMIM_WID` BIGINT NOT NULL,
  `CD` VARCHAR(100) NOT NULL,
  INDEX `fk_OMIMICD_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`OMIM_WID`, `CD`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMED`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMED` ;

CREATE TABLE IF NOT EXISTS `OMIMED` (
  `OMIM_WID` BIGINT NOT NULL,
  `ED` VARCHAR(100) NOT NULL,
  INDEX `fk_OMIMED_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`OMIM_WID`, `ED`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMAV`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMAV` ;

CREATE TABLE IF NOT EXISTS `OMIMAV` (
  `WID` BIGINT NOT NULL,
  `OMIM_WID` BIGINT NOT NULL,
  `AV` TEXT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `fk_OMIMAV_OMIM1_idx` (`OMIM_WID` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMCN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCN` ;

CREATE TABLE IF NOT EXISTS `OMIMCN` (
  `OMIM_WID` BIGINT NOT NULL,
  `CN` VARCHAR(100) NOT NULL,
  INDEX `fk_OMIMCN_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`OMIM_WID`, `CN`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMSA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMSA` ;

CREATE TABLE IF NOT EXISTS `OMIMSA` (
  `WID` BIGINT NOT NULL,
  `OMIM_WID` BIGINT NOT NULL,
  `SA` TEXT NOT NULL,
  INDEX `fk_OMIMSA_OMIM1_idx` (`OMIM_WID` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `GeneInfo_has_OMIM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_OMIM` ;

CREATE TABLE IF NOT EXISTS `GeneInfo_has_OMIM` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `OMIM_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `OMIM_WID`),
  INDEX `fk_GeneInfo_has_OMIM_OMIM1_idx` (`OMIM_WID` ASC),
  INDEX `fk_GeneInfo_has_OMIM_GeneInfo1_idx` (`GeneInfo_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneInfo_has_GenePTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_GenePTT` ;

CREATE TABLE IF NOT EXISTS `GeneInfo_has_GenePTT` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `GenePTT_ProteinGi` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `GenePTT_ProteinGi`),
  INDEX `fk_GeneInfo_has_GenomesPTT_GenePTT1_idx` (`GenePTT_ProteinGi` ASC),
  INDEX `fk_GeneInfo_has_GenePTT_GeneInfo1_idx` (`GeneInfo_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `UniRefEntry_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntry_has_Protein` ;

CREATE TABLE IF NOT EXISTS `UniRefEntry_has_Protein` (
  `UniRefEntry_WID` BIGINT NOT NULL,
  `Protein_WID` BIGINT NOT NULL,
  PRIMARY KEY (`UniRefEntry_WID`, `Protein_WID`),
  INDEX `fk_UniRefEntry_has_Protein_Protein1_idx` (`Protein_WID` ASC),
  INDEX `fk_UniRefEntry_has_Protein_UniRefEntry1_idx` (`UniRefEntry_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamA_has_PfamArchitecture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamA_has_PfamArchitecture` ;

CREATE TABLE IF NOT EXISTS `PfamA_has_PfamArchitecture` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `PfamArchitecture_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`PfamA_WID`, `PfamArchitecture_WID`),
  INDEX `fk_PfamA_has_PfamArchitecture_PfamArchitecture1_idx` (`PfamArchitecture_WID` ASC),
  INDEX `fk_PfamA_has_PfamArchitecture_PfamA1_idx` (`PfamA_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamA_has_Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamA_has_Ontology` ;

CREATE TABLE IF NOT EXISTS `PfamA_has_Ontology` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `Ontology_WID` BIGINT NOT NULL,
  PRIMARY KEY (`PfamA_WID`, `Ontology_WID`),
  INDEX `fk_PfamA_has_Ontology_Ontology1_idx` (`Ontology_WID` ASC),
  INDEX `fk_PfamA_has_Ontology_PfamA1_idx` (`PfamA_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamA_has_PfamLiteratureReferences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamA_has_PfamLiteratureReferences` ;

CREATE TABLE IF NOT EXISTS `PfamA_has_PfamLiteratureReferences` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `PfamLiteratureReferences_WID` BIGINT(20) NOT NULL,
  `order_added` TINYINT(4) NOT NULL,
  `comment` TINYTEXT NULL,
  PRIMARY KEY (`PfamA_WID`, `PfamLiteratureReferences_WID`, `order_added`),
  INDEX `fk_PfamA_has_PfamLiteratureReferences_PfamLiteratureReferen_idx` (`PfamLiteratureReferences_WID` ASC),
  INDEX `fk_PfamA_has_PfamLiteratureReferences_PfamA1_idx` (`PfamA_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamClans_has_PfamA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamClans_has_PfamA` ;

CREATE TABLE IF NOT EXISTS `PfamClans_has_PfamA` (
  `PfamClans_WID` BIGINT(20) NOT NULL,
  `PfamA_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`PfamClans_WID`, `PfamA_WID`),
  INDEX `fk_PfamClans_has_PfamA_PfamA1_idx` (`PfamA_WID` ASC),
  INDEX `fk_PfamClans_has_PfamA_PfamClans1_idx` (`PfamClans_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamClans_has_PfamArchitecture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamClans_has_PfamArchitecture` ;

CREATE TABLE IF NOT EXISTS `PfamClans_has_PfamArchitecture` (
  `PfamClans_WID` BIGINT(20) NOT NULL,
  `PfamArchitecture_WID` BIGINT(20) NOT NULL,
  PRIMARY KEY (`PfamClans_WID`, `PfamArchitecture_WID`),
  INDEX `fk_PfamClans_has_PfamArchitecture_PfamArchitecture1_idx` (`PfamArchitecture_WID` ASC),
  INDEX `fk_PfamClans_has_PfamArchitecture_PfamClans1_idx` (`PfamClans_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamClans_has_PfamLiteratureReferences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamClans_has_PfamLiteratureReferences` ;

CREATE TABLE IF NOT EXISTS `PfamClans_has_PfamLiteratureReferences` (
  `PfamClans_WID` BIGINT(20) NOT NULL,
  `PfamLiteratureReferences_WID` BIGINT(20) NOT NULL,
  `order_added` TINYINT(4) NOT NULL DEFAULT 0,
  `comment` TINYTEXT NULL,
  PRIMARY KEY (`PfamClans_WID`, `PfamLiteratureReferences_WID`, `order_added`),
  INDEX `fk_PfamClans_has_PfamLiteratureReferences_PfamLiteratureRef_idx` (`PfamLiteratureReferences_WID` ASC),
  INDEX `fk_PfamClans_has_PfamLiteratureReferences_PfamClans1_idx` (`PfamClans_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamA_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamA_has_Taxonomy` ;

CREATE TABLE IF NOT EXISTS `PfamA_has_Taxonomy` (
  `PfamA_WID` BIGINT(20) NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`PfamA_WID`, `Taxonomy_WID`),
  INDEX `fk_PfamA_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_PfamA_has_Taxonomy_PfamA1_idx` (`PfamA_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamSeq_has_UniProtId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamSeq_has_UniProtId` ;

CREATE TABLE IF NOT EXISTS `PfamSeq_has_UniProtId` (
  `auto_pfamseq` BIGINT NOT NULL,
  `UniProt_Id` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`auto_pfamseq`),
  UNIQUE INDEX `UniProt_Id_UNIQUE` (`UniProt_Id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `PfamARegFullSignificantTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamARegFullSignificantTemp` ;

CREATE TABLE IF NOT EXISTS `PfamARegFullSignificantTemp` (
  `WID` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `auto_pfamA_reg_full` BIGINT NOT NULL,
  PRIMARY KEY (`WID`, `auto_pfamA_reg_full`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `PfamCompleteProteomes_has_PfamSeq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `PfamCompleteProteomes_has_PfamSeq` ;

CREATE TABLE IF NOT EXISTS `PfamCompleteProteomes_has_PfamSeq` (
  `PfamCompleteProteomes_WID` BIGINT(20) NOT NULL,
  `auto_pfamseq` BIGINT NOT NULL,
  PRIMARY KEY (`PfamCompleteProteomes_WID`, `auto_pfamseq`),
  INDEX `fk_PfamCompleteProteomes_has_PfamSeq_has_Protein_PfamComple_idx` (`PfamCompleteProteomes_WID` ASC),
  INDEX `fk_PfamCompleteProteomes_has_PfamSeq_PfamSeq_has_Protein1_idx` (`auto_pfamseq` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `pfamA_ncbi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pfamA_ncbi` ;

CREATE TABLE IF NOT EXISTS `pfamA_ncbi` (
  `auto_pfamA` INT(5) NOT NULL,
  `pfamA_acc` VARCHAR(7) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `pfamA_id` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NOT NULL,
  `ncbi_taxid` INT(10) UNSIGNED NULL DEFAULT '0',
  INDEX `auto_pfamA` (`auto_pfamA` ASC),
  INDEX `ncbi_taxid` (`ncbi_taxid` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = COMPACT;


-- -----------------------------------------------------
-- Table `pfamA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pfamA` ;

CREATE TABLE IF NOT EXISTS `pfamA` (
  `auto_pfamA` INT(5) NOT NULL AUTO_INCREMENT,
  `pfamA_acc` VARCHAR(7) NOT NULL,
  `pfamA_id` VARCHAR(16) NOT NULL,
  `previous_id` TINYTEXT NULL DEFAULT NULL,
  `description` VARCHAR(100) NOT NULL,
  `author` TINYTEXT NOT NULL,
  `deposited_by` VARCHAR(100) NOT NULL DEFAULT 'anon',
  `seed_source` TINYTEXT NOT NULL,
  `type` ENUM('Family','Domain','Repeat','Motif') NOT NULL,
  `comment` LONGTEXT NULL DEFAULT NULL,
  `sequence_GA` DOUBLE(8,2) NOT NULL,
  `domain_GA` DOUBLE(8,2) NOT NULL,
  `sequence_TC` DOUBLE(8,2) NOT NULL,
  `domain_TC` DOUBLE(8,2) NOT NULL,
  `sequence_NC` DOUBLE(8,2) NOT NULL,
  `domain_NC` DOUBLE(8,2) NOT NULL,
  `buildMethod` TINYTEXT NOT NULL,
  `model_length` MEDIUMINT(8) NOT NULL,
  `searchMethod` TINYTEXT NOT NULL,
  `msv_lambda` DOUBLE(8,2) NOT NULL,
  `msv_mu` DOUBLE(8,2) NOT NULL,
  `viterbi_lambda` DOUBLE(8,2) NOT NULL,
  `viterbi_mu` DOUBLE(8,2) NOT NULL,
  `forward_lambda` DOUBLE(8,2) NOT NULL,
  `forward_tau` DOUBLE(8,2) NOT NULL,
  `num_seed` INT(10) NULL DEFAULT NULL,
  `num_full` INT(10) NULL DEFAULT NULL,
  `updated` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` DATETIME NULL DEFAULT NULL,
  `version` SMALLINT(5) NULL DEFAULT NULL,
  `number_archs` INT(8) NULL DEFAULT NULL,
  `number_species` INT(8) NULL DEFAULT NULL,
  `number_structures` INT(8) NULL DEFAULT NULL,
  `number_ncbi` INT(8) NULL DEFAULT NULL,
  `number_meta` INT(8) NULL DEFAULT NULL,
  `average_length` DOUBLE(6,2) NULL DEFAULT NULL,
  `percentage_id` INT(3) NULL DEFAULT NULL,
  `average_coverage` DOUBLE(6,2) NULL DEFAULT NULL,
  `change_status` TINYTEXT NULL DEFAULT NULL,
  `seed_consensus` TEXT NULL DEFAULT NULL,
  `full_consensus` TEXT NULL DEFAULT NULL,
  `number_shuffled_hits` INT(10) NULL DEFAULT NULL,
  PRIMARY KEY (`auto_pfamA`),
  UNIQUE INDEX `pfamA_acc` (`pfamA_acc` ASC),
  UNIQUE INDEX `pfamA_id` (`pfamA_id` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `Protein_has_GenePTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_GenePTT` ;

CREATE TABLE IF NOT EXISTS `Protein_has_GenePTT` (
  `Protein_WID` BIGINT NOT NULL,
  `GenePTT_ProteinGi` BIGINT NOT NULL,
  PRIMARY KEY (`Protein_WID`, `GenePTT_ProteinGi`),
  INDEX `fk_Protein_has_GenePTT_GenePTT1_idx` (`GenePTT_ProteinGi` ASC),
  INDEX `fk_Protein_has_GenePTT_Protein1_idx` (`Protein_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GenePTT_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenePTT_has_Taxonomy` ;

CREATE TABLE IF NOT EXISTS `GenePTT_has_Taxonomy` (
  `GenePTT_ProteinGi` BIGINT NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GenePTT_ProteinGi`, `Taxonomy_WID`),
  INDEX `fk_GenePTT_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_GenePTT_has_Taxonomy_GenePTT1_idx` (`GenePTT_ProteinGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankFeatures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankFeatures` ;

CREATE TABLE IF NOT EXISTS `GeneBankFeatures` (
  `GeneBank_WID` BIGINT NOT NULL,
  `KeyName` VARCHAR(20) NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Gi` BIGINT NULL,
  `Product` VARCHAR(255) NULL,
  `Gene` VARCHAR(50) NULL,
  INDEX `fk_GeneBankFeatures_GeneBank1_idx` (`GeneBank_WID` ASC),
  INDEX `key_index` (`KeyName` ASC),
  INDEX `gi_index` (`Gi` ASC),
  INDEX `location_index` (`Location` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankCDS_has_GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankCDS_has_GeneInfo` ;

CREATE TABLE IF NOT EXISTS `GeneBankCDS_has_GeneInfo` (
  `GeneBankCDS_WID` BIGINT NOT NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneBankCDS_WID`, `GeneInfo_WID`),
  INDEX `fk_GeneBankCDS_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `fk_GeneBankCDS_has_GeneInfo_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankCDSDBXref`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankCDSDBXref` ;

CREATE TABLE IF NOT EXISTS `GeneBankCDSDBXref` (
  `GeneBankCDS_WID` BIGINT NOT NULL,
  `DBXrefs` VARCHAR(50) NOT NULL,
  `DBIdent` VARCHAR(45) NOT NULL,
  INDEX `fk_GeneBankCDSDBXref_GeneBankCDS1_idx` (`GeneBankCDS_WID` ASC),
  INDEX `db_index` (`DBXrefs` ASC, `DBIdent` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankCDSTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankCDSTemp` ;

CREATE TABLE IF NOT EXISTS `GeneBankCDSTemp` (
  `WID` BIGINT NOT NULL,
  `ProteinGi` INT NOT NULL,
  PRIMARY KEY (`WID`),
  INDEX `proteinGi_index` (`ProteinGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneBankAccession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneBankAccession` ;

CREATE TABLE IF NOT EXISTS `GeneBankAccession` (
  `GeneBank_WID` BIGINT NOT NULL,
  `Accession` VARCHAR(45) NOT NULL,
  INDEX `fk_GeneBankAccession_GeneBank1_idx` (`GeneBank_WID` ASC),
  INDEX `accession_index` (`Accession` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneRNT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneRNT` ;

CREATE TABLE IF NOT EXISTS `GeneRNT` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT,
  `pFrom` BIGINT NOT NULL,
  `pTo` BIGINT NOT NULL,
  `Location` VARCHAR(100) NOT NULL,
  `Strand` VARCHAR(50) NOT NULL,
  `PLength` INT NOT NULL,
  `GenomicNucleotideGi` BIGINT NOT NULL,
  `GeneSymbol` VARCHAR(100) NULL,
  `GeneLocusTag` VARCHAR(100) NULL,
  `Code` VARCHAR(50) NULL,
  `COG` VARCHAR(50) NULL,
  `Product` VARCHAR(1000) NOT NULL,
  `PTTFile` VARCHAR(50) NOT NULL,
  `DataSetWID` BIGINT NOT NULL,
  INDEX `fk_GenomesPTT_DataSet_idx` (`DataSetWID` ASC),
  INDEX `pk_pFrom` (`pFrom` ASC),
  INDEX `pk_pTo` (`pTo` ASC),
  INDEX `pk_GeneSymbol` (`GeneSymbol` ASC),
  INDEX `pk_COG` (`COG` ASC),
  INDEX `pk_PTTFile` (`PTTFile` ASC),
  INDEX `pk_GenomicNucleotideGi` (`GenomicNucleotideGi` ASC),
  PRIMARY KEY (`WID`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `GeneInfo_has_GeneRNT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_GeneRNT` ;

CREATE TABLE IF NOT EXISTS `GeneInfo_has_GeneRNT` (
  `GeneInfo_WID` BIGINT NOT NULL,
  `GeneRNT_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneInfo_WID`, `GeneRNT_WID`),
  INDEX `fk_GeneInfo_has_GeneRNT_GeneRNT1_idx` (`GeneRNT_WID` ASC),
  INDEX `fk_GeneInfo_has_GeneRNT_GeneInfo1_idx` (`GeneInfo_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `GeneRNT_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneRNT_has_Taxonomy` ;

CREATE TABLE IF NOT EXISTS `GeneRNT_has_Taxonomy` (
  `GeneRNT_WID` BIGINT NOT NULL,
  `Taxonomy_WID` BIGINT NOT NULL,
  PRIMARY KEY (`GeneRNT_WID`, `Taxonomy_WID`),
  INDEX `fk_GeneRNT_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC),
  INDEX `fk_GeneRNT_has_Taxonomy_GeneRNT1_idx` (`GeneRNT_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;


-- -----------------------------------------------------
-- Table `table3`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `table3` ;

CREATE TABLE IF NOT EXISTS `table3` (
  `id` INT NOT NULL,
  `table3col` VARCHAR(45) NULL,
  `table3col1` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `table1` ;

CREATE TABLE IF NOT EXISTS `table1` (
  `id` INT NOT NULL,
  `table1col` VARCHAR(45) NULL,
  `table1col1` VARCHAR(45) NULL,
  `table3_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_table31_idx` (`table3_id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `table2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `table2` ;

CREATE TABLE IF NOT EXISTS `table2` (
  `id` INT NOT NULL,
  `table1_id` INT NOT NULL,
  `table2col` VARCHAR(45) NULL,
  `table2col1` VARCHAR(45) NULL,
  PRIMARY KEY (`id`, `table1_id`),
  INDEX `fk_table2_table11_idx` (`table1_id` ASC))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `Gene2RNANucleotide`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2RNANucleotide` ;

CREATE TABLE IF NOT EXISTS `Gene2RNANucleotide` (
  `RNANucleotideGi` BIGINT NOT NULL,
  `RNANucleotideAccession` VARCHAR(50) NOT NULL,
  `RNANucleotideAccessionVersion` INT NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  INDEX `fk_Gene2RNANucleotide_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `accession_index` (`RNANucleotideAccession` ASC),
  INDEX `gi_index` (`RNANucleotideGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Gene2ProteinAccession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2ProteinAccession` ;

CREATE TABLE IF NOT EXISTS `Gene2ProteinAccession` (
  `ProteinGi` BIGINT NOT NULL,
  `ProteinAccession` VARCHAR(50) NOT NULL,
  `ProteinAccessionVersion` INT NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  INDEX `fk_Gene2ProteinAccession_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `accession_index` (`ProteinAccession` ASC),
  INDEX `gi_index` (`ProteinGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Gene2GenomicNucleotide`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2GenomicNucleotide` ;

CREATE TABLE IF NOT EXISTS `Gene2GenomicNucleotide` (
  `GenomicNucleotideGi` BIGINT NOT NULL,
  `GenomicNucleotideAccession` VARCHAR(50) NOT NULL,
  `GenomicNucleotideAccessionVersion` INT NULL,
  `StartPositionOnTheGenomicAccession` VARCHAR(50) NULL,
  `EndPositionOnTheGenomicAccession` VARCHAR(50) NULL,
  `Orientation` VARCHAR(50) NULL,
  `Assembly` VARCHAR(50) NULL,
  `GeneInfo_WID` BIGINT NOT NULL,
  INDEX `fk_Gene2GenomicNucleotide_GeneInfo1_idx` (`GeneInfo_WID` ASC),
  INDEX `gi_index` (`GenomicNucleotideGi` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
