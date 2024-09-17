--liquibase formatted sql

--changeset C7V5Z6:2
CREATE TABLE IF NOT EXISTS aae_gov_marketing.sfdc_geographic_and_territory_matrix__c (
COUNTY__C                                                   VARCHAR(255), 
MARKET__C                                                   VARCHAR(255), 
MICROMARKET__C                                              VARCHAR(255), 
STATE__C                                                    VARCHAR(255), 
ZIPCODE__C                                                  VARCHAR(255), 
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
FIPS_Code__c                                                VARCHAR(10), 
Region__c                                                   VARCHAR(255), 
SubMarket__c                                                VARCHAR(255), 
Middle_Market__c                                            VARCHAR(255), 
AUDITDATAID                                                 BIGINT NOT NULL, 
SRC_DATA_KEY                                                SMALLINT NOT NULL, 
LOAD_DTTS                                                   TIMESTAMP,
PRIMARY KEY (ID) -- NOT UNIQUE INDEX
) 
USING DELTA 
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.sfdc_geographic_and_territory_matrix__c;  
 