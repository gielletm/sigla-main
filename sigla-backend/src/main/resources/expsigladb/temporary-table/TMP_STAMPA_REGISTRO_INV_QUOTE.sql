CREATE GLOBAL TEMPORARY TABLE "TMP_STAMPA_REGISTRO_INV_QUOTE" (
"CD_UNITA_ORGANIZZATIVA" VARCHAR2(30 BYTE),
"CD_CDS" VARCHAR2(30 BYTE),
"ESERCIZIO_CARICO_BENE" NUMBER(4,0),
"ETICHETTA" VARCHAR2(50 BYTE),
"CATEGORIA" VARCHAR2(5 BYTE),
"CD_CATEGORIA_GRUPPO" VARCHAR2(10 BYTE),
"CD_ASSEGNATARIO" NUMBER(8,0),
"DATA_REGISTRAZIONE" DATE,
"CD_TIPO_CARICO_SCARICO" VARCHAR2(10 BYTE),
"DS_TIPO_CARICO_SCARICO" VARCHAR2(100 BYTE),
"VALORE_AMMORTIZZATO" NUMBER(20,6),
"IMPONIBILE_AMMORTAMENTO" NUMBER(20,6),
"ESERCIZIO_AMM" NUMBER(4,0),
"NUMERO_ANNI" NUMBER(4,0),
"PERC_AMMORTAMENTO" NUMBER(5,2),
"PERC_PRIMO_ANNO" NUMBER(5,2),
"PERC_SUCCESSIVI" NUMBER(5,2),
"NR_INVENTARIO" NUMBER(10,0),
"FL_AMMORTAMENTO" CHAR(1 BYTE),
"TIPO" CHAR(1 BYTE),
"ESERCIZIO_COMP" NUMBER(4,0)
) ON COMMIT DELETE ROWS