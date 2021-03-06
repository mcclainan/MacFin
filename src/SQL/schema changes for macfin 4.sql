ALTER TABLE BANK_RECORD ADD CREATED DATE;
ALTER TABLE ACCOUNT ADD DATE_FORMAT VARCHAR2(15);
ALTER TABLE TRANSACTION ADD RELATIONSHIP VARCHAR2(10);
ALTER TABLE CATEGORY ADD ASSET_LIABILITY_ACTION NUMBER(19,0);
ALTER TABLE CATEGORY ADD ASSET_LIABILITY_ID NUMBER(19,0);

CREATE TABLE USER_TABLE(
  ID NUMBER(19,0), 
	VERSION NUMBER(19,0), 
  USER_NAME VARCHAR2(225),
  PASSWORD VARCHAR2(225),
  NAME VARCHAR2(225));
  ALTER TABLE USER_TABLE ADD PRIMARY KEY ("ID");
  CREATE UNIQUE INDEX USER_TABLE_NAME_UNIQUE ON USER_TABLE (USER_NAME); 
  ALTER TABLE USER_TABLE MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE USER_TABLE MODIFY ("VERSION" NOT NULL ENABLE);
  ALTER TABLE USER_TABLE MODIFY ("USER_NAME" NOT NULL ENABLE);
  ALTER TABLE USER_TABLE MODIFY ("PASSWORD" NOT NULL ENABLE);
  ALTER TABLE USER_TABLE MODIFY ("NAME" NOT NULL ENABLE);

 CREATE TABLE BANK(
  ID NUMBER(19,0), 
  VERSION NUMBER(19,0), 
  DATE_FORMAT VARCHAR2(225),
  ACTIVE VARCHAR2(225),
  HAS_HEADING VARCHAR2(225),
  BANK_NAME VARCHAR2(225),
  DATE_COLUMN NUMBER(19,0), 
  DESCRIPTION_COLUMN NUMBER(19,0), 
  AMOUNT_COLUMN NUMBER(19,0);
  ALTER TABLE BANK ADD PRIMARY KEY ("ID");
  CREATE UNIQUE INDEX BANK_NAME_UNIQUE ON BANK (BANK_NAME); 
  ALTER TABLE BANK MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("VERSION" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("DATE_FORMAT" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("ACTIVE" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("BANK_NAME" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("DATE_COLUMN" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("DESCRIPTION_COLUMN" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("AMOUNT_COLUMN" NOT NULL ENABLE);
  ALTER TABLE BANK MODIFY ("HAS_HEADING" NOT NULL ENABLE);
  
  ALTER TABLE ACCOUNT ADD BANK_ID NUMBER(19,0);
  ALTER TABLE ACCOUNT ADD CONSTRAINT ACCOUNT_BANK_FK FOREIGN KEY (BANK_ID)
	  REFERENCES BANK ("ID") ENABLE;
	  
alter table bank add has_Multiple_Amount_Columns varchar2(1);
alter table bank add credit_Column number;
alter table bank add debit_Column number;
	  
  