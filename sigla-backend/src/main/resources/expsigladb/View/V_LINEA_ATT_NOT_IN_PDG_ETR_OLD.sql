--------------------------------------------------------
--  DDL for View V_LINEA_ATT_NOT_IN_PDG_ETR_OLD
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_LINEA_ATT_NOT_IN_PDG_ETR_OLD" ("ESERCIZIO", "ESERCIZIO_INIZIO", "CD_LINEA_ATTIVITA", "PG_PROGETTO", "CD_PROGETTO", "CD_PROGETTO_PADRE", "DS_LINEA_ATTIVITA", "CD_CENTRO_RESPONSABILITA", "CD_INSIEME_LA", "TI_GESTIONE", "DENOMINAZIONE", "CD_GRUPPO_LINEA_ATTIVITA", "CD_FUNZIONE", "CD_NATURA", "CD_TIPO_LINEA_ATTIVITA", "CD_CDR_COLLEGATO", "CD_LA_COLLEGATO", "ESERCIZIO_FINE", "DACR", "UTCR", "DUVA", "UTUV", "PG_VER_REC", "TI_APPARTENENZA", "TI_GESTIONE_VOCE", "CD_ELEMENTO_VOCE", "CD_RESPONSABILE_TERZO", "FL_LIMITE_ASS_OBBLIG") AS 
  SELECT
--
-- Date: 09/11/2006
-- Version: 1.2
--
-- Estrae tutte le linee di attivita di tipo ENTRATA; per quelle presenti nel pdg viene
-- estratto anche l'elemento voce. E' utilizzata dall'on line della gestione accertamento
-- per recuperare le linee di attività non presenti nel pdg dato un certo elemento_voce.
--
-- History:
--
-- Body:
--
-- Date: 16/05/2005
-- Version: 1.0
-- Creazione
--
-- Date: 12/01/2006
-- Version: 1.1
-- Aggiunto il recupero dei dati da PDG_MODULO_ENTRATE_GEST se l'esercizio è superiore al 2005
--
-- Date: 09/11/2006
-- Version: 1.2
-- Aggiunta la selezione del progetto/commessa/modulo per anno
--
-- Body:
--
B.ESERCIZIO 				  ,
A.ESERCIZIO_INIZIO          ,
A.CD_LINEA_ATTIVITA         ,
A.PG_PROGETTO,
(Select CD_PROGETTO From PROGETTO_PREV PROGETTO
 Where B.ESERCIZIO = PROGETTO.ESERCIZIO
 And   A.PG_PROGETTO = PROGETTO.PG_PROGETTO) CD_PROGETTO,
(Select CD_PROGETTO From PROGETTO_PREV PROGETTO_PADRE
 Where PROGETTO_PADRE.ESERCIZIO = B.ESERCIZIO
 And   PROGETTO_PADRE.PG_PROGETTO = (Select PG_PROGETTO From PROGETTO_PREV PROGETTO
                                     Where B.ESERCIZIO = PROGETTO.ESERCIZIO
                                     And   A.PG_PROGETTO = PROGETTO.PG_PROGETTO)) CD_PROGETTO_PADRE,
A.DS_LINEA_ATTIVITA         ,
A.CD_CENTRO_RESPONSABILITA  ,
A.CD_INSIEME_LA			  ,
A.TI_GESTIONE				  ,
A.DENOMINAZIONE             ,
A.CD_GRUPPO_LINEA_ATTIVITA  ,
A.CD_FUNZIONE               ,
A.CD_NATURA                 ,
A.CD_TIPO_LINEA_ATTIVITA    ,
A.CD_CDR_COLLEGATO		  ,
A.CD_LA_COLLEGATO			  ,
A.ESERCIZIO_FINE			  ,
A.DACR                      ,
A.UTCR                      ,
A.DUVA                      ,
A.UTUV                      ,
A.PG_VER_REC,
B.TI_APPARTENENZA,
B.TI_GESTIONE,
B.CD_ELEMENTO_VOCE,
A.CD_RESPONSABILE_TERZO,
A.FL_LIMITE_ASS_OBBLIG
FROM PDG_PREVENTIVO_ETR_DET B,
LINEA_ATTIVITA A, CDR, UNITA_ORGANIZZATIVA, PARAMETRI_CDS
WHERE
B.CATEGORIA_DETTAGLIO = 'SIN'
AND B.STATO = 'Y'
AND B.TI_APPARTENENZA = 'C'
AND B.TI_GESTIONE = 'E'
AND A.TI_GESTIONE = 'E'
AND	A.CD_CENTRO_RESPONSABILITA = B.CD_CENTRO_RESPONSABILITA
AND A.CD_LINEA_ATTIVITA = B.CD_LINEA_ATTIVITA
  And A.CD_CENTRO_RESPONSABILITA = CDR.CD_CENTRO_RESPONSABILITA
  And CDR.CD_UNITA_ORGANIZZATIVA = UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA
  And PARAMETRI_CDS.ESERCIZIO = B.ESERCIZIO
  And PARAMETRI_CDS.CD_CDS = UNITA_ORGANIZZATIVA.CD_UNITA_PADRE
  And ((PARAMETRI_CDS.FL_COMMESSA_OBBLIGATORIA = 'Y' And
        A.PG_PROGETTO Is Not Null) Or
       (PARAMETRI_CDS.FL_COMMESSA_OBBLIGATORIA = 'N'))
Union
Select
PDG_MODULO_ENTRATE_GEST.ESERCIZIO,
LINEA_ATTIVITA.ESERCIZIO_INIZIO,
LINEA_ATTIVITA.CD_LINEA_ATTIVITA,
LINEA_ATTIVITA.PG_PROGETTO,
(Select CD_PROGETTO From PROGETTO_GEST PROGETTO
 Where PDG_MODULO_ENTRATE_GEST.ESERCIZIO = PROGETTO.ESERCIZIO
 And   LINEA_ATTIVITA.PG_PROGETTO = PROGETTO.PG_PROGETTO) CD_PROGETTO,
(Select CD_PROGETTO From PROGETTO_GEST PROGETTO_PADRE
 Where PROGETTO_PADRE.ESERCIZIO = PDG_MODULO_ENTRATE_GEST.ESERCIZIO
 And   PROGETTO_PADRE.PG_PROGETTO = (Select PG_PROGETTO From PROGETTO_GEST PROGETTO
                                     Where PDG_MODULO_ENTRATE_GEST.ESERCIZIO = PROGETTO.ESERCIZIO
                                     And   LINEA_ATTIVITA.PG_PROGETTO = PROGETTO.PG_PROGETTO)) CD_PROGETTO_PADRE,
LINEA_ATTIVITA.DS_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA,
LINEA_ATTIVITA.CD_INSIEME_LA,
LINEA_ATTIVITA.TI_GESTIONE,
LINEA_ATTIVITA.DENOMINAZIONE,
LINEA_ATTIVITA.CD_GRUPPO_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_FUNZIONE,
LINEA_ATTIVITA.CD_NATURA,
LINEA_ATTIVITA.CD_TIPO_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_CDR_COLLEGATO,
LINEA_ATTIVITA.CD_LA_COLLEGATO,
LINEA_ATTIVITA.ESERCIZIO_FINE,
LINEA_ATTIVITA.DACR,
LINEA_ATTIVITA.UTCR,
LINEA_ATTIVITA.DUVA,
LINEA_ATTIVITA.UTUV,
LINEA_ATTIVITA.PG_VER_REC,
PDG_MODULO_ENTRATE_GEST.TI_APPARTENENZA,
PDG_MODULO_ENTRATE_GEST.TI_GESTIONE,
PDG_MODULO_ENTRATE_GEST.CD_ELEMENTO_VOCE,
LINEA_ATTIVITA.CD_RESPONSABILE_TERZO,
LINEA_ATTIVITA.FL_LIMITE_ASS_OBBLIG
FROM PDG_MODULO_ENTRATE_GEST,
LINEA_ATTIVITA
WHERE
PDG_MODULO_ENTRATE_GEST.CATEGORIA_DETTAGLIO = 'DIR'
And PDG_MODULO_ENTRATE_GEST.TI_APPARTENENZA = 'C'
AND PDG_MODULO_ENTRATE_GEST.TI_GESTIONE = 'E'
AND LINEA_ATTIVITA.TI_GESTIONE = 'E'
And LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA = PDG_MODULO_ENTRATE_GEST.CD_CENTRO_RESPONSABILITA
AND LINEA_ATTIVITA.CD_LINEA_ATTIVITA = PDG_MODULO_ENTRATE_GEST.CD_LINEA_ATTIVITA
/*
Union
Select
VOCE_F_SALDI_CDR_LINEA.ESERCIZIO,
LINEA_ATTIVITA.ESERCIZIO_INIZIO,
LINEA_ATTIVITA.CD_LINEA_ATTIVITA,
LINEA_ATTIVITA.PG_PROGETTO,
(Select CD_PROGETTO From PROGETTO_GEST PROGETTO
 Where PDG_MODULO_ENTRATE_GEST.ESERCIZIO = PROGETTO.ESERCIZIO
 And   LINEA_ATTIVITA.PG_PROGETTO = PROGETTO.PG_PROGETTO) CD_PROGETTO,
(Select CD_PROGETTO From PROGETTO_GEST PROGETTO_PADRE
 Where PROGETTO_PADRE.ESERCIZIO = PDG_MODULO_ENTRATE_GEST.ESERCIZIO
 And   PROGETTO_PADRE.PG_PROGETTO = (Select PG_PROGETTO From PROGETTO_GEST PROGETTO
                                     Where PDG_MODULO_ENTRATE_GEST.ESERCIZIO = PROGETTO.ESERCIZIO
                                     And   LINEA_ATTIVITA.PG_PROGETTO = PROGETTO.PG_PROGETTO)) CD_PROGETTO_PADRE,
LINEA_ATTIVITA.DS_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA,
LINEA_ATTIVITA.CD_INSIEME_LA,
LINEA_ATTIVITA.TI_GESTIONE,
LINEA_ATTIVITA.DENOMINAZIONE,
LINEA_ATTIVITA.CD_GRUPPO_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_FUNZIONE,
LINEA_ATTIVITA.CD_NATURA,
LINEA_ATTIVITA.CD_TIPO_LINEA_ATTIVITA,
LINEA_ATTIVITA.CD_CDR_COLLEGATO,
LINEA_ATTIVITA.CD_LA_COLLEGATO,
LINEA_ATTIVITA.ESERCIZIO_FINE,
LINEA_ATTIVITA.DACR,
LINEA_ATTIVITA.UTCR,
LINEA_ATTIVITA.DUVA,
LINEA_ATTIVITA.UTUV,
LINEA_ATTIVITA.PG_VER_REC,
VOCE_F_SALDI_CDR_LINEA.TI_APPARTENENZA,
VOCE_F_SALDI_CDR_LINEA.TI_GESTIONE,
VOCE_F_SALDI_CDR_LINEA.CD_ELEMENTO_VOCE,
LINEA_ATTIVITA.CD_RESPONSABILE_TERZO,
LINEA_ATTIVITA.FL_LIMITE_ASS_OBBLIG
FROM VOCE_F_SALDI_CDR_LINEA,
LINEA_ATTIVITA
WHERE
VOCE_F_SALDI_CDR_LINEA.ESERCIZIO > VOCE_F_SALDI_CDR_LINEA.ESERCIZIO_RES
And VOCE_F_SALDI_CDR_LINEA.TI_APPARTENENZA = 'C'
AND VOCE_F_SALDI_CDR_LINEA.TI_GESTIONE = 'E'
AND LINEA_ATTIVITA.TI_GESTIONE = 'E'
And LINEA_ATTIVITA.CD_CENTRO_RESPONSABILITA = VOCE_F_SALDI_CDR_LINEA.CD_CENTRO_RESPONSABILITA
AND LINEA_ATTIVITA.CD_LINEA_ATTIVITA = VOCE_F_SALDI_CDR_LINEA.CD_LINEA_ATTIVITA
*/
UNION
SELECT
ESERCIZIO 				  ,
ESERCIZIO_INIZIO           ,
CD_LINEA_ATTIVITA         ,
PG_PROGETTO,
CD_PROGETTO,
CD_PROGETTO_PADRE,
DS_LINEA_ATTIVITA         ,
CD_CENTRO_RESPONSABILITA  ,
CD_INSIEME_LA			  ,
TI_GESTIONE				  ,
DENOMINAZIONE             ,
CD_GRUPPO_LINEA_ATTIVITA  ,
CD_FUNZIONE               ,
CD_NATURA                 ,
CD_TIPO_LINEA_ATTIVITA    ,
CD_CDR_COLLEGATO		  ,
CD_LA_COLLEGATO			  ,
ESERCIZIO_FINE			  ,
DACR                      ,
UTCR                      ,
DUVA                      ,
UTUV                      ,
PG_VER_REC,
NULL,
NULL,
Null,
A.CD_RESPONSABILE_TERZO,
A.FL_LIMITE_ASS_OBBLIG
FROM
V_LINEA_ATTIVITA_VALIDA  A
WHERE
TI_GESTIONE = 'E'   AND
NOT EXISTS   ( SELECT 1
FROM   PDG_PREVENTIVO_ETR_DET B
WHERE   A.CD_LINEA_ATTIVITA = B.CD_LINEA_ATTIVITA AND
A.CD_CENTRO_RESPONSABILITA = B.CD_CENTRO_RESPONSABILITA AND
A.ESERCIZIO = B.ESERCIZIO
Union
SELECT 1
FROM   PDG_MODULO_ENTRATE_GEST B
WHERE   A.CD_LINEA_ATTIVITA = B.CD_LINEA_ATTIVITA AND
A.CD_CENTRO_RESPONSABILITA = B.CD_CENTRO_RESPONSABILITA AND
A.ESERCIZIO = B.ESERCIZIO
/*
Union
Select 1
From VOCE_F_SALDI_CDR_LINEA B
WHERE   A.CD_LINEA_ATTIVITA = B.CD_LINEA_ATTIVITA AND
A.CD_CENTRO_RESPONSABILITA = B.CD_CENTRO_RESPONSABILITA AND
A.ESERCIZIO = B.ESERCIZIO And
B.ESERCIZIO > B.ESERCIZIO_RES
*/
);