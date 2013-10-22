SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Use this SQL script to update an existing JBioWH DB
-- from version 2.0.3 to 2.0.7
-- -----------------------------------------------------

ALTER TABLE `Taxonomy` 
ADD INDEX `fk_Taxonomy_DataSet_idx` (`DataSetWID` ASC) 
, ADD INDEX `fk_Taxonomy_TaxonomyDivision1_idx` (`TaxonomyDivision_WID` ASC) 
, ADD INDEX `fk_Taxonomy_TaxonomyGenCode1_idx` (`TaxonomyGenCode_WID` ASC) 
, ADD INDEX `fk_Taxonomy_TaxonomyGenCode2_idx` (`TaxonomyMCGenCode_WID` ASC) 
, DROP INDEX `fk_Taxonomy_TaxonomyGenCode2` 
, DROP INDEX `fk_Taxonomy_TaxonomyGenCode1` 
, DROP INDEX `fk_Taxonomy_TaxonomyDivision1` 
, DROP INDEX `fk_Taxonomy_DataSet` ;

ALTER TABLE `TaxonomySynonym` 
ADD INDEX `fk_TaxonomySynonym_TaxonomySynonymNameClass1_idx` (`TaxonomySynonymNameClass_WID` ASC) 
, DROP INDEX `fk_TaxonomySynonym_TaxonomySynonymNameClass1` ;

ALTER TABLE `TaxonomyPMID` 
ADD INDEX `fk_TaxonomyPMID_Taxonomy1_idx` (`Taxonomy_WID` ASC) 
, DROP INDEX `fk_TaxonomyPMID_Taxonomy1` ;

ALTER TABLE `Taxonomy_has_TaxonomyUnParseCitation` 
ADD INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_TaxonomyUnParseCita_idx` (`TaxonomyUnParseCitation_WID` ASC) 
, ADD INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_Taxonomy1_idx` (`Taxonomy_WID` ASC) 
, DROP INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_Taxonomy1` 
, DROP INDEX `fk_Taxonomy_has_TaxonomyUnParseCitation_TaxonomyUnParseCitati1` ;

ALTER TABLE `Ontology` 
ADD INDEX `fk_Ontology_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_Ontology_DataSet` ;

ALTER TABLE `OntologyAlternativeId` 
ADD INDEX `fk_OntologyAlternativeId_Ontology1_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_OntologyAlternativeId_Ontology1` ;

ALTER TABLE `OntologyRelation` 
ADD INDEX `fk_OntologyRelation_Ontology2_idx` (`OtherOntology_WID` ASC) 
, DROP INDEX `fk_OntologyRelation_Ontology2` ;

ALTER TABLE `OntologyToConsider` 
ADD INDEX `fk_OntologyToConsider_Ontology2_idx` (`ToConsiderOntology_WID` ASC) 
, DROP INDEX `fk_OntologyToConsider_Ontology2` ;

ALTER TABLE `OntologyPMID` 
ADD INDEX `fk_OntologyPMID_Ontology1_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_OntologyPMID_Ontology1` ;

ALTER TABLE `Ontology_has_OntologySubset` 
ADD INDEX `fk_Ontology_has_OntologySubset_OntologySubset1_idx` (`OntologySubset_WID` ASC) 
, ADD INDEX `fk_Ontology_has_OntologySubset_Ontology1_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_Ontology_has_OntologySubset_Ontology1` 
, DROP INDEX `fk_Ontology_has_OntologySubset_OntologySubset1` ;

ALTER TABLE `Ontology_has_OntologyXRef` 
ADD INDEX `fk_Ontology_has_OntologyXRef_OntologyXRef1_idx` (`OntologyXRef_WID` ASC) 
, ADD INDEX `fk_Ontology_has_OntologyXRef_Ontology1_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_Ontology_has_OntologyXRef_Ontology1` 
, DROP INDEX `fk_Ontology_has_OntologyXRef_OntologyXRef1` ;

ALTER TABLE `Ontology_has_OntologySynonym` 
ADD INDEX `fk_Ontology_has_OntologySynonym_OntologySynonym1_idx` (`OntologySynonym_WID` ASC) 
, ADD INDEX `fk_Ontology_has_OntologySynonym_Ontology1_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_Ontology_has_OntologySynonym_Ontology1` 
, DROP INDEX `fk_Ontology_has_OntologySynonym_OntologySynonym1` ;

ALTER TABLE `GeneInfo` 
ADD INDEX `fk_GeneInfo_DataSet_idx` (`DataSetWID` ASC) 
, ADD INDEX `fk_GeneInfo_Taxonomy_idx` (`TaxID` ASC) 
, DROP INDEX `fk_GeneInfo_Taxonomy` 
, DROP INDEX `fk_GeneInfo_DataSet` ;

ALTER TABLE `GeneInfoSynonyms` 
ADD INDEX `fk_GeneInfoSynonyms_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneInfoSynonyms_GeneInfo1` ;

ALTER TABLE `GeneInfoDBXrefs` 
ADD INDEX `fk_GeneInfoDBXrefs_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneInfoDBXrefs_GeneInfo1` ;

ALTER TABLE `Gene2Accession` CHANGE COLUMN `ProteinGi` `ProteinGi` BIGINT(20) NULL DEFAULT 0  
, ADD INDEX `fk_Gene2Accession_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2Accession_GeneInfo1` ;

ALTER TABLE `Gene2Ensembl` 
ADD INDEX `fk_Gene2Ensembl_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2Ensembl_GeneInfo1` ;

ALTER TABLE `Gene2GO` 
ADD INDEX `fk_Gene2GO_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2GO_GeneInfo1` ;

ALTER TABLE `Gene2PMID` 
ADD INDEX `fk_Gene2PMID_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2PMID_GeneInfo1` ;

ALTER TABLE `Gene2STS` 
ADD INDEX `fk_Gene2STS_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2STS_GeneInfo1` ;

ALTER TABLE `Gene2UniGene` 
ADD INDEX `fk_Gene2UniGene_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Gene2UniGene_GeneInfo1` ;

ALTER TABLE `GeneGroup` 
ADD INDEX `fk_GeneGroup_GeneInfo2_idx` (`OtherGeneInfo_WID` ASC) 
, ADD INDEX `fk_GeneGroup_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneGroup_GeneInfo1` 
, DROP INDEX `fk_GeneGroup_GeneInfo2` ;

ALTER TABLE `GeneHistory` 
ADD INDEX `fk_GeneHistory_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_GeneHistory_DataSet` ;

ALTER TABLE `GenomesPTTTaxonomy` 
ADD INDEX `fk_GenomesPPTTaxonomy_Taxonomy_idx` (`TaxId` ASC) 
, DROP INDEX `fk_GenomesPPTTaxonomy_Taxonomy` ;

ALTER TABLE `GenomesPTT` 
ADD INDEX `fk_GenomesPTT_Gene2Accession_idx` (`ProteinGi` ASC) 
, ADD INDEX `fk_GenomesPTT_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_GenomesPTT_DataSet` 
, DROP INDEX `fk_GenomesPTT_Gene2Accession` ;

ALTER TABLE `Protein` 
ADD INDEX `fk_Protein_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_Protein_DataSet` ;

ALTER TABLE `ProteinName` 
ADD INDEX `fk_ProteinName_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinName_Protein1` ;

ALTER TABLE `ProteinAccessionNumber` 
ADD INDEX `fk_ProteinAccessionNumber_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinAccessionNumber_Protein1` ;

ALTER TABLE `ProteinLongName` 
ADD INDEX `fk_ProteinLongName_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinLongName_Protein1` ;

ALTER TABLE `ProteinGeneName` 
ADD INDEX `fk_ProteinGeneName_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinGeneName_Protein1` ;

ALTER TABLE `ProteinDBReference` 
ADD INDEX `fk_ProteinDBReference_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinDBReference_Protein1` ;

ALTER TABLE `ProteinRefSeq` 
ADD INDEX `fk_ProteinRefSeq_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinRefSeq_Protein1` ;

ALTER TABLE `ProteinPMID` 
ADD INDEX `fk_ProteinPMID_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinPMID_Protein1` ;

ALTER TABLE `ProteinKEGG` 
ADD INDEX `fk_ProteinKEGG_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinKEGG_Protein1` ;

ALTER TABLE `ProteinEC` 
ADD INDEX `fk_ProteinEC_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinEC_Protein1` ;

ALTER TABLE `ProteinBioCyc` 
ADD INDEX `fk_ProteinBioCyc_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinBioCyc_Protein1` ;

ALTER TABLE `ProteinPDB` 
ADD INDEX `fk_ProteinPDB_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinPDB_Protein1` ;

ALTER TABLE `ProteinIntAct` 
ADD INDEX `fk_ProteinIntAct_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinIntAct_Protein1` ;

ALTER TABLE `ProteinDIP` 
ADD INDEX `fk_ProteinDIP_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinDIP_Protein1` ;

ALTER TABLE `ProteinMINT` 
ADD INDEX `fk_ProteinMINT_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinMINT_Protein1` ;

ALTER TABLE `ProteinDrugBank` 
ADD INDEX `fk_ProteinDrugBank_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinDrugBank_Protein1` ;

ALTER TABLE `ProteinDBReferenceProperty` 
ADD INDEX `fk_ProteinDBReferenceProperty_ProteinDBReference1_idx` (`ProteinDBReference_WID` ASC) 
, DROP INDEX `fk_ProteinDBReferenceProperty_ProteinDBReference1` ;

ALTER TABLE `ProteinGeneLocation` 
ADD INDEX `fk_ProteinGeneLocation_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinGeneLocation_Protein1` ;

ALTER TABLE `ProteinComment` 
ADD INDEX `fk_ProteinComment_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinComment_Protein1` ;

ALTER TABLE `ProteinOtherLocation` 
ADD INDEX `fk_ProteinOtherLocation_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_ProteinOtherLocation_DataSet` ;

ALTER TABLE `ProteinCommentSubCellularLocation` 
ADD INDEX `fk_ProteinCommentSubCellularLocation_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentSubCellularLocation_ProteinComment1` ;

ALTER TABLE `ProteinCommentConflict` 
ADD INDEX `fk_ProteinCommentConflict_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentConflict_ProteinComment1` ;

ALTER TABLE `ProteinCommentLink` 
ADD INDEX `fk_ProteinCommentLink_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentLink_ProteinComment1` ;

ALTER TABLE `ProteinCommentEvent` 
ADD INDEX `fk_ProteinCommentEvent_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentEvent_ProteinComment1` ;

ALTER TABLE `ProteinCommentIsoform` 
ADD INDEX `fk_ProteinCommentIsoform_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentIsoform_ProteinComment1` ;

ALTER TABLE `ProteinIsoformId` 
ADD INDEX `fk_ProteinIsoformId_ProteinCommentIsoform1_idx` (`ProteinCommentIsoform_WID` ASC) 
, DROP INDEX `fk_ProteinIsoformId_ProteinCommentIsoform1` ;

ALTER TABLE `ProteinIsoformName` 
ADD INDEX `fk_ProteinIsoformName_ProteinCommentIsoform1_idx` (`ProteinCommentIsoform_WID` ASC) 
, DROP INDEX `fk_ProteinIsoformName_ProteinCommentIsoform1` ;

ALTER TABLE `ProteinCommentInteract` 
ADD INDEX `fk_ProteinCommentInteract_ProteinComment1_idx` (`ProteinComment_WID` ASC) 
, DROP INDEX `fk_ProteinCommentInteract_ProteinComment1` ;

ALTER TABLE `ProteinFeature` 
ADD INDEX `fk_ProteinFeature_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinFeature_Protein1` ;

ALTER TABLE `ProteinFeatureVariation` 
ADD INDEX `fk_ProteinFeatureVariation_ProteinFeature1_idx` (`ProteinFeature_WID` ASC) 
, DROP INDEX `fk_ProteinFeatureVariation_ProteinFeature1` ;

ALTER TABLE `Protein_has_ProteinKeyword` 
ADD INDEX `fk_Protein_has_ProteinKeyword_ProteinKeyword1_idx` (`ProteinKeyword_WID` ASC) 
, ADD INDEX `fk_Protein_has_ProteinKeyword_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_ProteinKeyword_Protein1` 
, DROP INDEX `fk_Protein_has_ProteinKeyword_ProteinKeyword1` ;

ALTER TABLE `Protein_has_GeneInfo` 
ADD INDEX `fk_Protein_has_Gene_Protein_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_Protein_has_Gene_Gene_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_Protein_has_Gene_Gene` 
, DROP INDEX `fk_Protein_has_Gene_Protein` ;

ALTER TABLE `Protein_has_Ontology` 
ADD INDEX `fk_Protein_has_Ontology_Protein_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_Protein_has_Ontology_Ontology_idx` (`Ontology_WID` ASC) 
, DROP INDEX `fk_Protein_has_Ontology_Ontology` 
, DROP INDEX `fk_Protein_has_Ontology_Protein` ;

ALTER TABLE `Gene2Accession_has_Protein` 
ADD INDEX `fk_Gene2Accession_has_Protein_Protein1_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_Gene2Accession_has_Protein_Gene2Accession1_idx` (`ProteinGi` ASC) 
, DROP INDEX `fk_Gene2Accession_has_Protein_Gene2Accession1` 
, DROP INDEX `fk_Gene2Accession_has_Protein_Protein1` ;

ALTER TABLE `MIFEntrySetEntry` 
ADD INDEX `fk_MIFEntrySetEntry_MIFEntrySet1_idx` (`MIFEntrySet_WID` ASC) 
, DROP INDEX `fk_MIFEntrySetEntry_MIFEntrySet1` ;

ALTER TABLE `MIFEntrySource` 
ADD INDEX `fk_MIFEntrySource_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC) 
, DROP INDEX `fk_MIFEntrySource_MIFEntrySetEntry1` ;

ALTER TABLE `MIFOtherAlias` 
ADD INDEX `fk_MIFOtherAlias_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherAlias_DataSet` ;

ALTER TABLE `MIFOtherAttribute` 
ADD INDEX `fk_MIFOtherAttribute_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherAttribute_DataSet` ;

ALTER TABLE `MIFOtherBibRef` 
ADD INDEX `fk_MIFOtherBibRef_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherBibRef_DataSet` ;

ALTER TABLE `MIFOtherXRef` 
ADD INDEX `fk_MIFOtherXRef_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherXRef_DataSet` ;

ALTER TABLE `MIFOtherXRefGO` 
ADD INDEX `fk_MIFOtherXRefGO_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherXRefGO_DataSet` ;

ALTER TABLE `MIFOtherXRefPubMed` 
ADD INDEX `fk_MIFOtherXRefPubMed_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherXRefPubMed_DataSet` ;

ALTER TABLE `MIFOtherXRefRefSeq` 
ADD INDEX `fk_MIFOtherXRefRefSeq_DateSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherXRefRefSeq_DateSet` ;

ALTER TABLE `MIFOtherXRefUniprot` 
ADD INDEX `fk_MIFOtherXRefUniprot_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherXRefUniprot_DataSet` ;

ALTER TABLE `MIFOtherAvailability` 
ADD INDEX `fk_MIFOtherAvailability_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherAvailability_DataSet` ;

ALTER TABLE `MIFEntryExperiment` 
ADD INDEX `fk_MIFEntryExperiment_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC) 
, DROP INDEX `fk_MIFEntryExperiment_MIFEntrySetEntry1` ;

ALTER TABLE `MIFOtherBioSourceType` 
ADD INDEX `fk_MIFOtherBioSourceType_DataSet_idx` (`DataSetWID` ASC) 
, ADD INDEX `fk_MIFOtherBioSourceType_Taxonomy_idx` (`TaxId` ASC) 
, DROP INDEX `fk_MIFOtherBioSourceType_Taxonomy` 
, DROP INDEX `fk_MIFOtherBioSourceType_DataSet` ;

ALTER TABLE `MIFBioSourceTypeCellType` 
ADD INDEX `fk_MIFBioSourceTypeCellType_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC) 
, DROP INDEX `fk_MIFBioSourceTypeCellType_MIFOtherBioSourceType1` ;

ALTER TABLE `MIFBioSourceTypeCompartment` 
ADD INDEX `fk_MIFBioSourceTypeCompartment_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC) 
, DROP INDEX `fk_MIFBioSourceTypeCompartment_MIFOtherBioSourceType1` ;

ALTER TABLE `MIFBioSourceTypeTissue` 
ADD INDEX `fk_MIFBioSourceTypeTissue_MIFOtherBioSourceType1_idx` (`MIFOtherBioSourceType_WID` ASC) 
, DROP INDEX `fk_MIFBioSourceTypeTissue_MIFOtherBioSourceType1` ;

ALTER TABLE `MIFExperimentInterDetecMethod` 
ADD INDEX `fk_MIFExperimentInterDetecMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC) 
, DROP INDEX `fk_MIFExperimentInterDetecMethod_MIFEntryExperiment1` ;

ALTER TABLE `MIFExperimentPartIdentMethod` 
ADD INDEX `fk_MIFExperimentPartIdentMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC) 
, DROP INDEX `fk_MIFExperimentPartIdentMethod_MIFEntryExperiment1` ;

ALTER TABLE `MIFExperimentFeatDetecMethod` 
ADD INDEX `fk_MIFExperimentFeatDetecMethod_MIFEntryExperiment1_idx` (`MIFEntryExperiment_WID` ASC) 
, DROP INDEX `fk_MIFExperimentFeatDetecMethod_MIFEntryExperiment1` ;

ALTER TABLE `MIFOtherConfidence` 
ADD INDEX `fk_MIFOtherConfidence_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherConfidence_DataSet` ;

ALTER TABLE `MIFOtherExperimentRef` 
ADD INDEX `fk_MIFOtherExperimentRef_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFOtherExperimentRef_DataSet` ;

ALTER TABLE `MIFEntryInteractor` 
ADD INDEX `fk_MIFEntryInteractor_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC) 
, DROP INDEX `fk_MIFEntryInteractor_MIFEntrySetEntry1` ;

ALTER TABLE `MIFInteractorInteractorType` 
ADD INDEX `fk_MIFInteractorInteractorType_MIFEntryInteractor1_idx` (`MIFEntryInteractor_WID` ASC) 
, DROP INDEX `fk_MIFInteractorInteractorType_MIFEntryInteractor1` ;

ALTER TABLE `MIFEntryInteraction` 
ADD INDEX `fk_MIFEntryInteraction_MIFEntrySetEntry1_idx` (`MIFEntrySetEntry_WID` ASC) 
, DROP INDEX `fk_MIFEntryInteraction_MIFEntrySetEntry1` ;

ALTER TABLE `MIFInteractionParticipant` 
ADD INDEX `fk_MIFInteractionParticipant_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInteractionParticipant_MIFEntryInteraction1` ;

ALTER TABLE `MIFParticipantPartIdentMeth` 
ADD INDEX `fk_MIFParticipantPartIdentMeth_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantPartIdentMeth_MIFInteractionParticipant1` ;

ALTER TABLE `MIFParticipantBiologicalRole` 
ADD INDEX `fk_MIFParticipantBiologicalRole_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantBiologicalRole_MIFInteractionParticipant1` ;

ALTER TABLE `MIFParticipantExperimentalRole` 
ADD INDEX `fk_MIFParticipantExperimentalRole_MIFInteractionParticipant_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantExperimentalRole_MIFInteractionParticipant1` ;

ALTER TABLE `MIFParticipantExperimentalPreparation` 
ADD INDEX `fk_MIFParticipantExperimentalPreparation_MIFInteractionPart_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantExperimentalPreparation_MIFInteractionPartic1` ;

ALTER TABLE `MIFParticipantExperimentalInteractor` 
ADD INDEX `fk_MIFParticipantExperimentalInteractor_MIFInteractionParti_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantExperimentalInteractor_MIFInteractionPartici1` ;

ALTER TABLE `MIFParticipantFeature` 
ADD INDEX `fk_MIFParticipantFeature_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantFeature_MIFInteractionParticipant1` ;

ALTER TABLE `MIFFeatureFeatureType` 
ADD INDEX `fk_MIFFeatureFeatureType_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC) 
, DROP INDEX `fk_MIFFeatureFeatureType_MIFParticipantFeature1` ;

ALTER TABLE `MIFFeatureFeatDetMeth` 
ADD INDEX `fk_MIFFeatureFeatDetMeth_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC) 
, DROP INDEX `fk_MIFFeatureFeatDetMeth_MIFParticipantFeature1` ;

ALTER TABLE `MIFFeatureFeatureRange` 
ADD INDEX `fk_MIFFeatureFeatureRange_MIFParticipantFeature1_idx` (`MIFParticipantFeature_WID` ASC) 
, DROP INDEX `fk_MIFFeatureFeatureRange_MIFParticipantFeature1` ;

ALTER TABLE `MIFParticipantParameter` 
ADD INDEX `fk_MIFParticipantParameter_MIFInteractionParticipant1_idx` (`MIFInteractionParticipant_WID` ASC) 
, DROP INDEX `fk_MIFParticipantParameter_MIFInteractionParticipant1` ;

ALTER TABLE `MIFInteractionInferredInteraction` 
ADD INDEX `fk_MIFInteractionInferredInteraction_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInteractionInferredInteraction_MIFEntryInteraction1` ;

ALTER TABLE `MIFInferredInteractionParticipant` 
ADD INDEX `fk_MIFInferredInteractionParticipant_MIFInteractionInferred_idx` (`MIFInteractionInferredInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInferredInteractionParticipant_MIFInteractionInferredIn1` ;

ALTER TABLE `MIFInteractionInteractionType` 
ADD INDEX `fk_MIFInteractionInteractionType_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInteractionInteractionType_MIFEntryInteraction1` ;

ALTER TABLE `MIFEntrySet` 
ADD INDEX `fk_MIFEntrySet_DataSet_idx` (`DataSetWID` ASC) 
, DROP INDEX `fk_MIFEntrySet_DataSet` ;

ALTER TABLE `Protein_has_Taxonomy` 
ADD INDEX `fk_Protein_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC) 
, ADD INDEX `fk_Protein_has_Taxonomy_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_Taxonomy_Protein1` 
, DROP INDEX `fk_Protein_has_Taxonomy_Taxonomy1` ;

ALTER TABLE `Protein_has_TaxonomyHost` 
ADD INDEX `fk_Protein_has_Taxonomy1_Taxonomy1_idx` (`Taxonomy_WID` ASC) 
, ADD INDEX `fk_Protein_has_Taxonomy1_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_Taxonomy1_Protein1` 
, DROP INDEX `fk_Protein_has_Taxonomy1_Taxonomy1` ;

ALTER TABLE `ProteinPFAM` 
ADD INDEX `fk_ProteinPFAM_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinPFAM_Protein1` ;

ALTER TABLE `MIFInteraction_has_Protein` 
ADD INDEX `fk_MIFInteraction_has_Protein_Protein1_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInteraction_has_Protein_MIFEntryInteraction1` 
, DROP INDEX `fk_MIFInteraction_has_Protein_Protein1` ;

ALTER TABLE `MIFInteractionCount` 
ADD INDEX `fk_MIFInteractionCount_MIFEntryInteraction1_idx` (`MIFEntryInteraction_WID` ASC) 
, DROP INDEX `fk_MIFInteractionCount_MIFEntryInteraction1` ;

ALTER TABLE `UniRefEntry` 
ADD INDEX `fk_UniRefEntry_Taxonomy1_idx` (`TaxId` ASC) 
, ADD INDEX `fk_UniRefEntry_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_UniRefEntry_DataSet1` 
, DROP INDEX `fk_UniRefEntry_Taxonomy1` ;

ALTER TABLE `UniRefEntryProperty` 
ADD INDEX `fk_UniRefCommonProperty_UniRefEntry1_idx` (`UniRefEntry_WID` ASC) 
, DROP INDEX `fk_UniRefCommonProperty_UniRefEntry1` ;

ALTER TABLE `UniRefMember` DROP COLUMN `DataSet_WID` 
, ADD INDEX `fk_UniRefMember_UniRefEntry1_idx` (`UniRefEntry_WID` ASC) 
, ADD INDEX `fk_UniRefMember_Taxonomy1_idx` (`TaxId` ASC) 
, ADD INDEX `fk_UniRefMember_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_UniRefMember_DataSet1` 
, DROP INDEX `fk_UniRefMember_Protein1` 
, DROP INDEX `fk_UniRefMember_Taxonomy1` 
, DROP INDEX `fk_UniRefMember_UniRefEntry1` ;

ALTER TABLE `UniRefMemberProperty` 
ADD INDEX `fk_UniRefMemberProperty_UniRefMember1_idx` (`UniRefMember_WID` ASC) 
, DROP INDEX `fk_UniRefMemberProperty_UniRefMember1` ;

ALTER TABLE `UniRefMemberTemp` DROP COLUMN `DataSet_WID` 
, DROP INDEX `fk_UniRefMemberTemp_DataSet1` ;

ALTER TABLE `UniRefMemberTemp1` DROP COLUMN `DataSet_WID` 
, DROP INDEX `fk_UniRefMemberTemp_DataSet1` ;

ALTER TABLE `UniRefMemberTemp2` DROP COLUMN `DataSet_WID` 
, DROP INDEX `fk_UniRefMemberTemp_DataSet1` ;

CREATE  TABLE IF NOT EXISTS `UniRefEntry_has_Protein` (
  `UniRefEntry_WID` BIGINT(20) NOT NULL ,
  `Protein_WID` BIGINT(20) NOT NULL ,
  PRIMARY KEY (`UniRefEntry_WID`, `Protein_WID`) ,
  INDEX `fk_UniRefEntry_has_Protein_Protein1_idx` (`Protein_WID` ASC) ,
  INDEX `fk_UniRefEntry_has_Protein_UniRefEntry1_idx` (`UniRefEntry_WID` ASC) )
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_bin;

ALTER TABLE `UniRefEntry_has_Protein` 
ADD INDEX `fk_UniRefEntry_has_Protein_Protein1_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_UniRefEntry_has_Protein_UniRefEntry1_idx` (`UniRefEntry_WID` ASC) 
, DROP INDEX `fk_UniRefEntry_has_Protein_UniRefEntry1_idx` 
, DROP INDEX `fk_UniRefEntry_has_Protein_Protein1_idx` ;

insert into UniRefEntry_has_Protein (UniRefEntry_WID, Protein_WID) select e.WID,m.Protein_WID from UniRefEntry e 
inner join UniRefMember m on m.UniRefEntry_WID = e.WID;

ALTER TABLE `DrugBank` 
ADD INDEX `fk_DrugBank_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_DrugBank_DataSet1` ;

ALTER TABLE `DrugBankGeneralRef` 
ADD INDEX `fk_DrugBankGeneralRef_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankGeneralRef_DrugBank1` ;

ALTER TABLE `DrugBankSecondAccessionNumbers` 
ADD INDEX `fk_DrugBankSecondAccessionNumbers_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankSecondAccessionNumbers_DrugBank1` ;

ALTER TABLE `DrugBankGroup` 
ADD INDEX `fk_DrugBankGroup_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankGroup_DrugBank1` ;

ALTER TABLE `DrugBankTaxonomySubstructures` 
ADD INDEX `fk_DrugBankTaxonomySubstructures_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankTaxonomySubstructures_DrugBank1` ;

ALTER TABLE `DrugBankSynonyms` 
ADD INDEX `fk_DrugBankSynonyms_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankSynonyms_DrugBank1` ;

ALTER TABLE `DrugBankBrands` 
ADD INDEX `fk_DrugBankBrands_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankBrands_DrugBank1` ;

ALTER TABLE `DrugBankMixtures` 
ADD INDEX `fk_DrugBankMixtures_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankMixtures_DrugBank1` ;

ALTER TABLE `DrugBankPackagers` 
ADD INDEX `fk_DrugBankPackagers_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankPackagers_DrugBank1` ;

ALTER TABLE `DrugBankManufacturers` 
ADD INDEX `fk_DrugBankManufacturers_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankManufacturers_DrugBank1` ;

ALTER TABLE `DrugBankPrices` 
ADD INDEX `fk_DrugBankPrices_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankPrices_DrugBank1` ;

ALTER TABLE `DrugBankCategoriesTemp` 
ADD INDEX `fk_DrugBankCategoriesTemp_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankCategoriesTemp_DrugBank1` ;

ALTER TABLE `DrugBank_has_DrugBankCategories` 
ADD INDEX `fk_DrugBank_has_DrugBankCategories_DrugBankCategories1_idx` (`DrugBankCategories_WID` ASC) 
, ADD INDEX `fk_DrugBank_has_DrugBankCategories_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBank_has_DrugBankCategories_DrugBank1` 
, DROP INDEX `fk_DrugBank_has_DrugBankCategories_DrugBankCategories1` ;

ALTER TABLE `DrugBankAffectedOrganisms` 
ADD INDEX `fk_DrugBankAffectedOrganisms_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankAffectedOrganisms_DrugBank1` ;

ALTER TABLE `DrugBankDosages` 
ADD INDEX `fk_DrugBankDosages_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankDosages_DrugBank1` ;

ALTER TABLE `DrugBankATCCodes` 
ADD INDEX `fk_DrugBankATCCodes_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankATCCodes_DrugBank1` ;

ALTER TABLE `DrugBankAHFSCodes` 
ADD INDEX `fk_DrugBankAHFSCodes_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankAHFSCodes_DrugBank1` ;

ALTER TABLE `DrugBankPatentsTemp` 
ADD INDEX `fk_DrugBankPatentsTemp_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankPatentsTemp_DrugBank1` ;

ALTER TABLE `DrugBank_has_DrugBankPatents` 
ADD INDEX `fk_DrugBank_has_DrugBankPatents_DrugBankPatents1_idx` (`DrugBankPatents_WID` ASC) 
, ADD INDEX `fk_DrugBank_has_DrugBankPatents_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBank_has_DrugBankPatents_DrugBank1` 
, DROP INDEX `fk_DrugBank_has_DrugBankPatents_DrugBankPatents1` ;

ALTER TABLE `DrugBankFoodInteractions` 
ADD INDEX `fk_DrugBankFoodInteractions_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankFoodInteractions_DrugBank1` ;

ALTER TABLE `DrugBankDrugInteractions` 
ADD INDEX `fk_DrugBankDrugInteractions_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankDrugInteractions_DrugBank1` ;

ALTER TABLE `DrugBankProteinSequences` 
ADD INDEX `fk_DrugBankProteinSequences_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankProteinSequences_DrugBank1` ;

ALTER TABLE `DrugBankCalculatedProperties` 
ADD INDEX `fk_DrugBankCalculatedProperties_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankCalculatedProperties_DrugBank1` ;

ALTER TABLE `DrugBankExternalIdentifiers` 
ADD INDEX `fk_DrugBankExternalIdentifiers_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankExternalIdentifiers_DrugBank1` ;

ALTER TABLE `DrugBankExternalLinks` 
ADD INDEX `fk_DrugBankExternalLinks_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankExternalLinks_DrugBank1` ;

ALTER TABLE `DrugBankTargets` 
ADD INDEX `fk_DrugBankTargets_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankTargets_DrugBank1` ;

ALTER TABLE `DrugBankTargetsRef` 
ADD INDEX `fk_DrugBankTargetsRef_DrugBankTargets1_idx` (`DrugBankTargets_WID` ASC) 
, DROP INDEX `fk_DrugBankTargetsRef_DrugBankTargets1` ;

ALTER TABLE `DrugBankTargetsActions` 
ADD INDEX `fk_DrugBankTargetsActions_DrugBankTargets1_idx` (`DrugBankTargets_WID` ASC) 
, DROP INDEX `fk_DrugBankTargetsActions_DrugBankTargets1` ;

ALTER TABLE `DrugBankEnzymesRef` 
ADD INDEX `fk_DrugBankEnzymesRef_DrugBankEnzymes1_idx` (`DrugBankEnzymes_WID` ASC) 
, DROP INDEX `fk_DrugBankEnzymesRef_DrugBankEnzymes1` ;

ALTER TABLE `DrugBankEnzymesActions` 
ADD INDEX `fk_DrugBankEnzymesActions_DrugBankEnzymes1_idx` (`DrugBankEnzymes_WID` ASC) 
, DROP INDEX `fk_DrugBankEnzymesActions_DrugBankEnzymes1` ;

ALTER TABLE `DrugBankTransportersRef` 
ADD INDEX `fk_DrugBankTransportersRef_DrugBankTransporters1_idx` (`DrugBankTransporters_WID` ASC) 
, DROP INDEX `fk_DrugBankTransportersRef_DrugBankTransporters1` ;

ALTER TABLE `DrugBankTransportersActions` 
ADD INDEX `fk_DrugBankTransportersActions_DrugBankTransporters1_idx` (`DrugBankTransporters_WID` ASC) 
, DROP INDEX `fk_DrugBankTransportersActions_DrugBankTransporters1` ;

ALTER TABLE `DrugBankCarriersRef` 
ADD INDEX `fk_DrugBankCarriersRef_DrugBankCarriers1_idx` (`DrugBankCarriers_WID` ASC) 
, DROP INDEX `fk_DrugBankCarriersRef_DrugBankCarriers1` ;

ALTER TABLE `DrugBankCarriersActions` 
ADD INDEX `fk_DrugBankCarriersActions_DrugBankCarriers1_idx` (`DrugBankCarriers_WID` ASC) 
, DROP INDEX `fk_DrugBankCarriersActions_DrugBankCarriers1` ;

ALTER TABLE `DrugBankPartners` 
ADD INDEX `fk_DrugBankPartners_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_DrugBankPartners_DataSet1` ;

ALTER TABLE `Protein_has_DrugBank` 
ADD INDEX `fk_Protein_has_DrugBank_DrugBank1_idx` (`DrugBank_WID` ASC) 
, ADD INDEX `fk_Protein_has_DrugBank_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_DrugBank_Protein1` 
, DROP INDEX `fk_Protein_has_DrugBank_DrugBank1` ;

ALTER TABLE `DrugBankPartnerRef` 
ADD INDEX `fk_DrugBankPartnerRef_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC) 
, DROP INDEX `fk_DrugBankPartnerRef_DrugBankPartners1` ;

ALTER TABLE `DrugBankPartnerExternalIdentifiers` 
ADD INDEX `fk_DrugBankPartnerExternalIdentifiers_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC) 
, DROP INDEX `fk_DrugBankPartnerExternalIdentifiers_DrugBankPartners1` ;

ALTER TABLE `DrugBankPartnerSynonyms` 
ADD INDEX `fk_DrugBankPartnerSynonyms_DrugBankPartners1_idx` (`DrugBankPartners_WID` ASC) 
, DROP INDEX `fk_DrugBankPartnerSynonyms_DrugBankPartners1` ;

ALTER TABLE `DrugBankTaxonomy` 
ADD INDEX `fk_DrugBankTaxonomy_DrugBank1_idx` (`DrugBank_WID` ASC) 
, DROP INDEX `fk_DrugBankTaxonomy_DrugBank1` ;

ALTER TABLE `Protein_has_DrugBankAsEnzyme` 
ADD INDEX `fk_Protein_has_DrugBank1_DrugBank1_idx` (`DrugBank_WID` ASC) 
, ADD INDEX `fk_Protein_has_DrugBank1_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_DrugBank1_Protein1` 
, DROP INDEX `fk_Protein_has_DrugBank1_DrugBank1` ;

ALTER TABLE `Protein_has_DrugBankAsTransporters` 
ADD INDEX `fk_Protein_has_DrugBank1_DrugBank2_idx` (`DrugBank_WID` ASC) 
, ADD INDEX `fk_Protein_has_DrugBank1_Protein2_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_DrugBank1_Protein2` 
, DROP INDEX `fk_Protein_has_DrugBank1_DrugBank2` ;

ALTER TABLE `Protein_has_DrugBankAsCarriers` 
ADD INDEX `fk_Protein_has_DrugBank1_DrugBank3_idx` (`DrugBank_WID` ASC) 
, ADD INDEX `fk_Protein_has_DrugBank1_Protein3_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_DrugBank1_Protein3` 
, DROP INDEX `fk_Protein_has_DrugBank1_DrugBank3` ;

ALTER TABLE `KEGGReaction` 
ADD INDEX `fk_KEGGReaction_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_DataSet1` ;

ALTER TABLE `KEGGEnzyme` 
ADD INDEX `fk_KEGGEnzyme_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_DataSet1` ;

ALTER TABLE `KEGGReactionName` 
ADD INDEX `fk_KEGGReactionName_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionName_KEGGReaction1` ;

ALTER TABLE `KEGGEnzymeName` 
ADD INDEX `fk_KEGGEnzymeName_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeName_KEGGEnzyme1` ;

ALTER TABLE `KEGGReactionOrthology` 
ADD INDEX `fk_KEGReactionOrthology_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGReactionOrthology_KEGGReaction1` ;

ALTER TABLE `KEGGEnzymeOrthology` 
ADD INDEX `fk_KEGGEnzymeOrthology_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeOrthology_KEGGEnzyme1` ;

ALTER TABLE `KEGGReactionRPair` 
ADD INDEX `fk_KEGGReactionRPair_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionRPair_KEGGReaction1` ;

ALTER TABLE `KEGGReactionPathway` 
ADD INDEX `fk_KEGGReactionPathway_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionPathway_KEGGReaction1` ;

ALTER TABLE `KEGGEnzymePathway` 
ADD INDEX `fk_KEGGEnzymePathway_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymePathway_KEGGEnzyme1` ;

ALTER TABLE `KEGGReactionEnzyme` 
ADD INDEX `fk_KEGGReactionEnzyme_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionEnzyme_KEGGReaction1` ;

ALTER TABLE `KEGGReaction_has_KEGGEnzyme` 
ADD INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGReaction1` 
, DROP INDEX `fk_KEGGReaction_has_KEGGEnzyme_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeAllReac` 
ADD INDEX `fk_KEGGEnzymeAllReac_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeAllReac_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzyme_has_KEGGEnzymeClass` 
ADD INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzymeClass1_idx` (`KEGGEnzymeClass_WID` ASC) 
, ADD INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzyme1` 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGEnzymeClass_KEGGEnzymeClass1` ;

ALTER TABLE `KEGGEnzymeReaction` 
ADD INDEX `fk_KEGGEnzymeReaction_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeReaction_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeSubstrate` 
ADD INDEX `fk_KEGGEnzymeSubstrate_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeSubstrate_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeProduct` 
ADD INDEX `fk_KEGGEnzymeProduct_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeProduct_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeCofactor` 
ADD INDEX `fk_KEGGEnzymeCofactor_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeCofactor_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeGenes` 
ADD INDEX `fk_KEGGEnzymeGenes_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeGenes_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeDBLink` 
ADD INDEX `fk_KEGGEnzymeDBLink_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeDBLink_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeInhibitor` 
ADD INDEX `fk_KEGGEnzymeInhibitor_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeInhibitor_KEGGEnzyme1` ;

ALTER TABLE `KEGGEnzymeEffector` 
ADD INDEX `fk_KEGGEnzymeEffector_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzymeEffector_KEGGEnzyme1` ;

ALTER TABLE `KEGGCompound` 
ADD INDEX `fk_KEGGCompound_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGCompound_DataSet1` ;

ALTER TABLE `KEGGCompoundName` 
ADD INDEX `fk_KEGGCompoundName_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompoundName_KEGGCompound1` ;

ALTER TABLE `KEGGCompoundReaction` 
ADD INDEX `fk_KEGGCompoundReaction_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompoundReaction_KEGGCompound1` ;

ALTER TABLE `KEGGCompoundEnzyme` 
ADD INDEX `fk_KEGGCompoundEnzyme_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompoundEnzyme_KEGGCompound1` ;

ALTER TABLE `KEGGCompoundPathway` 
ADD INDEX `fk_KEGGCompoundPathway_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompoundPathway_KEGGCompound1` ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Product` 
ADD INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction1` 
, DROP INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound1` ;

ALTER TABLE `KEGGReaction_has_KEGGCompound_as_Substrate` 
ADD INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound2_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction2_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGReaction2` 
, DROP INDEX `fk_KEGGReaction_has_KEGGCompound_KEGGCompound2` ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Cofactor` 
ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme1` 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound1` ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Inhibitor` 
ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound2_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme2_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme2` 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound2` ;

ALTER TABLE `KEGGCompoundDBLink` 
ADD INDEX `fk_KEGGCompoundDBLink_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompoundDBLink_KEGGCompound1` ;

ALTER TABLE `KEGGReactionProduct` 
ADD INDEX `fk_KEGGReactionProduct_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionProduct_KEGGReaction1` ;

ALTER TABLE `KEGGReactionSubstrate` 
ADD INDEX `fk_KEGGReactionSubstrate_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReactionSubstrate_KEGGReaction1` ;

ALTER TABLE `KEGGGlycan` 
ADD INDEX `fk_KEGGGlycan_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGGlycan_DataSet1` ;

ALTER TABLE `KEGGGlycanDBLink` 
ADD INDEX `fk_KEGGGlycanDBLink_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanDBLink_KEGGGlycan1` ;

ALTER TABLE `KEGGGlycanEnzyme` 
ADD INDEX `fk_KEGGGlycanEnzyme_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanEnzyme_KEGGGlycan1` ;

ALTER TABLE `KEGGGlycanPathway` 
ADD INDEX `fk_KEGGGlycanPathway_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanPathway_KEGGGlycan1` ;

ALTER TABLE `KEGGGlycanReaction` 
ADD INDEX `fk_KEGGGlycanReaction_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanReaction_KEGGGlycan1` ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Product` 
ADD INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction1` 
, DROP INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan1` ;

ALTER TABLE `KEGGReaction_has_KEGGGlycan_as_Substrate` 
ADD INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan2_idx` (`KEGGGlycan_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction2_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGReaction2` 
, DROP INDEX `fk_KEGGReaction_has_KEGGGlycan_KEGGGlycan2` ;

ALTER TABLE `KEGGGlycanClassTemp` 
ADD INDEX `fk_KEGGGlycanClassTemp_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanClassTemp_KEGGGlycan1` ;

ALTER TABLE `KEGGGlycan_has_KEGGGlycanClass` 
ADD INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycanClass1_idx` (`KEGGGlycanClass_WID` ASC) 
, ADD INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycan1` 
, DROP INDEX `fk_KEGGGlycan_has_KEGGGlycanClass_KEGGGlycanClass1` ;

ALTER TABLE `KEGGGlycanOrthology` 
ADD INDEX `fk_KEGGGlycanOrthology_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanOrthology_KEGGGlycan1` ;

ALTER TABLE `KEGGEnzyme_has_KEGGCompound_as_Effector` 
ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound3_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme3_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGEnzyme3` 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGCompound_KEGGCompound3` ;

ALTER TABLE `KEGGRPair` 
ADD INDEX `fk_KEGGRPair_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGRPair_DataSet1` ;

ALTER TABLE `KEGGRPairCompound` 
ADD INDEX `fk_KEGGRPairCompound_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPairCompound_KEGGRPair1` ;

ALTER TABLE `KEGGRPair_has_KEGGCompound` 
ADD INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, ADD INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGRPair1` 
, DROP INDEX `fk_KEGGRPair_has_KEGGCompound_KEGGCompound1` ;

ALTER TABLE `KEGGRPairRelatedPair` 
ADD INDEX `fk_KEGGRPair_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPair_KEGGRPair1` ;

ALTER TABLE `KEGGRPairRelatedPairTemp` 
ADD INDEX `fk_KEGGRPairTemp_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPairTemp_KEGGRPair1` ;

ALTER TABLE `KEGGRPairEnzyme` 
ADD INDEX `fk_KEGGRPairEnzyme_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPairEnzyme_KEGGRPair1` ;

ALTER TABLE `KEGGRPairReaction` 
ADD INDEX `fk_KEGGRPairReaction_KEGGRPair1_idx` (`KEGGRPair_WID` ASC) 
, DROP INDEX `fk_KEGGRPairReaction_KEGGRPair1` ;

ALTER TABLE `KEGGGene` 
ADD INDEX `fk_KEGGGene_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGGene_DataSet1` ;

ALTER TABLE `KEGGGeneName` 
ADD INDEX `fk_KEGGGeneName_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGeneName_KEGGGene1` ;

ALTER TABLE `KEGGGeneOrthology` 
ADD INDEX `fk_KEGGGeneOrthology_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGeneOrthology_KEGGGene1` ;

ALTER TABLE `KEGGGenePathway` 
ADD INDEX `fk_KEGGGenePathway_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGenePathway_KEGGGene1` ;

ALTER TABLE `KEGGGeneDBLink` 
ADD INDEX `fk_KEGGGeneDBLink_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGeneDBLink_KEGGGene1` ;

ALTER TABLE `KEGGGeneDisease` 
ADD INDEX `fk_KEGGGeneDisease_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGeneDisease_KEGGGene1` ;

ALTER TABLE `KEGGGeneDrugTarget` 
ADD INDEX `fk_KEGGGeneDrugTarget_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGeneDrugTarget_KEGGGene1` ;

ALTER TABLE `KEGGPathway` 
ADD INDEX `fk_KEGGPathway_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_KEGGPathway_DataSet1` ;

ALTER TABLE `KEGGPathwayEntry` 
ADD INDEX `fk_KEGGPathwayEntry_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntry_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayRelation` 
ADD INDEX `fk_KEGGPathwayRelation_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayRelation_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayReaction` 
ADD INDEX `fk_KEGGPathwayReaction_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayReaction_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayReactionSubstrate` 
ADD INDEX `fk_KEGGPathwayReactionSubstrate_KEGGPathwayReaction1_idx` (`KEGGPathwayReaction_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayReactionSubstrate_KEGGPathwayReaction1` ;

ALTER TABLE `KEGGPathwayReactionProduct` 
ADD INDEX `fk_KEGGPathwayReactionProduct_KEGGPathwayReaction1_idx` (`KEGGPathwayReaction_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayReactionProduct_KEGGPathwayReaction1` ;

ALTER TABLE `KEGGPathwayEntryGraphic` 
ADD INDEX `fk_KEGGPathwayEntryGraphic_KEGGPathwayEntry1_idx` (`KEGGPathwayEntry_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryGraphic_KEGGPathwayEntry1` ;

ALTER TABLE `KEGGPathwayEntryEnzyme` 
ADD INDEX `fk_KEGGPathwayEntryMap_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryMap_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayEntryCompound` 
ADD INDEX `fk_KEGGPathwayEntryCompound_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryCompound_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayEntryGene` 
ADD INDEX `fk_KEGGPathwayEntryGene_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryGene_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayEntryOrthology` 
ADD INDEX `fk_KEGGPathwayEntryOrthology_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryOrthology_KEGGPathway1` ;

ALTER TABLE `KEGGEnzyme_has_KEGGPathway` 
ADD INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, ADD INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGEnzyme1` 
, DROP INDEX `fk_KEGGEnzyme_has_KEGGPathway_KEGGPathway1` ;

ALTER TABLE `KEGGCompound_has_KEGGPathway` 
ADD INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, ADD INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGCompound1` 
, DROP INDEX `fk_KEGGCompound_has_KEGGPathway_KEGGPathway1` ;

ALTER TABLE `KEGGReaction_has_KEGGPathway` 
ADD INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, ADD INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGReaction1_idx` (`KEGGReaction_WID` ASC) 
, DROP INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGReaction1` 
, DROP INDEX `fk_KEGGReaction_has_KEGGPathway_KEGGPathway1` ;

ALTER TABLE `KEGGGene_has_KEGGPathway` 
ADD INDEX `fk_KEGGGene_has_KEGGPathway_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, ADD INDEX `fk_KEGGGene_has_KEGGPathway_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, DROP INDEX `fk_KEGGGene_has_KEGGPathway_KEGGGene1` 
, DROP INDEX `fk_KEGGGene_has_KEGGPathway_KEGGPathway1` ;

ALTER TABLE `KEGGPathwayEntryReaction` 
ADD INDEX `fk_KEGGPathwayEntryReaction_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayEntryReaction_KEGGPathway1` ;

ALTER TABLE `KEGGPathway_has_Taxonomy` 
ADD INDEX `fk_KEGGPathway_has_Taxonomy_Taxonomy1_idx` (`Taxonomy_WID` ASC) 
, ADD INDEX `fk_KEGGPathway_has_Taxonomy_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathway_has_Taxonomy_KEGGPathway1` 
, DROP INDEX `fk_KEGGPathway_has_Taxonomy_Taxonomy1` ;

ALTER TABLE `KEGGPathwayRelationSubType` 
ADD INDEX `fk_KEGGPathwayRelationSubType_KEGGPathwayRelation1_idx` (`KEGGPathwayRelation_WID` ASC) 
, DROP INDEX `fk_KEGGPathwayRelationSubType_KEGGPathwayRelation1` ;

ALTER TABLE `KEGGGlycanName` 
ADD INDEX `fk_KEGGGlycanName_KEGGGlycan1_idx` (`KEGGGlycan_WID` ASC) 
, DROP INDEX `fk_KEGGGlycanName_KEGGGlycan1` ;

ALTER TABLE `KEGGCompound_has_DrugBank` 
ADD INDEX `fk_KEGGCompound_has_DrugBank_DrugBank1_idx` (`DrugBank_WID` ASC) 
, ADD INDEX `fk_KEGGCompound_has_DrugBank_KEGGCompound1_idx` (`KEGGCompound_WID` ASC) 
, DROP INDEX `fk_KEGGCompound_has_DrugBank_KEGGCompound1` 
, DROP INDEX `fk_KEGGCompound_has_DrugBank_DrugBank1` ;

ALTER TABLE `Protein_has_KEGGEnzyme` 
ADD INDEX `fk_Protein_has_KEGGEnzyme_KEGGEnzyme1_idx` (`KEGGEnzyme_WID` ASC) 
, ADD INDEX `fk_Protein_has_KEGGEnzyme_Protein1_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_Protein_has_KEGGEnzyme_Protein1` 
, DROP INDEX `fk_Protein_has_KEGGEnzyme_KEGGEnzyme1` ;

ALTER TABLE `GeneInfo_has_KEGGGene` 
ADD INDEX `fk_GeneInfo_has_KEGGGene_KEGGGene1_idx` (`KEGGGene_WID` ASC) 
, ADD INDEX `fk_GeneInfo_has_KEGGGene_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneInfo_has_KEGGGene_GeneInfo1` 
, DROP INDEX `fk_GeneInfo_has_KEGGGene_KEGGGene1` ;

ALTER TABLE `ProteinGene` 
ADD INDEX `fk_ProteinGene_Protein2_idx` (`Protein_WID` ASC) 
, DROP INDEX `fk_ProteinGene_Protein2` ;

ALTER TABLE `KEGGPathway_has_Protein` 
ADD INDEX `fk_KEGGPathway_has_Protein_Protein1_idx` (`Protein_WID` ASC) 
, ADD INDEX `fk_KEGGPathway_has_Protein_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathway_has_Protein_KEGGPathway1` 
, DROP INDEX `fk_KEGGPathway_has_Protein_Protein1` ;

ALTER TABLE `KEGGPathway_has_GeneInfo` 
ADD INDEX `fk_KEGGPathway_has_GeneInfo_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, ADD INDEX `fk_KEGGPathway_has_GeneInfo_KEGGPathway1_idx` (`KEGGPathway_WID` ASC) 
, DROP INDEX `fk_KEGGPathway_has_GeneInfo_KEGGPathway1` 
, DROP INDEX `fk_KEGGPathway_has_GeneInfo_GeneInfo1` ;

ALTER TABLE `OMIMGeneMap_has_OMIMMethod` 
ADD INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMMethod1_idx` (`OMIMMethod_WID` ASC) 
, DROP INDEX `fk_OMIMGeneMap_has_OMIMMethod_OMIMMethod1` ;

ALTER TABLE `OMIM` 
ADD INDEX `fk_OMIM_DataSet1_idx` (`DataSet_WID` ASC) 
, DROP INDEX `fk_OMIM_DataSet1` ;

ALTER TABLE `OMIMTI` 
ADD INDEX `fk_OMIMTitle_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMTitle_OMIM1` ;

ALTER TABLE `OMIMTX` CHANGE COLUMN `TX` `TX` TEXT NOT NULL  
, ADD INDEX `fk_OMIMTX_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMTX_OMIM1` ;

ALTER TABLE `OMIMRF` 
ADD INDEX `fk_OMIMRF_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMRF_OMIM1` ;

ALTER TABLE `OMIMCS` 
ADD INDEX `fk_OMIMCS_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMCS_OMIM1` ;

ALTER TABLE `OMIMCSData` 
ADD INDEX `fk_OMIMCSData_OMIMCS1_idx` (`OMIMCS_WID` ASC) 
, DROP INDEX `fk_OMIMCSData_OMIMCS1` ;

ALTER TABLE `OMIMCD` 
ADD INDEX `fk_OMIMICD_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMICD_OMIM1` ;

ALTER TABLE `OMIMED` 
ADD INDEX `fk_OMIMED_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMED_OMIM1` ;

ALTER TABLE `OMIMAV` 
ADD INDEX `fk_OMIMAV_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMAV_OMIM1` ;

ALTER TABLE `OMIMCN` 
ADD INDEX `fk_OMIMCN_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMCN_OMIM1` ;

ALTER TABLE `OMIMSA` 
ADD INDEX `fk_OMIMSA_OMIM1_idx` (`OMIM_WID` ASC) 
, DROP INDEX `fk_OMIMSA_OMIM1` ;

ALTER TABLE `GeneInfo_has_OMIM` 
ADD INDEX `fk_GeneInfo_has_OMIM_OMIM1_idx` (`OMIM_WID` ASC) 
, ADD INDEX `fk_GeneInfo_has_OMIM_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneInfo_has_OMIM_GeneInfo1` 
, DROP INDEX `fk_GeneInfo_has_OMIM_OMIM1` ;

ALTER TABLE `GeneInfo_has_GenomesPTT` 
ADD INDEX `fk_GeneInfo_has_GenomesPTT_GenomesPTT1_idx` (`GenomesPTT_ProteinGi` ASC) 
, ADD INDEX `fk_GeneInfo_has_GenomesPTT_GeneInfo1_idx` (`GeneInfo_WID` ASC) 
, DROP INDEX `fk_GeneInfo_has_GenomesPTT_GeneInfo1` 
, DROP INDEX `fk_GeneInfo_has_GenomesPTT_GenomesPTT1` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
