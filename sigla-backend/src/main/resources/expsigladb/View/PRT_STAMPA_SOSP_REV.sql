--------------------------------------------------------
--  DDL for View PRT_STAMPA_SOSP_REV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "PRT_STAMPA_SOSP_REV" ("ESERCIZIO", "CD_CDS", "CD_UO_ORIGINE", "CD_SOSPESO", "IM_SOSPESO", "IM_ASSOCIATO", "DT_REGISTRAZIONE", "TI_CC_BI", "CAUSALE", "DS_ANAGRAFICO", "PG_REVERSALE", "DISPONIBILE") AS 
  SELECT
--
-- Date: 09/05/2008
-- Version: 1.2
--
-- Stampa sospesi di entrata associati a reversale
--
--
-- History:
--
-- Date: 20/06/2003
-- Version: 1.0
-- Creazione
--
-- Date: 21/10/2003
-- Version: 1.1
--
-- Date: 09/05/2008
-- Version: 1.2
--
-- Eliminata la condizione sullo stato del sospeso
-- Body:
--
SOSPESO.ESERCIZIO,
SOSPESO.CD_CDS,
REVERSALE.CD_UO_ORIGINE,
SOSPESO.CD_SOSPESO,
SOSPESO.IM_SOSPESO,
SOSPESO.IM_ASSOCIATO,
SOSPESO.DT_REGISTRAZIONE,
SOSPESO.TI_CC_BI,
SOSPESO.CAUSALE,
SOSPESO.DS_ANAGRAFICO,
SOSPESO_DET_ETR.PG_REVERSALE,
(sum(SOSPESO.IM_SOSPESO) - sum(SOSPESO.IM_ASSOCIATO)) AS DISPONIBILE
FROM
SOSPESO, SOSPESO_DET_ETR, REVERSALE
WHERE
SOSPESO.ESERCIZIO = SOSPESO_DET_ETR.ESERCIZIO AND
SOSPESO.CD_CDS = SOSPESO_DET_ETR.CD_CDS AND
SOSPESO.CD_SOSPESO = SOSPESO_DET_ETR.CD_SOSPESO AND
SOSPESO.TI_SOSPESO_RISCONTRO = 'S' AND
SOSPESO.TI_SOSPESO_RISCONTRO = SOSPESO_DET_ETR.TI_SOSPESO_RISCONTRO AND
SOSPESO.CD_SOSPESO_PADRE IS NOT NULL AND
--SOSPESO.STATO_SOSPESO = 'A' AND
SOSPESO.CD_CDS = cnrctb020.getCdCdsEnte(SOSPESO.ESERCIZIO) AND
SOSPESO.TI_ENTRATA_SPESA = 'E' AND
SOSPESO.TI_ENTRATA_SPESA = SOSPESO_DET_ETR.TI_ENTRATA_SPESA AND
SOSPESO_DET_ETR.STATO <> 'A' AND
SOSPESO_DET_ETR.CD_CDS_reversale = REVERSALE.CD_CDS AND
SOSPESO_DET_ETR.ESERCIZIO = REVERSALE.ESERCIZIO AND
SOSPESO_DET_ETR.PG_REVERSALE = REVERSALE.PG_REVERSALE
GROUP BY
SOSPESO.ESERCIZIO,
SOSPESO.CD_CDS,
REVERSALE.CD_UO_ORIGINE,
SOSPESO.CD_SOSPESO,
SOSPESO.IM_SOSPESO,
SOSPESO.IM_ASSOCIATO,
SOSPESO.DT_REGISTRAZIONE,
SOSPESO.TI_CC_BI,
SOSPESO.CAUSALE,
SOSPESO.DS_ANAGRAFICO,
SOSPESO_DET_ETR.PG_REVERSALE
ORDER BY
SOSPESO.DT_REGISTRAZIONE;

   COMMENT ON TABLE "PRT_STAMPA_SOSP_REV"  IS 'Stampa sospesi di entrata associati a reversale';