CREATE OR REPLACE package CNRCTB215 as
--
-- CNRCTB215 - Package controlli modifiche COEP/COAN
-- Date: 14/07/2006
-- Version: 1.12
--
-- Package per il controllo delle modifiche dei documenti contabili e amministrativi che generano modifiche COEP/COAN
--
-- Dependency: CNRCTB 100 IBMERR 001 IBMUTL 001
--
-- History:
--
-- Date: 02/05/2002
-- Version: 1.0
-- Creazione
--
-- Date: 07/05/2002
-- Version: 1.1
-- Completamento
--
-- Date: 15/05/2002
-- Version: 1.2
-- Miglioramento accesso a documenti amministrativi per aggiornamento stati
--
-- Date: 17/05/2002
-- Version: 1.3
-- Modificata interfaccia esterna di chiamata doRiproc
--
-- Date: 17/05/2002
-- Version: 1.3
-- Introdotti i metodi per la modifica sulla base delle differenze con una versione storica dell'obbligazione di dato pg_storico
--
-- Date: 27/05/2002
-- Version: 1.5
-- Fix errori su aggiornamento stato coge/coan
--
-- Date: 18/07/2002
-- Version: 1.6
-- Aggiornamento documentazione
--
-- Date: 28/08/2003
-- Version: 1.7
-- Fix errore su invocazione funzione di aggiornamento dello stato coge/coan doc amm
--
-- Date: 28/08/2003
-- Version: 1.8
-- Fix: aggiornamento stato coge/coan solo al cambiamento dell'elemento voce
--
-- Date: 31/01/2004
-- Version: 1.9
-- Lock del documento amministrativo di cui aggiornare lo stato coge/coan
-- Aggiornamento del solo pg_ver_rec e non di DUVA e UTUV
-- Controllo che il documento amministrativo da aggiornare NON sia gi? stato portato a nuovo esercizio anche
-- solo parzialmente
--
-- Date: 31/05/2004
-- Version: 1.10
-- Errore n. 827 nel recupero documento amministrativo: utilizzare il cds ed esercizio dell'obbligazione
--
-- Date: 02/11/2004
-- Version: 1.11
-- Errore n. 846
-- Se l'esercizio COEP del cds di origine del documento ? chiuso definitivamente
-- il documento amministrativo non ? messo "da riprocessare" e non viene sollevata eccezione
--
-- Date: 14/07/2006
-- Version: 1.12
-- Gestione Impegni/Accertamenti Residui:
-- aggiornata la funzione per tener conto anche del campo Esercizio Originale Impegno/Accertamento
--
-- Constants:

-- Functions e Procedures:

-- Aggiornamento dello stato COGE/COAN dei documenti amministrativi a seguito di modifiche su Obbligazione
--
-- Alla modifica di una obbligazione possono essere scatenate in automatico modifiche dello stato COGE e COAN dei documenti amministrativi collegati.
-- Il confronto pu? essere fatto ocon l'ultima versione presente nello storico dell'obbligazione o con versione storica identificata da progressivo aPgStorico.
--
-- pre-post-name: L'obbligazione non esiste
-- pre: Non esiste una obbligazione con esercizio/cds e pg obbligazione specificati
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Non esistono versioni storiche con cui confrontare la versione corrente dell'obbligazione
-- pre: La versione storica specificata con aPgStorico o l'ultima versione storica presente in tabella storico obbligazione (nel caso aPgStorico sia null) non viene trovata
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Aggiornamento dello stato COGE del documento amministrativo
-- pre: Lo stato COGE dei documenti amministrativi collegati alla scadenza modificata ? "contabilizzato",
-- la voce del piano dell'obbligazione ? cambiata
-- post: Viene aggiornato lo stato COGE del documento amministrativo a "da ricontabilizzare".
--
-- pre-post-name: Aggiornamento dello stato COAN del documento amministrativo
-- pre: Lo stato COAN dei documenti amministrativi collegati alla scadenza modificata ? di contabilizzato,
-- la voce del piano dell'obbligazione ? cambiata o la scadenza di obbligazione ? cambiata
-- post: Viene aggiornato lo stato COAN del documento amministrativo a "da ricontabilizzare".
--
-- Parametri
--   aEs -> esercizio dell'obbligazione
--   aCdCds -> codice del cds dell'obbligazione
--   aPgObbligazione -> progressivo dell'obbligazione
--   aPgStorico -> progressivo della versione storica dell'obbligazione da cui parte il controllo sulle differenze con la versione corrente (opzionale)
--

 procedure doRiprocObb(
  aEs number,
  aCdCds varchar2,
  aEsOri number,
  aPgObbligazione number,
  aPgStorico number default null
 );

-- Aggiornamento dello stato COGE/COAN dei documenti amministrativi a seguito di modifiche su Accertamento
--
-- Alla modifica di una accertamento possono essere scatenate in automatico modifiche dello stato COGE e COAN dei documenti amministrativi collegati.
-- Il confronto pu? essere fatto ocon l'ultima versione presente nello storico dell'accertamento con versione storica identificata da progressivo aPgStorico.
--
-- pre-post-name: L'accertamento non esiste
-- pre: Non esiste un accertamento con esercizio/cds e pg accertamento specificati
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Non esistono versioni storiche con cui confrontare la versione corrente dell'accertamento
-- pre: La versione storica specificata con aPgStorico o l'ultima versione storica presente in tabella storico accertamento (nel caso aPgStorico sia null) non viene trovata
-- post: Viene sollevata un'eccezione
--
-- pre-post-name: Aggiornamento dello stato COGE del documento amministrativo
-- pre: Lo stato COGE dei documenti amministrativi collegati alla scadenza modificata ? "contabilizzato",
-- la voce del piano dell'accertamento ? cambiata
-- post: Viene aggiornato lo stato COGE del documento amministrativo a "da ricontabilizzare".
--
-- pre-post-name: Aggiornamento dello stato COAN del documento amministrativo
-- pre: Lo stato COAN dei documenti amministrativi collegati alla scadenza modificata ? di contabilizzato,
-- la voce del piano dell'accertamento ? cambiata o la scadenza di accertamento ? cambiata
-- post: Viene aggiornato lo stato COGE del documento amministrativo a "da ricontabilizzare".
--
-- Parametri
--   aEs -> esercizio dell'accertamento
--   aCdCds -> codice del cds dell'accertamento
--   aPgAccertamento -> progressivo dell'accertamento
--   aPgStorico -> progressivo della versione storica dell'accertamento da cui parte il controllo sulle differenze con la versione corrente (opzionale)
--

 procedure doRiprocAcc(
  aEs number,
  aCdCds varchar2,
  aEsOri number,
  aPgAccertamento number,
  aPgStorico number default null
 );

 procedure doRiproc(aObb obbligazione%rowtype, aPgStorico number default null);
 procedure doRiproc(aAcc accertamento%rowtype, aPgStorico number default null);
end;
/


CREATE OR REPLACE package body         CNRCTB215 is

 function getDesc(aDocPassivo v_doc_passivo_obbligazione%rowtype) return varchar2 is
  aStringa varchar2(1000);
 begin
  aStringa:='';
  aStringa:=aStringa||' Cds:'||aDocPassivo.CD_CDS;
  aStringa:=aStringa||' Uo:'||aDocPassivo.CD_UNITA_ORGANIZZATIVA;
  aStringa:=aStringa||' Es:'||aDocPassivo.ESERCIZIO;
  aStringa:=aStringa||' Tipo:'||aDocPassivo.CD_TIPO_DOCUMENTO_AMM;
  aStringa:=aStringa||' Pg_doc:'||aDocPassivo.PG_DOCUMENTO_AMM;
  return aStringa;
 end;

 function getDesc(aDocPassivo v_doc_attivo_accertamento%rowtype) return varchar2 is
  aStringa varchar2(1000);
 begin
  aStringa:='';
  aStringa:=aStringa||' Cds:'||aDocPassivo.CD_CDS;
  aStringa:=aStringa||' Uo:'||aDocPassivo.CD_UNITA_ORGANIZZATIVA;
  aStringa:=aStringa||' Es:'||aDocPassivo.ESERCIZIO;
  aStringa:=aStringa||' Tipo:'||aDocPassivo.CD_TIPO_DOCUMENTO_AMM;
  aStringa:=aStringa||' Pg_doc:'||aDocPassivo.PG_DOCUMENTO_AMM;
  return aStringa;
 end;

 procedure aggiornaStatoCOGECOAN(aDocPassivo v_doc_passivo_obbligazione%rowtype, inCoge boolean, inCoan boolean, aUtente varchar2, aTSNow date, aPgStorico number) is
  aStatement varchar2(2000);
  aBase varchar2(500);
  aWhere varchar2(2000);
 begin
  aBase:= 'update '||CNRCTB100.GETTABELLA(aDocPassivo.cd_tipo_documento_amm)||' set ';
  aWhere:=CNRCTB100.GETTSTAWHERECONDFORKEY(
                                                           aDocPassivo.cd_tipo_documento_amm,
                                                           aDocPassivo.cd_cds,
                                                           aDocPassivo.esercizio,
                                                           aDocPassivo.cd_unita_organizzativa,
                                                           aDocPassivo.pg_documento_amm);
  if inCoge or inCoan then
   -- Lock del documento
   CNRCTB100.LOCKDOCAMM(
    aDocPassivo.cd_tipo_documento_amm,
    aDocPassivo.cd_cds,
    aDocPassivo.esercizio,
    aDocPassivo.cd_unita_organizzativa,
    aDocPassivo.pg_documento_amm
   );
   if
    CNRCTB105.ISRIPORTATO(
       aDocPassivo.cd_cds
	 , aDocPassivo.cd_unita_organizzativa
	 , aDocPassivo.esercizio
	 , aDocPassivo.pg_documento_amm
	 , aDocPassivo.cd_tipo_documento_amm
    )='Y'
   then
    -- Fix del 02/11/2004
    -- Errore n. 846
    -- Se l'esercizio COEP del cds di origine del documento ? chiuso definitivamente
	-- il documento amministrativo non ? messo "da riprocessare" e non viene sollevata eccezione
    if CNRCTB200.ISCHIUSURACOEPDEF(aDocPassivo.esercizio, aDocPassivo.cd_cds_origine)='Y' then
	 return;
	end if;
    IBMERR001.RAISE_ERR_GENERICO(
	    'Tentativo di aggiornare lo stato coge o coan in "da riprocessare" per documento amministrativo riportato a nuovo esercizio. '
	 || getDesc(aDocPassivo)
	);
   end if;
  end if;
  if inCoge then
   aStatement:=aBase||' stato_coge = '''||CNRCTB100.STATO_COEP_DA_RIP||''' ';
   if aPgStorico is null then
    aStatement:=aStatement||', pg_ver_rec = pg_ver_rec+1 ';
   end if;
   aStatement:=aStatement||aWhere||' and stato_coge = '''||CNRCTB100.STATO_COEP_CON||''' ';
   execute immediate aStatement;
  end if;
  if inCoan then
   aStatement:=aBase||' stato_coan = '''||CNRCTB100.STATO_COEP_DA_RIP||''' ';
   if aPgStorico is null then
    aStatement:=aStatement||', pg_ver_rec = pg_ver_rec+1 ';
   end if;
   aStatement:=aStatement||aWhere||' and stato_coan = '''||CNRCTB100.STATO_COEP_CON||''' ';
   execute immediate aStatement;
  end if;
 end;

Procedure aggiornaStatoCOGECOAN(aDocAttivo v_doc_attivo_accertamento%rowtype, inCoge boolean, inCoan boolean, aUtente varchar2, aTSNow date, aPgStorico number) is
  aStatement varchar2(2000);
  aBase varchar2(500);
  aWhere varchar2(2000);

Begin
  aBase:= 'update '||CNRCTB100.GETTABELLA(aDocAttivo.cd_tipo_documento_amm)||' set ';
  aWhere:=CNRCTB100.GETTSTAWHERECONDFORKEY(
                                                            aDocAttivo.cd_tipo_documento_amm,
                                                            aDocAttivo.cd_cds,
                                                            aDocAttivo.esercizio,
                                                            aDocAttivo.cd_unita_organizzativa,
                                                            aDocAttivo.pg_documento_amm);
If inCoge or inCoan then
   -- Lock del documento
   CNRCTB100.LOCKDOCAMM(
    aDocAttivo.cd_tipo_documento_amm,
    aDocAttivo.cd_cds,
    aDocAttivo.esercizio,
    aDocAttivo.cd_unita_organizzativa,
    aDocAttivo.pg_documento_amm);

   If CNRCTB105.ISRIPORTATO(
       aDocAttivo.cd_cds
	 , aDocAttivo.cd_unita_organizzativa
	 , aDocAttivo.esercizio
	 , aDocAttivo.pg_documento_amm
	 , aDocAttivo.cd_tipo_documento_amm)='Y' Then

    -- Errore n. 846
    -- Se l'esercizio COEP del cds di origine del documento ? chiuso definitivamente
    -- il documento amministrativo non ? messo "da riprocessare" e non viene sollevata eccezione

    if CNRCTB200.ISCHIUSURACOEPDEF(aDocAttivo.esercizio, aDocAttivo.cd_cds_origine) = 'Y' then
	 return;
    end if;

    IBMERR001.RAISE_ERR_GENERICO(
 'Tentativo di aggiornare lo stato coge o coan in "da riprocessare" per documento amministrativo '||
 'riportato a nuovo esercizio. '|| getDesc(aDocAttivo));
   End if;

End if;

If inCoge then
   aStatement:=aBase||' stato_coge = '''||CNRCTB100.STATO_COEP_DA_RIP||''' ';
   if aPgStorico is null then
    aStatement:=aStatement||', pg_ver_rec = pg_ver_rec+1 ';
   end if;
   aStatement:=aStatement||aWhere||' and stato_coge = '''||CNRCTB100.STATO_COEP_CON||''' ';
   execute immediate aStatement;
End if;

If inCoan then
   aStatement:=aBase||' stato_coan = '''||CNRCTB100.STATO_COEP_DA_RIP||''' ';
   if aPgStorico is null then
    aStatement:=aStatement||', pg_ver_rec = pg_ver_rec+1 ';
   end if;
   aStatement:=aStatement||aWhere||' and stato_coan = '''||CNRCTB100.STATO_COEP_CON||''' ';
   execute immediate aStatement;
End if;

End;

 procedure doRiprocAcc(
  aEs number,
  aCdCds varchar2,
  aEsOri number,
  aPgAccertamento number,
  aPgStorico number default null
 ) is
  aAcc accertamento%rowtype;
 begin
  begin
   select * into aAcc from accertamento where
        cd_cds = aCdCds
    and esercizio = aEs
    and esercizio_originale = aEsOri
    and pg_accertamento = aPgAccertamento for update nowait;
  exception when NO_DATA_FOUND then
   IBMERR001.RAISE_ERR_GENERICO('Accertamento in modifica non trovato');
  end;
  doRiproc(aAcc, aPgStorico);
 end;

 procedure doRiprocObb(
  aEs number,
  aCdCds varchar2,
  aEsOri number,
  aPgObbligazione number,
  aPgStorico number default null
 ) is
  aObb obbligazione%rowtype;
 begin
  begin
   select * into aObb from obbligazione where
        cd_cds = aCdCds
    and esercizio = aEs
    and esercizio_originale = aEsOri
    and pg_obbligazione = aPgObbligazione for update nowait;
  exception when NO_DATA_FOUND then
      If cnrutil.isLabelObbligazione() Then
        IBMERR001.RAISE_ERR_GENERICO('Obbligazione in modifica non trovata');
   	  Else
        IBMERR001.RAISE_ERR_GENERICO('Impegno in modifica non trovato');
  	  End If;
  end;
  doRiproc(aObb, aPgStorico);
 end;


 procedure doRiproc(aObb obbligazione%rowtype, aPgStorico number default null) is
  aObbS          obbligazione_s%rowtype;
  aScadS         obbligazione_scadenzario_s%rowtype;
  aScadVoceS     obbligazione_scad_voce_s%rowtype;
  isScadCambiata boolean:=false;
  isEVCambiato   boolean:=false;

 begin
  -- Legge dallo storico l'obbligazione
  begin
   if aPgStorico is null then
       select * into aObbS from obbligazione_s a where
            cd_cds = aObb.cd_cds
    	and esercizio = aObb.esercizio
    	and esercizio_originale = aObb.esercizio_originale
    	and pg_obbligazione = aObb.pg_obbligazione
    	and pg_storico_ = (select max(pg_storico_) from obbligazione_s where
               cd_cds = a.cd_cds
    	   and esercizio = a.esercizio
    	   and esercizio_originale = a.esercizio_originale
    	   and pg_obbligazione = a.pg_obbligazione
        );
   else
       select * into aObbS from obbligazione_s a where
            cd_cds = aObb.cd_cds
    	and esercizio = aObb.esercizio
    	and esercizio_originale = aObb.esercizio_originale
    	and pg_obbligazione = aObb.pg_obbligazione
    	and pg_storico_ = aPgStorico;
   end if;
  exception when NO_DATA_FOUND then
   return;
  end;

  -- Se la voce del piano ? cambiata devo riprocessare in economica e analitica ?

  isEVCambiato := false;
  if aObb.cd_elemento_voce != aObbS.cd_elemento_voce then
   isEVCambiato:=true;
  end if;

  for aScad in (select * from obbligazione_scadenzario where
        cd_cds = aObb.cd_cds
	and esercizio = aObb.esercizio
	and esercizio_originale = aObb.esercizio_originale
	and pg_obbligazione = aObb.pg_obbligazione for update nowait) loop

   isScadCambiata:=false;

   -- Se l'importo collegato a documenti amministrativi ? 0 non devo verificare eventuali modifiche dei dettagli
   if aScad.im_associato_doc_amm <> 0 then
    begin
     select * into aScadS from obbligazione_scadenzario_s where
          cd_cds = aScad.cd_cds
      and esercizio = aScad.esercizio
      and esercizio_originale = aScad.esercizio_originale
      and pg_obbligazione = aScad.pg_obbligazione
      and pg_obbligazione_scadenzario = aScad.pg_obbligazione_scadenzario
      and pg_storico_ = aObbS.pg_storico_
      and im_scadenza = aScad.im_scadenza;
    exception when NO_DATA_FOUND then
     isScadCambiata:=true;
    end;


    -- Verifica il cambiamento dei dati analitici

    -- Leggo le ripartizioni della scadenza eliminate solo se isScadCambiata ? ancora a false
	if not isScadCambiata then
        for aScadVoceEl in (Select *
                            From   obbligazione_scad_voce_s aEl
                            Where  cd_cds = aScad.cd_cds And
                                   esercizio = aScad.esercizio And
                                   esercizio_originale = aScad.esercizio_originale And
                                   pg_obbligazione = aScad.pg_obbligazione And
                                   pg_obbligazione_scadenzario = aScad.pg_obbligazione_scadenzario And
                                   pg_storico_ = aObbS.pg_storico_ And
                                   not exists (Select 1
                                               From  obbligazione_scad_voce
                                               Where cd_cds = aEl.cd_cds And
                                                     esercizio = aEl.esercizio And
                                                     esercizio_originale = aEl.esercizio_originale And
                                                     pg_obbligazione = aEl.pg_obbligazione And
                                                     pg_obbligazione_scadenzario = aEl.pg_obbligazione_scadenzario And
                                                     ti_appartenenza = aEl.ti_appartenenza And
                                                     ti_gestione = aEl.ti_gestione And
                                                     cd_voce = aEl.cd_voce And
                                                     cd_centro_responsabilita = aEl.cd_centro_responsabilita And
                                                     cd_linea_attivita = aEl.cd_linea_attivita)) loop
         isScadCambiata:=true;
    	end loop;
    end if;

    -- Analizzo le ripartizioni attuali della scadenza solo se isScadCambiata ? ancora a false
	if not isScadCambiata then
        for aScadVoce in (select * from obbligazione_scad_voce where
             cd_cds = aScad.cd_cds
         and esercizio = aScad.esercizio
    	 and esercizio_originale = aScad.esercizio_originale
         and pg_obbligazione = aScad.pg_obbligazione
         and pg_obbligazione_scadenzario = aScad.pg_obbligazione_scadenzario for update nowait) loop
    	 begin
    	  -- Leggo dallo storico la scad voce corrispondente
    	  select * into aScadVoceS from obbligazione_scad_voce_s where
               cd_cds = aScadVoce.cd_cds
           and esercizio = aScadVoce.esercizio
    	   and esercizio_originale = aScadVoce.esercizio_originale
           and pg_obbligazione = aScadVoce.pg_obbligazione
           and pg_obbligazione_scadenzario = aScadVoce.pg_obbligazione_scadenzario
       	   and pg_storico_ = aObbS.pg_storico_
           and ti_appartenenza = aScadVoce.ti_appartenenza
           and ti_gestione = aScadVoce.ti_gestione
           and cd_voce = aScadVoce.cd_voce
           and cd_centro_responsabilita = aScadVoce.cd_centro_responsabilita
           and cd_linea_attivita = aScadVoce.cd_linea_attivita
           and im_voce = aScadVoce.im_voce;
         exception when NO_DATA_FOUND then
          isScadCambiata:=true;
         end;
        end loop;
    end if;
	-- leggo i documenti per aggiornare lo stato di modifica COEP
	if isScadCambiata or isEVCambiato then
     for aDocPassivo in (select * from v_doc_passivo_obbligazione where
           cd_cds_obbligazione = aScad.cd_cds
	   and esercizio_obbligazione = aScad.esercizio
	   and esercizio_ori_obbligazione = aScad.esercizio_originale
	   and pg_obbligazione = aScad.pg_obbligazione
       and pg_obbligazione_scadenzario = aScad.pg_obbligazione_scadenzario) loop
      -- Se ? cambiato l'elemento voce da riproc. sia in analitica che in economica
	  if isEVCambiato then
	   aggiornaStatoCOGECOAN(aDocPassivo,true,true,aObb.utuv,aObb.duva,aPgStorico);
      else
       -- Se non ? cambiato l'elemento voce ma solo la spaccatura analitica, devo riprocessare solo in analitica

	   if isScadCambiata Then
            -- 29.03.2007 L'AGGIORNAMENTO DELLO STATO_COAN BLOCCAVA ALCUNE OPERAZIONI (TRA CUI L'EMISSIONE DI NOTE CREDITO)
            -- LA MODIFICA PULITA ANDREBBE FATTA CONTROLLANDO CHE LA RIPARTIZIONE PER CDR TRA PRIMA E DOPO E' DIVERSA
	    Null;
--	    aggiornaStatoCOGECOAN(aDocPassivo,false, True, aObb.utuv,aObb.duva,aPgStorico);
	   end if;
	  end if;
	 end loop;
	end if;
   end if;
  end loop;
 end;

 procedure doRiproc(aAcc accertamento%rowtype, aPgStorico number default null) is
  aAccS accertamento_s%rowtype;
  aScadS accertamento_scadenzario_s%rowtype;
  aScadVoceS accertamento_scad_voce_s%rowtype;
  isScadCambiata boolean:=false;
  isEVCambiato boolean:=false;
 begin
  -- Legge dallo storico l'accertamento
Dbms_Output.PUT_LINE ('A');
  begin
   if aPgStorico is null then
       select * into aAccS from accertamento_s a where
            cd_cds = aAcc.cd_cds
    	and esercizio = aAcc.esercizio
    	and esercizio_originale = aAcc.esercizio_originale
    	and pg_accertamento = aAcc.pg_accertamento
    	and pg_storico_ = (select max(pg_storico_) from accertamento_s where
               cd_cds = a.cd_cds
    	   and esercizio = a.esercizio
    	   and esercizio_originale = a.esercizio_originale
    	   and pg_accertamento = a.pg_accertamento
        );
   else
       select * into aAccS from accertamento_s a where
            cd_cds = aAcc.cd_cds
    	and esercizio = aAcc.esercizio
    	and esercizio_originale = aAcc.esercizio_originale
    	and pg_accertamento = aAcc.pg_accertamento
    	and pg_storico_ = aPgStorico;
    end if;
  exception when NO_DATA_FOUND then
Dbms_Output.PUT_LINE ('B');
   return;
  end;

  -- Se la voce del piano ? cambiata devo riprocessare in economica e analitica ?

  isEVCambiato:=false;
  if aAcc.cd_elemento_voce != aAccS.cd_elemento_voce then
   isEVCambiato:=true;
  end if;

Dbms_Output.PUT_LINE ('C');
  for aScad in (select * from accertamento_scadenzario where
        cd_cds = aAcc.cd_cds
	and esercizio = aAcc.esercizio
	and esercizio_originale = aAcc.esercizio_originale
	and pg_accertamento = aAcc.pg_accertamento for update nowait) loop

   isScadCambiata:=false;

   -- Se l'importo collegato a documenti amministrativi ? 0 non devo verificare eventuali modifiche dei dettagli
   if aScad.im_associato_doc_amm <> 0 then
    begin
     select * into aScadS from accertamento_scadenzario_s where
          cd_cds = aScad.cd_cds
      and esercizio = aScad.esercizio
      and esercizio_originale = aScad.esercizio_originale
      and pg_accertamento = aScad.pg_accertamento
      and pg_accertamento_scadenzario = aScad.pg_accertamento_scadenzario
 	  and pg_storico_ = aAccS.pg_storico_
	  and im_scadenza = aScad.im_scadenza;
    exception when NO_DATA_FOUND then
     isScadCambiata:=true;
    end;

Dbms_Output.PUT_LINE ('D');
    -- Verifica il cambiamento dei dati analitici

    -- Leggo le ripartizioni della scadenza eliminate solo se isScadCambiata ? ancora a false
	if not isScadCambiata then
        for aScadVoceEl in (select * from accertamento_scad_voce_s aEl where
               cd_cds = aScad.cd_cds
           and esercizio = aScad.esercizio
    	   and esercizio_originale = aScad.esercizio_originale
           and pg_accertamento = aScad.pg_accertamento
           and pg_accertamento_scadenzario = aScad.pg_accertamento_scadenzario
       	   and pg_storico_ = aAccS.pg_storico_
    	   and not exists (select 1 from accertamento_scad_voce where
                   cd_cds = aEl.cd_cds
               and esercizio = aEl.esercizio
               and esercizio_originale = aEl.esercizio_originale
               and pg_accertamento = aEl.pg_accertamento
               and pg_accertamento_scadenzario = aEl.pg_accertamento_scadenzario
               and cd_centro_responsabilita = aEl.cd_centro_responsabilita
               and cd_linea_attivita = aEl.cd_linea_attivita
    	   )) loop
         isScadCambiata:=true;
    	end loop;
    end if;

    -- Analizzo le ripartizioni attuali della scadenza solo se isScadCambiata ? ancora a false
	if not isScadCambiata then
        for aScadVoce in (select * from accertamento_scad_voce where
             cd_cds = aScad.cd_cds
         and esercizio = aScad.esercizio
    	 and esercizio_originale = aScad.esercizio_originale
         and pg_accertamento = aScad.pg_accertamento
         and pg_accertamento_scadenzario = aScad.pg_accertamento_scadenzario for update nowait) loop
    	 begin
    	  -- Leggo dallo storico la scad voce corrispondente
    	  select * into aScadVoceS from accertamento_scad_voce_s where
               cd_cds = aScadVoce.cd_cds
           and esercizio = aScadVoce.esercizio
    	   and esercizio_originale = aScadVoce.esercizio_originale
           and pg_accertamento = aScadVoce.pg_accertamento
           and pg_accertamento_scadenzario = aScadVoce.pg_accertamento_scadenzario
       	   and pg_storico_ = aAccS.pg_storico_
           and cd_centro_responsabilita = aScadVoce.cd_centro_responsabilita
           and cd_linea_attivita = aScadVoce.cd_linea_attivita
           and im_voce = aScadVoce.im_voce;
         exception when NO_DATA_FOUND then
          isScadCambiata:=true;
         end;
        end loop;
    end if;
	-- leggo i documenti per aggiornare lo stato di modifica COEP
	if isScadCambiata or isEVCambiato then
     for aDocAttivo in (select * from v_doc_attivo_accertamento where
           cd_cds_accertamento = aScad.cd_cds
	   and esercizio_accertamento = aScad.esercizio
	   and esercizio_ori_accertamento = aScad.esercizio_originale
	   and pg_accertamento = aScad.pg_accertamento
       and pg_accertamento_scadenzario = aScad.pg_accertamento_scadenzario) loop
      -- switch sul tipo di documento
	  if isEVCambiato then
	   aggiornaStatoCOGECOAN(aDocAttivo,true,true,aAcc.utuv,aAcc.duva,aPgStorico);
      else
       if isScadCambiata Then
         -- 29.03.2007 L'AGGIORNAMENTO DELLO STATO_COAN BLOCCAVA ALCUNE OPERAZIONI (TRA CUI L'EMISSIONE DI NOTE CREDITO)
         -- LA MODIFICA PULITA ANDREBBE FATTA CONTROLLANDO CHE LA RIPARTIZIONE PER CDR TRA PRIMA E DOPO E' DIVERSA
         Null;
--	    aggiornaStatoCOGECOAN(aDocAttivo,false,true,aAcc.utuv,aAcc.duva,aPgStorico);
	   end if;
	  end if;
	 end loop;
	end if;
   end if;
  end loop;
 end;
end;
/


