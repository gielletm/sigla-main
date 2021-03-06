--------------------------------------------------------
--  DDL for Package CNRCTB105
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "CNRCTB105" as
--
-- CNRCTB105 - Package gestione applicativa documenti amministrativi
-- Date: 03/11/2004
-- Version: 1.13
--
-- Package gestione applicativa documenti amministrativi
-- in ottica di chiusura contabile
--
-- Dependency:
--
-- History:
--
-- Date: 06/06/2003
-- Version: 1.0
-- Creazione
--
-- Date: 16/06/2003
-- Version: 1.1
-- Fix
--
-- Date: 23/06/2003
-- Version: 1.2
-- Corretta impostazione stato
--
-- Date: 30/06/2003
-- Version: 1.3
-- Fix per fatture create da compenso
--
-- Date: 15/07/2003
-- Version: 1.4
-- Aggiunto metodo isRiportato
-- Gestione di tutte le tipologie di documenti
--
-- Date: 16/07/2003
-- Version: 1.5
-- Fix per compenso con cori negativi
--
-- Date: 16/07/2003
-- Version: 1.6
-- Fix errore in isRiportato: semantica invertita
--
-- Date: 17/07/2003
-- Version: 1.7
-- Fix getStatoRiportato per missioni provvisorie o con anticipo> missione
--
-- Date: 15/09/2003
-- Version: 1.8
-- Aggiunta documentazione pre-post conditions
--
-- Date: 30/01/2004
-- Version: 1.9
-- Il metodo isRiportato non funzionava correttamente su ANTICIPO
--
-- Date: 13/10/2004
-- Version: 1.10
-- Fix al metodo getStatoRiportato
--
-- Date: 26/10/2004
-- Version: 1.11
-- Aggiunta metodo getStatoRiportatoInScrivania() e relativi metodi privati
--
-- Date: 02/11/2004
-- Version: 1.12
-- Fix al metodo getStatoRiportato per gestione rimborso/anticipo
--
-- Date: 03/11/2004
-- Version: 1.13
-- Se il documento non è mai stato riportato, getStatoRiportatoInScrivania
-- ritorna NON_RIPORTATO
--
-- Constants:

-- Stati del documento
COMPLETAMENTE_RIPORTATO CONSTANT CHAR(1) := 'R';
NON_RIPORTATO CONSTANT CHAR(1) := 'N';
PARZIALMENTE_RIPORTATO CONSTANT CHAR(1) := 'Q';

-- Functions e Procedures:
--
-- getStatoRiportato
-- =================
--
-- pre-post name: Documento amministrativo non valido
-- pre: documento amministrativo diverso da documento generico, fattura passiva,
--      fattura attiva, rimborso, anticipo, compenso, missione
-- post: viene sollevato un errore
--
-- Casi richiamati dalle pre-post conditions:
-- A1. si distinguono i seguenti casi:
--       1. esercizio del documento amm pari all'esercizio di scrivania e pari
--          all'esercizio degli accertamenti: documento non riportato, ritorna 'N'
--       2. esercizio del documento amm pari all'esercizio di scrivania, esercizio
--          degli accertamenti diverso dall'esercizio di scrivania: documento
--          riportato, ritorna 'R'
--       3. esercizio di scrivania diverso dall'esercizio del documento amm ed
--          esercizio degli accertamenti pari all'esercizio di scrivania: documento
--          non riportato, ritorna 'N'
--       4. altri casi (esercizio del documento amm diverso da esercizio di
--          scrivania ed esercizio degli accertamenti diverso dall'esercizio
--          del documento amm): documento riportato, ritorna 'R'
--
-- A2. si distinguono i seguenti casi:
--       1. esercizio del documento amm pari all'esercizio di scrivania e pari
--          al massimo esercizio degli accertamenti: documento non riportato, ritorna 'N'
--       2. esercizio del documento amm pari all'esercizio di scrivania, massimo
--          esercizio degli accertamenti diverso dall'esercizio di scrivania: documento
--          parzialmente riportato, ritorna 'Q'
--       3. esercizio di scrivania diverso dall'esercizio del documento amm e
--          massimo esercizio degli accertamenti pari all'esercizio di scrivania:
--          documento non riportato, ritorna 'N'
--       4. altri casi (esercizio del documento amm diverso da esercizio di
--          scrivania e massimo esercizio degli accertamenti diverso dall'esercizio
--          del documento amm): documento parzialmente riportato, ritorna 'Q'
--
-- B1. si distinguono i seguenti casi:
--       1. esercizio del documento amm pari all'esercizio di scrivania e pari
--          all'esercizio delle obbligazioni: documento non riportato, ritorna 'N'
--       2. esercizio del documento amm pari all'esercizio di scrivania, esercizio
--          delle obbligazioni diverso dall'esercizio di scrivania: documento
--          riportato, ritorna 'R'
--       3. esercizio di scrivania diverso dall'esercizio del documento amm ed
--          esercizio delle obbligazioni pari all'esercizio di scrivania: documento
--          non riportato, ritorna 'N'
--       4. altri casi (esercizio del documento amm diverso da esercizio di
--          scrivania ed esercizio delle obbligazioni diverso dall'esercizio
--          del documento amm): documento riportato, ritorna 'R'
--
-- B2. si distinguono i seguenti casi:
--       1. esercizio del documento amm pari all'esercizio di scrivania e pari
--          al massimo esercizio delle obbligazioni: documento non riportato, ritorna 'N'
--       2. esercizio del documento amm pari all'esercizio di scrivania, massimo
--          esercizio delle obbligazioni diverso dall'esercizio di scrivania: documento
--          parzialmente riportato, ritorna 'Q'
--       3. esercizio di scrivania diverso dall'esercizio del documento amm e
--          massimo esercizio delle obbligazion pari all'esercizio di scrivania:
--          documento non riportato, ritorna 'N'
--       4. altri casi (esercizio del documento amm diverso da esercizio di
--          scrivania e massimo esercizio delle obbligazioni diverso dall'esercizio
--          del documento amm): documento parzialmente riportato, ritorna 'Q'
--
-- =============================
-- = OSSERVAZIONI (25/10/2004) =
-- =============================
-- Il metodo ha lo scopo di verificare se il documento amministrativo è stato riportato dall'esercizio
-- di scrivania ad esercizi successivi, totalmente e parzialmente. Viene utilizzato per l'interfaccia
-- grafica, per l'abilitazione/disabilitazione dei pulsanti di riporto/deriporto/annulla (concorrentemente
-- ad altre condizioni!).
-- I casi 1-2-3-4 elencati sopra, sono i casi significativi. In realtà le condizioni di relazione fra
-- esercizio doc contabile, esercizio doc amministrativo ed esercizio di scrivania sono:
-- 			 - esDocAmm <= esDocCont
-- 			 - esDocAmm <= esScr
-- 			 - esDocCont >=< esScr
-- quindi i casi reali sono 6:
-- 		  1. esDocAmm = esDocCont = esScr (=> pre-post n.1)
-- 		  2. esDocAmm = esDocCont < esScr (non significativo - documento comunque non modificabile)
-- 		  3. esDocAmm < esDocCont = esScr (=> pre-post n.3)
-- 		  4. esDocAmm = esScr < esDocCont (=> pre-post n.2)
-- 		  5. esDocAmm < esDocCont < esScr (non significativo - documento comunque non modificabile)
-- 		  6. esDocAmm < esScr < esDocCont (=> pre-post n.4)
-- Ma quelli significativi sono i 4 già esamintati. Nei due casi non significativi 2 e 5 si è scelto
-- di ritornare NON_RIPORTATO, per non dare l'informazione scorretta sullo stato del documento
-- comunque bloccato in modifica da altre condizioni.
-- =============================
--
-- pre-post name: Documento generico di entrata, righe contabilizzate sullo stesso
--                esercizio
-- pre: la chiave del documento amministrativo identifica un documento generico
--      di entrata, le righe del documento generico sono contabilizzate su accertamenti
--      dello stesso esercizio
-- post: si veda A1.
--
-- pre-post name: Documento generico di entrata, righe contabilizzate sul esercizi
--                diversi
-- pre: la chiave del documento amministrativo identifica un documento generico
--      di entrata, le righe del documento generico sono contabilizzate su accertamenti
--      di esercizi diversi
-- post: si veda A2.
--
-- pre-post name: Documento generico di spesa, righe contabilizzate sullo stesso
--                esercizio
-- pre: la chiave del documento amministrativo identifica un documento generico
--      di spesa, le righe del documento generico sono contabilizzate su obbligazioni
--      dello stesso esercizio
-- post: si veda B1.
--
-- pre-post name: Documento generico di spesa, righe contabilizzate sul esercizi
--                diversi
-- pre: la chiave del documento amministrativo identifica un documento generico
--      di spesa, le righe del documento generico sono contabilizzate su obbligazioni
--      di esercizi diversi
-- post: si veda B2.
--
-- pre-post name: Fattura passiva: nota di credito sull'ente, righe contabilizzate
--                sullo stesso esercizio
-- pre: la chiave del documento amministrativo identifica una fattura passiva,
--      le righe della nota di credito sull'ente sono contabilizzate su accertamenti
--      dello stesso esercizio
-- post: si veda A1.
--
-- pre-post name: Fattura passiva: nota di credito sull'ente, righe contabilizzate
--                su esercizi diversi
-- pre: la chiave del documento amministrativo identifica una fattura passiva,
--      le righe della nota di credito sull'ente sono contabilizzate su accertamenti
--      di esercizi diversi
-- post: si veda A2.
--
-- pre-post name: Fattura passiva e note di debito, righe contabilizzate sullo
--                stesso esercizio
-- pre: la chiave del documento amministrativo identifica una fattura passiva,
--      le righe della fattura passiva sono contabilizzate su obbligazioni
--      dello stesso esercizio
-- post: si veda B1.
--
-- pre-post name: Fattura passiva e note di debito, righe contabilizzate su
--                esercizi diversi
-- pre: la chiave del documento amministrativo identifica una fattura passiva,
--      le righe della fattura passiva sono contabilizzate su obbligazioni
--      di esercizi diversi
-- post: si veda B2.
--
-- pre-post name: Fattura attiva, nota di debito o nota di credito su accertamento,
--                righe contabilizzate sullo stesso esercizio
-- pre: la chiave del documento amministrativo identifica una fattura attiva,
--      le righe della fattura attiva sono contabilizzate su accertamenti
--      dello stesso esercizio
-- post: si veda A1.
--
-- pre-post name: Fattura attiva, nota di debito o nota di credito su accertamento,
--                righe contabilizzate sul esercizi diversi
-- pre: la chiave del documento amministrativo identifica una fattura attiva,
--      le righe della fattura attiva sono contabilizzate su accertamenti
--      di esercizi diversi
-- post: si veda A2.
--
-- pre-post name: Fattura attiva: nota di credito su obbligazione, righe
--                contabilizzate sullo stesso esercizio
-- pre: la chiave del documento amministrativo identifica una fattura attiva,
--      le righe della fattura attiva sono contabilizzate su obbligazioni
--      dello stesso esercizio
-- post: si veda B1.
--
-- pre-post name: Fattura attiva: nota di credito su obbligazione, righe
--                contabilizzate su esercizi diversi di obbligazioni
-- pre: la chiave del documento amministrativo identifica una fattura attiva,
--      le righe della fattura attiva sono contabilizzate su obbligazioni
--      di esercizi diversi
-- post: si veda B2.
--
-- pre-post name: Rimborso
-- pre: la chiave del documento amministrativo identifica un rimborso
-- post: si veda A1.
--
-- pre-post name: Anticipo
-- pre: la chiave del documento amministrativo identifica un anticipo
-- post: si veda B1.
--
-- pre-post name: Compenso associato a linea di attività
-- pre: la chiave del documento amministrativo identifica un compenso, il compenso
--      non è associato a obbligazione ma a linea di attività
-- post: si distinguono i casi:
--       1. esercizio del documento pari all'esercizio di scrivania: documento
--          non riportato, ritorna 'N'
--       2. esercizio del documento minore dell'esercizio di scrivania: documento
--          riportato, ritorna 'R'
--
-- pre-post name: Compenso associato ad obbligazione
-- pre: la chiave del documento amministrativo identifica un compenso, il compenso
--      è associato ad obbligazione
-- post: si veda B1.
--
-- pre-post name: Missione non associata a compenso, o missione provvisoria
-- pre: la chiave del documento amministrativo identifica una missione, la missione
--      è provvisoria oppure non associata a compenso
-- post: se la missione non è associata a obbligazione:
--       1. esercizio del documento pari all'esercizio di scrivania: documento
--          non riportato, ritorna 'N'
--       2. esercizio del documento minore dell'esercizio di scrivania: documento
--          riportato, ritorna 'R'
--       se la missione è associata a obbligazione: si veda B1.
--
-- pre-post name: Missione associata a compenso
-- pre: la chiave del documento amministrativo identifica una missione, la missione
--      è associata a compenso
-- post: ritorna lo stato del compenso - si veda pre-post relative al compenso

-- Verifica lo stato dei documenti contabili collegati alle righe dei documenti amministrativi
-- Parametri:
-- (aCdCds, aCdUo, aEs, aPg, aTipoDocAmm) identifica il documento amministrativo
-- aEsScr: esercizio di scrivania rispetto al quale è necessario verificare lo stato
-- Return: 'N' : documenti contabili non riportati in nessuna riga
-- 		   'Q' : documenti contabili riportati per alcune righe
-- 		   'R' : documenti contabili riportati per tutte le righe
--
function getStatoRiportato(aCdCds varchar2,aCdUo varchar2, aEs number, aPg number, aCdTipoDocAmm varchar2, aEsScr number) return varchar2;

-- Verifica se il documento risulta riportato ad esercizio diverso da quello del documento
-- Parametri:
-- (aCdCds, aCdUo, aEs, aPg, aTipoDocAmm) identifica il documento amministrativo
-- Return: 'N' : documenti contabili non riportati per tutte le righe
-- 		   'Y' : documenti contabili riportati per almeno una riga
--
function isRiportato(aCdCds varchar2,aCdUo varchar2, aEs number, aPg number, aCdTipoDocAmm varchar2) return varchar2;

-- Stabilisce se il documento amministrativo è stato riportato totalmente o parzialmente
-- nell'esercizio di scrivania, e non a successivi
-- Parametri:
-- (aCdCds, aCdUo, aEs, aPg, aTipoDocAmm) identifica il documento amministrativo
-- aEsScr: esercizio di scrivania rispetto al quale è necessario verificare lo stato
-- Return: 'N' : documenti contabili non riportati in nessuna riga
-- 		   'Q' : documenti contabili riportati all'esercizio di scrivania per alcune righe
-- 		   'R' : documenti contabili riportati all'esercizio di scrivania (e non a successivi!) per tutte le righe
function getStatoRiportatoInScrivania(aCdCds varchar2,aCdUo varchar2, aEs number, aPg number, aCdTipoDocAmm varchar2, aEsScr number) return varchar2;

END;
