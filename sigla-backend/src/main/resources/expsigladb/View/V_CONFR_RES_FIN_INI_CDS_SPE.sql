--------------------------------------------------------
--  DDL for View V_CONFR_RES_FIN_INI_CDS_SPE
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "V_CONFR_RES_FIN_INI_CDS_SPE" ("ESERCIZIO", "ESERCIZIO_RES", "CD_CENTRO_RESPONSABILITA", "CD_LINEA_ATTIVITA", "CD_ELEMENTO_VOCE", "STANZ_RES_DA_RIB", "RES_PRO_DA_RIB", "STANZ_RES_INI_ES_SUCC", "OBBL_RES_PRO_INI_ES_SUCC") AS 
  SELECT ESERCIZIO, ESERCIZIO_RES, CD_CENTRO_RESPONSABILITA, CD_LINEA_ATTIVITA, CD_ELEMENTO_VOCE,
(IM_STANZ_INIZIALE_A1 + VARIAZIONI_PIU - VARIAZIONI_MENO - IM_OBBL_ACC_COMP + IM_STANZ_RES_IMPROPRIO + VAR_PIU_STANZ_RES_IMP - VAR_MENO_STANZ_RES_IMP - VAR_PIU_OBBL_RES_PRO + VAR_MENO_OBBL_RES_PRO - IM_OBBL_RES_IMP) STANZ_RES_DA_RIB,
(IM_OBBL_ACC_COMP + (IM_OBBL_RES_PRO + VAR_PIU_OBBL_RES_PRO - VAR_MENO_OBBL_RES_PRO) - IM_MANDATI_REVERSALI_PRO + IM_OBBL_RES_IMP - IM_MANDATI_REVERSALI_IMP) RES_PRO_DA_RIB,
 NVL((SELECT IM_STANZ_RES_IMPROPRIO
      FROM   VOCE_F_SALDI_CDR_LINEA V_ES_SUCC
      WHERE  V_ES_SUCC.ESERCIZIO                = VOCE_F_SALDI_CDR_LINEA.ESERCIZIO+1 AND
             V_ES_SUCC.ESERCIZIO_RES            = VOCE_F_SALDI_CDR_LINEA.ESERCIZIO_RES AND
             V_ES_SUCC.CD_CENTRO_RESPONSABILITA = VOCE_F_SALDI_CDR_LINEA.CD_CENTRO_RESPONSABILITA AND
             V_ES_SUCC.CD_LINEA_ATTIVITA        = VOCE_F_SALDI_CDR_LINEA.CD_LINEA_ATTIVITA AND
             V_ES_SUCC.TI_APPARTENENZA          = VOCE_F_SALDI_CDR_LINEA.TI_APPARTENENZA AND
             V_ES_SUCC.TI_GESTIONE              = VOCE_F_SALDI_CDR_LINEA.TI_GESTIONE AND
             V_ES_SUCC.CD_ELEMENTO_VOCE         = VOCE_F_SALDI_CDR_LINEA.CD_ELEMENTO_VOCE), 0) STANZ_RES_INI_ES_SUCC,
 NVL((SELECT IM_OBBL_RES_PRO
      FROM   VOCE_F_SALDI_CDR_LINEA V_ES_SUCC
      WHERE  V_ES_SUCC.ESERCIZIO                = VOCE_F_SALDI_CDR_LINEA.ESERCIZIO+1 AND
             V_ES_SUCC.ESERCIZIO_RES            = VOCE_F_SALDI_CDR_LINEA.ESERCIZIO_RES AND
             V_ES_SUCC.CD_CENTRO_RESPONSABILITA = VOCE_F_SALDI_CDR_LINEA.CD_CENTRO_RESPONSABILITA AND
             V_ES_SUCC.CD_LINEA_ATTIVITA        = VOCE_F_SALDI_CDR_LINEA.CD_LINEA_ATTIVITA AND
             V_ES_SUCC.TI_APPARTENENZA          = VOCE_F_SALDI_CDR_LINEA.TI_APPARTENENZA AND
             V_ES_SUCC.TI_GESTIONE              = VOCE_F_SALDI_CDR_LINEA.TI_GESTIONE AND
             V_ES_SUCC.CD_ELEMENTO_VOCE         = VOCE_F_SALDI_CDR_LINEA.CD_ELEMENTO_VOCE), 0) OBBL_RES_PRO_INI_ES_SUCC
FROM   VOCE_F_SALDI_CDR_LINEA
WHERE  TI_GESTIONE = 'S' AND
       TI_APPARTENENZA = 'D';