--------------------------------------------------------
--  DDL for View DATABASE_INFO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "DATABASE_INFO" ("DBID", "NAME", "CREATED", "RESETLOGS_CHANGE#", "RESETLOGS_TIME", "PRIOR_RESETLOGS_CHANGE#", "PRIOR_RESETLOGS_TIME", "LOG_MODE", "CHECKPOINT_CHANGE#", "ARCHIVE_CHANGE#", "CONTROLFILE_TYPE", "CONTROLFILE_CREATED", "CONTROLFILE_SEQUENCE#", "CONTROLFILE_CHANGE#", "CONTROLFILE_TIME", "OPEN_RESETLOGS", "VERSION_TIME", "OPEN_MODE", "PROTECTION_MODE", "PROTECTION_LEVEL", "REMOTE_ARCHIVE", "ACTIVATION#", "DATABASE_ROLE", "ARCHIVELOG_CHANGE#", "SWITCHOVER_STATUS", "DATAGUARD_BROKER", "GUARD_STATUS", "SUPPLEMENTAL_LOG_DATA_MIN", "SUPPLEMENTAL_LOG_DATA_PK", "SUPPLEMENTAL_LOG_DATA_UI", "FORCE_LOGGING") AS 
  select "DBID","NAME","CREATED","RESETLOGS_CHANGE#","RESETLOGS_TIME","PRIOR_RESETLOGS_CHANGE#","PRIOR_RESETLOGS_TIME","LOG_MODE","CHECKPOINT_CHANGE#","ARCHIVE_CHANGE#","CONTROLFILE_TYPE","CONTROLFILE_CREATED","CONTROLFILE_SEQUENCE#","CONTROLFILE_CHANGE#","CONTROLFILE_TIME","OPEN_RESETLOGS","VERSION_TIME","OPEN_MODE","PROTECTION_MODE","PROTECTION_LEVEL","REMOTE_ARCHIVE","ACTIVATION#","DATABASE_ROLE","ARCHIVELOG_CHANGE#","SWITCHOVER_STATUS","DATAGUARD_BROKER","GUARD_STATUS","SUPPLEMENTAL_LOG_DATA_MIN","SUPPLEMENTAL_LOG_DATA_PK","SUPPLEMENTAL_LOG_DATA_UI","FORCE_LOGGING" from sys.v_$database;