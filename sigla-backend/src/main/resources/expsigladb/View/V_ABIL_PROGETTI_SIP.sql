--------------------------------------------------------
--  DDL for View V_ABIL_PROGETTI_SIP
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_ABIL_PROGETTI_SIP" ("ESERCIZIO_PROGETTO", "PG_PROGETTO", "TIPO_FASE_PROGETTO", "ESERCIZIO_COMMESSA", "PG_COMMESSA", "TIPO_FASE_COMMESSA", "ESERCIZIO_MODULO", "PG_MODULO", "TIPO_FASE_MODULO", "CD_UNITA_ORGANIZZATIVA") AS 
  SELECT
--
-- Date: 24/10/2005
-- Version: 1.0
--
-- Vista per controllare le abilitazioni dei progetti
--
-- History:
--
-- Date: 24/10/2005
-- Version: 1.0
-- Creazione
--
-- Body:
--
PROGETTO.ESERCIZIO ESERCIZIO_PROGETTO, PROGETTO.PG_PROGETTO PG_PROGETTO, PROGETTO.TIPO_FASE TIPO_FASE_PROGETTO,
COMMESSA.ESERCIZIO ESERCIZIO_COMMESSA, COMMESSA.PG_PROGETTO PG_COMMESSA, COMMESSA.TIPO_FASE TIPO_FASE_COMMESSA,
MODULO.ESERCIZIO   ESERCIZIO_MODULO,   MODULO.PG_PROGETTO   PG_MODULO,   MODULO.TIPO_FASE   TIPO_FASSE_MODULO,
MODULO.CD_UNITA_ORGANIZZATIVA
From PROGETTO_SIP PROGETTO, PROGETTO_SIP COMMESSA, PROGETTO_SIP MODULO
Where MODULO.ESERCIZIO = COMMESSA.ESERCIZIO
  And MODULO.PG_PROGETTO_PADRE = COMMESSA.PG_PROGETTO
  And MODULO.TIPO_FASE = COMMESSA.TIPO_FASE
  And COMMESSA.ESERCIZIO = PROGETTO.ESERCIZIO
  And COMMESSA.PG_PROGETTO_PADRE = PROGETTO.PG_PROGETTO
  And COMMESSA.TIPO_FASE = PROGETTO.TIPO_FASE;
