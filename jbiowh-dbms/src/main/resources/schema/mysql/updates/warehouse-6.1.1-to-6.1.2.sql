SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 6.1.1 to 6.1.2
-- -----------------------------------------------------

ALTER TABLE `ProteinTaxId` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBank` 
CHANGE COLUMN `Id` `Id` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Description` `Description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `Indication` `Indication` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `DrugBankGeneralRef` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankSecondAccessionNumber` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankGroup` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTaxonomySubstructure` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankSynonym` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankBrand` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankMixture` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPackager` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankManufacturer` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPrice` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCategory` 
CHANGE COLUMN `Category` `Category` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `DrugBankCategoriesTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBank_has_DrugBankCategory` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankAffectedOrganism` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDosage` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankATCCode` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankAHFSCode` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPatent` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankPatentsTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBank_has_DrugBankPatent` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankFoodInteraction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDrugInteraction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankProteinSequence` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCalculatedProperty` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExperimentalProperty` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExternalIdentifier` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankExternalLink` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTarget` 
COLLATE = utf8_bin ,
DROP COLUMN `Position`,
DROP COLUMN `Partner`,
ADD COLUMN `Id` VARCHAR(25) NOT NULL AFTER `DrugBank_WID`,
ADD COLUMN `Name` VARCHAR(255) NULL DEFAULT NULL AFTER `Id`,
ADD INDEX `id_index` (`Id` ASC),
DROP INDEX `pk_Partner` ;

ALTER TABLE `DrugBankTargetRef` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTargetAction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankEnzyme` 
COLLATE = utf8_bin ,
DROP COLUMN `Position`,
DROP COLUMN `Partner`,
ADD COLUMN `Id` VARCHAR(25) NOT NULL AFTER `DrugBank_WID`,
ADD COLUMN `Name` VARCHAR(255) NULL DEFAULT NULL AFTER `Id`,
DROP INDEX `pk_Partner` ,
ADD INDEX `pk_Partner` (`Id` ASC);

ALTER TABLE `DrugBankEnzymeRef` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankEnzymeAction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTransporter` 
COLLATE = utf8_bin ,
DROP COLUMN `Position`,
DROP COLUMN `Partner`,
ADD COLUMN `Id` VARCHAR(25) NOT NULL AFTER `DrugBank_WID`,
ADD COLUMN `Name` VARCHAR(255) NULL DEFAULT NULL AFTER `Id`,
DROP INDEX `pk_Partner` ,
ADD INDEX `pk_Partner` (`Id` ASC);

ALTER TABLE `DrugBankTransporterRef` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTransporterAction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCarrier` 
COLLATE = utf8_bin ,
DROP COLUMN `Position`,
DROP COLUMN `Partner`,
ADD COLUMN `Id` VARCHAR(25) NULL DEFAULT NULL AFTER `DrugBank_WID`,
ADD COLUMN `Name` VARCHAR(255) NULL DEFAULT NULL AFTER `Id`,
DROP INDEX `pk_Partner` ;

ALTER TABLE `DrugBankCarrierRef` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankCarrierAction` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankTaxonomy` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionRPair` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymePathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeClass` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeAllReac` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeClassTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGEnzymeClass` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeSysName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeCofactor` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeGenes` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeInhibitor` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzymeEffector` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Product` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Substrate` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Cofactor` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompoundDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReactionSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycan` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Product` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Substrate` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanClassTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanClass` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycan_has_KEGGGlycanClass` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Effector` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPair` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPair_has_KEGGCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairRelatedPair` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairRelatedPairTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGRPairReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGene` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGenePathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDisease` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGeneDrugTarget` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntry` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayRelation` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReactionSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayReactionProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryGraphic` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryGene` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGEnzyme_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGReaction_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGene_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayEntryReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_Taxonomy` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathwayRelationSubType` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGGlycanName` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGCompound_has_DrugBank` 
COLLATE = utf8_bin ;

ALTER TABLE `DrugBankDrugInteractionsTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `ProteinGeneTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `ProteinPFAMTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_Protein` 
COLLATE = utf8_bin ;

ALTER TABLE `KEGGPathway_has_GeneInfo` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMapTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_GeneSymbol` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMMethod` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_OMIMMethod` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap_has_GeneSymbol` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_OMIMMorbidMap` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMGeneMap_has_GeneSymbolTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMMethodTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMMorbidMap_has_GeneSymbolTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIM` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMTI` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMTX` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMRF` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMCS` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMCSData` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMCD` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMED` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMAV` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMCN` 
COLLATE = utf8_bin ;

ALTER TABLE `OMIMSA` 
COLLATE = utf8_bin ;

ALTER TABLE `PfamSeq_has_UniProtId` 
COLLATE = utf8_bin ;

ALTER TABLE `PfamSeq_has_Protein` 
COLLATE = utf8_bin ;

ALTER TABLE `PIRSF` 
CHANGE COLUMN `CurationStatus` `CurationStatus` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `PIRSFProtein` 
COLLATE = utf8_bin ;

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

ALTER TABLE `ProtClustProteins` 
CHANGE COLUMN `GeneGi` `GeneGi` BIGINT(20) NULL DEFAULT NULL ,
CHANGE COLUMN `ProteinGi` `ProteinGi` BIGINT(20) NULL DEFAULT NULL ;

CREATE TABLE IF NOT EXISTS `DrugBankTargetPolypeptide` (
  `DrugBankTarget_WID` BIGINT(20) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Source` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_DrugBankTargetPolypeptide_DrugBankTarget1_idx` (`DrugBankTarget_WID` ASC),
  INDEX `id_index` (`Id` ASC),
  INDEX `externalId_index` (`Source` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `DrugBankEnzymePolypeptide` (
  `DrugBankEnzyme_WID` BIGINT(20) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Source` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `fk_DrugBankEnzymePolypeptide_DrugBankEnzyme1_idx` (`DrugBankEnzyme_WID` ASC),
  INDEX `id_index` (`Id` ASC),
  INDEX `externalId_index` (`Source` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `DrugBankTransporterPolypeptide` (
  `DrugBankTransporter_WID` BIGINT(20) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Source` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `id_index` (`Id` ASC),
  INDEX `externalId_index` (`Source` ASC),
  INDEX `fk_DrugBankTransporterPolypeptide_DrugBankTransporter1_idx` (`DrugBankTransporter_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

CREATE TABLE IF NOT EXISTS `DrugBankCarrierPolypeptide` (
  `DrugBankCarrier_WID` BIGINT(20) NOT NULL,
  `Id` VARCHAR(25) NOT NULL,
  `Name` VARCHAR(255) NULL DEFAULT NULL,
  `Source` VARCHAR(45) NULL DEFAULT NULL,
  INDEX `id_index` (`Id` ASC),
  INDEX `externalId_index` (`Source` ASC),
  INDEX `fk_DrugBankCarrierPolypeptide_DrugBankCarrier1_idx` (`DrugBankCarrier_WID` ASC))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

DROP TABLE IF EXISTS `DrugBankPartners` ;

DROP TABLE IF EXISTS `DrugBankPartnerSynonyms` ;

DROP TABLE IF EXISTS `DrugBankPartnerRef` ;

DROP TABLE IF EXISTS `DrugBankPartnerPFam` ;

DROP TABLE IF EXISTS `DrugBankPartnerExternalIdentifiers` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
