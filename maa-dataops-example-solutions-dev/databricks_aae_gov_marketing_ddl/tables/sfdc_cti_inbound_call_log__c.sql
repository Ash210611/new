--liquibase formatted sql

--changeset C7V5Z6:3
CREATE TABLE IF NOT EXISTS aae_gov_marketing.sfdc_cti_inbound_call_log__c (
AGENT__C                                                    VARCHAR(255), 
AGENT_TYPE__C                                               VARCHAR(255), 
CAMPAIGN__C                                                 VARCHAR(255), 
FINESSE_GUID__C                                             VARCHAR(255), 
FINESSE_PCK__C                                              VARCHAR(255), 
FINESSE_ROUTER_KEY__C                                       VARCHAR(255), 
PROSPECT_LEAD_PHONE_NUMBER__C                               VARCHAR(255), 
USER_ID__C                                                  VARCHAR(255), 
CREATEDBYID                                                 VARCHAR(255), 
CREATEDDATE                                                 TIMESTAMP, 
ID                                                          VARCHAR(255), 
ISDELETED                                                   TINYINT, 
LASTMODIFIEDBYID                                            VARCHAR(255), 
LASTMODIFIEDDATE                                            TIMESTAMP, 
LASTREFERENCEDDATE                                          TIMESTAMP, 
LASTVIEWEDDATE                                              TIMESTAMP, 
NAME_RW                                                     VARCHAR(255), 
OWNERID                                                     VARCHAR(255), 
SYSTEMMODSTAMP                                              TIMESTAMP, 
AUDITDATAID                                                 BIGINT NOT NULL, 
SRC_DATA_KEY                                                SMALLINT NOT NULL, 
LOAD_DTTS                                                   TIMESTAMP,
PRIMARY KEY (ID) -- NOT UNIQUE INDEX
) 
USING DELTA 
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.sfdc_cti_inbound_call_log__c;  
 