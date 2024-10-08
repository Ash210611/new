--liquibase formatted sql
--changeset C7V5Z6:3
CREATE TABLE IF NOT EXISTS aae_gov_marketing.sfdc_campaign_request_detail__c (
Action__c                                                   VARCHAR(255), 
Business_Unit__c                                            VARCHAR(255), 
Campaign_Category__c                                        VARCHAR(155), 
Campaign_Name__c                                            VARCHAR(1300), 
Campaign_Number__c                                          VARCHAR(1300), 
CCLC__c                                                     VARCHAR(1300), 
Change_Comments__c                                          VARCHAR(255), 
Change_Date__c                                              TIMESTAMP, 
CID__c                                                      VARCHAR(20), 
CM_Campaign_Group__c                                        VARCHAR(155), 
CreatedById                                                 VARCHAR(255), 
CreatedDate                                                 TIMESTAMP, 
Creative__c                                                 VARCHAR(155), 
Description__c                                              VARCHAR(64000), 
Destination_URL__c                                          VARCHAR(255), 
DNIS__c                                                     VARCHAR(50), 
End_Date__c                                                 TIMESTAMP, 
Error_Message__c                                            VARCHAR(200), 
EventId__c                                                  VARCHAR(30), 
Expire_Early__c                                             TINYINT, 
form_EventID__c                                             VARCHAR(1300), 
Fulfillment__c                                              VARCHAR(255), 
GoHealth__c                                                 TINYINT, 
GoHealth_DID__c                                             VARCHAR(40), 
Historical_Event_Id__c                                      VARCHAR(50), 
Host__c                                                     TINYINT, 
Host_Skill_Group__c                                         VARCHAR(40), 
HPone__c                                                    TINYINT, 
HPone_DID__c                                                VARCHAR(40), 
HPS__c                                                      TINYINT, 
HPS_DID__c                                                  VARCHAR(40), 
Id                                                          VARCHAR(255), 
IsDeleted                                                   TINYINT, 
Kit_description__c                                          VARCHAR(255), 
Kit_Type__c                                                 VARCHAR(255), 
Language__c                                                 VARCHAR(55), 
LastActivityDate                                            TIMESTAMP, 
LastModifiedById                                            VARCHAR(255), 
LastModifiedDate                                            TIMESTAMP, 
LastReferencedDate                                          TIMESTAMP, 
LastViewedDate                                              TIMESTAMP, 
Lead_Source_Name__c                                         VARCHAR(155), 
Macromarket__c                                              VARCHAR(255), 
Market__c                                                   VARCHAR(155), 
Media_Type__c                                               VARCHAR(255), 
Micromarket__c                                              VARCHAR(255), 
Middle_Market__c                                            VARCHAR(155), 
Name                                                        VARCHAR(80), 
Parent_Campaign_Request__c                                  VARCHAR(255), 
Parent_Case_Status__c                                       TINYINT, 
Path__c                                                     VARCHAR(255), 
Phone_Campaign__c                                           VARCHAR(255), 
Phone_Lead_Source_Type__c                                   VARCHAR(155), 
Print_code__c                                               VARCHAR(225), 
Program__c                                                  VARCHAR(255), 
ProjectCode__c                                              VARCHAR(55), 
Referral_ID_Tool_Tip__c                                     VARCHAR(255), 
Region__c                                                   VARCHAR(255), 
Segment__c                                                  VARCHAR(50), 
SP_Kit_Description__c                                       VARCHAR(255), 
SP_Print_code__c                                            VARCHAR(225), 
Start_Date__c                                               TIMESTAMP, 
Status__c                                                   VARCHAR(255), 
Status_of_Campaign_Load__c                                  VARCHAR(30), 
Status_of_TFA__c                                            VARCHAR(50), 
Status_of_TFN__c                                            VARCHAR(40), 
SubMarket__c                                                VARCHAR(255), 
Sutherland__c                                               TINYINT, 
Sutherland_DID__c                                           VARCHAR(40), 
SystemModstamp                                              TIMESTAMP, 
Territory__c                                                VARCHAR(155), 
TFN__c                                                      VARCHAR(40), 
Timestamp__c                                                TIMESTAMP, 
Touch__c                                                    VARCHAR(155), 
Tranzact__c                                                 TINYINT, 
Tranzact_DID__c                                             VARCHAR(40), 
URL__c                                                      VARCHAR(155), 
URL_Media_Path__c                                           VARCHAR(255), 
URLsp__c                                                    VARCHAR(155), 
AUDITDATAID                                                 BIGINT NOT NULL, 
SRC_DATA_KEY                                                SMALLINT NOT NULL, 
LOAD_DTTS                                                   TIMESTAMP,
PRIMARY KEY (Id) -- NOT UNIQUE INDEX
) 
USING DELTA 
TBLPROPERTIES (delta.enableChangeDataCapture=true,delta.autooptimize.optimizewrite=true,delta.minReaderVersion='2',delta.minWriterVersion='5',delta.columnMapping.mode='name');
-- rollback DROP TABLE aae_gov_marketing.sfdc_campaign_request_detail__c;  