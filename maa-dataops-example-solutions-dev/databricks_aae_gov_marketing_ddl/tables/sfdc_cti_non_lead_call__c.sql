--liquibase formatted sql

--changeset C7V5Z6:3
CREATE TABLE IF NOT EXISTS aae_gov_marketing.sfdc_cti_non_lead_call__c (
ANI_ID__c                                                   VARCHAR(255), 
Call_Result__c                                              VARCHAR(255), 
Campaign__c                                                 VARCHAR(255), 
Carrier__c                                                  VARCHAR(255), 
Comments__c                                                 VARCHAR(255), 
CTI_Inbound_Call_Log__c                                     VARCHAR(255), 
Disposition__c                                              VARCHAR(255), 
DNIS__c                                                     VARCHAR(255), 
Finesse_GUID__c                                             VARCHAR(255), 
Finesse_PCK__c                                              VARCHAR(255), 
Finesse_Router_Key__c                                       VARCHAR(255), 
Media_Source__c                                             VARCHAR(255), 
Non_Par_Name__c                                             VARCHAR(255), 
Other_Carrier__c                                            VARCHAR(255), 
Reason__c                                                   VARCHAR(255), 
Sub_Type__c                                                 VARCHAR(255), 
Subject__c                                                  VARCHAR(255), 
Type__c                                                     VARCHAR(255), 
CreatedById                                                 VARCHAR(255), 
CreatedDate                                                 TIMESTAMP, 
Id                                                          VARCHAR(255), 
IsDeleted                                                   TINYINT, 
LastModifiedById                                            VARCHAR(255), 
LastModifiedDate                                            TIMESTAMP, 
LastReferencedDate                                          TIMESTAMP, 
LastViewedDate                                              TIMESTAMP, 
Name_rw                                                     VARCHAR(255), 
OwnerId                                                     VARCHAR(255), 
SystemModstamp                                              TIMESTAMP, 
AUDITDATAID                                                 BIGINT NOT NULL, 
SRC_DATA_KEY                                                SMALLINT NOT NULL, 
LOAD_DTTS                                                   TIMESTAMP,
PRIMARY KEY (Id) -- NOT UNIQUE INDEX
) 
USING DELTA 
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.sfdc_cti_non_lead_call__c;  
 