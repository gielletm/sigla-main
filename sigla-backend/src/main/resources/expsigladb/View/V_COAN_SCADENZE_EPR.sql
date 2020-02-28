--------------------------------------------------------
--  DDL for View V_COAN_SCADENZE_EPR
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_COAN_SCADENZE_EPR" ("CD_TIPO_DOCUMENTO_AMM", "CD_TERZO", "CD_CDS", "CD_UNITA_ORGANIZZATIVA", "ESERCIZIO", "PG_NUMERO_DOCUMENTO", "TI_FATTURA", "CD_CDS_OBB_ACC", "ESERCIZIO_OBB_ACC", "ESERCIZIO_ORI_OBB_ACC", "PG_OBB_ACC", "PG_OBB_ACC_SCADENZARIO", "IM_DIPONIBILE_NC", "IM_IMPONIBILE", "IM_IVA", "IM_IVA_DETRAIBILE", "IM_TOTALE", "TI_APPARTENENZA", "TI_GESTIONE", "CD_ELEMENTO_VOCE", "IM_SCADENZA", "FL_OBBIGAZIONE") AS 
  SELECT
--
-- Date: 18/07/2006
-- Version: 1.6
--
-- Vista di estrazione del dettaglio delle scadenze di OBB_ACC relative ai documenti gestiti nella movimentazione coan
--
-- History:
--
-- Date: 28/01/2004
-- Version: 1.0
-- Creazione
--
-- Date: 17/02/2004
-- Version: 1.4
-- Fix errore di calcolo del costo in fattura commerciale come imponibile + iva - iva detraibile
--
-- Date: 03/03/2004
-- Version: 1.5
-- Fix errore estrazione doc attivi
--
-- Date: 18/07/2006
-- Version: 1.6
-- Gestione Impegni/Accertamenti Residui:
-- gestito il nuovo campo ESERCIZIO_ORIGINALE
--
-- Body:
--
        V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.TI_FATTURA
	   ,O_SCAD.CD_CDS
	   ,O_SCAD.ESERCIZIO
	   ,O_SCAD.ESERCIZIO_ORIGINALE
	   ,O_SCAD.PG_OBBLIGAZIONE
	   ,O_SCAD.PG_OBBLIGAZIONE_SCADENZARIO
	   ,SUM(NVL(V.IM_DIPONIBILE_NC,0)) IM_DIPONIBILE_NC
	   ,SUM(NVL(V.IM_IMPONIBILE,0))    IM_IMPONIBILE
	   ,SUM(NVL(V.IM_IVA,0))    IM_IVA
	   ,SUM(NVL(V.IM_IVA_DETRAIBILE,0))  IM_IVA_DETRAIBILE
	   ,SUM(DECODE(V.TI_ISTITUZ_COMMERC,'C',V.IM_IMPONIBILE + V.IM_IVA - V.IM_IVA_DETRAIBILE,V.IM_IMPONIBILE + V.IM_IVA )) IM_TOTALE
	   ,OBBL.TI_APPARTENENZA
	   ,OBBL.TI_GESTIONE
	   ,OBBL.CD_ELEMENTO_VOCE
	   ,O_SCAD.IM_SCADENZA
	   ,V.FL_OBBIGAZIONE
FROM V_COAN_DOCUMENTI_DETT V
     ,OBBLIGAZIONE IOBBL
	 ,OBBLIGAZIONE_SCADENZARIO IO_SCAD
     ,OBBLIGAZIONE OBBL
	 ,OBBLIGAZIONE_SCADENZARIO O_SCAD
WHERE
      V.ESERCIZIO_OBB_ACC = V.ESERCIZIO + 1
  AND V.CD_CDS_OBB_ACC    = IOBBL.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = IOBBL.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = IOBBL.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = IOBBL.PG_OBBLIGAZIONE
  AND V.CD_CDS_OBB_ACC    = IO_SCAD.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = IO_SCAD.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = IO_SCAD.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = IO_SCAD.PG_OBBLIGAZIONE
  AND V.PG_OBB_ACC_SCADENZARIO = IO_SCAD.PG_OBBLIGAZIONE_SCADENZARIO
  AND O_SCAD.CD_CDS = IOBBL.CD_CDS_ORI_RIPORTO
  AND O_SCAD.ESERCIZIO = IOBBL.ESERCIZIO_ORI_RIPORTO
  AND O_SCAD.ESERCIZIO_ORIGINALE = IOBBL.ESERCIZIO_ORI_ORI_RIPORTO
  AND O_SCAD.PG_OBBLIGAZIONE = IOBBL.PG_OBBLIGAZIONE_ORI_RIPORTO
  AND O_SCAD.PG_OBBLIGAZIONE_SCADENZARIO = IO_SCAD.PG_OBBL_SCAD_ORI_RIPORTO
  AND OBBL.CD_CDS = O_SCAD.CD_CDS
  AND OBBL.ESERCIZIO = O_SCAD.ESERCIZIO
  AND OBBL.ESERCIZIO_ORIGINALE = O_SCAD.ESERCIZIO_ORIGINALE
  AND OBBL.PG_OBBLIGAZIONE = O_SCAD.PG_OBBLIGAZIONE
  and V.FL_OBBIGAZIONE = 'Y'
  and not exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC > V.ESERCIZIO + 1
  )
GROUP BY V.CD_TIPO_DOCUMENTO_AMM
	    ,V.CD_TERZO
        ,V.CD_CDS
	    ,V.CD_UNITA_ORGANIZZATIVA
	    ,V.ESERCIZIO
	    ,V.PG_NUMERO_DOCUMENTO
        ,V.TI_FATTURA
	    ,O_SCAD.CD_CDS
	    ,O_SCAD.ESERCIZIO
	    ,O_SCAD.ESERCIZIO_ORIGINALE
	    ,O_SCAD.PG_OBBLIGAZIONE
	    ,O_SCAD.PG_OBBLIGAZIONE_SCADENZARIO
	    ,OBBL.TI_APPARTENENZA
	    ,OBBL.TI_GESTIONE
	    ,OBBL.CD_ELEMENTO_VOCE
	    ,O_SCAD.IM_SCADENZA
	    ,V.FL_OBBIGAZIONE
UNION ALL
 select
        V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.TI_FATTURA
	   ,V.CD_CDS_OBB_ACC
	   ,V.ESERCIZIO_OBB_ACC
	   ,V.ESERCIZIO_ORI_OBB_ACC
	   ,V.PG_OBB_ACC
	   ,V.PG_OBB_ACC_SCADENZARIO
	   ,SUM(NVL(V.IM_DIPONIBILE_NC,0)) IM_DIPONIBILE_NC
	   ,SUM(NVL(V.IM_IMPONIBILE,0))    IM_IMPONIBILE
	   ,SUM(NVL(V.IM_IVA,0))    IM_IVA
	   ,SUM(NVL(V.IM_IVA_DETRAIBILE,0))  IM_IVA_DETRAIBILE
	   ,SUM(DECODE(V.TI_ISTITUZ_COMMERC,'C',V.IM_IMPONIBILE + V.IM_IVA - V.IM_IVA_DETRAIBILE,V.IM_IMPONIBILE + V.IM_IVA )) IM_TOTALE
	   ,OBBL.TI_APPARTENENZA
	   ,OBBL.TI_GESTIONE
	   ,OBBL.CD_ELEMENTO_VOCE
	   ,O_SCAD.IM_SCADENZA
	   ,V.FL_OBBIGAZIONE
FROM V_COAN_DOCUMENTI_DETT V
     ,OBBLIGAZIONE OBBL
	 ,OBBLIGAZIONE_SCADENZARIO O_SCAD
WHERE
      V.ESERCIZIO_OBB_ACC = V.ESERCIZIO
  AND V.CD_CDS_OBB_ACC    = OBBL.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = OBBL.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = OBBL.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = OBBL.PG_OBBLIGAZIONE
  AND V.CD_CDS_OBB_ACC    = O_SCAD.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = O_SCAD.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = O_SCAD.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = O_SCAD.PG_OBBLIGAZIONE
  AND V.PG_OBB_ACC_SCADENZARIO = O_SCAD.PG_OBBLIGAZIONE_SCADENZARIO
  and V.FL_OBBIGAZIONE = 'Y'
  and exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC = V.ESERCIZIO + 1
  )
  and not exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC > V.ESERCIZIO + 1
  )
GROUP BY V.CD_TIPO_DOCUMENTO_AMM
	    ,V.CD_TERZO
        ,V.CD_CDS
	    ,V.CD_UNITA_ORGANIZZATIVA
	    ,V.ESERCIZIO
	    ,V.PG_NUMERO_DOCUMENTO
        ,V.TI_FATTURA
	    ,V.CD_CDS_OBB_ACC
	    ,V.ESERCIZIO_OBB_ACC
	    ,V.ESERCIZIO_ORI_OBB_ACC
	    ,V.PG_OBB_ACC
	    ,V.PG_OBB_ACC_SCADENZARIO
	    ,OBBL.TI_APPARTENENZA
	    ,OBBL.TI_GESTIONE
	    ,OBBL.CD_ELEMENTO_VOCE
	    ,O_SCAD.IM_SCADENZA
	    ,V.FL_OBBIGAZIONE
union all
SELECT
        V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.TI_FATTURA
	   ,A_SCAD.CD_CDS
	   ,A_SCAD.ESERCIZIO
       ,A_SCAD.ESERCIZIO_ORIGINALE
       ,A_SCAD.PG_ACCERTAMENTO
	   ,A_SCAD.PG_ACCERTAMENTO_SCADENZARIO
	   ,SUM(NVL(V.IM_DIPONIBILE_NC,0)) IM_DIPONIBILE_NC
	   ,SUM(NVL(V.IM_IMPONIBILE,0))    IM_IMPONIBILE
	   ,SUM(NVL(V.IM_IVA,0))    IM_IVA
	   ,SUM(NVL(V.IM_IVA_DETRAIBILE,0))  IM_IVA_DETRAIBILE
	   ,SUM(DECODE(V.TI_ISTITUZ_COMMERC,'C',V.IM_IMPONIBILE + V.IM_IVA - V.IM_IVA_DETRAIBILE,V.IM_IMPONIBILE + V.IM_IVA )) IM_TOTALE
	   ,ACC.TI_APPARTENENZA
	   ,ACC.TI_GESTIONE
	   ,ACC.CD_ELEMENTO_VOCE
	   ,A_SCAD.IM_SCADENZA
       ,V.FL_OBBIGAZIONE
FROM V_COAN_DOCUMENTI_DETT V
	 , ACCERTAMENTO ACC
	 , ACCERTAMENTO_SCADENZARIO A_SCAD
	 , ACCERTAMENTO IACC
	 , ACCERTAMENTO_SCADENZARIO IA_SCAD
WHERE
      V.ESERCIZIO_OBB_ACC = V.ESERCIZIO + 1
  AND V.CD_CDS_OBB_ACC    = IACC.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = IACC.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = IACC.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = IACC.PG_ACCERTAMENTO
  AND V.CD_CDS_OBB_ACC    = IA_SCAD.CD_CDS
  AND V.ESERCIZIO_OBB_ACC = IA_SCAD.ESERCIZIO
  AND V.ESERCIZIO_ORI_OBB_ACC = IA_SCAD.ESERCIZIO_ORIGINALE
  AND V.PG_OBB_ACC        = IA_SCAD.PG_ACCERTAMENTO
  AND V.PG_OBB_ACC_SCADENZARIO = IA_SCAD.PG_ACCERTAMENTO_SCADENZARIO
  AND A_SCAD.CD_CDS = IACC.CD_CDS_ORI_RIPORTO
  AND A_SCAD.ESERCIZIO = IACC.ESERCIZIO_ORI_RIPORTO
  AND A_SCAD.ESERCIZIO_ORIGINALE = IACC.ESERCIZIO_ORI_ORI_RIPORTO
  AND A_SCAD.PG_ACCERTAMENTO = IACC.PG_ACCERTAMENTO_ORI_RIPORTO
  AND A_SCAD.PG_ACCERTAMENTO_SCADENZARIO = IA_SCAD.PG_ACC_SCAD_ORI_RIPORTO
  AND ACC.CD_CDS = A_SCAD.CD_CDS
  AND ACC.ESERCIZIO = A_SCAD.ESERCIZIO
  AND ACC.ESERCIZIO_ORIGINALE = A_SCAD.ESERCIZIO_ORIGINALE
  AND ACC.PG_ACCERTAMENTO = A_SCAD.PG_ACCERTAMENTO
  and V.FL_OBBIGAZIONE = 'N'
  and not exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC > V.ESERCIZIO + 1
  )
GROUP BY V.CD_TIPO_DOCUMENTO_AMM
	    ,V.CD_TERZO
        ,V.CD_CDS
	    ,V.CD_UNITA_ORGANIZZATIVA
	    ,V.ESERCIZIO
	    ,V.PG_NUMERO_DOCUMENTO
        ,V.TI_FATTURA
	    ,A_SCAD.CD_CDS
	    ,A_SCAD.ESERCIZIO
	    ,A_SCAD.ESERCIZIO_ORIGINALE
	    ,A_SCAD.PG_ACCERTAMENTO
	    ,A_SCAD.PG_ACCERTAMENTO_SCADENZARIO
	    ,ACC.TI_APPARTENENZA
	    ,ACC.TI_GESTIONE
	    ,ACC.CD_ELEMENTO_VOCE
	    ,A_SCAD.IM_SCADENZA
	    ,V.FL_OBBIGAZIONE
union all
SELECT
        V.CD_TIPO_DOCUMENTO_AMM
	   ,V.CD_TERZO
       ,V.CD_CDS
	   ,V.CD_UNITA_ORGANIZZATIVA
	   ,V.ESERCIZIO
	   ,V.PG_NUMERO_DOCUMENTO
	   ,V.TI_FATTURA
	   ,V.CD_CDS_OBB_ACC
	   ,V.ESERCIZIO_OBB_ACC
	   ,V.ESERCIZIO_ORI_OBB_ACC
	   ,V.PG_OBB_ACC
	   ,V.PG_OBB_ACC_SCADENZARIO
	   ,SUM(NVL(V.IM_DIPONIBILE_NC,0)) IM_DIPONIBILE_NC
	   ,SUM(NVL(V.IM_IMPONIBILE,0))    IM_IMPONIBILE
	   ,SUM(NVL(V.IM_IVA,0))    IM_IVA
	   ,SUM(NVL(V.IM_IVA_DETRAIBILE,0))  IM_IVA_DETRAIBILE
	   ,SUM(DECODE(V.TI_ISTITUZ_COMMERC,'C',V.IM_IMPONIBILE + V.IM_IVA - V.IM_IVA_DETRAIBILE,V.IM_IMPONIBILE + V.IM_IVA )) IM_TOTALE
	   ,ACC.TI_APPARTENENZA
	   ,ACC.TI_GESTIONE
	   ,ACC.CD_ELEMENTO_VOCE
	   ,A_SCAD.IM_SCADENZA
       ,V.FL_OBBIGAZIONE
FROM V_COAN_DOCUMENTI_DETT V
	 , ACCERTAMENTO ACC
	 , ACCERTAMENTO_SCADENZARIO A_SCAD
WHERE
      V.ESERCIZIO_OBB_ACC = V.ESERCIZIO
  AND V.CD_CDS_OBB_ACC    = ACC.CD_CDS (+)
  AND V.ESERCIZIO_OBB_ACC = ACC.ESERCIZIO (+)
  AND V.ESERCIZIO_ORI_OBB_ACC = ACC.ESERCIZIO_ORIGINALE (+)
  AND V.PG_OBB_ACC        = ACC.PG_ACCERTAMENTO (+)
  AND V.CD_CDS_OBB_ACC    = A_SCAD.CD_CDS (+)
  AND V.ESERCIZIO_OBB_ACC = A_SCAD.ESERCIZIO (+)
  AND V.ESERCIZIO_ORI_OBB_ACC = A_SCAD.ESERCIZIO_ORIGINALE (+)
  AND V.PG_OBB_ACC        = A_SCAD.PG_ACCERTAMENTO (+)
  AND V.PG_OBB_ACC_SCADENZARIO = A_SCAD.PG_ACCERTAMENTO_SCADENZARIO (+)
  and V.FL_OBBIGAZIONE = 'N'
  and exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC = V.ESERCIZIO + 1
  )
  and not exists (
   select 1 from V_COAN_DOCUMENTI_DETT where
            CD_TIPO_DOCUMENTO_AMM=V.CD_TIPO_DOCUMENTO_AMM
	    AND CD_CDS=V.CD_CDS
	    AND CD_UNITA_ORGANIZZATIVA=V.CD_UNITA_ORGANIZZATIVA
	    AND ESERCIZIO=V.ESERCIZIO
		AND PG_NUMERO_DOCUMENTO=V.PG_NUMERO_DOCUMENTO
		AND ESERCIZIO_OBB_ACC > V.ESERCIZIO + 1
  )
GROUP BY V.CD_TIPO_DOCUMENTO_AMM
	    ,V.CD_TERZO
            ,V.CD_CDS
	    ,V.CD_UNITA_ORGANIZZATIVA
	    ,V.ESERCIZIO
	    ,V.PG_NUMERO_DOCUMENTO
            ,V.TI_FATTURA
	    ,V.CD_CDS_OBB_ACC
	    ,V.ESERCIZIO_OBB_ACC
	    ,V.ESERCIZIO_ORI_OBB_ACC
	    ,V.PG_OBB_ACC
	    ,V.PG_OBB_ACC_SCADENZARIO
	    ,ACC.TI_APPARTENENZA
	    ,ACC.TI_GESTIONE
	    ,ACC.CD_ELEMENTO_VOCE
	    ,A_SCAD.IM_SCADENZA
	    ,V.FL_OBBIGAZIONE;

   COMMENT ON TABLE "V_COAN_SCADENZE_EPR"  IS 'Vista di estrazione del dettaglio delle scadenze di OBB_ACC
relative ai documenti gestiti nella movimentazione coan EPR';