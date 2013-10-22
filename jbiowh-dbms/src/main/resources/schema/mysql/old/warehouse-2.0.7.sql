SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `WIDTable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `WIDTable` ;

CREATE  TABLE IF NOT EXISTS `WIDTable` (
  `WID` BIGINT NOT NULL DEFAULT 1 ,
  `PreviousWID` BIGINT NOT NULL DEFAULT 1000000 ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `DataSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DataSet` ;

CREATE  TABLE IF NOT EXISTS `DataSet` (
  `WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  `Version` VARCHAR(50) NULL DEFAULT NULL ,
  `ReleaseDate` DATETIME NULL DEFAULT NULL ,
  `LoadDate` DATETIME NOT NULL ,
  `ChangeDate` DATETIME NULL DEFAULT NULL ,
  `HomeURL` VARCHAR(255) NULL DEFAULT NULL ,
  `LoadedBy` VARCHAR(255) NULL DEFAULT NULL ,
  `Application` VARCHAR(255) NULL DEFAULT NULL ,
  `ApplicationVersion` VARCHAR(255) NULL DEFAULT NULL ,
  `Status` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `NAME` ON `DataSet` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `DivisionTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DivisionTemp` ;

CREATE  TABLE IF NOT EXISTS `DivisionTemp` (
  `id` INT NOT NULL ,
  `Code` VARCHAR(4) NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  `Comment` VARCHAR(255) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyDivision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyDivision` ;

CREATE  TABLE IF NOT EXISTS `TaxonomyDivision` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `id` INT NOT NULL ,
  `Code` VARCHAR(4) NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  `Comment` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Id` ON `TaxonomyDivision` (`id` ASC) ;

CREATE INDEX `pk_Name` ON `TaxonomyDivision` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `GenCodeTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenCodeTemp` ;

CREATE  TABLE IF NOT EXISTS `GenCodeTemp` (
  `GenCodeId` INT NOT NULL ,
  `Abbreviation` VARCHAR(50) NULL DEFAULT NULL ,
  `Name` VARCHAR(100) NOT NULL ,
  `Code` VARCHAR(255) NOT NULL ,
  `Start` VARCHAR(100) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomyGenCode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyGenCode` ;

CREATE  TABLE IF NOT EXISTS `TaxonomyGenCode` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `GenCodeId` INT NOT NULL ,
  `Abbreviation` VARCHAR(50) NULL DEFAULT NULL ,
  `Name` VARCHAR(100) NOT NULL ,
  `Code` VARCHAR(255) NOT NULL ,
  `Start` VARCHAR(100) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_GeneCodeId` ON `TaxonomyGenCode` (`GenCodeId` ASC) ;

CREATE INDEX `pk_Name` ON `TaxonomyGenCode` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `CitTax`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CitTax` ;

CREATE  TABLE IF NOT EXISTS `CitTax` (
  `cit_id` INT NULL DEFAULT NULL ,
  `tax_id` INT NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_cit_id` ON `CitTax` (`cit_id` ASC) ;

CREATE INDEX `pk_tax_id` ON `CitTax` (`tax_id` ASC) ;


-- -----------------------------------------------------
-- Table `NCBICitationTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `NCBICitationTemp` ;

CREATE  TABLE IF NOT EXISTS `NCBICitationTemp` (
  `cit_id` INT NOT NULL ,
  `cit_key` VARCHAR(500) NOT NULL ,
  `pubmed_id` INT NULL DEFAULT NULL ,
  `medline_id` INT NULL DEFAULT NULL ,
  `url` VARCHAR(255) NULL DEFAULT NULL ,
  `text` VARCHAR(5000) NULL DEFAULT NULL ,
  `taxid_list` TEXT NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_cit_id` ON `NCBICitationTemp` (`cit_id` ASC) ;

CREATE INDEX `pk_medline_id` ON `NCBICitationTemp` (`medline_id` ASC) ;


-- -----------------------------------------------------
-- Table `TaxonomyUnParseCitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyUnParseCitation` ;

CREATE  TABLE IF NOT EXISTS `TaxonomyUnParseCitation` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `CitId` INT NOT NULL ,
  `CitKey` VARCHAR(500) NULL DEFAULT NULL ,
  `URL` VARCHAR(255) NULL DEFAULT NULL ,
  `Text` VARCHAR(5000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_CitId` ON `TaxonomyUnParseCitation` (`CitId` ASC) ;


-- -----------------------------------------------------
-- Table `Names`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Names` ;

CREATE  TABLE IF NOT EXISTS `Names` (
  `tax_id` INT NOT NULL ,
  `name_txt` VARCHAR(255) NOT NULL ,
  `unique_name` VARCHAR(100) NOT NULL ,
  `name_class` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_name_class` ON `Names` (`name_class` ASC) ;

CREATE INDEX `pk_tax_id` ON `Names` (`tax_id` ASC) ;


-- -----------------------------------------------------
-- Table `Nodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Nodes` ;

CREATE  TABLE IF NOT EXISTS `Nodes` (
  `tax_id` INT NOT NULL ,
  `parent` INT NOT NULL ,
  `rank_name` VARCHAR(100) NOT NULL ,
  `embl` VARCHAR(10) NULL DEFAULT NULL ,
  `division` INT NOT NULL ,
  `inherited_div_flag` INT NOT NULL ,
  `genetic` INT NOT NULL ,
  `inherited_GC` INT NOT NULL ,
  `mitochondrial` INT NOT NULL ,
  `inherited_MGC` INT NOT NULL ,
  `GenBank` INT NOT NULL ,
  `hidden` INT NOT NULL ,
  `Comment` VARCHAR(255) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_tax_id` ON `Nodes` (`tax_id` ASC) ;

CREATE INDEX `pk_division` ON `Nodes` (`division` ASC) ;

CREATE INDEX `pk_genetic` ON `Nodes` (`genetic` ASC) ;

CREATE INDEX `pk_mitochondrial` ON `Nodes` (`mitochondrial` ASC) ;


-- -----------------------------------------------------
-- Table `Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Taxonomy` ;

CREATE  TABLE IF NOT EXISTS `Taxonomy` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `TaxId` BIGINT NOT NULL ,
  `ParentTaxId` BIGINT NOT NULL ,
  `Rank` VARCHAR(100) NULL DEFAULT NULL ,
  `EMBLCode` VARCHAR(5) NULL DEFAULT NULL ,
  `TaxonomyDivision_WID` BIGINT NOT NULL ,
  `InheritedDivision` VARCHAR(1) NULL DEFAULT NULL ,
  `TaxonomyGenCode_WID` BIGINT NOT NULL ,
  `InheritedGencode` VARCHAR(1) NULL DEFAULT NULL ,
  `TaxonomyMCGenCode_WID` BIGINT NOT NULL ,
  `InheritedMCGencode` VARCHAR(1) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Taxonomy_DataSet_idx` ON `Taxonomy` (`DataSetWID` ASC) ;

CREATE INDEX `pk_TaxId` ON `Taxonomy` (`TaxId` ASC) ;

CREATE INDEX `pk_ParentTaxId` ON `Taxonomy` (`ParentTaxId` ASC) ;

CREATE INDEX `fk_Taxonomy_TaxonomyDivision1_idx` ON `Taxonomy` (`TaxonomyDivision_WID` ASC) ;

CREATE INDEX `fk_Taxonomy_TaxonomyGenCode1_idx` ON `Taxonomy` (`TaxonomyGenCode_WID` ASC) ;

CREATE INDEX `fk_Taxonomy_TaxonomyGenCode2_idx` ON `Taxonomy` (`TaxonomyMCGenCode_WID` ASC) ;


-- -----------------------------------------------------
-- Table `TaxonomySynonymNameClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomySynonymNameClass` ;

CREATE  TABLE IF NOT EXISTS `TaxonomySynonymNameClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `NameClass` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `TaxonomySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomySynonym` ;

CREATE  TABLE IF NOT EXISTS `TaxonomySynonym` (
  `Taxonomy_WID` BIGINT NOT NULL ,
  `Synonym` VARCHAR(255) NOT NULL ,
  `TaxonomySynonymNameClass_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Taxonomy_WID`, `Synonym`, `TaxonomySynonymNameClass_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_TaxonomySynonym_TaxonomySynonymNameClass1_idx` ON `TaxonomySynonym` (`TaxonomySynonymNameClass_WID` ASC) ;


-- -----------------------------------------------------
-- Table `TaxonomyPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaxonomyPMID` ;

CREATE  TABLE IF NOT EXISTS `TaxonomyPMID` (
  `Taxonomy_WID` BIGINT NOT NULL ,
  `PMID` BIGINT NOT NULL ,
  PRIMARY KEY (`Taxonomy_WID`, `PMID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_TaxonomyPMID_Taxonomy1_idx` ON `TaxonomyPMID` (`Taxonomy_WID` ASC) ;

CREATE INDEX `pk_PMID` ON `TaxonomyPMID` (`PMID` ASC) ;


-- -----------------------------------------------------
-- Table `Taxonomy_has_TaxonomyUnParseCitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Taxonomy_has_TaxonomyUnParseCitation` ;

CREATE  TABLE IF NOT EXISTS `Taxonomy_has_TaxonomyUnParseCitation` (
  `Taxonomy_WID` BIGINT NOT NULL ,
  `TaxonomyUnParseCitation_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Taxonomy_WID`, `TaxonomyUnParseCitation_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_TaxonomyUnParseCita_idx` ON `Taxonomy_has_TaxonomyUnParseCitation` (`TaxonomyUnParseCitation_WID` ASC) ;

CREATE INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_Taxonomy1_idx` ON `Taxonomy_has_TaxonomyUnParseCitation` (`Taxonomy_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologySubset` ;

CREATE  TABLE IF NOT EXISTS `OntologySubset` (
  `WID` BIGINT NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_id` ON `OntologySubset` (`Id` ASC) ;

CREATE INDEX `pk_Name` ON `OntologySubset` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology` ;

CREATE  TABLE IF NOT EXISTS `Ontology` (
  `WID` BIGINT NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  `NameSpace` VARCHAR(25) NOT NULL ,
  `Def` VARCHAR(5000) NULL DEFAULT NULL ,
  `Comment` VARCHAR(1000) NULL DEFAULT NULL ,
  `IsObsolete` TINYINT(1) NOT NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Ontology_DataSet_idx` ON `Ontology` (`DataSetWID` ASC) ;

CREATE INDEX `pk_id` ON `Ontology` (`Id` ASC) ;

CREATE INDEX `pk_Name` ON `Ontology` (`Name` ASC) ;

CREATE INDEX `pk_IsObsolete` ON `Ontology` (`IsObsolete` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDXRefTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDXRefTemp` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDXRefTemp` (
  `OntologyWID` BIGINT NOT NULL ,
  `ACC` VARCHAR(255) NULL ,
  `DBName` VARCHAR(255) NULL ,
  `Name` VARCHAR(255) NULL ,
  `Type` VARCHAR(25) NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_OntologyWID` ON `OntologyWIDXRefTemp` (`OntologyWID` ASC) ;

CREATE INDEX `pk_Type` ON `OntologyWIDXRefTemp` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyXRef` ;

CREATE  TABLE IF NOT EXISTS `OntologyXRef` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `ACC` VARCHAR(255) NOT NULL ,
  `DBName` VARCHAR(255) NOT NULL ,
  `Name` VARCHAR(255) NULL ,
  `Type` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_ACC` ON `OntologyXRef` (`ACC` ASC) ;

CREATE INDEX `pk_DBName` ON `OntologyXRef` (`DBName` ASC) ;

CREATE INDEX `pk_Type` ON `OntologyXRef` (`Type` ASC) ;

CREATE INDEX `pk_Name` ON `OntologyXRef` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDOntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDOntologySubset` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDOntologySubset` (
  `OntologyWID` BIGINT NOT NULL ,
  `Subset` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`OntologyWID`, `Subset`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `OntologyAlternativeId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyAlternativeId` ;

CREATE  TABLE IF NOT EXISTS `OntologyAlternativeId` (
  `Ontology_WID` BIGINT NOT NULL ,
  `AltId` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `AltId`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_OntologyAlternativeId_Ontology1_idx` ON `OntologyAlternativeId` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDSynonymTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDSynonymTemp` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDSynonymTemp` (
  `OntologyWID` BIGINT NOT NULL ,
  `Synonym` VARCHAR(1000) NOT NULL ,
  `Scope` VARCHAR(255) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_OntologyWID` ON `OntologyWIDSynonymTemp` (`OntologyWID` ASC) ;

CREATE INDEX `pk_Synonym` USING HASH ON `OntologyWIDSynonymTemp` (`Synonym`(255) ASC) ;


-- -----------------------------------------------------
-- Table `OntologySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologySynonym` ;

CREATE  TABLE IF NOT EXISTS `OntologySynonym` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Synonym` VARCHAR(1000) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Synonym` USING BTREE ON `OntologySynonym` (`Synonym`(255) ASC) ;


-- -----------------------------------------------------
-- Table `OntologyRelation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyRelation` ;

CREATE  TABLE IF NOT EXISTS `OntologyRelation` (
  `Ontology_WID` BIGINT NOT NULL ,
  `OtherOntology_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `OtherOntology_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_OntologyRelation_Ontology2_idx` ON `OntologyRelation` (`OtherOntology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyIsA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyIsA` ;

CREATE  TABLE IF NOT EXISTS `OntologyIsA` (
  `Ontology_WID` BIGINT NOT NULL ,
  `IsAOntology_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `IsAOntology_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_IsAOntology_Ontology` ON `OntologyIsA` (`IsAOntology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyToConsider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyToConsider` ;

CREATE  TABLE IF NOT EXISTS `OntologyToConsider` (
  `Ontology_WID` BIGINT NOT NULL ,
  `ToConsiderOntology_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `ToConsiderOntology_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_OntologyToConsider_Ontology2_idx` ON `OntologyToConsider` (`ToConsiderOntology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDIsATemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDIsATemp` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDIsATemp` (
  `OntologyWID` BIGINT NOT NULL ,
  `isA` VARCHAR(25) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_OntologyWID` ON `OntologyWIDIsATemp` (`OntologyWID` ASC) ;

CREATE INDEX `pk_IsA` ON `OntologyWIDIsATemp` (`isA` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDRelationTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDRelationTemp` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDRelationTemp` (
  `OntologyWID` BIGINT NOT NULL ,
  `Type` VARCHAR(25) NOT NULL ,
  `OtherId` VARCHAR(25) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_OntologyWID` ON `OntologyWIDRelationTemp` (`OntologyWID` ASC) ;

CREATE INDEX `pk_OtherId` ON `OntologyWIDRelationTemp` (`OtherId` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyWIDToConsiderTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyWIDToConsiderTemp` ;

CREATE  TABLE IF NOT EXISTS `OntologyWIDToConsiderTemp` (
  `OntologyWID` BIGINT NOT NULL ,
  `OtherId` VARCHAR(25) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_OntologyWID` ON `OntologyWIDToConsiderTemp` (`OntologyWID` ASC) ;

CREATE INDEX `pk_OtherId` ON `OntologyWIDToConsiderTemp` (`OtherId` ASC) ;


-- -----------------------------------------------------
-- Table `OntologyPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OntologyPMID` ;

CREATE  TABLE IF NOT EXISTS `OntologyPMID` (
  `Ontology_WID` BIGINT NOT NULL ,
  `PMID` BIGINT NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `PMID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_OntologyPMID_Ontology1_idx` ON `OntologyPMID` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologySubset`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologySubset` ;

CREATE  TABLE IF NOT EXISTS `Ontology_has_OntologySubset` (
  `Ontology_WID` BIGINT NOT NULL ,
  `OntologySubset_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `OntologySubset_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Ontology_has_OntologySubset_OntologySubset1_idx` ON `Ontology_has_OntologySubset` (`OntologySubset_WID` ASC) ;

CREATE INDEX `fk_Ontology_has_OntologySubset_Ontology1_idx` ON `Ontology_has_OntologySubset` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologyXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologyXRef` ;

CREATE  TABLE IF NOT EXISTS `Ontology_has_OntologyXRef` (
  `Ontology_WID` BIGINT NOT NULL ,
  `OntologyXRef_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `OntologyXRef_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Ontology_has_OntologyXRef_OntologyXRef1_idx` ON `Ontology_has_OntologyXRef` (`OntologyXRef_WID` ASC) ;

CREATE INDEX `fk_Ontology_has_OntologyXRef_Ontology1_idx` ON `Ontology_has_OntologyXRef` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Ontology_has_OntologySynonym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Ontology_has_OntologySynonym` ;

CREATE  TABLE IF NOT EXISTS `Ontology_has_OntologySynonym` (
  `Ontology_WID` BIGINT NOT NULL ,
  `OntologySynonym_WID` BIGINT NOT NULL ,
  `Scope` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`Ontology_WID`, `OntologySynonym_WID`, `Scope`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Ontology_has_OntologySynonym_OntologySynonym1_idx` ON `Ontology_has_OntologySynonym` (`OntologySynonym_WID` ASC) ;

CREATE INDEX `fk_Ontology_has_OntologySynonym_Ontology1_idx` ON `Ontology_has_OntologySynonym` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo` ;

CREATE  TABLE IF NOT EXISTS `GeneInfo` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `GeneID` BIGINT NOT NULL ,
  `TaxID` BIGINT NOT NULL ,
  `Symbol` VARCHAR(50) NULL DEFAULT NULL ,
  `LocusTag` VARCHAR(100) NULL DEFAULT NULL ,
  `Chromosome` VARCHAR(25) NULL DEFAULT NULL ,
  `MapLocation` VARCHAR(100) NULL DEFAULT NULL ,
  `Description` VARCHAR(5000) NULL DEFAULT NULL ,
  `TypeOfGene` VARCHAR(25) NULL DEFAULT NULL ,
  `SymbolFromNomenclature` VARCHAR(25) NULL DEFAULT NULL ,
  `FullNameFromNomenclatureAuthority` VARCHAR(255) NULL DEFAULT NULL ,
  `NomenclatureStatus` VARCHAR(2) NULL DEFAULT NULL ,
  `OtherDesignations` VARCHAR(5000) NULL DEFAULT NULL ,
  `ModificationDate` DATETIME NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE UNIQUE INDEX `pk_GeneId` ON `GeneInfo` (`GeneID` ASC) ;

CREATE INDEX `pk_Symbol` ON `GeneInfo` (`Symbol` ASC) ;

CREATE INDEX `fk_GeneInfo_DataSet_idx` ON `GeneInfo` (`DataSetWID` ASC) ;

CREATE INDEX `fk_GeneInfo_Taxonomy_idx` ON `GeneInfo` (`TaxID` ASC) ;

CREATE INDEX `pk_LocusTag` ON `GeneInfo` (`LocusTag` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfoSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoSynonyms` ;

CREATE  TABLE IF NOT EXISTS `GeneInfoSynonyms` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `Synonyms` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `Synonyms`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_GeneInfoSynonyms_GeneInfo1_idx` ON `GeneInfoSynonyms` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_Synonym` ON `GeneInfoSynonyms` (`Synonyms` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfoDBXrefs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoDBXrefs` ;

CREATE  TABLE IF NOT EXISTS `GeneInfoDBXrefs` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `DBName` VARCHAR(50) NOT NULL ,
  `ID` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `DBName`, `ID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_GeneInfoDBXrefs_GeneInfo1_idx` ON `GeneInfoDBXrefs` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_DBName` ON `GeneInfoDBXrefs` (`DBName` ASC) ;

CREATE INDEX `pk_ID` ON `GeneInfoDBXrefs` (`ID` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2Accession`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2Accession` ;

CREATE  TABLE IF NOT EXISTS `Gene2Accession` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `GeneInfo_WID` BIGINT NOT NULL ,
  `Status` VARCHAR(50) NULL DEFAULT NULL ,
  `RNANucleotideAccession` VARCHAR(50) NULL DEFAULT NULL ,
  `RNANucleotideAccessionVersion` INT NULL DEFAULT NULL ,
  `RNANucleotideGi` BIGINT NULL DEFAULT NULL ,
  `ProteinAccession` VARCHAR(50) NULL DEFAULT NULL ,
  `ProteinAccessionVersion` INT NULL DEFAULT NULL ,
  `ProteinGi` BIGINT NULL ,
  `GenomicNucleotideAccession` VARCHAR(50) NULL DEFAULT NULL ,
  `GenomicNucleotideAccessionVersion` INT NULL DEFAULT NULL ,
  `GenomicNucleotideGi` BIGINT NULL DEFAULT NULL ,
  `StartPositionOnTheGenomicAccession` VARCHAR(50) NULL DEFAULT NULL ,
  `EndPositionOnTheGenomicAccession` VARCHAR(50) NULL DEFAULT NULL ,
  `Orientation` VARCHAR(50) NULL DEFAULT NULL ,
  `Assembly` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`, `GeneInfo_WID`, `ProteinGi`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2Accession_GeneInfo1_idx` ON `Gene2Accession` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_RNANuclotideAccession` ON `Gene2Accession` (`RNANucleotideAccession` ASC) ;

CREATE INDEX `pk_RNANuclotideGi` ON `Gene2Accession` (`RNANucleotideGi` ASC) ;

CREATE INDEX `pk_ProteinAccession` ON `Gene2Accession` (`ProteinAccession` ASC) ;

CREATE INDEX `pk_ProteinGi` ON `Gene2Accession` (`ProteinGi` ASC) ;

CREATE INDEX `pk_GenomicNucleotideAccession` ON `Gene2Accession` (`GenomicNucleotideAccession` ASC) ;

CREATE INDEX `pk_GenomicNucleotideGi` ON `Gene2Accession` (`GenomicNucleotideGi` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2Ensembl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2Ensembl` ;

CREATE  TABLE IF NOT EXISTS `Gene2Ensembl` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `GeneInfo_WID` BIGINT NOT NULL ,
  `EnsemblGeneIdentifier` VARCHAR(20) NULL DEFAULT NULL ,
  `RNANucleotideAccession` VARCHAR(20) NULL DEFAULT NULL ,
  `EnsemblRNAIdentifier` VARCHAR(20) NULL DEFAULT NULL ,
  `ProteinAccession` VARCHAR(20) NULL DEFAULT NULL ,
  `EnsemblProteinIdentifier` VARCHAR(20) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2Ensembl_GeneInfo1_idx` ON `Gene2Ensembl` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_RNANucleotideAccession` ON `Gene2Ensembl` (`RNANucleotideAccession` ASC) ;

CREATE INDEX `pk_EnsemblRNAIdentifier` ON `Gene2Ensembl` (`EnsemblRNAIdentifier` ASC) ;

CREATE INDEX `pk_ProteinAccession` ON `Gene2Ensembl` (`ProteinAccession` ASC) ;

CREATE INDEX `pk_EnsemblProteinIdentifier` ON `Gene2Ensembl` (`EnsemblProteinIdentifier` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2GO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2GO` ;

CREATE  TABLE IF NOT EXISTS `Gene2GO` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `GOID` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `GOID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2GO_GeneInfo1_idx` ON `Gene2GO` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_GOID` ON `Gene2GO` (`GOID` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2PMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2PMID` ;

CREATE  TABLE IF NOT EXISTS `Gene2PMID` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `PMID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `PMID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2PMID_GeneInfo1_idx` ON `Gene2PMID` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_PMID` ON `Gene2PMID` (`PMID` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2STS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2STS` ;

CREATE  TABLE IF NOT EXISTS `Gene2STS` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `UniSTSID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `UniSTSID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2STS_GeneInfo1_idx` ON `Gene2STS` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_UniSTSID` ON `Gene2STS` (`UniSTSID` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2UniGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2UniGene` ;

CREATE  TABLE IF NOT EXISTS `Gene2UniGene` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `UniGene` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `UniGene`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Gene2UniGene_GeneInfo1_idx` ON `Gene2UniGene` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_UniGene` ON `Gene2UniGene` (`UniGene` ASC) ;


-- -----------------------------------------------------
-- Table `GeneGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneGroup` ;

CREATE  TABLE IF NOT EXISTS `GeneGroup` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `Relationship` VARCHAR(25) NOT NULL ,
  `OtherGeneInfo_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `OtherGeneInfo_WID`, `Relationship`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_GeneGroup_GeneInfo2_idx` ON `GeneGroup` (`OtherGeneInfo_WID` ASC) ;

CREATE INDEX `fk_GeneGroup_GeneInfo1_idx` ON `GeneGroup` (`GeneInfo_WID` ASC) ;

CREATE INDEX `pk_RelationShip` ON `GeneGroup` (`Relationship` ASC) ;


-- -----------------------------------------------------
-- Table `GeneHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneHistory` ;

CREATE  TABLE IF NOT EXISTS `GeneHistory` (
  `TaxID` BIGINT NOT NULL ,
  `GeneID` BIGINT NULL ,
  `DiscontinuedGeneID` BIGINT NOT NULL ,
  `DiscontinuedSymbol` VARCHAR(50) NOT NULL ,
  `DiscontinueDate` DATETIME NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`DiscontinuedGeneID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_TaxId` ON `GeneHistory` (`TaxID` ASC) ;

CREATE INDEX `pk_GeneId` ON `GeneHistory` (`GeneID` ASC) ;

CREATE INDEX `pk_DiscontinuedGeneId` ON `GeneHistory` (`DiscontinuedGeneID` ASC) ;

CREATE INDEX `pk_DiscontinuedSymbol` ON `GeneHistory` (`DiscontinuedSymbol` ASC) ;

CREATE INDEX `fk_GeneHistory_DataSet_idx` ON `GeneHistory` (`DataSetWID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneRefseqUniProt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneRefseqUniProt` ;

CREATE  TABLE IF NOT EXISTS `GeneRefseqUniProt` (
  `ProteinAccession` VARCHAR(50) NOT NULL ,
  `UniProtKBProteinAccession` VARCHAR(50) NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`ProteinAccession`, `UniProtKBProteinAccession`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_ProteinAccession1` ON `GeneRefseqUniProt` (`ProteinAccession` ASC) ;

CREATE INDEX `pk_UniProtKBProteinAccession1` ON `GeneRefseqUniProt` (`UniProtKBProteinAccession` ASC) ;

CREATE INDEX `fk_GeneRefseqUniProt_DataSet1` ON `GeneRefseqUniProt` (`DataSetWID` ASC) ;


-- -----------------------------------------------------
-- Table `gene_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_info` ;

CREATE  TABLE IF NOT EXISTS `gene_info` (
  `GeneID` BIGINT NOT NULL ,
  `Synonyms` TEXT NOT NULL ,
  `dbXrefs` TEXT NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene_info` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfoWIDSynonymsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoWIDSynonymsTemp` ;

CREATE  TABLE IF NOT EXISTS `GeneInfoWIDSynonymsTemp` (
  `GeneID` BIGINT NOT NULL ,
  `Synonyms` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `GeneInfoWIDSynonymsTemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfoWIDDBXrefsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfoWIDDBXrefsTemp` ;

CREATE  TABLE IF NOT EXISTS `GeneInfoWIDDBXrefsTemp` (
  `GeneID` BIGINT NOT NULL ,
  `DBName` VARCHAR(50) NOT NULL ,
  `ID` VARCHAR(50) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `GeneInfoWIDDBXrefsTemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2accessiontemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2accessiontemp` ;

CREATE  TABLE IF NOT EXISTS `gene2accessiontemp` (
  `GeneID` BIGINT NOT NULL ,
  `Status` VARCHAR(50) NULL ,
  `RNANucleotideAccession` VARCHAR(50) NULL ,
  `RNANucleotideGi` VARCHAR(50) NULL ,
  `ProteinAccession` VARCHAR(50) NULL ,
  `ProteinGi` VARCHAR(50) NULL ,
  `GenomicNucleotideAccession` VARCHAR(50) NULL ,
  `GenomicNucleotideGi` VARCHAR(50) NULL ,
  `StartPositionOnTheGenomicAccession` VARCHAR(50) NULL ,
  `EndPositionOnTheGenomicAccession` VARCHAR(50) NULL ,
  `Orientation` VARCHAR(50) NULL ,
  `Assembly` VARCHAR(50) NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2accessiontemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2ensembltemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2ensembltemp` ;

CREATE  TABLE IF NOT EXISTS `gene2ensembltemp` (
  `GeneID` BIGINT NOT NULL ,
  `EnsemblGeneIdentifier` VARCHAR(20) NOT NULL ,
  `RNANucleotideAccession` VARCHAR(20) NOT NULL ,
  `EnsemblRNAIdentifier` VARCHAR(20) NOT NULL ,
  `ProteinAccession` VARCHAR(20) NOT NULL ,
  `EnsemblProteinIdentifier` VARCHAR(20) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2ensembltemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2gotemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2gotemp` ;

CREATE  TABLE IF NOT EXISTS `gene2gotemp` (
  `GeneID` BIGINT NOT NULL ,
  `GOID` VARCHAR(15) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2gotemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2pubmedtemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2pubmedtemp` ;

CREATE  TABLE IF NOT EXISTS `gene2pubmedtemp` (
  `GeneID` BIGINT NOT NULL ,
  `PMID` VARCHAR(255) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2pubmedtemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2ststemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2ststemp` ;

CREATE  TABLE IF NOT EXISTS `gene2ststemp` (
  `GeneID` BIGINT NOT NULL ,
  `UniSTSID` BIGINT NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2ststemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene2unigenetemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene2unigenetemp` ;

CREATE  TABLE IF NOT EXISTS `gene2unigenetemp` (
  `GeneID` BIGINT NOT NULL ,
  `UniGene` VARCHAR(25) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene2unigenetemp` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_group` ;

CREATE  TABLE IF NOT EXISTS `gene_group` (
  `GeneID` BIGINT NOT NULL ,
  `Relationship` VARCHAR(25) NOT NULL ,
  `OtherGeneID` BIGINT NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `gene_group` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `gene_refseq_uniprotkb_collab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gene_refseq_uniprotkb_collab` ;

CREATE  TABLE IF NOT EXISTS `gene_refseq_uniprotkb_collab` (
  `ProteinAccession` VARCHAR(50) NOT NULL ,
  `UniProtKBProteinAccession` VARCHAR(50) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `mim2gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mim2gene` ;

CREATE  TABLE IF NOT EXISTS `mim2gene` (
  `MIM` BIGINT NOT NULL ,
  `GeneID` BIGINT NOT NULL ,
  `Type` VARCHAR(10) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Gene_Id` ON `mim2gene` (`GeneID` ASC) ;


-- -----------------------------------------------------
-- Table `GenomesPTTTaxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenomesPTTTaxonomy` ;

CREATE  TABLE IF NOT EXISTS `GenomesPTTTaxonomy` (
  `TaxId` BIGINT NOT NULL ,
  `Synonym` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`TaxId`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_GenomesPPTTaxonomy_Taxonomy_idx` ON `GenomesPTTTaxonomy` (`TaxId` ASC) ;


-- -----------------------------------------------------
-- Table `GenomesPTT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenomesPTT` ;

CREATE  TABLE IF NOT EXISTS `GenomesPTT` (
  `pFrom` BIGINT NOT NULL ,
  `pTo` BIGINT NOT NULL ,
  `Location` VARCHAR(100) NOT NULL ,
  `Strand` VARCHAR(50) NOT NULL ,
  `PLength` INT NOT NULL ,
  `ProteinGi` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(100) NULL ,
  `GeneLocusTag` VARCHAR(100) NULL ,
  `Code` VARCHAR(50) NULL ,
  `COG` VARCHAR(50) NULL ,
  `Product` VARCHAR(1000) NOT NULL ,
  `PTTFile` VARCHAR(50) NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`ProteinGi`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_GenomesPTT_Gene2Accession_idx` ON `GenomesPTT` (`ProteinGi` ASC) ;

CREATE INDEX `fk_GenomesPTT_DataSet_idx` ON `GenomesPTT` (`DataSetWID` ASC) ;

CREATE INDEX `pk_pFrom` ON `GenomesPTT` (`pFrom` ASC) ;

CREATE INDEX `pk_pTo` ON `GenomesPTT` (`pTo` ASC) ;

CREATE INDEX `pk_GeneSymbol` ON `GenomesPTT` (`GeneSymbol` ASC) ;

CREATE INDEX `pk_COG` ON `GenomesPTT` (`COG` ASC) ;

CREATE INDEX `pk_PTTFile` ON `GenomesPTT` (`PTTFile` ASC) ;


-- -----------------------------------------------------
-- Table `GenomesPTTTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GenomesPTTTemp` ;

CREATE  TABLE IF NOT EXISTS `GenomesPTTTemp` (
  `Location` VARCHAR(100) NOT NULL ,
  `Strand` VARCHAR(50) NOT NULL ,
  `PLength` INT NOT NULL ,
  `ProteinGi` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(100) NOT NULL ,
  `GeneLocusTag` VARCHAR(100) NOT NULL ,
  `Code` VARCHAR(50) NOT NULL ,
  `COG` VARCHAR(50) NOT NULL ,
  `Product` VARCHAR(1000) NOT NULL ,
  `PTTFile` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`ProteinGi`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_PTTFile` ON `GenomesPTTTemp` (`PTTFile` ASC) ;


-- -----------------------------------------------------
-- Table `Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein` ;

CREATE  TABLE IF NOT EXISTS `Protein` (
  `WID` BIGINT NOT NULL ,
  `Version` INT NULL DEFAULT NULL ,
  `Modified` DATETIME NULL DEFAULT NULL ,
  `Created` DATETIME NULL DEFAULT NULL ,
  `DataSet` VARCHAR(10) NULL DEFAULT NULL ,
  `Existence` VARCHAR(50) NULL DEFAULT NULL ,
  `SeqLength` INT NULL DEFAULT NULL ,
  `Mass` INT NULL DEFAULT NULL ,
  `Checksum` VARCHAR(255) NULL DEFAULT NULL ,
  `SeqModified` DATETIME NULL DEFAULT NULL ,
  `SeqVersion` INT NULL DEFAULT NULL ,
  `Precursor` VARCHAR(10) NULL DEFAULT NULL ,
  `Fragment` VARCHAR(10) NULL DEFAULT NULL ,
  `Seq` TEXT NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_Protein_DataSet_idx` ON `Protein` (`DataSetWID` ASC) ;

CREATE INDEX `pk_DataSet` ON `Protein` (`DataSet` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinName` ;

CREATE  TABLE IF NOT EXISTS `ProteinName` (
  `Protein_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  `OrderNumber` INT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Name`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinName_Protein1_idx` ON `ProteinName` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinAccessionNumber`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinAccessionNumber` ;

CREATE  TABLE IF NOT EXISTS `ProteinAccessionNumber` (
  `Protein_WID` BIGINT NOT NULL ,
  `AccessionNumber` VARCHAR(10) NOT NULL ,
  `OrderNumber` INT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `AccessionNumber`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinAccessionNumber_Protein1_idx` ON `ProteinAccessionNumber` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinLongName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinLongName` ;

CREATE  TABLE IF NOT EXISTS `ProteinLongName` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `ProteinNameDef` VARCHAR(30) NOT NULL ,
  `Type` VARCHAR(10) NULL DEFAULT 'fullName' ,
  `Component` TINYINT(1) NULL DEFAULT 0 ,
  `Domain` TINYINT(1) NULL DEFAULT 0 ,
  `Name` VARCHAR(500) NOT NULL ,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL ,
  `Status` VARCHAR(15) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Name` USING HASH ON `ProteinLongName` (`Name`(255) ASC) ;

CREATE INDEX `pk_ProteinNameDef` ON `ProteinLongName` (`ProteinNameDef` ASC) ;

CREATE INDEX `pk_Type` ON `ProteinLongName` (`Type` ASC) ;

CREATE INDEX `fk_ProteinLongName_Protein1_idx` ON `ProteinLongName` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGeneName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneName` ;

CREATE  TABLE IF NOT EXISTS `ProteinGeneName` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `GeneNameType` VARCHAR(15) NOT NULL ,
  `Name` VARCHAR(50) NOT NULL ,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinGeneName_Protein1_idx` ON `ProteinGeneName` (`Protein_WID` ASC) ;

CREATE INDEX `pk_GeneNameType` ON `ProteinGeneName` (`GeneNameType` ASC) ;

CREATE INDEX `pk_Name` ON `ProteinGeneName` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDBReference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDBReference` ;

CREATE  TABLE IF NOT EXISTS `ProteinDBReference` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(100) NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  `Evidence` VARCHAR(100) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDBReference_Protein1_idx` ON `ProteinDBReference` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Type` ON `ProteinDBReference` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinDBReference` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGo` ;

CREATE  TABLE IF NOT EXISTS `ProteinGo` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(10) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinRefSeq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinRefSeq` ;

CREATE  TABLE IF NOT EXISTS `ProteinRefSeq` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinRefSeq_Protein1_idx` ON `ProteinRefSeq` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPMID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPMID` ;

CREATE  TABLE IF NOT EXISTS `ProteinPMID` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinPMID_Protein1_idx` ON `ProteinPMID` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinKEGG`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKEGG` ;

CREATE  TABLE IF NOT EXISTS `ProteinKEGG` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinKEGG_Protein1_idx` ON `ProteinKEGG` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinEC`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinEC` ;

CREATE  TABLE IF NOT EXISTS `ProteinEC` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinEC_Protein1_idx` ON `ProteinEC` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinBioCyc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinBioCyc` ;

CREATE  TABLE IF NOT EXISTS `ProteinBioCyc` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinBioCyc_Protein1_idx` ON `ProteinBioCyc` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPDB`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPDB` ;

CREATE  TABLE IF NOT EXISTS `ProteinPDB` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinPDB_Protein1_idx` ON `ProteinPDB` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinIntAct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIntAct` ;

CREATE  TABLE IF NOT EXISTS `ProteinIntAct` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinIntAct_Protein1_idx` ON `ProteinIntAct` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDIP`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDIP` ;

CREATE  TABLE IF NOT EXISTS `ProteinDIP` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDIP_Protein1_idx` ON `ProteinDIP` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinMINT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinMINT` ;

CREATE  TABLE IF NOT EXISTS `ProteinMINT` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinMINT_Protein1_idx` ON `ProteinMINT` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDrugBank` ;

CREATE  TABLE IF NOT EXISTS `ProteinDrugBank` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDrugBank_Protein1_idx` ON `ProteinDrugBank` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDBReferenceProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDBReferenceProperty` ;

CREATE  TABLE IF NOT EXISTS `ProteinDBReferenceProperty` (
  `ProteinDBReference_WID` BIGINT NOT NULL ,
  `AttribType` VARCHAR(100) NOT NULL ,
  `AttribValue` VARCHAR(255) NULL ,
  PRIMARY KEY (`ProteinDBReference_WID`, `AttribType`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDBReferenceProperty_ProteinDBReference1_idx` ON `ProteinDBReferenceProperty` (`ProteinDBReference_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGeneLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneLocation` ;

CREATE  TABLE IF NOT EXISTS `ProteinGeneLocation` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NULL DEFAULT NULL ,
  `Type` VARCHAR(255) NULL DEFAULT NULL ,
  `Status` VARCHAR(15) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinGeneLocation_Protein1_idx` ON `ProteinGeneLocation` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Name` ON `ProteinGeneLocation` (`Name` ASC) ;

CREATE INDEX `pk_Type` ON `ProteinGeneLocation` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinComment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinComment` ;

CREATE  TABLE IF NOT EXISTS `ProteinComment` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(100) NULL DEFAULT NULL ,
  `Mass` FLOAT NULL DEFAULT NULL ,
  `Error` VARCHAR(255) NULL DEFAULT NULL ,
  `Method` VARCHAR(255) NULL DEFAULT NULL ,
  `Type` VARCHAR(30) NULL DEFAULT NULL ,
  `LocationType` VARCHAR(255) NULL DEFAULT NULL ,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL ,
  `Text` TEXT NULL DEFAULT NULL ,
  `TextEvidence` VARCHAR(255) NULL DEFAULT NULL ,
  `TextStatus` VARCHAR(15) NULL DEFAULT NULL ,
  `Molecule` VARCHAR(255) NULL DEFAULT NULL ,
  `OrganismsDiffer` VARCHAR(25) NULL DEFAULT NULL ,
  `Experiments` VARCHAR(25) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinComment_Protein1_idx` ON `ProteinComment` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Type` ON `ProteinComment` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinOtherLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinOtherLocation` ;

CREATE  TABLE IF NOT EXISTS `ProteinOtherLocation` (
  `WID` BIGINT NOT NULL ,
  `OtherWID` BIGINT NOT NULL ,
  `BeginPos` INT NULL DEFAULT -1 ,
  `BeginStatus` VARCHAR(15) NULL DEFAULT NULL ,
  `EndPos` INT NULL DEFAULT -1 ,
  `EndStatus` VARCHAR(15) NULL DEFAULT NULL ,
  `Position` INT NULL DEFAULT -1 ,
  `PositionStatus` VARCHAR(15) NULL DEFAULT NULL ,
  `Sequence` VARCHAR(1000) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinOtherLocation_DataSet_idx` ON `ProteinOtherLocation` (`DataSetWID` ASC) ;

CREATE INDEX `pk_OtherWID` ON `ProteinOtherLocation` (`OtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentSubCellularLocation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentSubCellularLocation` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentSubCellularLocation` (
  `WID` BIGINT NOT NULL ,
  `ProteinComment_WID` BIGINT NOT NULL ,
  `Data` VARCHAR(255) NULL DEFAULT NULL ,
  `Element` VARCHAR(15) NULL DEFAULT NULL ,
  `Evidence` VARCHAR(1000) NULL DEFAULT NULL ,
  `Status` VARCHAR(15) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentSubCellularLocation_ProteinComment1_idx` ON `ProteinCommentSubCellularLocation` (`ProteinComment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentConflict`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentConflict` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentConflict` (
  `ProteinComment_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(40) NOT NULL ,
  `SeqVersion` INT NULL DEFAULT NULL ,
  `SeqResource` VARCHAR(25) NULL DEFAULT NULL ,
  `SeqID` VARCHAR(25) NULL DEFAULT NULL ,
  PRIMARY KEY (`ProteinComment_WID`, `Type`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentConflict_ProteinComment1_idx` ON `ProteinCommentConflict` (`ProteinComment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentLink` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentLink` (
  `ProteinComment_WID` BIGINT NOT NULL ,
  `URI` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`ProteinComment_WID`, `URI`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentLink_ProteinComment1_idx` ON `ProteinCommentLink` (`ProteinComment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentEvent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentEvent` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentEvent` (
  `ProteinComment_WID` BIGINT NOT NULL ,
  `EventType` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`ProteinComment_WID`, `EventType`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentEvent_ProteinComment1_idx` ON `ProteinCommentEvent` (`ProteinComment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentIsoform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentIsoform` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentIsoform` (
  `WID` BIGINT NOT NULL ,
  `ProteinComment_WID` BIGINT NOT NULL ,
  `SeqType` VARCHAR(25) NULL DEFAULT NULL ,
  `SeqRef` VARCHAR(255) NULL DEFAULT NULL ,
  `Note` TEXT NULL DEFAULT NULL ,
  `NoteEvidence` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentIsoform_ProteinComment1_idx` ON `ProteinCommentIsoform` (`ProteinComment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinIsoformId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIsoformId` ;

CREATE  TABLE IF NOT EXISTS `ProteinIsoformId` (
  `ProteinCommentIsoform_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`ProteinCommentIsoform_WID`, `Id`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinIsoformId_ProteinCommentIsoform1_idx` ON `ProteinIsoformId` (`ProteinCommentIsoform_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinIsoformName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIsoformName` ;

CREATE  TABLE IF NOT EXISTS `ProteinIsoformName` (
  `ProteinCommentIsoform_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(100) NOT NULL ,
  `Evidence` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`ProteinCommentIsoform_WID`, `Name`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinIsoformName_ProteinCommentIsoform1_idx` ON `ProteinIsoformName` (`ProteinCommentIsoform_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinCommentInteract`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinCommentInteract` ;

CREATE  TABLE IF NOT EXISTS `ProteinCommentInteract` (
  `WID` BIGINT NOT NULL ,
  `ProteinComment_WID` BIGINT NOT NULL ,
  `IntactID` VARCHAR(25) NOT NULL ,
  `Id` VARCHAR(25) NULL DEFAULT NULL ,
  `Label` VARCHAR(25) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`, `ProteinComment_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinCommentInteract_ProteinComment1_idx` ON `ProteinCommentInteract` (`ProteinComment_WID` ASC) ;

CREATE INDEX `pk_IntactID` ON `ProteinCommentInteract` (`IntactID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinCommentInteract` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinWIDKeywordTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinWIDKeywordTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinWIDKeywordTemp` (
  `ProteinWID` BIGINT NOT NULL ,
  `Evidence` VARCHAR(100) NULL DEFAULT NULL ,
  `Id` VARCHAR(100) NULL DEFAULT NULL ,
  `Keyword` VARCHAR(255) NULL DEFAULT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Id` ON `ProteinWIDKeywordTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinKeyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKeyword` ;

CREATE  TABLE IF NOT EXISTS `ProteinKeyword` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Id` VARCHAR(100) NULL DEFAULT NULL ,
  `Keyword` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;


-- -----------------------------------------------------
-- Table `ProteinFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinFeature` ;

CREATE  TABLE IF NOT EXISTS `ProteinFeature` (
  `WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(40) NULL DEFAULT NULL ,
  `Status` VARCHAR(25) NULL DEFAULT NULL ,
  `Id` VARCHAR(25) NULL DEFAULT NULL ,
  `Description` TEXT NULL DEFAULT NULL ,
  `Evidence` VARCHAR(255) NULL DEFAULT NULL ,
  `Ref` VARCHAR(100) NULL DEFAULT NULL ,
  `Original` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinFeature_Protein1_idx` ON `ProteinFeature` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Type` ON `ProteinFeature` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinFeature` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinFeatureVariation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinFeatureVariation` ;

CREATE  TABLE IF NOT EXISTS `ProteinFeatureVariation` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `ProteinFeature_WID` BIGINT NOT NULL ,
  `Variation` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinFeatureVariation_ProteinFeature1_idx` ON `ProteinFeatureVariation` (`ProteinFeature_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_ProteinKeyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_ProteinKeyword` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_ProteinKeyword` (
  `Protein_WID` BIGINT NOT NULL ,
  `ProteinKeyword_WID` BIGINT NOT NULL ,
  `Evidence` VARCHAR(100) NULL ,
  PRIMARY KEY (`Protein_WID`, `ProteinKeyword_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_ProteinKeyword_ProteinKeyword1_idx` ON `Protein_has_ProteinKeyword` (`ProteinKeyword_WID` ASC) ;

CREATE INDEX `fk_Protein_has_ProteinKeyword_Protein1_idx` ON `Protein_has_ProteinKeyword` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_GeneInfo` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_GeneInfo` (
  `Protein_WID` BIGINT NOT NULL ,
  `GeneInfo_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `GeneInfo_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_Gene_Protein_idx` ON `Protein_has_GeneInfo` (`Protein_WID` ASC) ;

CREATE INDEX `fk_Protein_has_Gene_Gene_idx` ON `Protein_has_GeneInfo` (`GeneInfo_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_Ontology` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_Ontology` (
  `Protein_WID` BIGINT NOT NULL ,
  `Ontology_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Ontology_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_Ontology_Protein_idx` ON `Protein_has_Ontology` (`Protein_WID` ASC) ;

CREATE INDEX `fk_Protein_has_Ontology_Ontology_idx` ON `Protein_has_Ontology` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfo_has_Ontology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_Ontology` ;

CREATE  TABLE IF NOT EXISTS `GeneInfo_has_Ontology` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `Ontology_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `Ontology_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_GeneInfo_has_Ontology_GeneInfo1` ON `GeneInfo_has_Ontology` (`GeneInfo_WID` ASC) ;

CREATE INDEX `fk_GeneInfo_has_Ontology_Ontology` ON `GeneInfo_has_Ontology` (`Ontology_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Gene2Accession_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Gene2Accession_has_Protein` ;

CREATE  TABLE IF NOT EXISTS `Gene2Accession_has_Protein` (
  `ProteinGi` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`ProteinGi`, `Protein_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Gene2Accession_has_Protein_Protein1_idx` ON `Gene2Accession_has_Protein` (`Protein_WID` ASC) ;

CREATE INDEX `fk_Gene2Accession_has_Protein_Gene2Accession1_idx` ON `Gene2Accession_has_Protein` (`ProteinGi` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntrySet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySet` ;

CREATE  TABLE IF NOT EXISTS `MIFEntrySet` (
  `WID` BIGINT NOT NULL ,
  `Level` INT NULL ,
  `Version` INT NULL ,
  `MinorVersion` INT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_MIFEntrySet_DataSet_idx` ON `MIFEntrySet` (`DataSetWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntrySetEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySetEntry` ;

CREATE  TABLE IF NOT EXISTS `MIFEntrySetEntry` (
  `WID` BIGINT NOT NULL ,
  `MIFEntrySet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFEntrySetEntry_MIFEntrySet1_idx` ON `MIFEntrySetEntry` (`MIFEntrySet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntrySource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntrySource` ;

CREATE  TABLE IF NOT EXISTS `MIFEntrySource` (
  `WID` BIGINT NOT NULL ,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL ,
  `ReleaseValue` VARCHAR(100) NULL DEFAULT NULL ,
  `ReleaseDate` DATETIME NULL DEFAULT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFEntrySource_MIFEntrySetEntry1_idx` ON `MIFEntrySource` (`MIFEntrySetEntry_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherAlias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAlias` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherAlias` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `Alias` VARCHAR(1000) NULL DEFAULT NULL ,
  `TypeAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Type` VARCHAR(50) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherAlias_DataSet_idx` ON `MIFOtherAlias` (`DataSetWID` ASC) ;

CREATE INDEX `pk_TypeAc` ON `MIFOtherAlias` (`TypeAc` ASC) ;

CREATE INDEX `pk_Type` ON `MIFOtherAlias` (`Type` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherAlias` (`MIFOtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherAttribute`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAttribute` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherAttribute` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `Attribute` VARCHAR(1000) NULL DEFAULT NULL ,
  `NameAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Name` VARCHAR(50) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherAttribute_DataSet_idx` ON `MIFOtherAttribute` (`DataSetWID` ASC) ;

CREATE INDEX `pk_NameAc` ON `MIFOtherAttribute` (`NameAc` ASC) ;

CREATE INDEX `pk_Name` ON `MIFOtherAttribute` (`Name` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherAttribute` (`MIFOtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherBibRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherBibRef` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherBibRef` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherBibRef_DataSet_idx` ON `MIFOtherBibRef` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherBibRef` (`MIFOtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherXRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRef` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherXRef` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NULL DEFAULT NULL ,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` VARCHAR(50) NULL DEFAULT NULL ,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL ,
  `Version` VARCHAR(100) NULL DEFAULT NULL ,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL ,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL ,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherXRef_DataSet_idx` ON `MIFOtherXRef` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherXRef` (`MIFOtherWID` ASC) ;

CREATE INDEX `pk_DB` ON `MIFOtherXRef` (`DB` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherXRef` (`Id` ASC) ;

CREATE INDEX `pk_PrimaryRef` ON `MIFOtherXRef` (`PrimaryRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherXRefGO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefGO` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherXRefGO` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NULL DEFAULT NULL ,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` VARCHAR(50) NULL DEFAULT NULL ,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL ,
  `Version` VARCHAR(100) NULL DEFAULT NULL ,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL ,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL ,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherXRefGO_DataSet_idx` ON `MIFOtherXRefGO` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWIF` ON `MIFOtherXRefGO` (`MIFOtherWID` ASC) ;

CREATE INDEX `pk_DB` ON `MIFOtherXRefGO` (`DB` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherXRefGO` (`Id` ASC) ;

CREATE INDEX `pk_PrimaryRef` ON `MIFOtherXRefGO` (`PrimaryRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherXRefPubMed`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefPubMed` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherXRefPubMed` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NULL DEFAULT NULL ,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` VARCHAR(50) NULL DEFAULT NULL ,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL ,
  `Version` VARCHAR(100) NULL DEFAULT NULL ,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL ,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL ,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherXRefPubMed_DataSet_idx` ON `MIFOtherXRefPubMed` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherXRefPubMed` (`MIFOtherWID` ASC) ;

CREATE INDEX `pk_DB` ON `MIFOtherXRefPubMed` (`DB` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherXRefPubMed` (`Id` ASC) ;

CREATE INDEX `pk_PrimaryRef` ON `MIFOtherXRefPubMed` (`PrimaryRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherXRefRefSeq`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefRefSeq` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherXRefRefSeq` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NULL DEFAULT NULL ,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` VARCHAR(50) NULL DEFAULT NULL ,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL ,
  `Version` VARCHAR(100) NULL DEFAULT NULL ,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL ,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL ,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherXRefRefSeq_DateSet_idx` ON `MIFOtherXRefRefSeq` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherXRefRefSeq` (`MIFOtherWID` ASC) ;

CREATE INDEX `pk_DB` ON `MIFOtherXRefRefSeq` (`DB` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherXRefRefSeq` (`Id` ASC) ;

CREATE INDEX `pk_PrimaryRef` ON `MIFOtherXRefRefSeq` (`PrimaryRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherXRefUniprot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherXRefUniprot` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherXRefUniprot` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NULL DEFAULT NULL ,
  `DBAc` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` VARCHAR(50) NULL DEFAULT NULL ,
  `Secondary` VARCHAR(50) NULL DEFAULT NULL ,
  `Version` VARCHAR(100) NULL DEFAULT NULL ,
  `RefType` VARCHAR(1000) NULL DEFAULT NULL ,
  `RefTypeAc` VARCHAR(100) NULL DEFAULT NULL ,
  `PrimaryRef` TINYINT(1) NULL DEFAULT 0 ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherXRefUniprot_DataSet_idx` ON `MIFOtherXRefUniprot` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherXRefUniprot` (`MIFOtherWID` ASC) ;

CREATE INDEX `pk_DB` ON `MIFOtherXRefUniprot` (`DB` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherXRefUniprot` (`Id` ASC) ;

CREATE INDEX `pk_PrimaryRef` ON `MIFOtherXRefUniprot` (`PrimaryRef` ASC) ;

CREATE INDEX `pk_RefType` USING HASH ON `MIFOtherXRefUniprot` (`RefType`(255) ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherAvailability`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherAvailability` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherAvailability` (
  `MIFOtherWID` BIGINT NOT NULL ,
  `Availability` VARCHAR(255) NOT NULL ,
  `Id` INT NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`MIFOtherWID`, `Availability`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherAvailability_DataSet_idx` ON `MIFOtherAvailability` (`DataSetWID` ASC) ;

CREATE INDEX `pk_Id` ON `MIFOtherAvailability` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntryExperiment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryExperiment` ;

CREATE  TABLE IF NOT EXISTS `MIFEntryExperiment` (
  `WID` BIGINT NOT NULL ,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL ,
  `Id` INT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFEntryExperiment_MIFEntrySetEntry1_idx` ON `MIFEntryExperiment` (`MIFEntrySetEntry_WID` ASC) ;

CREATE INDEX `pk_id` ON `MIFEntryExperiment` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherBioSourceType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherBioSourceType` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherBioSourceType` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherBioSourceType_DataSet_idx` ON `MIFOtherBioSourceType` (`DataSetWID` ASC) ;

CREATE INDEX `fk_MIFOtherBioSourceType_Taxonomy_idx` ON `MIFOtherBioSourceType` (`TaxId` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherBioSourceType` (`MIFOtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeCellType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeCellType` ;

CREATE  TABLE IF NOT EXISTS `MIFBioSourceTypeCellType` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFBioSourceTypeCellType_MIFOtherBioSourceType1_idx` ON `MIFBioSourceTypeCellType` (`MIFOtherBioSourceType_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeCompartment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeCompartment` ;

CREATE  TABLE IF NOT EXISTS `MIFBioSourceTypeCompartment` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFBioSourceTypeCompartment_MIFOtherBioSourceType1_idx` ON `MIFBioSourceTypeCompartment` (`MIFOtherBioSourceType_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFBioSourceTypeTissue`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFBioSourceTypeTissue` ;

CREATE  TABLE IF NOT EXISTS `MIFBioSourceTypeTissue` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherBioSourceType_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFBioSourceTypeTissue_MIFOtherBioSourceType1_idx` ON `MIFBioSourceTypeTissue` (`MIFOtherBioSourceType_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFExperimentInterDetecMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentInterDetecMethod` ;

CREATE  TABLE IF NOT EXISTS `MIFExperimentInterDetecMethod` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryExperiment_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFExperimentInterDetecMethod_MIFEntryExperiment1_idx` ON `MIFExperimentInterDetecMethod` (`MIFEntryExperiment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFExperimentPartIdentMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentPartIdentMethod` ;

CREATE  TABLE IF NOT EXISTS `MIFExperimentPartIdentMethod` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryExperiment_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFExperimentPartIdentMethod_MIFEntryExperiment1_idx` ON `MIFExperimentPartIdentMethod` (`MIFEntryExperiment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFExperimentFeatDetecMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFExperimentFeatDetecMethod` ;

CREATE  TABLE IF NOT EXISTS `MIFExperimentFeatDetecMethod` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryExperiment_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFExperimentFeatDetecMethod_MIFEntryExperiment1_idx` ON `MIFExperimentFeatDetecMethod` (`MIFEntryExperiment_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherConfidence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherConfidence` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherConfidence` (
  `WID` BIGINT NOT NULL ,
  `MIFOtherWID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `ValueVal` VARCHAR(1000) NULL DEFAULT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherConfidence_DataSet_idx` ON `MIFOtherConfidence` (`DataSetWID` ASC) ;

CREATE INDEX `pk_MIFOtherWID` ON `MIFOtherConfidence` (`MIFOtherWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFOtherExperimentRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFOtherExperimentRef` ;

CREATE  TABLE IF NOT EXISTS `MIFOtherExperimentRef` (
  `MIFOtherWID` BIGINT NOT NULL ,
  `ExperimentRef` INT NOT NULL ,
  `DataSetWID` BIGINT NOT NULL ,
  PRIMARY KEY (`MIFOtherWID`, `ExperimentRef`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFOtherExperimentRef_DataSet_idx` ON `MIFOtherExperimentRef` (`DataSetWID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntryInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryInteractor` ;

CREATE  TABLE IF NOT EXISTS `MIFEntryInteractor` (
  `WID` BIGINT NOT NULL ,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `Sequence` TEXT NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFEntryInteractor_MIFEntrySetEntry1_idx` ON `MIFEntryInteractor` (`MIFEntrySetEntry_WID` ASC) ;

CREATE INDEX `pk_Id` ON `MIFEntryInteractor` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteractorInteractorType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractorInteractorType` ;

CREATE  TABLE IF NOT EXISTS `MIFInteractorInteractorType` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryInteractor_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFInteractorInteractorType_MIFEntryInteractor1_idx` ON `MIFInteractorInteractorType` (`MIFEntryInteractor_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFEntryInteraction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFEntryInteraction` ;

CREATE  TABLE IF NOT EXISTS `MIFEntryInteraction` (
  `WID` BIGINT NOT NULL ,
  `MIFEntrySetEntry_WID` BIGINT NOT NULL ,
  `ImexId` VARCHAR(50) NULL DEFAULT NULL ,
  `Id` INT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `AvailabilityRef` INT NULL DEFAULT 0 ,
  `Modelled` VARCHAR(10) NULL DEFAULT NULL ,
  `IntraMolecular` VARCHAR(10) NULL DEFAULT NULL ,
  `Negative` VARCHAR(10) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFEntryInteraction_MIFEntrySetEntry1_idx` ON `MIFEntryInteraction` (`MIFEntrySetEntry_WID` ASC) ;

CREATE INDEX `pk_ImedId` ON `MIFEntryInteraction` (`ImexId` ASC) ;

CREATE INDEX `pk_Id` ON `MIFEntryInteraction` (`Id` ASC) ;

CREATE INDEX `pk_Modelled` ON `MIFEntryInteraction` (`Modelled` ASC) ;

CREATE INDEX `pk_Negative` ON `MIFEntryInteraction` (`Negative` ASC) ;

CREATE INDEX `pk_IntraMolecular` ON `MIFEntryInteraction` (`IntraMolecular` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteractionParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionParticipant` ;

CREATE  TABLE IF NOT EXISTS `MIFInteractionParticipant` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `InteractorRef` INT NULL DEFAULT NULL ,
  `InteractionRef` INT NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFInteractionParticipant_MIFEntryInteraction1_idx` ON `MIFInteractionParticipant` (`MIFEntryInteraction_WID` ASC) ;

CREATE INDEX `pk_Id` ON `MIFInteractionParticipant` (`Id` ASC) ;

CREATE INDEX `pk_InteractorRef` ON `MIFInteractionParticipant` (`InteractorRef` ASC) ;

CREATE INDEX `pk_InteractionRef` ON `MIFInteractionParticipant` (`InteractionRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantPartIdentMeth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantPartIdentMeth` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantPartIdentMeth` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantPartIdentMeth_MIFInteractionParticipant1_idx` ON `MIFParticipantPartIdentMeth` (`MIFInteractionParticipant_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantBiologicalRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantBiologicalRole` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantBiologicalRole` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantBiologicalRole_MIFInteractionParticipant1_idx` ON `MIFParticipantBiologicalRole` (`MIFInteractionParticipant_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalRole` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantExperimentalRole` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantExperimentalRole_MIFInteractionParticipant_idx` ON `MIFParticipantExperimentalRole` (`MIFInteractionParticipant_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalPreparation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalPreparation` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantExperimentalPreparation` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantExperimentalPreparation_MIFInteractionPart_idx` ON `MIFParticipantExperimentalPreparation` (`MIFInteractionParticipant_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantExperimentalInteractor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantExperimentalInteractor` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantExperimentalInteractor` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `InteractorRef` INT NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantExperimentalInteractor_MIFInteractionParti_idx` ON `MIFParticipantExperimentalInteractor` (`MIFInteractionParticipant_WID` ASC) ;

CREATE INDEX `pk_InteractorRef` ON `MIFParticipantExperimentalInteractor` (`InteractorRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantFeature` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantFeature` (
  `WID` BIGINT NOT NULL ,
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `Id` INT NULL DEFAULT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantFeature_MIFInteractionParticipant1_idx` ON `MIFParticipantFeature` (`MIFInteractionParticipant_WID` ASC) ;

CREATE INDEX `pk_Id` ON `MIFParticipantFeature` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatureType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatureType` ;

CREATE  TABLE IF NOT EXISTS `MIFFeatureFeatureType` (
  `WID` BIGINT NOT NULL ,
  `MIFParticipantFeature_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFFeatureFeatureType_MIFParticipantFeature1_idx` ON `MIFFeatureFeatureType` (`MIFParticipantFeature_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatDetMeth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatDetMeth` ;

CREATE  TABLE IF NOT EXISTS `MIFFeatureFeatDetMeth` (
  `WID` BIGINT NOT NULL ,
  `MIFParticipantFeature_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFFeatureFeatDetMeth_MIFParticipantFeature1_idx` ON `MIFFeatureFeatDetMeth` (`MIFParticipantFeature_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFFeatureFeatureRange`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFFeatureFeatureRange` ;

CREATE  TABLE IF NOT EXISTS `MIFFeatureFeatureRange` (
  `WID` BIGINT NOT NULL ,
  `MIFParticipantFeature_WID` BIGINT NOT NULL ,
  `StartShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `StartFullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `EndShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `EndFullName` VARCHAR(1000) NULL DEFAULT NULL ,
  `BeginPosition` INT NULL DEFAULT -1 ,
  `BeginIntervalBegin` INT NULL DEFAULT -1 ,
  `BeginIntervalEnd` INT NULL DEFAULT -1 ,
  `EndPosition` INT NULL DEFAULT -1 ,
  `EndIntervalBegin` INT NULL DEFAULT -1 ,
  `EndIntervalEnd` INT NULL DEFAULT -1 ,
  `IsLink` TINYINT(1) NULL DEFAULT 0 ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFFeatureFeatureRange_MIFParticipantFeature1_idx` ON `MIFFeatureFeatureRange` (`MIFParticipantFeature_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFParticipantParameter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFParticipantParameter` ;

CREATE  TABLE IF NOT EXISTS `MIFParticipantParameter` (
  `MIFInteractionParticipant_WID` BIGINT NOT NULL ,
  `ExperimentRef` INT NOT NULL ,
  `Term` VARCHAR(100) NULL ,
  `TermAc` VARCHAR(100) NOT NULL ,
  `Unit` VARCHAR(100) NULL ,
  `UnitAc` VARCHAR(100) NULL ,
  `Base` FLOAT NULL ,
  `Exponent` FLOAT NULL ,
  `Factor` FLOAT NULL ,
  `Uncertainty` FLOAT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFParticipantParameter_MIFInteractionParticipant1_idx` ON `MIFParticipantParameter` (`MIFInteractionParticipant_WID` ASC) ;

CREATE INDEX `pk_ExperimentRef` ON `MIFParticipantParameter` (`ExperimentRef` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteractionInferredInteraction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionInferredInteraction` ;

CREATE  TABLE IF NOT EXISTS `MIFInteractionInferredInteraction` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFInteractionInferredInteraction_MIFEntryInteraction1_idx` ON `MIFInteractionInferredInteraction` (`MIFEntryInteraction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInferredInteractionParticipant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInferredInteractionParticipant` ;

CREATE  TABLE IF NOT EXISTS `MIFInferredInteractionParticipant` (
  `MIFInteractionInferredInteraction_WID` BIGINT NOT NULL ,
  `Participant` INT NOT NULL ,
  `ParticipantType` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`MIFInteractionInferredInteraction_WID`, `Participant`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFInferredInteractionParticipant_MIFInteractionInferred_idx` ON `MIFInferredInteractionParticipant` (`MIFInteractionInferredInteraction_WID` ASC) ;

CREATE INDEX `pk_ParticipantType` ON `MIFInferredInteractionParticipant` (`ParticipantType` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteractionInteractionType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionInteractionType` ;

CREATE  TABLE IF NOT EXISTS `MIFInteractionInteractionType` (
  `WID` BIGINT NOT NULL ,
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  `ShortLabel` VARCHAR(100) NULL DEFAULT NULL ,
  `FullName` VARCHAR(1000) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_MIFInteractionInteractionType_MIFEntryInteraction1_idx` ON `MIFInteractionInteractionType` (`MIFEntryInteraction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_Taxonomy` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_Taxonomy` (
  `Protein_WID` BIGINT NOT NULL ,
  `Taxonomy_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Taxonomy_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_Taxonomy_Taxonomy1_idx` ON `Protein_has_Taxonomy` (`Taxonomy_WID` ASC) ;

CREATE INDEX `fk_Protein_has_Taxonomy_Protein1_idx` ON `Protein_has_Taxonomy` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_TaxonomyHost`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_TaxonomyHost` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_TaxonomyHost` (
  `Protein_WID` BIGINT NOT NULL ,
  `Taxonomy_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Taxonomy_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_Taxonomy1_Taxonomy1_idx` ON `Protein_has_TaxonomyHost` (`Taxonomy_WID` ASC) ;

CREATE INDEX `fk_Protein_has_Taxonomy1_Protein1_idx` ON `Protein_has_TaxonomyHost` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinTaxId`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinTaxId` ;

CREATE  TABLE IF NOT EXISTS `ProteinTaxId` (
  `Protein_WID` BIGINT NOT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `IsHost` INT NOT NULL DEFAULT 0 )
ENGINE = MyISAM;

CREATE INDEX `pk_Protein_WID` ON `ProteinTaxId` (`Protein_WID` ASC) ;

CREATE INDEX `pk_TaxId` ON `ProteinTaxId` (`TaxId` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPFAM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPFAM` ;

CREATE  TABLE IF NOT EXISTS `ProteinPFAM` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_ProteinPFAM_Protein1_idx` ON `ProteinPFAM` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteraction_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteraction_has_Protein` ;

CREATE  TABLE IF NOT EXISTS `MIFInteraction_has_Protein` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`MIFEntryInteraction_WID`, `Protein_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_MIFInteraction_has_Protein_Protein1_idx` ON `MIFInteraction_has_Protein` (`Protein_WID` ASC) ;

CREATE INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1_idx` ON `MIFInteraction_has_Protein` (`MIFEntryInteraction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteractionCount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteractionCount` ;

CREATE  TABLE IF NOT EXISTS `MIFInteractionCount` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  `Count` INT NOT NULL ,
  PRIMARY KEY (`MIFEntryInteraction_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_MIFInteractionCount_MIFEntryInteraction1_idx` ON `MIFInteractionCount` (`MIFEntryInteraction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `MIFInteraction_has_Protein_Temp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MIFInteraction_has_Protein_Temp` ;

CREATE  TABLE IF NOT EXISTS `MIFInteraction_has_Protein_Temp` (
  `MIFEntryInteraction_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_MIFInteraction_has_Protein_Protein1` ON `MIFInteraction_has_Protein_Temp` (`Protein_WID` ASC) ;

CREATE INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1` ON `MIFInteraction_has_Protein_Temp` (`MIFEntryInteraction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntry` ;

CREATE  TABLE IF NOT EXISTS `UniRefEntry` (
  `WID` BIGINT NOT NULL ,
  `Id` VARCHAR(45) NOT NULL ,
  `Updated` DATETIME NOT NULL ,
  `Name` VARCHAR(100) NOT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `pk_Id` ON `UniRefEntry` (`Id` ASC) ;

CREATE INDEX `pk_Name` ON `UniRefEntry` (`Name` ASC) ;

CREATE INDEX `fk_UniRefEntry_Taxonomy1_idx` ON `UniRefEntry` (`TaxId` ASC) ;

CREATE INDEX `fk_UniRefEntry_DataSet1_idx` ON `UniRefEntry` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefEntryProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntryProperty` ;

CREATE  TABLE IF NOT EXISTS `UniRefEntryProperty` (
  `WID` BIGINT NOT NULL ,
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Value` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_UniRefCommonProperty_UniRefEntry1_idx` ON `UniRefEntryProperty` (`UniRefEntry_WID` ASC) ;

CREATE INDEX `pk_Type` ON `UniRefEntryProperty` (`Type` ASC) ;

CREATE INDEX `pk_Value` ON `UniRefEntryProperty` (`Value` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefMember`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMember` ;

CREATE  TABLE IF NOT EXISTS `UniRefMember` (
  `WID` BIGINT NOT NULL ,
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Id` VARCHAR(100) NULL ,
  `IsRepresentative` TINYINT(1) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_UniRefMember_UniRefEntry1_idx` ON `UniRefMember` (`UniRefEntry_WID` ASC) ;

CREATE INDEX `pk_Type` ON `UniRefMember` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `UniRefMember` (`Id` ASC) ;

CREATE INDEX `fk_UniRefMember_Taxonomy1_idx` ON `UniRefMember` (`TaxId` ASC) ;

CREATE INDEX `fk_UniRefMember_Protein1_idx` ON `UniRefMember` (`Protein_WID` ASC) ;

CREATE INDEX `pk_IsRepresentative` ON `UniRefMember` (`IsRepresentative` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefMemberProperty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberProperty` ;

CREATE  TABLE IF NOT EXISTS `UniRefMemberProperty` (
  `WID` BIGINT NOT NULL ,
  `UniRefMember_WID` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Value` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_UniRefMemberProperty_UniRefMember1_idx` ON `UniRefMemberProperty` (`UniRefMember_WID` ASC) ;

CREATE INDEX `pk_Type` ON `UniRefMemberProperty` (`Type` ASC) ;

CREATE INDEX `pk_Value` ON `UniRefMemberProperty` (`Value` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp` ;

CREATE  TABLE IF NOT EXISTS `UniRefMemberTemp` (
  `WID` BIGINT NOT NULL ,
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Id` VARCHAR(100) NULL ,
  `IsRepresentative` TINYINT(1) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `pk_Type` ON `UniRefMemberTemp` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `UniRefMemberTemp` (`Id` ASC) ;

CREATE INDEX `pk_UniRefEntry_Protein_WID` USING BTREE ON `UniRefMemberTemp` (`UniRefEntry_WID` ASC, `Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp1` ;

CREATE  TABLE IF NOT EXISTS `UniRefMemberTemp1` (
  `WID` BIGINT NOT NULL ,
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Id` VARCHAR(100) NULL ,
  `IsRepresentative` TINYINT(1) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `pk_Type` ON `UniRefMemberTemp1` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `UniRefMemberTemp1` (`Id` ASC) ;

CREATE INDEX `pk_UniRefEntry_Id` USING BTREE ON `UniRefMemberTemp1` (`UniRefEntry_WID` ASC, `Id` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefMemberTemp2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefMemberTemp2` ;

CREATE  TABLE IF NOT EXISTS `UniRefMemberTemp2` (
  `WID` BIGINT NOT NULL ,
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NULL ,
  `TaxId` BIGINT NOT NULL ,
  `Type` VARCHAR(45) NULL ,
  `Id` VARCHAR(100) NULL ,
  `IsRepresentative` TINYINT(1) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `pk_Type` ON `UniRefMemberTemp2` (`Type` ASC) ;

CREATE INDEX `pk_Id` ON `UniRefMemberTemp2` (`Id` ASC) ;

CREATE INDEX `pk_UniRefEntry_Id` USING BTREE ON `UniRefMemberTemp2` (`UniRefEntry_WID` ASC, `Id` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank` ;

CREATE  TABLE IF NOT EXISTS `DrugBank` (
  `WID` BIGINT NOT NULL ,
  `Id` VARCHAR(10) NOT NULL ,
  `Name` VARCHAR(45) NOT NULL ,
  `Description` TEXT NULL ,
  `CASNumber` VARCHAR(20) NULL ,
  `SynthesisRef` TEXT NULL ,
  `Indication` TEXT NULL ,
  `Pharmacology` TEXT NULL ,
  `MechanismOfAction` TEXT NULL ,
  `Toxicity` TEXT NULL ,
  `Biotransformation` TEXT NULL ,
  `Absorption` TEXT NULL ,
  `HalfLife` TEXT NULL ,
  `ProteinBinding` TEXT NULL ,
  `RouteOfElimination` TEXT NULL ,
  `VolumeOfDistribution` TEXT NULL ,
  `Clearance` TEXT NULL ,
  `Type` VARCHAR(25) NULL ,
  `Version` VARCHAR(25) NULL ,
  `Updated` DATETIME NULL ,
  `Created` DATETIME NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Id` ON `DrugBank` (`Id` ASC) ;

CREATE INDEX `pk_Name` ON `DrugBank` (`Name` ASC) ;

CREATE INDEX `pk_CASNumber` ON `DrugBank` (`CASNumber` ASC) ;

CREATE INDEX `fk_DrugBank_DataSet1_idx` ON `DrugBank` (`DataSet_WID` ASC) ;

CREATE INDEX `pk_Type` ON `DrugBank` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankGeneralRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankGeneralRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankGeneralRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankGeneralRef_DrugBank1_idx` ON `DrugBankGeneralRef` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankSecondAccessionNumbers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankSecondAccessionNumbers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankSecondAccessionNumbers` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `AccessionNumber` VARCHAR(45) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankSecondAccessionNumbers_DrugBank1_idx` ON `DrugBankSecondAccessionNumbers` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_AccessionNumber` ON `DrugBankSecondAccessionNumbers` (`AccessionNumber` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankGroup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankGroup` ;

CREATE  TABLE IF NOT EXISTS `DrugBankGroup` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `GroupName` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankGroup_DrugBank1_idx` ON `DrugBankGroup` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTaxonomySubstructures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTaxonomySubstructures` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTaxonomySubstructures` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Substructure` VARCHAR(255) NULL ,
  `Class` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTaxonomySubstructures_DrugBank1_idx` ON `DrugBankTaxonomySubstructures` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankSynonyms` ;

CREATE  TABLE IF NOT EXISTS `DrugBankSynonyms` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Synonym` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankSynonyms_DrugBank1_idx` ON `DrugBankSynonyms` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankBrands`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankBrands` ;

CREATE  TABLE IF NOT EXISTS `DrugBankBrands` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Brand` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankBrands_DrugBank1_idx` ON `DrugBankBrands` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankMixtures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankMixtures` ;

CREATE  TABLE IF NOT EXISTS `DrugBankMixtures` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(50) NULL ,
  `Ingredients` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankMixtures_DrugBank1_idx` ON `DrugBankMixtures` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Name` ON `DrugBankMixtures` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPackagers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPackagers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPackagers` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(50) NULL ,
  `URL` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPackagers_DrugBank1_idx` ON `DrugBankPackagers` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankManufacturers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankManufacturers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankManufacturers` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Manufacturer` VARCHAR(50) NULL ,
  `Generic` VARCHAR(10) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankManufacturers_DrugBank1_idx` ON `DrugBankManufacturers` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPrices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPrices` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPrices` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Description` TEXT NULL ,
  `Cost` VARCHAR(25) NULL ,
  `Currency` VARCHAR(6) NULL ,
  `Unit` VARCHAR(10) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPrices_DrugBank1_idx` ON `DrugBankPrices` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCategories` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCategories` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Category` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Category` USING BTREE ON `DrugBankCategories` (`Category` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCategoriesTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCategoriesTemp` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCategoriesTemp` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `Category` VARCHAR(50) NULL )
ENGINE = MyISAM;

CREATE INDEX `pk_Category` USING BTREE ON `DrugBankCategoriesTemp` (`Category` ASC) ;

CREATE INDEX `fk_DrugBankCategoriesTemp_DrugBank1_idx` ON `DrugBankCategoriesTemp` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBank_has_DrugBankCategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank_has_DrugBankCategories` ;

CREATE  TABLE IF NOT EXISTS `DrugBank_has_DrugBankCategories` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `DrugBankCategories_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`DrugBank_WID`, `DrugBankCategories_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBank_has_DrugBankCategories_DrugBankCategories1_idx` ON `DrugBank_has_DrugBankCategories` (`DrugBankCategories_WID` ASC) ;

CREATE INDEX `fk_DrugBank_has_DrugBankCategories_DrugBank1_idx` ON `DrugBank_has_DrugBankCategories` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankAffectedOrganisms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankAffectedOrganisms` ;

CREATE  TABLE IF NOT EXISTS `DrugBankAffectedOrganisms` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `AffectedOrganisms` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankAffectedOrganisms_DrugBank1_idx` ON `DrugBankAffectedOrganisms` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankDosages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDosages` ;

CREATE  TABLE IF NOT EXISTS `DrugBankDosages` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Form` VARCHAR(25) NULL ,
  `Route` VARCHAR(25) NULL ,
  `Strength` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankDosages_DrugBank1_idx` ON `DrugBankDosages` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankATCCodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankATCCodes` ;

CREATE  TABLE IF NOT EXISTS `DrugBankATCCodes` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `ATCCode` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankATCCodes_DrugBank1_idx` ON `DrugBankATCCodes` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_ATCCode` ON `DrugBankATCCodes` (`ATCCode` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankAHFSCodes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankAHFSCodes` ;

CREATE  TABLE IF NOT EXISTS `DrugBankAHFSCodes` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `AHFSCodes` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankAHFSCodes_DrugBank1_idx` ON `DrugBankAHFSCodes` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_AHFSCodes` ON `DrugBankAHFSCodes` (`AHFSCodes` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPatents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPatents` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPatents` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Number` BIGINT NOT NULL ,
  `Country` VARCHAR(255) NULL ,
  `Approved` DATETIME NULL ,
  `Expires` DATETIME NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Number` ON `DrugBankPatents` (`Number` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPatentsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPatentsTemp` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPatentsTemp` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `Number` BIGINT NOT NULL ,
  `Country` VARCHAR(255) NULL ,
  `Approved` DATETIME NULL ,
  `Expires` DATETIME NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPatentsTemp_DrugBank1_idx` ON `DrugBankPatentsTemp` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Number` ON `DrugBankPatentsTemp` (`Number` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBank_has_DrugBankPatents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBank_has_DrugBankPatents` ;

CREATE  TABLE IF NOT EXISTS `DrugBank_has_DrugBankPatents` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `DrugBankPatents_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`DrugBank_WID`, `DrugBankPatents_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBank_has_DrugBankPatents_DrugBankPatents1_idx` ON `DrugBank_has_DrugBankPatents` (`DrugBankPatents_WID` ASC) ;

CREATE INDEX `fk_DrugBank_has_DrugBankPatents_DrugBank1_idx` ON `DrugBank_has_DrugBankPatents` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankFoodInteractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankFoodInteractions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankFoodInteractions` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `FoodInteractions` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankFoodInteractions_DrugBank1_idx` ON `DrugBankFoodInteractions` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankDrugInteractions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDrugInteractions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankDrugInteractions` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `Drug` BIGINT NOT NULL ,
  `Description` TEXT NULL ,
  PRIMARY KEY (`DrugBank_WID`, `Drug`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankDrugInteractions_DrugBank1_idx` ON `DrugBankDrugInteractions` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankProteinSequences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankProteinSequences` ;

CREATE  TABLE IF NOT EXISTS `DrugBankProteinSequences` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Header` VARCHAR(100) NULL ,
  `Chain` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankProteinSequences_DrugBank1_idx` ON `DrugBankProteinSequences` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCalculatedProperties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCalculatedProperties` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCalculatedProperties` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Kind` VARCHAR(25) NULL ,
  `Value` VARCHAR(255) NULL ,
  `Source` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankCalculatedProperties_DrugBank1_idx` ON `DrugBankCalculatedProperties` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Kind` ON `DrugBankCalculatedProperties` (`Kind` ASC) ;

CREATE INDEX `pk_Source` ON `DrugBankCalculatedProperties` (`Source` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankExperimentalProperties`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExperimentalProperties` ;

CREATE  TABLE IF NOT EXISTS `DrugBankExperimentalProperties` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Kind` VARCHAR(25) NULL ,
  `Value` VARCHAR(255) NULL ,
  `Source` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankCalculatedProperties_DrugBank1` ON `DrugBankExperimentalProperties` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Kind` ON `DrugBankExperimentalProperties` (`Kind` ASC) ;

CREATE INDEX `pk_Source` ON `DrugBankExperimentalProperties` (`Source` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankExternalIdentifiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExternalIdentifiers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankExternalIdentifiers` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Resource` VARCHAR(50) NULL ,
  `Identifier` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankExternalIdentifiers_DrugBank1_idx` ON `DrugBankExternalIdentifiers` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Resource_Identifier` USING BTREE ON `DrugBankExternalIdentifiers` (`Resource` ASC, `Identifier` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankExternalLinks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankExternalLinks` ;

CREATE  TABLE IF NOT EXISTS `DrugBankExternalLinks` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Resource` VARCHAR(50) NULL ,
  `URL` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankExternalLinks_DrugBank1_idx` ON `DrugBankExternalLinks` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Resource` ON `DrugBankExternalLinks` (`Resource` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTargets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargets` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTargets` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Partner` INT NOT NULL ,
  `Position` INT NULL ,
  `KnownAction` VARCHAR(10) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTargets_DrugBank1_idx` ON `DrugBankTargets` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Partner` ON `DrugBankTargets` (`Partner` ASC) ;

CREATE INDEX `pk_KnownAction` ON `DrugBankTargets` (`KnownAction` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTargetsRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargetsRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTargetsRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBankTargets_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTargetsRef_DrugBankTargets1_idx` ON `DrugBankTargetsRef` (`DrugBankTargets_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTargetsActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTargetsActions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTargetsActions` (
  `WID` BIGINT NOT NULL ,
  `DrugBankTargets_WID` BIGINT NOT NULL ,
  `Action` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTargetsActions_DrugBankTargets1_idx` ON `DrugBankTargetsActions` (`DrugBankTargets_WID` ASC) ;

CREATE INDEX `pk_Action` ON `DrugBankTargetsActions` (`Action` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankEnzymes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymes` ;

CREATE  TABLE IF NOT EXISTS `DrugBankEnzymes` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Partner` INT NOT NULL ,
  `Position` INT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankEnzymes_DrugBank1` ON `DrugBankEnzymes` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Partner` ON `DrugBankEnzymes` (`Partner` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankEnzymesRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymesRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankEnzymesRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBankEnzymes_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankEnzymesRef_DrugBankEnzymes1_idx` ON `DrugBankEnzymesRef` (`DrugBankEnzymes_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankEnzymesActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankEnzymesActions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankEnzymesActions` (
  `WID` BIGINT NOT NULL ,
  `DrugBankEnzymes_WID` BIGINT NOT NULL ,
  `Action` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Action` ON `DrugBankEnzymesActions` (`Action` ASC) ;

CREATE INDEX `fk_DrugBankEnzymesActions_DrugBankEnzymes1_idx` ON `DrugBankEnzymesActions` (`DrugBankEnzymes_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTransporters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransporters` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTransporters` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Partner` INT NOT NULL ,
  `Position` INT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTransporters_DrugBank1` ON `DrugBankTransporters` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Partner` ON `DrugBankTransporters` (`Partner` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTransportersRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransportersRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTransportersRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBankTransporters_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTransportersRef_DrugBankTransporters1_idx` ON `DrugBankTransportersRef` (`DrugBankTransporters_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTransportersActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTransportersActions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTransportersActions` (
  `WID` BIGINT NOT NULL ,
  `DrugBankTransporters_WID` BIGINT NOT NULL ,
  `Action` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Action` ON `DrugBankTransportersActions` (`Action` ASC) ;

CREATE INDEX `fk_DrugBankTransportersActions_DrugBankTransporters1_idx` ON `DrugBankTransportersActions` (`DrugBankTransporters_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCarriers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCarriers` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Partner` INT NOT NULL ,
  `Position` INT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankCarriers_DrugBank1` ON `DrugBankCarriers` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Partner` ON `DrugBankCarriers` (`Partner` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCarriersRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriersRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCarriersRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBankCarriers_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankCarriersRef_DrugBankCarriers1_idx` ON `DrugBankCarriersRef` (`DrugBankCarriers_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankCarriersActions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankCarriersActions` ;

CREATE  TABLE IF NOT EXISTS `DrugBankCarriersActions` (
  `WID` BIGINT NOT NULL ,
  `DrugBankCarriers_WID` BIGINT NOT NULL ,
  `Action` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Action` ON `DrugBankCarriersActions` (`Action` ASC) ;

CREATE INDEX `fk_DrugBankCarriersActions_DrugBankCarriers1_idx` ON `DrugBankCarriersActions` (`DrugBankCarriers_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPartners`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartners` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPartners` (
  `WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `Name` VARCHAR(45) NULL ,
  `GeneralFunction` TEXT NULL ,
  `SpecificFunction` TEXT NULL ,
  `GeneName` VARCHAR(45) NULL ,
  `Locus` VARCHAR(45) NULL ,
  `Reaction` TEXT NULL ,
  `Signals` TEXT NULL ,
  `CellularLocation` TEXT NULL ,
  `TransmembraneRegions` TEXT NULL ,
  `TheoreticalPi` FLOAT NULL ,
  `MolecularWeight` FLOAT NULL ,
  `Chromosome` VARCHAR(100) NULL ,
  `Essentiality` VARCHAR(25) NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Id` ON `DrugBankPartners` (`Id` ASC) ;

CREATE INDEX `fk_DrugBankPartners_DataSet1_idx` ON `DrugBankPartners` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBank` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_DrugBank` (
  `Protein_WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_DrugBank_DrugBank1_idx` ON `Protein_has_DrugBank` (`DrugBank_WID` ASC) ;

CREATE INDEX `fk_Protein_has_DrugBank_Protein1_idx` ON `Protein_has_DrugBank` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPartnerRef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerRef` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPartnerRef` (
  `WID` BIGINT NOT NULL ,
  `DrugBankPartners_WID` BIGINT NOT NULL ,
  `Cite` TEXT NULL ,
  `Link` TEXT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPartnerRef_DrugBankPartners1_idx` ON `DrugBankPartnerRef` (`DrugBankPartners_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPartnerExternalIdentifiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerExternalIdentifiers` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPartnerExternalIdentifiers` (
  `WID` BIGINT NOT NULL ,
  `DrugBankPartners_WID` BIGINT NOT NULL ,
  `Resource` VARCHAR(50) NULL ,
  `Identifier` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPartnerExternalIdentifiers_DrugBankPartners1_idx` ON `DrugBankPartnerExternalIdentifiers` (`DrugBankPartners_WID` ASC) ;

CREATE INDEX `pk_Resource` ON `DrugBankPartnerExternalIdentifiers` (`Resource` ASC) ;

CREATE INDEX `pk_Identifier` ON `DrugBankPartnerExternalIdentifiers` (`Identifier` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPartnerSynonyms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerSynonyms` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPartnerSynonyms` (
  `WID` BIGINT NOT NULL ,
  `DrugBankPartners_WID` BIGINT NOT NULL ,
  `Synonym` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPartnerSynonyms_DrugBankPartners1_idx` ON `DrugBankPartnerSynonyms` (`DrugBankPartners_WID` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankPartnerPFam`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankPartnerPFam` ;

CREATE  TABLE IF NOT EXISTS `DrugBankPartnerPFam` (
  `WID` BIGINT NOT NULL ,
  `DrugBankPartners_WID` BIGINT NOT NULL ,
  `Identifier` VARCHAR(25) NULL ,
  `Name` VARCHAR(50) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankPartnerRef_DrugBankPartners1` ON `DrugBankPartnerPFam` (`DrugBankPartners_WID` ASC) ;

CREATE INDEX `pk_Identifier` ON `DrugBankPartnerPFam` (`Identifier` ASC) ;

CREATE INDEX `pk_Name` ON `DrugBankPartnerPFam` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankTaxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankTaxonomy` ;

CREATE  TABLE IF NOT EXISTS `DrugBankTaxonomy` (
  `WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  `Kingdom` VARCHAR(100) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankTaxonomy_DrugBank1_idx` ON `DrugBankTaxonomy` (`DrugBank_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsEnzyme` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_DrugBankAsEnzyme` (
  `Protein_WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_DrugBank1_DrugBank1_idx` ON `Protein_has_DrugBankAsEnzyme` (`DrugBank_WID` ASC) ;

CREATE INDEX `fk_Protein_has_DrugBank1_Protein1_idx` ON `Protein_has_DrugBankAsEnzyme` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsTransporters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsTransporters` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_DrugBankAsTransporters` (
  `Protein_WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_DrugBank1_DrugBank2_idx` ON `Protein_has_DrugBankAsTransporters` (`DrugBank_WID` ASC) ;

CREATE INDEX `fk_Protein_has_DrugBank1_Protein2_idx` ON `Protein_has_DrugBankAsTransporters` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_DrugBankAsCarriers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_DrugBankAsCarriers` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_DrugBankAsCarriers` (
  `Protein_WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `DrugBank_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_DrugBank1_DrugBank3_idx` ON `Protein_has_DrugBankAsCarriers` (`DrugBank_WID` ASC) ;

CREATE INDEX `fk_Protein_has_DrugBank1_Protein3_idx` ON `Protein_has_DrugBankAsCarriers` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NULL ,
  `Comment` TEXT NULL ,
  `Definition` TEXT NULL ,
  `Equation` TEXT NULL ,
  `Remark` VARCHAR(255) NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGReaction` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGReaction_DataSet1_idx` ON `KEGGReaction` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(20) NOT NULL ,
  `Comment` TEXT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGEnzyme` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_DataSet1_idx` ON `KEGGEnzyme` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionName` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionName` (
  `WID` BIGINT NOT NULL ,
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionName_KEGGReaction1_idx` ON `KEGGReactionName` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGReactionName` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeName` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeName` (
  `WID` BIGINT NOT NULL ,
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeName_KEGGEnzyme1_idx` ON `KEGGEnzymeName` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGEnzymeName` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionOrthology` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionOrthology` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGReactionOrthology_KEGGReaction1_idx` ON `KEGGReactionOrthology` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGReactionOrthology` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeOrthology` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeOrthology` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `Entry`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeOrthology_KEGGEnzyme1_idx` ON `KEGGEnzymeOrthology` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeOrthology` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionRPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionRPair` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionRPair` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(10) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionRPair_KEGGReaction1_idx` ON `KEGGReactionRPair` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGReactionRPair` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionPathway` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionPathway_KEGGReaction1_idx` ON `KEGGReactionPathway` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGReactionPathway` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymePathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymePathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymePathway` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymePathway_KEGGEnzyme1_idx` ON `KEGGEnzymePathway` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymePathway` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionEnzyme` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Enzyme` VARCHAR(16) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionEnzyme_KEGGReaction1_idx` ON `KEGGReactionEnzyme` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Enzyme` ON `KEGGReactionEnzyme` (`Enzyme` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGEnzyme` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGEnzyme_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGEnzyme1_idx` ON `KEGGReaction_has_KEGGEnzyme` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGReaction1_idx` ON `KEGGReaction_has_KEGGEnzyme` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeClass` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Class` VARCHAR(255) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `KEGGEnzymeAllReac`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeAllReac` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeAllReac` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `AllReac` VARCHAR(255) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeAllReac_KEGGEnzyme1_idx` ON `KEGGEnzymeAllReac` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeClassTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeClassTemp` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeClassTemp` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Class` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeClass_KEGGEnzyme1` ON `KEGGEnzymeClassTemp` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Class` ON `KEGGEnzymeClassTemp` (`Class` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGEnzymeClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGEnzymeClass` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGEnzymeClass` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `KEGGEnzymeClass_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGEnzymeClass_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzymeClass1_idx` ON `KEGGEnzyme_has_KEGGEnzymeClass` (`KEGGEnzymeClass_WID` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzyme1_idx` ON `KEGGEnzyme_has_KEGGEnzymeClass` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeSysName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeSysName` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeSysName` (
  `WID` BIGINT NOT NULL ,
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `SySName` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeSysName_KEGGEnzyme1` ON `KEGGEnzymeSysName` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_SysName` ON `KEGGEnzymeSysName` (`SySName` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeReaction` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Reaction` TEXT NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeReaction_KEGGEnzyme1_idx` ON `KEGGEnzymeReaction` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeSubstrate` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeSubstrate` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeSubstrate_KEGGEnzyme1_idx` ON `KEGGEnzymeSubstrate` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeSubstrate` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeProduct` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeProduct` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeProduct_KEGGEnzyme1_idx` ON `KEGGEnzymeProduct` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeProduct` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeCofactor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeCofactor` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeCofactor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(255) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeCofactor_KEGGEnzyme1_idx` ON `KEGGEnzymeCofactor` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeCofactor` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeGenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeGenes` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeGenes` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Organism` VARCHAR(4) NULL ,
  `Genes` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeGenes_KEGGEnzyme1_idx` ON `KEGGEnzymeGenes` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Organism` ON `KEGGEnzymeGenes` (`Organism` ASC) ;

CREATE INDEX `pk_Genes` ON `KEGGEnzymeGenes` (`Genes` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeDBLink` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeDBLink` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `DB`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeDBLink_KEGGEnzyme1_idx` ON `KEGGEnzymeDBLink` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeInhibitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeInhibitor` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeInhibitor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(255) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeInhibitor_KEGGEnzyme1_idx` ON `KEGGEnzymeInhibitor` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeInhibitor` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzymeEffector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzymeEffector` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzymeEffector` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(255) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzymeEffector_KEGGEnzyme1_idx` ON `KEGGEnzymeEffector` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGEnzymeEffector` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompound` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Comment` TEXT NULL ,
  `Mass` FLOAT NULL ,
  `Remark` VARCHAR(255) NULL ,
  `Formula` VARCHAR(255) NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGCompound` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGCompound_DataSet1_idx` ON `KEGGCompound` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompoundName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundName` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompoundName` (
  `WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompoundName_KEGGCompound1_idx` ON `KEGGCompoundName` (`KEGGCompound_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompoundReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompoundReaction` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `Reaction` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompoundReaction_KEGGCompound1_idx` ON `KEGGCompoundReaction` (`KEGGCompound_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompoundEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompoundEnzyme` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompoundEnzyme_KEGGCompound1_idx` ON `KEGGCompoundEnzyme` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGCompoundEnzyme` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompoundPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompoundPathway` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompoundPathway_KEGGCompound1_idx` ON `KEGGCompoundPathway` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGCompoundPathway` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGCompound_as_Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGCompound_as_Product` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGCompound_as_Product` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound1_idx` ON `KEGGReaction_has_KEGGCompound_as_Product` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction1_idx` ON `KEGGReaction_has_KEGGCompound_as_Product` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGCompound_as_Substrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGCompound_as_Substrate` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGCompound_as_Substrate` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound2_idx` ON `KEGGReaction_has_KEGGCompound_as_Substrate` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction2_idx` ON `KEGGReaction_has_KEGGCompound_as_Substrate` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Cofactor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Cofactor` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Cofactor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound1_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Cofactor` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme1_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Cofactor` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Inhibitor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound2_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme2_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompoundDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompoundDBLink` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompoundDBLink` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`KEGGCompound_WID`, `DB`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompoundDBLink_KEGGCompound1_idx` ON `KEGGCompoundDBLink` (`KEGGCompound_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionProduct` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionProduct` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionProduct_KEGGReaction1_idx` ON `KEGGReactionProduct` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGReactionProduct` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReactionSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReactionSubstrate` ;

CREATE  TABLE IF NOT EXISTS `KEGGReactionSubstrate` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReactionSubstrate_KEGGReaction1_idx` ON `KEGGReactionSubstrate` (`KEGGReaction_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGReactionSubstrate` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycan` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycan` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Comment` TEXT NULL ,
  `Mass` VARCHAR(25) NULL ,
  `Remark` VARCHAR(255) NULL ,
  `Composition` TEXT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGGlycan` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGGlycan_DataSet1_idx` ON `KEGGGlycan` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanDBLink` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanDBLink` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`KEGGGlycan_WID`, `DB`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanDBLink_KEGGGlycan1_idx` ON `KEGGGlycanDBLink` (`KEGGGlycan_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanEnzyme` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanEnzyme_KEGGGlycan1_idx` ON `KEGGGlycanEnzyme` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGlycanEnzyme` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanPathway` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanPathway_KEGGGlycan1_idx` ON `KEGGGlycanPathway` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGlycanPathway` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanReaction` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanReaction_KEGGGlycan1_idx` ON `KEGGGlycanReaction` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGlycanReaction` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGGlycan_as_Product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGGlycan_as_Product` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGGlycan_as_Product` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGGlycan_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan1_idx` ON `KEGGReaction_has_KEGGGlycan_as_Product` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction1_idx` ON `KEGGReaction_has_KEGGGlycan_as_Product` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGGlycan_as_Substrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGGlycan_as_Substrate` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGGlycan_as_Substrate` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGGlycan_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan2_idx` ON `KEGGReaction_has_KEGGGlycan_as_Substrate` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction2_idx` ON `KEGGReaction_has_KEGGGlycan_as_Substrate` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanClassTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanClassTemp` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanClassTemp` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Class` VARCHAR(255) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanClassTemp_KEGGGlycan1_idx` ON `KEGGGlycanClassTemp` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Class` ON `KEGGGlycanClassTemp` (`Class` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanClass` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanClass` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Class` VARCHAR(255) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Class` ON `KEGGGlycanClass` (`Class` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycan_has_KEGGGlycanClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycan_has_KEGGGlycanClass` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycan_has_KEGGGlycanClass` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `KEGGGlycanClass_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGGlycan_WID`, `KEGGGlycanClass_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycanClass1_idx` ON `KEGGGlycan_has_KEGGGlycanClass` (`KEGGGlycanClass_WID` ASC) ;

CREATE INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycan1_idx` ON `KEGGGlycan_has_KEGGGlycanClass` (`KEGGGlycan_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanOrthology` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanOrthology` (
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanOrthology_KEGGGlycan1_idx` ON `KEGGGlycanOrthology` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGlycanOrthology` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGCompound_as_Effector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGCompound_as_Effector` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGCompound_as_Effector` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound3_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Effector` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme3_idx` ON `KEGGEnzyme_has_KEGGCompound_as_Effector` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPair` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPair` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(15) NOT NULL ,
  `Type` VARCHAR(15) NOT NULL ,
  `RClass` VARCHAR(8) NOT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGRPair` (`Entry` ASC) ;

CREATE INDEX `pk_RClass` ON `KEGGRPair` (`RClass` ASC) ;

CREATE INDEX `fk_KEGGRPair_DataSet1_idx` ON `KEGGRPair` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPairCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairCompound` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPairCompound` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPairCompound_KEGGRPair1_idx` ON `KEGGRPairCompound` (`KEGGRPair_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGRPairCompound` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPair_has_KEGGCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPair_has_KEGGCompound` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPair_has_KEGGCompound` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `KEGGCompound_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGRPair_WID`, `KEGGCompound_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGCompound1_idx` ON `KEGGRPair_has_KEGGCompound` (`KEGGCompound_WID` ASC) ;

CREATE INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGRPair1_idx` ON `KEGGRPair_has_KEGGCompound` (`KEGGRPair_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPairRelatedPair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairRelatedPair` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPairRelatedPair` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `KEGGRPair_Other_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGRPair_WID`, `KEGGRPair_Other_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPair_KEGGRPair1_idx` ON `KEGGRPairRelatedPair` (`KEGGRPair_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPairRelatedPairTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairRelatedPairTemp` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPairRelatedPairTemp` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPairTemp_KEGGRPair1_idx` ON `KEGGRPairRelatedPairTemp` (`KEGGRPair_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGRPairRelatedPairTemp` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPairEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPairEnzyme` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPairEnzyme_KEGGRPair1_idx` ON `KEGGRPairEnzyme` (`KEGGRPair_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGRPairEnzyme` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGRPairReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGRPairReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGRPairReaction` (
  `KEGGRPair_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGRPairReaction_KEGGRPair1_idx` ON `KEGGRPairReaction` (`KEGGRPair_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGRPairReaction` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGene` ;

CREATE  TABLE IF NOT EXISTS `KEGGGene` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL ,
  `Definition` TEXT NULL ,
  `PositionStart` INT NULL ,
  `PositionEnd` INT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGGene` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGGene_DataSet1_idx` ON `KEGGGene` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGeneName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneName` ;

CREATE  TABLE IF NOT EXISTS `KEGGGeneName` (
  `WID` BIGINT NOT NULL ,
  `KEGGGene_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGeneName_KEGGGene1_idx` ON `KEGGGeneName` (`KEGGGene_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGGeneName` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGeneOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneOrthology` ;

CREATE  TABLE IF NOT EXISTS `KEGGGeneOrthology` (
  `KEGGGene_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL ,
  PRIMARY KEY (`KEGGGene_WID`, `Entry`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGeneOrthology_KEGGGene1_idx` ON `KEGGGeneOrthology` (`KEGGGene_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGeneOrthology` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGenePathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGenePathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGGenePathway` (
  `KEGGGene_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(8) NOT NULL ,
  `Name` VARCHAR(255) NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGenePathway_KEGGGene1_idx` ON `KEGGGenePathway` (`KEGGGene_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGenePathway` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGeneDBLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDBLink` ;

CREATE  TABLE IF NOT EXISTS `KEGGGeneDBLink` (
  `KEGGGene_WID` BIGINT NOT NULL ,
  `DB` VARCHAR(100) NOT NULL ,
  `Id` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`KEGGGene_WID`, `DB`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGeneDBLink_KEGGGene1_idx` ON `KEGGGeneDBLink` (`KEGGGene_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGeneDisease`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDisease` ;

CREATE  TABLE IF NOT EXISTS `KEGGGeneDisease` (
  `WID` BIGINT NOT NULL ,
  `KEGGGene_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL ,
  `Disease` VARCHAR(255) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGeneDisease_KEGGGene1_idx` ON `KEGGGeneDisease` (`KEGGGene_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGGeneDisease` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGeneDrugTarget`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGeneDrugTarget` ;

CREATE  TABLE IF NOT EXISTS `KEGGGeneDrugTarget` (
  `KEGGGene_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  `Entries` TEXT NULL ,
  PRIMARY KEY (`KEGGGene_WID`, `Name`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGeneDrugTarget_KEGGGene1_idx` ON `KEGGGeneDrugTarget` (`KEGGGene_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGGeneDrugTarget` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathway` (
  `WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL ,
  `Org` VARCHAR(5) NULL ,
  `Number` VARCHAR(25) NOT NULL ,
  `Title` VARCHAR(255) NULL ,
  `Image` VARCHAR(255) NULL ,
  `Link` VARCHAR(255) NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Entry` ON `KEGGPathway` (`Entry` ASC) ;

CREATE INDEX `fk_KEGGPathway_DataSet1_idx` ON `KEGGPathway` (`DataSet_WID` ASC) ;

CREATE INDEX `pk_Org` ON `KEGGPathway` (`Org` ASC) ;

CREATE INDEX `pk_Number` ON `KEGGPathway` (`Number` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntry`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntry` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntry` (
  `WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL ,
  `Type` VARCHAR(25) NOT NULL ,
  `Reaction` VARCHAR(255) NULL ,
  `Link` VARCHAR(255) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntry_KEGGPathway1_idx` ON `KEGGPathwayEntry` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Id` ON `KEGGPathwayEntry` (`Id` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntry` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayRelation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayRelation` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayRelation` (
  `WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Id1` INT NOT NULL ,
  `Id2` INT NOT NULL ,
  `Type` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayRelation_KEGGPathway1_idx` ON `KEGGPathwayRelation` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Id1` ON `KEGGPathwayRelation` (`Id1` ASC) ;

CREATE INDEX `pk_Id2` ON `KEGGPathwayRelation` (`Id2` ASC) ;

CREATE INDEX `pk_Type` ON `KEGGPathwayRelation` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayReaction` (
  `WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL ,
  `Type` VARCHAR(25) NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayReaction_KEGGPathway1_idx` ON `KEGGPathwayReaction` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Id` ON `KEGGPathwayReaction` (`Id` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayReaction` (`Entry` ASC) ;

CREATE INDEX `pk_Type` ON `KEGGPathwayReaction` (`Type` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayReactionSubstrate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReactionSubstrate` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayReactionSubstrate` (
  `KEGGPathwayReaction_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayReactionSubstrate_KEGGPathwayReaction1_idx` ON `KEGGPathwayReactionSubstrate` (`KEGGPathwayReaction_WID` ASC) ;

CREATE INDEX `pk_Id` ON `KEGGPathwayReactionSubstrate` (`Id` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayReactionSubstrate` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayReactionProduct`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayReactionProduct` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayReactionProduct` (
  `KEGGPathwayReaction_WID` BIGINT NOT NULL ,
  `Id` INT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayReactionProduct_KEGGPathwayReaction1_idx` ON `KEGGPathwayReactionProduct` (`KEGGPathwayReaction_WID` ASC) ;

CREATE INDEX `pk_Id` ON `KEGGPathwayReactionProduct` (`Id` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayReactionProduct` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryGraphic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryGraphic` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryGraphic` (
  `WID` BIGINT NOT NULL ,
  `KEGGPathwayEntry_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  `FGColor` VARCHAR(25) NULL ,
  `BGColor` VARCHAR(25) NULL ,
  `Type` VARCHAR(25) NULL ,
  `X` INT NULL ,
  `Y` INT NULL ,
  `Coord` VARCHAR(255) NULL ,
  `Width` INT NULL ,
  `Height` INT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryGraphic_KEGGPathwayEntry1_idx` ON `KEGGPathwayEntryGraphic` (`KEGGPathwayEntry_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryEnzyme` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryEnzyme` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryMap_KEGGPathway1_idx` ON `KEGGPathwayEntryEnzyme` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntryEnzyme` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryCompound`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryCompound` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryCompound` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryCompound_KEGGPathway1_idx` ON `KEGGPathwayEntryCompound` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntryCompound` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryGene` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryGene` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryGene_KEGGPathway1_idx` ON `KEGGPathwayEntryGene` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntryGene` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryOrthology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryOrthology` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryOrthology` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryOrthology_KEGGPathway1_idx` ON `KEGGPathwayEntryOrthology` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntryOrthology` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGEnzyme_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGEnzyme_has_KEGGPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGEnzyme_has_KEGGPathway` (
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGEnzyme_WID`, `KEGGPathway_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGPathway1_idx` ON `KEGGEnzyme_has_KEGGPathway` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGEnzyme1_idx` ON `KEGGEnzyme_has_KEGGPathway` (`KEGGEnzyme_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompound_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound_has_KEGGPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompound_has_KEGGPathway` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGCompound_WID`, `KEGGPathway_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGPathway1_idx` ON `KEGGCompound_has_KEGGPathway` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGCompound1_idx` ON `KEGGCompound_has_KEGGPathway` (`KEGGCompound_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGReaction_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGReaction_has_KEGGPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGReaction_has_KEGGPathway` (
  `KEGGReaction_WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGReaction_WID`, `KEGGPathway_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGPathway1_idx` ON `KEGGReaction_has_KEGGPathway` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGReaction1_idx` ON `KEGGReaction_has_KEGGPathway` (`KEGGReaction_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGene_has_KEGGPathway`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGene_has_KEGGPathway` ;

CREATE  TABLE IF NOT EXISTS `KEGGGene_has_KEGGPathway` (
  `KEGGGene_WID` BIGINT NOT NULL ,
  `KEGGPathway_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGGene_WID`, `KEGGPathway_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGene_has_KEGGPathway_KEGGPathway1_idx` ON `KEGGGene_has_KEGGPathway` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `fk_KEGGGene_has_KEGGPathway_KEGGGene1_idx` ON `KEGGGene_has_KEGGPathway` (`KEGGGene_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayEntryReaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayEntryReaction` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayEntryReaction` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Entry` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayEntryReaction_KEGGPathway1_idx` ON `KEGGPathwayEntryReaction` (`KEGGPathway_WID` ASC) ;

CREATE INDEX `pk_Entry` ON `KEGGPathwayEntryReaction` (`Entry` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_Taxonomy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_Taxonomy` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathway_has_Taxonomy` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Taxonomy_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGPathway_WID`, `Taxonomy_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathway_has_Taxonomy_Taxonomy1_idx` ON `KEGGPathway_has_Taxonomy` (`Taxonomy_WID` ASC) ;

CREATE INDEX `fk_KEGGPathway_has_Taxonomy_KEGGPathway1_idx` ON `KEGGPathway_has_Taxonomy` (`KEGGPathway_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathwayRelationSubType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathwayRelationSubType` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathwayRelationSubType` (
  `KEGGPathwayRelation_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(25) NOT NULL ,
  `Value` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`KEGGPathwayRelation_WID`, `Name`, `Value`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathwayRelationSubType_KEGGPathwayRelation1_idx` ON `KEGGPathwayRelationSubType` (`KEGGPathwayRelation_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGPathwayRelationSubType` (`Name` ASC) ;

CREATE INDEX `Value` ON `KEGGPathwayRelationSubType` (`Value` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGGlycanName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGGlycanName` ;

CREATE  TABLE IF NOT EXISTS `KEGGGlycanName` (
  `WID` BIGINT NOT NULL ,
  `KEGGGlycan_WID` BIGINT NOT NULL ,
  `Name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGGlycanName_KEGGGlycan1_idx` ON `KEGGGlycanName` (`KEGGGlycan_WID` ASC) ;

CREATE INDEX `pk_Name` ON `KEGGGlycanName` (`Name` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGCompound_has_DrugBank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGCompound_has_DrugBank` ;

CREATE  TABLE IF NOT EXISTS `KEGGCompound_has_DrugBank` (
  `KEGGCompound_WID` BIGINT NOT NULL ,
  `DrugBank_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGCompound_WID`, `DrugBank_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGCompound_has_DrugBank_DrugBank1_idx` ON `KEGGCompound_has_DrugBank` (`DrugBank_WID` ASC) ;

CREATE INDEX `fk_KEGGCompound_has_DrugBank_KEGGCompound1_idx` ON `KEGGCompound_has_DrugBank` (`KEGGCompound_WID` ASC) ;


-- -----------------------------------------------------
-- Table `Protein_has_KEGGEnzyme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Protein_has_KEGGEnzyme` ;

CREATE  TABLE IF NOT EXISTS `Protein_has_KEGGEnzyme` (
  `Protein_WID` BIGINT NOT NULL ,
  `KEGGEnzyme_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `KEGGEnzyme_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_Protein_has_KEGGEnzyme_KEGGEnzyme1_idx` ON `Protein_has_KEGGEnzyme` (`KEGGEnzyme_WID` ASC) ;

CREATE INDEX `fk_Protein_has_KEGGEnzyme_Protein1_idx` ON `Protein_has_KEGGEnzyme` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfo_has_KEGGGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_KEGGGene` ;

CREATE  TABLE IF NOT EXISTS `GeneInfo_has_KEGGGene` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `KEGGGene_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `KEGGGene_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_GeneInfo_has_KEGGGene_KEGGGene1_idx` ON `GeneInfo_has_KEGGGene` (`KEGGGene_WID` ASC) ;

CREATE INDEX `fk_GeneInfo_has_KEGGGene_GeneInfo1_idx` ON `GeneInfo_has_KEGGGene` (`GeneInfo_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPDBTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPDBTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinPDBTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinPDB_Protein1` ON `ProteinPDBTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinPDBTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `DrugBankDrugInteractionsTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DrugBankDrugInteractionsTemp` ;

CREATE  TABLE IF NOT EXISTS `DrugBankDrugInteractionsTemp` (
  `DrugBank_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(10) NOT NULL ,
  `Description` TEXT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_DrugBankDrugInteractions_DrugBank1` ON `DrugBankDrugInteractionsTemp` (`DrugBank_WID` ASC) ;

CREATE INDEX `pk_Id` ON `DrugBankDrugInteractionsTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPMIDTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPMIDTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinPMIDTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinPMID_Protein1` ON `ProteinPMIDTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinPMIDTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinKEGGTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinKEGGTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinKEGGTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinKEGG_Protein1` ON `ProteinKEGGTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinKEGGTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGoTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGoTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinGoTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(10) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `pk_Protein_WID` ON `ProteinGoTemp` (`Protein_WID` ASC, `Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinRefSeqTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinRefSeqTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinRefSeqTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinRefSeq_Protein1` ON `ProteinRefSeqTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinRefSeqTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinMINTTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinMINTTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinMINTTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinMINT_Protein1` ON `ProteinMINTTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinMINTTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGene` ;

CREATE  TABLE IF NOT EXISTS `ProteinGene` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`Protein_WID`, `Id`) )
ENGINE = MyISAM;

CREATE INDEX `fk_ProteinGene_Protein2_idx` ON `ProteinGene` (`Protein_WID` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinGeneTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinGeneTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinGeneTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_ProteinGene_Protein2` ON `ProteinGeneTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinGeneTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDIPTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDIPTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinDIPTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDIP_Protein1` ON `ProteinDIPTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinDIPTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinPFAMTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinPFAMTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinPFAMTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_ProteinPFAM_Protein1` ON `ProteinPFAMTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinPFAMTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinIntActTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinIntActTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinIntActTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinIntAct_Protein1` ON `ProteinIntActTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinIntActTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinECTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinECTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinECTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinEC_Protein1` ON `ProteinECTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinECTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinBioCycTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinBioCycTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinBioCycTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinBioCyc_Protein1` ON `ProteinBioCycTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinBioCycTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `ProteinDrugBankTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProteinDrugBankTemp` ;

CREATE  TABLE IF NOT EXISTS `ProteinDrugBankTemp` (
  `Protein_WID` BIGINT NOT NULL ,
  `Id` VARCHAR(100) NOT NULL )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin
ROW_FORMAT = Compact;

CREATE INDEX `fk_ProteinDrugBank_Protein1` ON `ProteinDrugBankTemp` (`Protein_WID` ASC) ;

CREATE INDEX `pk_Id` ON `ProteinDrugBankTemp` (`Id` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_Protein` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathway_has_Protein` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGPathway_WID`, `Protein_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathway_has_Protein_Protein1_idx` ON `KEGGPathway_has_Protein` (`Protein_WID` ASC) ;

CREATE INDEX `fk_KEGGPathway_has_Protein_KEGGPathway1_idx` ON `KEGGPathway_has_Protein` (`KEGGPathway_WID` ASC) ;


-- -----------------------------------------------------
-- Table `KEGGPathway_has_GeneInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `KEGGPathway_has_GeneInfo` ;

CREATE  TABLE IF NOT EXISTS `KEGGPathway_has_GeneInfo` (
  `KEGGPathway_WID` BIGINT NOT NULL ,
  `GeneInfo_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`KEGGPathway_WID`, `GeneInfo_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_KEGGPathway_has_GeneInfo_GeneInfo1_idx` ON `KEGGPathway_has_GeneInfo` (`GeneInfo_WID` ASC) ;

CREATE INDEX `fk_KEGGPathway_has_GeneInfo_KEGGPathway1_idx` ON `KEGGPathway_has_GeneInfo` (`KEGGPathway_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMGeneMapTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMapTemp` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMapTemp` (
  `Number` VARCHAR(10) NULL DEFAULT NULL ,
  `Month` VARCHAR(5) NULL DEFAULT NULL ,
  `Day` VARCHAR(5) NULL DEFAULT NULL ,
  `Year` VARCHAR(5) NULL DEFAULT NULL ,
  `CytogLoc` VARCHAR(25) NULL DEFAULT NULL ,
  `GeneSymbol` VARCHAR(100) NULL DEFAULT NULL ,
  `GeneStatus` VARCHAR(5) NULL DEFAULT NULL ,
  `Title` VARCHAR(255) NULL DEFAULT NULL ,
  `TitleCont` VARCHAR(255) NULL DEFAULT NULL ,
  `MIMNumber` BIGINT NULL DEFAULT NULL ,
  `Method` VARCHAR(100) NULL DEFAULT NULL ,
  `Comments` VARCHAR(255) NULL DEFAULT NULL ,
  `CommentsCont` VARCHAR(255) NULL DEFAULT NULL ,
  `Disorders` TEXT NULL DEFAULT NULL ,
  `DisordersCont1` TEXT NULL DEFAULT NULL ,
  `DisordersCont2` TEXT NULL DEFAULT NULL ,
  `MouseCorr` VARCHAR(25) NULL DEFAULT NULL ,
  `Reference` VARCHAR(100) NULL DEFAULT NULL )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_GeneSymbol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_GeneSymbol` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMap_has_GeneSymbol` (
  `OMIMGeneMap_WID` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`GeneSymbol`, `OMIMGeneMap_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMGeneMap_has_GeneSymbol_OMIMGeneMap1` ON `OMIMGeneMap_has_GeneSymbol` (`OMIMGeneMap_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMethod` ;

CREATE  TABLE IF NOT EXISTS `OMIMMethod` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Method` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Method` ON `OMIMMethod` (`Method` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_OMIMMethod`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_OMIMMethod` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMap_has_OMIMMethod` (
  `OMIMGeneMap_WID` BIGINT NOT NULL ,
  `OMIMMethod_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`OMIMGeneMap_WID`, `OMIMMethod_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMMethod1_idx` ON `OMIMGeneMap_has_OMIMMethod` (`OMIMMethod_WID` ASC) ;

CREATE INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMGeneMap1` ON `OMIMGeneMap_has_OMIMMethod` (`OMIMGeneMap_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_OMIMMorbidMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_OMIMMorbidMap` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMap_has_OMIMMorbidMap` (
  `OMIMGeneMap_WID` BIGINT NOT NULL ,
  `OMIMMorbidMap_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`OMIMGeneMap_WID`, `OMIMMorbidMap_WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMGeneMap_has_OMIMMorbidMap_OMIMMorbidMap1` ON `OMIMGeneMap_has_OMIMMorbidMap` (`OMIMMorbidMap_WID` ASC) ;

CREATE INDEX `fk_OMIMGeneMap_has_OMIMMorbidMap_OMIMGeneMap1` ON `OMIMGeneMap_has_OMIMMorbidMap` (`OMIMGeneMap_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMGeneMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMap` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `Number` VARCHAR(10) NOT NULL ,
  `Month` VARCHAR(5) NULL DEFAULT NULL ,
  `Day` VARCHAR(5) NULL DEFAULT NULL ,
  `Year` VARCHAR(5) NULL DEFAULT NULL ,
  `CytogLoc` VARCHAR(25) NULL DEFAULT NULL ,
  `GeneStatus` VARCHAR(5) NULL DEFAULT NULL ,
  `Title` TEXT NULL DEFAULT NULL ,
  `MIMNumber` BIGINT NULL DEFAULT NULL ,
  `Comments` TEXT NULL DEFAULT NULL ,
  `MouseCorr` VARCHAR(25) NULL DEFAULT NULL ,
  `Reference` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_Number` ON `OMIMGeneMap` (`Number` ASC) ;

CREATE INDEX `pk_MIMNumber` ON `OMIMGeneMap` (`MIMNumber` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap_has_GeneSymbol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap_has_GeneSymbol` ;

CREATE  TABLE IF NOT EXISTS `OMIMMorbidMap_has_GeneSymbol` (
  `OMIMMorbidMap_WID` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`OMIMMorbidMap_WID`, `GeneSymbol`) )
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap` ;

CREATE  TABLE IF NOT EXISTS `OMIMMorbidMap` (
  `WID` BIGINT NOT NULL AUTO_INCREMENT ,
  `OMIM_ID` BIGINT NULL DEFAULT NULL ,
  `Disorder` VARCHAR(100) NOT NULL ,
  `MIMNumber` BIGINT NULL DEFAULT NULL ,
  `CytogLog` VARCHAR(25) NULL DEFAULT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_OMIM_ID` ON `OMIMMorbidMap` (`OMIM_ID` ASC) ;

CREATE INDEX `pk_Disorder` ON `OMIMMorbidMap` (`Disorder` ASC) ;

CREATE INDEX `pk_MIMNumber` ON `OMIMMorbidMap` (`MIMNumber` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMGeneMap_has_GeneSymbolTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMGeneMap_has_GeneSymbolTemp` ;

CREATE  TABLE IF NOT EXISTS `OMIMGeneMap_has_GeneSymbolTemp` (
  `OMIMGeneMap_WID` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMGeneMap_has_GeneSymbol_OMIMGeneMap1` ON `OMIMGeneMap_has_GeneSymbolTemp` (`OMIMGeneMap_WID` ASC) ;

CREATE INDEX `pk_GeneSymbol` ON `OMIMGeneMap_has_GeneSymbolTemp` (`GeneSymbol` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMMethodTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMethodTemp` ;

CREATE  TABLE IF NOT EXISTS `OMIMMethodTemp` (
  `WID` BIGINT NOT NULL ,
  `Method` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `pk_WID` ON `OMIMMethodTemp` (`WID` ASC) ;

CREATE INDEX `pk_Method` ON `OMIMMethodTemp` (`Method` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMMorbidMap_has_GeneSymbolTemp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMMorbidMap_has_GeneSymbolTemp` ;

CREATE  TABLE IF NOT EXISTS `OMIMMorbidMap_has_GeneSymbolTemp` (
  `OMIMMorbidMap_WID` BIGINT NOT NULL ,
  `GeneSymbol` VARCHAR(25) NOT NULL )
ENGINE = MyISAM;

CREATE INDEX `pk_OMIMMorbidMap` ON `OMIMMorbidMap_has_GeneSymbolTemp` (`OMIMMorbidMap_WID` ASC) ;

CREATE INDEX `pk_GeneSymbol` ON `OMIMMorbidMap_has_GeneSymbolTemp` (`GeneSymbol` ASC) ;


-- -----------------------------------------------------
-- Table `OMIM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIM` ;

CREATE  TABLE IF NOT EXISTS `OMIM` (
  `WID` BIGINT NOT NULL ,
  `OMIM_ID` BIGINT NOT NULL ,
  `TX` TEXT NULL ,
  `DataSet_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `pk_OMIM_ID` ON `OMIM` (`OMIM_ID` ASC) ;

CREATE INDEX `fk_OMIM_DataSet1_idx` ON `OMIM` (`DataSet_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMTI`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMTI` ;

CREATE  TABLE IF NOT EXISTS `OMIMTI` (
  `OMIM_WID` BIGINT NOT NULL ,
  `TI` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`OMIM_WID`, `TI`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMTitle_OMIM1_idx` ON `OMIMTI` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMTX`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMTX` ;

CREATE  TABLE IF NOT EXISTS `OMIMTX` (
  `OMIM_WID` BIGINT NOT NULL ,
  `Tag` VARCHAR(100) NOT NULL ,
  `TX` TEXT(50000) NOT NULL ,
  PRIMARY KEY (`OMIM_WID`, `Tag`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMTX_OMIM1_idx` ON `OMIMTX` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMRF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMRF` ;

CREATE  TABLE IF NOT EXISTS `OMIMRF` (
  `WID` BIGINT NOT NULL ,
  `OMIM_WID` BIGINT NOT NULL ,
  `Reference` TEXT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMRF_OMIM1_idx` ON `OMIMRF` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMCS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCS` ;

CREATE  TABLE IF NOT EXISTS `OMIMCS` (
  `WID` BIGINT NOT NULL ,
  `OMIM_WID` BIGINT NOT NULL ,
  `CS` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMCS_OMIM1_idx` ON `OMIMCS` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMCSData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCSData` ;

CREATE  TABLE IF NOT EXISTS `OMIMCSData` (
  `WID` BIGINT NOT NULL ,
  `OMIMCS_WID` BIGINT NOT NULL ,
  `Data` TEXT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMCSData_OMIMCS1_idx` ON `OMIMCSData` (`OMIMCS_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMCD`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCD` ;

CREATE  TABLE IF NOT EXISTS `OMIMCD` (
  `OMIM_WID` BIGINT NOT NULL ,
  `CD` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`OMIM_WID`, `CD`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMICD_OMIM1_idx` ON `OMIMCD` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMED`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMED` ;

CREATE  TABLE IF NOT EXISTS `OMIMED` (
  `OMIM_WID` BIGINT NOT NULL ,
  `ED` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`OMIM_WID`, `ED`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMED_OMIM1_idx` ON `OMIMED` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMAV`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMAV` ;

CREATE  TABLE IF NOT EXISTS `OMIMAV` (
  `WID` BIGINT NOT NULL ,
  `OMIM_WID` BIGINT NOT NULL ,
  `AV` TEXT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMAV_OMIM1_idx` ON `OMIMAV` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMCN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMCN` ;

CREATE  TABLE IF NOT EXISTS `OMIMCN` (
  `OMIM_WID` BIGINT NOT NULL ,
  `CN` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`OMIM_WID`, `CN`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMCN_OMIM1_idx` ON `OMIMCN` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `OMIMSA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OMIMSA` ;

CREATE  TABLE IF NOT EXISTS `OMIMSA` (
  `WID` BIGINT NOT NULL ,
  `OMIM_WID` BIGINT NOT NULL ,
  `SA` TEXT NOT NULL ,
  PRIMARY KEY (`WID`) )
ENGINE = MyISAM;

CREATE INDEX `fk_OMIMSA_OMIM1_idx` ON `OMIMSA` (`OMIM_WID` ASC) ;


-- -----------------------------------------------------
-- Table `GeneInfo_has_OMIM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneInfo_has_OMIM` ;

CREATE  TABLE IF NOT EXISTS `GeneInfo_has_OMIM` (
  `GeneInfo_WID` BIGINT NOT NULL ,
  `OMIM_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`GeneInfo_WID`, `OMIM_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_GeneInfo_has_OMIM_OMIM1_idx` ON `GeneInfo_has_OMIM` (`OMIM_WID` ASC) ;

CREATE INDEX `fk_GeneInfo_has_OMIM_GeneInfo1_idx` ON `GeneInfo_has_OMIM` (`GeneInfo_WID` ASC) ;


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

CREATE INDEX `fk_GeneInfo_has_GenomesPTT_GenomesPTT1_idx` ON `GeneInfo_has_GenomesPTT` (`GenomesPTT_ProteinGi` ASC) ;

CREATE INDEX `fk_GeneInfo_has_GenomesPTT_GeneInfo1_idx` ON `GeneInfo_has_GenomesPTT` (`GeneInfo_WID` ASC) ;


-- -----------------------------------------------------
-- Table `UniRefEntry_has_Protein`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UniRefEntry_has_Protein` ;

CREATE  TABLE IF NOT EXISTS `UniRefEntry_has_Protein` (
  `UniRefEntry_WID` BIGINT NOT NULL ,
  `Protein_WID` BIGINT NOT NULL ,
  PRIMARY KEY (`UniRefEntry_WID`, `Protein_WID`) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE INDEX `fk_UniRefEntry_has_Protein_Protein1_idx` ON `UniRefEntry_has_Protein` (`Protein_WID` ASC) ;

CREATE INDEX `fk_UniRefEntry_has_Protein_UniRefEntry1_idx` ON `UniRefEntry_has_Protein` (`UniRefEntry_WID` ASC) ;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
