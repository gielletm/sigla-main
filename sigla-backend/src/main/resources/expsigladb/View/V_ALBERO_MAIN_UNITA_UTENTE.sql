--------------------------------------------------------
--  DDL for View V_ALBERO_MAIN_UNITA_UTENTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_ALBERO_MAIN_UNITA_UTENTE" ("ESERCIZIO", "CD_UTENTE", "CD_UNITA_ORGANIZZATIVA", "CD_NODO", "CD_NODO_PADRE", "CD_ACCESSO", "CD_PROPRIO_NODO", "DS_NODO", "TI_FUNZIONE", "FL_TERMINALE", "BUSINESS_PROCESS", "URL_ICONA", "URL_ICONA_OPEN", "PG_ORDINAMENTO", "LIVELLO", "DACR", "UTCR", "DUVA", "UTUV", "PG_VER_REC") AS 
  Select
--
-- Date: 26/03/2008
-- Version: 2.5
--
-- History:
--
-- Date: 01/07/2001
-- Version: 1.0
-- Creazione
--
-- Date: 10/07/2001
-- Version: 2.0
-- Fix errori di estrazioni nodi terminali per utente amministratore
--
-- Date: 13/09/2001
-- Version: 2.1
-- Modifiche
--
-- Date: 14/11/2001
-- Version: 2.2
-- Revisione della vista per eliminazione prodotti cartesiani inutili
-- Introdotto ESERCIZIO IN INTERFACCIA
--
-- Date: 19/04/2006
-- Version: 2.3
-- Introduzione filtro su esercizio iniziale e finale di validità del BP
--
-- Date: 30/07/2007
-- Version: 2.4
-- Introduzione filtro utente.fl_supervisore, con utilizzo di ruolo definito
-- su utente.cd_ruolo_supervisore
--
-- Date: 26/03/2008
-- Version: 2.5
-- Modifica accesso a filtro utente.fl_supervisore non più presente su tabella
-- TIPO_RUOLO ma su ASS_TIPO_RUOLO_PRIVILEGIO
--
-- Body:
--
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- UTENTE_UNITA_ACCESSO
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- UTENTE_UNITA_ACCESSO perche ereditati da utenza template
 --
V_UNITA_ORGANIZZATIVA.ESERCIZIO,
UTENTE.CD_UTENTE,
V_UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
ASS_BP_ACCESSO.TI_FUNZIONE,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
ASS_BP_ACCESSO,
ALBERO_MAIN,
UTENTE,
V_UNITA_ORGANIZZATIVA
WHERE
 ASS_BP_ACCESSO.CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
 ASS_BP_ACCESSO.BUSINESS_PROCESS = ALBERO_MAIN.BUSINESS_PROCESS AND
 (ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO >= ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA) And
 (ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO <= ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA) And
 exists (select 1 from utente_unita_accesso where
           CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
           CD_UNITA_ORGANIZZATIVA = V_UNITA_ORGANIZZATIVA.CD_UO AND
           CD_UTENTE in (UTENTE.CD_UTENTE, UTENTE.CD_UTENTE_TEMPL)
		)
UNION
Select
 --
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- UTENTE_UNITA_ACCESSO con UO = '*'
 --
0, -- Esercizio indefinito
UTENTE.CD_UTENTE,
'*',
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
ASS_BP_ACCESSO.TI_FUNZIONE,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
ASS_BP_ACCESSO,
ALBERO_MAIN,
UTENTE
WHERE
ASS_BP_ACCESSO.CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
ASS_BP_ACCESSO.BUSINESS_PROCESS = ALBERO_MAIN.BUSINESS_PROCESS AND
Exists (select 1 from utente_unita_accesso where
           CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
           CD_UNITA_ORGANIZZATIVA = '*' AND
           CD_UTENTE = UTENTE.CD_UTENTE
		)
UNION
Select
 --
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- UTENTE_UNITA_RUOLO
 --
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- UTENTE_UNITA_RUOLO perche ereditati da UTENTE TEMPLATE
 --
V_UNITA_ORGANIZZATIVA.ESERCIZIO,
UTENTE.CD_UTENTE,
V_UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
ASS_BP_ACCESSO.TI_FUNZIONE,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
ASS_BP_ACCESSO,
ALBERO_MAIN,
UTENTE,
V_UNITA_ORGANIZZATIVA
WHERE
ASS_BP_ACCESSO.CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
ASS_BP_ACCESSO.BUSINESS_PROCESS = ALBERO_MAIN.BUSINESS_PROCESS AND
 (ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO >= ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA) And
 (ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO <= ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA) And
exists (select 1 from utente_unita_ruolo a where
           a.CD_UNITA_ORGANIZZATIVA = V_UNITA_ORGANIZZATIVA.CD_UO AND
           a.CD_UTENTE in (UTENTE.CD_UTENTE, UTENTE.CD_UTENTE_TEMPL) AND
		   exists (select 1 from RUOLO_ACCESSO where
		        cd_ruolo = a.CD_RUOLO
			and cd_accesso = ALBERO_MAIN.CD_ACCESSO
		   )
		)
UNION
Select
 --
 -- Selezione dei nodi di albero main su cui l'utente ha accesso a livello di
 -- RUOLO con cd_ruolo inserito sul record utente se fl_supervisore='Y'
 --
V_UNITA_ORGANIZZATIVA.ESERCIZIO,
UTENTE.CD_UTENTE,
V_UNITA_ORGANIZZATIVA.CD_UNITA_ORGANIZZATIVA,
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
ASS_BP_ACCESSO.TI_FUNZIONE,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
ASS_BP_ACCESSO,
ALBERO_MAIN,
UTENTE,
V_UNITA_ORGANIZZATIVA
WHERE
ASS_BP_ACCESSO.CD_ACCESSO = ALBERO_MAIN.CD_ACCESSO AND
ASS_BP_ACCESSO.BUSINESS_PROCESS = ALBERO_MAIN.BUSINESS_PROCESS AND
 (ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO >= ASS_BP_ACCESSO.ESERCIZIO_INIZIO_VALIDITA) And
 (ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA Is Null Or
  V_UNITA_ORGANIZZATIVA.ESERCIZIO <= ASS_BP_ACCESSO.ESERCIZIO_FINE_VALIDITA) And
  utente.fl_supervisore='Y' And
    exists (select 1
            from RUOLO_ACCESSO, RUOLO, ASS_TIPO_RUOLO_PRIVILEGIO
            where RUOLO_ACCESSO.CD_RUOLO=RUOLO.CD_RUOLO
            And RUOLO.TIPO=ASS_TIPO_RUOLO_PRIVILEGIO.TIPO
            --And TIPO_RUOLO.FL_SUPERVISORE='Y'
            and ASS_TIPO_RUOLO_PRIVILEGIO.CD_PRIVILEGIO='SUPVIS'
	        And RUOLO_ACCESSO.cd_ruolo = utente.CD_RUOLO_SUPERVISORE
			And RUOLO_ACCESSO.cd_accesso = ALBERO_MAIN.CD_ACCESSO
		   )
Union
Select
 --
 -- Selezione dei nodi non terminali di albero main con cd_unita_organizzativa presente
 -- in tabella UNITA_ORGANIZZATIVA
 --
ESERCIZIO_BASE.ESERCIZIO,
UTENTE.CD_UTENTE,
UNITA_ORGANIZZATIVA.cd_unita_organizzativa,
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
NULL,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
ALBERO_MAIN,
UTENTE,
UNITA_ORGANIZZATIVA,
ESERCIZIO_BASE
WHERE
ALBERO_MAIN.FL_TERMINALE = 'N'
UNION
Select
 --
 -- Selezione dei nodi non terminali di albero main con cd_unita_organizzativa = '*'
 --
0,
UTENTE.CD_UTENTE,
'*',
ALBERO_MAIN.CD_NODO,
ALBERO_MAIN.CD_NODO_PADRE,
ALBERO_MAIN.CD_ACCESSO,
ALBERO_MAIN.CD_PROPRIO_NODO,
ALBERO_MAIN.DS_NODO,
NULL,
ALBERO_MAIN.FL_TERMINALE,
ALBERO_MAIN.BUSINESS_PROCESS,
ALBERO_MAIN.URL_ICONA,
ALBERO_MAIN.URL_ICONA_OPEN,
ALBERO_MAIN.PG_ORDINAMENTO,
ALBERO_MAIN.LIVELLO,
ALBERO_MAIN.DACR,
ALBERO_MAIN.UTCR,
ALBERO_MAIN.DUVA,
ALBERO_MAIN.UTUV,
ALBERO_MAIN.PG_VER_REC
FROM
UTENTE,
ALBERO_MAIN
WHERE
ALBERO_MAIN.FL_TERMINALE = 'N';

   COMMENT ON TABLE "V_ALBERO_MAIN_UNITA_UTENTE"  IS 'Dato un utente, data una unità organizzativa, restituisce lo elenco di tutti i nodi di ALBERO_MAIN a cui UTENTE ha accesso diretto o indiretto';