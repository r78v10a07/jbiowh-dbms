SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

ALTER SCHEMA `biowh`  DEFAULT COLLATE utf8_bin ;

ALTER TABLE `biowh`.`ProteinTaxId` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBank` 
DROP COLUMN `Version`,
DROP COLUMN `Biotransformation`,
CHANGE COLUMN `Id` `Id` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Description` `Description` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ,
CHANGE COLUMN `Indication` `Indication` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`DrugBankGeneralRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankSecondAccessionNumber` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankGroup` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTaxonomySubstructure` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankSynonym` 
COLLATE = utf8_bin ,
ADD COLUMN `Language` VARCHAR(100) NULL DEFAULT NULL AFTER `Synonym`,
ADD COLUMN `Coder` VARCHAR(45) NULL DEFAULT NULL AFTER `Language`;

ALTER TABLE `biowh`.`DrugBankBrand` 
COLLATE = utf8_bin ,
ADD COLUMN `Company` VARCHAR(100) NULL DEFAULT NULL AFTER `Brand`;

ALTER TABLE `biowh`.`DrugBankMixture` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPackager` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankManufacturer` 
COLLATE = utf8_bin ,
CHANGE COLUMN `Generic` `Generic` TINYINT(1) NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`DrugBankPrice` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankCategory` 
CHANGE COLUMN `Category` `Category` VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`DrugBankCategoriesTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBank_has_DrugBankCategory` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankAffectedOrganism` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankDosage` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankATCCode` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankAHFSCode` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPatent` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPatentsTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBank_has_DrugBankPatent` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankFoodInteraction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankDrugInteraction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankProteinSequence` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankCalculatedProperty` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankExperimentalProperty` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankExternalIdentifier` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankExternalLink` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTarget` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTargetRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTargetAction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankEnzymeRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankEnzymeAction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTransporter` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTransporterRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTransporterAction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankCarrier` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankCarrierRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankCarrierAction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPartners` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPartnerRef` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPartnerExternalIdentifiers` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPartnerSynonyms` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankPartnerPFam` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankTaxonomy` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionRPair` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymePathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeClass` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeAllReac` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeClassTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme_has_KEGGEnzymeClass` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeSysName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeCofactor` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeGenes` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeInhibitor` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzymeEffector` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompoundName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompoundReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompoundEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompoundPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGCompound_as_Product` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGCompound_as_Substrate` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme_has_KEGGCompound_as_Cofactor` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme_has_KEGGCompound_as_Inhibitor` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompoundDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReactionSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycan` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGGlycan_as_Product` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGGlycan_as_Substrate` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanClassTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanClass` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycan_has_KEGGGlycanClass` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme_has_KEGGCompound_as_Effector` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPair` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPairCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPair_has_KEGGCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPairRelatedPair` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPairRelatedPairTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPairEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGRPairReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGene` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGeneName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGeneOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGenePathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGeneDBLink` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGeneDisease` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGeneDrugTarget` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntry` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayRelation` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayReactionSubstrate` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayReactionProduct` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryGraphic` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryEnzyme` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryCompound` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryGene` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryOrthology` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGEnzyme_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompound_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGReaction_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGene_has_KEGGPathway` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayEntryReaction` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathway_has_Taxonomy` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathwayRelationSubType` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGGlycanName` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGCompound_has_DrugBank` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`DrugBankDrugInteractionsTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`ProteinGeneTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`ProteinPFAMTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathway_has_Protein` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`KEGGPathway_has_GeneInfo` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMapTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMap` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMap_has_GeneSymbol` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMMethod` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMap_has_OMIMMethod` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMMorbidMap` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMMorbidMap_has_GeneSymbol` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMap_has_OMIMMorbidMap` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMGeneMap_has_GeneSymbolTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMMethodTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMMorbidMap_has_GeneSymbolTemp` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIM` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMTI` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMTX` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMRF` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMCS` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMCSData` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMCD` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMED` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMAV` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMCN` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`OMIMSA` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`PfamSeq_has_UniProtId` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`PfamSeq_has_Protein` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`PIRSF` 
CHANGE COLUMN `CurationStatus` `CurationStatus` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`PIRSFProtein` 
COLLATE = utf8_bin ;

ALTER TABLE `biowh`.`COGFuncClassGroup` 
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ;

ALTER TABLE `biowh`.`COGFuncClass` 
CHANGE COLUMN `Letter` `Letter` CHAR CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `Name` `Name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ;

ALTER TABLE `biowh`.`COGOrthologousGroup` 
CHANGE COLUMN `Id` `Id` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL ,
CHANGE COLUMN `GroupFunction` `GroupFunction` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`GeneBankCDSLocation` 
CHANGE COLUMN `pTo` `pTo` INT(11) NULL DEFAULT NULL ;

ALTER TABLE `biowh`.`ProtClustProteins` 
CHANGE COLUMN `GeneGi` `GeneGi` BIGINT(20) NULL DEFAULT NULL ,
CHANGE COLUMN `ProteinGi` `ProteinGi` BIGINT(20) NULL DEFAULT NULL ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
