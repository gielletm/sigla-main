/*
 * Copyright (C) 2019  Consiglio Nazionale delle Ricerche
 *
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU Affero General Public License as
 *     published by the Free Software Foundation, either version 3 of the
 *     License, or (at your option) any later version.
 *
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU Affero General Public License for more details.
 *
 *     You should have received a copy of the GNU Affero General Public License
 *     along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

package it.cnr.contab.doccont00.core.bulk;

import it.cnr.contab.config00.pdcfin.bulk.Voce_fBulk;
import it.cnr.contab.utenze00.bp.*;
import it.cnr.jada.bulk.*;

import java.util.*;

public class ImpegnoBulk extends ObbligazioneBulk {
	private List unitaOrganizzativaOptions;
	private String cd_uo_ente;
	private java.sql.Timestamp dt_scadenza;	

	private Integer esercizio_mandato;
	private java.lang.Long pg_mandato;

	private Integer esercizio_doc_passivo;
	private java.lang.Long pg_doc_passivo;
	private String cd_tipo_documento_amm;
	public static java.util.Hashtable tipoDocumentoKeys;
	private Voce_fBulk voce_f;

	public final static Dictionary competenzaResiduoKeys;

	static 
	{
		competenzaResiduoKeys = new Hashtable();
		competenzaResiduoKeys.put(Numerazione_doc_contBulk.TIPO_IMP,		"Competenza");
		competenzaResiduoKeys.put(Numerazione_doc_contBulk.TIPO_IMP_RES,	"Residuo");
	};

	protected boolean fl_isTronco = false;
public ImpegnoBulk() {
	super();
	initialize();	
}
public ImpegnoBulk(String cd_cds, Integer esercizio, Integer esercizio_originale, Long pg_obbligazione) {
	super(cd_cds, esercizio, esercizio_originale, pg_obbligazione);
	initialize();
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'cd_tipo_documento_amm'
 *
 * @return Il valore della propriet?? 'cd_tipo_documento_amm'
 */
public java.lang.String getCd_tipo_documento_amm() {
	return cd_tipo_documento_amm;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'cd_uo_ente'
 *
 * @return Il valore della propriet?? 'cd_uo_ente'
 */
public java.lang.String getCd_uo_ente() {
	return cd_uo_ente;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'dt_scadenza'
 *
 * @return Il valore della propriet?? 'dt_scadenza'
 */
public java.sql.Timestamp getDt_scadenza() {
	return dt_scadenza;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'esercizio_doc_passivo'
 *
 * @return Il valore della propriet?? 'esercizio_doc_passivo'
 */
public java.lang.Integer getEsercizio_doc_passivo() {
	return esercizio_doc_passivo;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'esercizio_mandato'
 *
 * @return Il valore della propriet?? 'esercizio_mandato'
 */
public java.lang.Integer getEsercizio_mandato() {
	return esercizio_mandato;
}
public String getManagerName() {

	return "CRUDImpegnoBilEnteBP";
}
/**
 * @return java.lang.Long
 */
public java.lang.Long getPg_doc_passivo() {
	return pg_doc_passivo;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'pg_mandato'
 *
 * @return Il valore della propriet?? 'pg_mandato'
 */
public java.lang.Long getPg_mandato() {
	return pg_mandato;
}
/**
 * @return java.util.Hashtable
 */
public final static java.util.Hashtable getTipoDocumentoKeys() {
	return tipoDocumentoKeys;
}
/**
 * <!-- @TODO: da completare -->
 * Restituisce il valore della propriet?? 'unitaOrganizzativaOptions'
 *
 * @return Il valore della propriet?? 'unitaOrganizzativaOptions'
 */
public java.util.List getUnitaOrganizzativaOptions() {
	return unitaOrganizzativaOptions;
}
private void initialize () {
	setFl_pgiro( new Boolean( false ));
}
/**
 * Inizializza l'Oggetto Bulk per la ricerca libera.
 * @param bp Il Business Process in uso
 * @param context Il contesto dell'azione
 * @return OggettoBulk L'oggetto bulk inizializzato
 */
public OggettoBulk initializeForFreeSearch(it.cnr.jada.util.action.CRUDBP bp,it.cnr.jada.action.ActionContext context) {
//	return super.initializeForSearch(bp,context);
	setEsercizio( ((CNRUserContext)context.getUserContext()).getEsercizio() );
	setEsercizio_competenza( ((CNRUserContext)context.getUserContext()).getEsercizio() );
	return this;
}
/**
 * Inizializza l'Oggetto Bulk per l'inserimento.
 * @param bp Il Business Process in uso
 * @param context Il contesto dell'azione
 * @return OggettoBulk L'oggetto bulk inizializzato
 */
public OggettoBulk initializeForInsert(it.cnr.jada.util.action.CRUDBP bp,it.cnr.jada.action.ActionContext context) {
	super.initializeForInsert( bp, context );
	setEsercizio_originale( it.cnr.contab.utenze00.bulk.CNRUserInfo.getEsercizio(context) );
	setStato_obbligazione( STATO_OBB_DEFINITIVO );
	return this;
}
/**
 * Inizializza l'Oggetto Bulk per la ricerca.
 * @param bp Il Business Process in uso
 * @param context Il contesto dell'azione
 * @return OggettoBulk L'oggetto bulk inizializzato
 */
public OggettoBulk initializeForSearch(it.cnr.jada.util.action.CRUDBP bp,it.cnr.jada.action.ActionContext context) {
//	super.initializeForSearch( bp, context);
	setEsercizio( ((CNRUserContext)context.getUserContext()).getEsercizio() );
	setEsercizio_competenza( ((CNRUserContext)context.getUserContext()).getEsercizio() );
	setUnita_organizzativa( it.cnr.contab.utenze00.bulk.CNRUserInfo.getUnita_organizzativa(context));
	return this;
}
/**
 * @return boolean
 */
public boolean isFl_isTronco() {
	return fl_isTronco;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'cd_tipo_documento_amm'
 *
 * @param newCd_tipo_documento_amm	Il valore da assegnare a 'cd_tipo_documento_amm'
 */
public void setCd_tipo_documento_amm(java.lang.String newCd_tipo_documento_amm) {
	cd_tipo_documento_amm = newCd_tipo_documento_amm;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'cd_uo_ente'
 *
 * @param newCd_uo_ente	Il valore da assegnare a 'cd_uo_ente'
 */
public void setCd_uo_ente(java.lang.String newCd_uo_ente) {
	cd_uo_ente = newCd_uo_ente;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'dt_scadenza'
 *
 * @param newDt_scadenza	Il valore da assegnare a 'dt_scadenza'
 */
public void setDt_scadenza(java.sql.Timestamp newDt_scadenza) {
	dt_scadenza = newDt_scadenza;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'esercizio_doc_passivo'
 *
 * @param newEsercizio_doc_passivo	Il valore da assegnare a 'esercizio_doc_passivo'
 */
public void setEsercizio_doc_passivo(java.lang.Integer newEsercizio_doc_passivo) {
	esercizio_doc_passivo = newEsercizio_doc_passivo;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'esercizio_mandato'
 *
 * @param newEsercizio_mandato	Il valore da assegnare a 'esercizio_mandato'
 */
public void setEsercizio_mandato(java.lang.Integer newEsercizio_mandato) {
	esercizio_mandato = newEsercizio_mandato;
}
/**
 * @param newFl_isTronco boolean
 */
public void setFl_isTronco(boolean newFl_isTronco) {
	fl_isTronco = newFl_isTronco;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'pg_doc_passivo'
 *
 * @param newPg_doc_passivo	Il valore da assegnare a 'pg_doc_passivo'
 */
public void setPg_doc_passivo(java.lang.Long newPg_doc_passivo) {
	pg_doc_passivo = newPg_doc_passivo;
}
/**
 * <!-- @TODO: da completare -->
 * Imposta il valore della propriet?? 'pg_mandato'
 *
 * @param newPg_mandato	Il valore da assegnare a 'pg_mandato'
 */
public void setPg_mandato(java.lang.Long newPg_mandato) {
	pg_mandato = newPg_mandato;
}
/**
 * @param newUnitaOrganizzativaOptions java.util.List
 */
public void setUnitaOrganizzativaOptions(java.util.List newUnitaOrganizzativaOptions) {
	unitaOrganizzativaOptions = newUnitaOrganizzativaOptions;
}
/**
 * Metodo con cui si verifica la validit?? di alcuni campi, mediante un 
 * controllo sintattico o contestuale.
 */
public void validate() throws ValidationException
{
	super.validate();
	// controllo su campo DATA SCADENZA
	if ( getDt_scadenza() == null )
		throw new ValidationException( "Il campo DATA SCADENZA ?? obbligatorio." );

/*	if ( !Numerazione_doc_contBulk.TIPO_IMP_RES.equals( getCd_tipo_documento_cont()))
	{
		*/
		if ( //  data obbligazione != data scadenza && data_obbligazione >= data_scadenza
			!(getDt_registrazione().after( getDt_scadenza() ) && getDt_registrazione().before( getDt_scadenza() )) &&
			  getDt_registrazione().after( getDt_scadenza() ))
			throw new ValidationException( "Non ?? possibile inserire una data scadenza antecedente a quella di registrazione dell'Impegno su bilancio Ente." );
		
		java.util.GregorianCalendar gc = (java.util.GregorianCalendar)java.util.GregorianCalendar.getInstance();
		gc.setTime(getDt_scadenza());
		if (gc.get(java.util.GregorianCalendar.YEAR) < getEsercizio().intValue())
			throw new ValidationException( "Non ?? possibile inserire una data scadenza antecedente all'esercizio di creazione dell'Impegno su bilancio Ente." );
/*	}	*/

	// controlli su campo IMPORTO	
	if (  getIm_obbligazione() == null ) 
		throw new ValidationException( "L' IMPORTO dell'Impegno su bilancio Ente non pu?? essere nullo." );
	
	if ( this.isAssociataADocAmm() == false && ( ( getIm_obbligazione() == null ) || 
		 (getIm_obbligazione().compareTo(new java.math.BigDecimal(0)) <= 0) ))
		throw new ValidationException( "L' IMPORTO dell'Impegno su bilancio Ente deve essere maggiore di 0." );

}
	/**
	 * @return
	 */
	public Voce_fBulk getVoce_f() {
		return voce_f;
	}

	/**
	 * @param bulk
	 */
	public void setVoce_f(Voce_fBulk bulk) {
		this.voce_f=bulk;
	}

	public boolean isROVoce_f() {
		return voce_f == null || voce_f.getCrudStatus() == NORMAL;
	}
}
