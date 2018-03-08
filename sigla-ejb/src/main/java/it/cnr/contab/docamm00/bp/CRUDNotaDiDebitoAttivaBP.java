package it.cnr.contab.docamm00.bp;

import it.cnr.contab.doccont00.core.bulk.*;
import it.cnr.contab.docamm00.docs.bulk.*;
import it.cnr.contab.docamm00.docs.bulk.Nota_di_debito_attiva_rigaBulk;
import it.cnr.contab.docamm00.docs.bulk.Nota_di_debito_attivaBulk;
import it.cnr.contab.docamm00.ejb.FatturaAttivaSingolaComponentSession;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.bulk.ValidationException;
import it.cnr.jada.util.ObjectReplacer;
import it.cnr.jada.util.action.SimpleDetailCRUDController;

/**
 * Insert the type's description here.
 * Creation date: (10/25/2001 11:20:49 AM)
 * @author: Roberto Peli
 */
public class CRUDNotaDiDebitoAttivaBP 
	extends CRUDFatturaAttivaBP 
	implements ObjectReplacer, TitoloDiCreditoDebitoBP {

	private final FatturaAttivaRigaCRUDController dettaglio = new FatturaAttivaRigaCRUDController(
	"Dettaglio",Nota_di_debito_attiva_rigaBulk.class,"fattura_attiva_dettColl", this) {
			//Modificato a seguito richiesta 423.
			public boolean isGrowable() {
				Nota_di_debito_attivaBulk ndd = (Nota_di_debito_attivaBulk)getParentModel();
				return	super.isGrowable() &&
						ndd.getProtocollo_iva() == null &&
						ndd.getProtocollo_iva_generale() == null;
			}
			public boolean isShrinkable() {
				Nota_di_debito_attivaBulk ndd = (Nota_di_debito_attivaBulk)getParentModel();
				return	super.isShrinkable() && 
						ndd.getProtocollo_iva() == null &&
						ndd.getProtocollo_iva_generale() == null;
			}	
		};

	private java.lang.Boolean autoGenerated = Boolean.FALSE;
	private it.cnr.jada.bulk.PrimaryKeyHashMap documentiContabiliModificati = null;
/**
 * CRUDNotaDiCreditoBP constructor comment.
 */
public CRUDNotaDiDebitoAttivaBP() {
	
	super(Nota_di_debito_attiva_rigaBulk.class);
}
/**
 * CRUDNotaDiCreditoBP constructor comment.
 * @param function java.lang.String
 * @exception it.cnr.jada.action.BusinessProcessException The exception description.
 */
public CRUDNotaDiDebitoAttivaBP(String function) throws it.cnr.jada.action.BusinessProcessException {
	super(function, Nota_di_debito_attiva_rigaBulk.class);
}
/**
 * Insert the method's description here.
 * Creation date: (5/2/2002 4:51:58 PM)
 */
public void addToDocumentiContabiliModificati(it.cnr.contab.doccont00.core.bulk.IScadenzaDocumentoContabileBulk scadenza) {

	if (scadenza == null) return;
	
	if (getDocumentiContabiliModificati() == null)
		setDocumentiContabiliModificati(new it.cnr.jada.bulk.PrimaryKeyHashMap());
	if (!getDocumentiContabiliModificati().containsKey(scadenza))
		getDocumentiContabiliModificati().put(scadenza, Boolean.TRUE);
}
protected it.cnr.jada.util.jsp.Button[] createFPInventarioToolbar() {

	it.cnr.jada.util.jsp.Button[] toolbar = new it.cnr.jada.util.jsp.Button[2];
	int i = 0;
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.inventaria");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.associaInventario");
	return toolbar;
}
protected it.cnr.jada.util.jsp.Button[] createToolbar() {
	it.cnr.jada.util.jsp.Button[] toolbar = new it.cnr.jada.util.jsp.Button[12];
	int i = 0;
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.search");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.startSearch");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.freeSearch");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.new");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.save");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.delete");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.bringBack");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(it.cnr.jada.util.action.CRUDBP.class),"CRUDToolbar.print");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.riportaIndietro");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.riportaAvanti");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.downloadXml");
	toolbar[i++] = new it.cnr.jada.util.jsp.Button(it.cnr.jada.util.Config.getHandler().getProperties(getClass()),"CRUDToolbar.downloadFatturaFirmata");

	return toolbar;
}
/**
 * Insert the method's description here.
 * Creation date: (11/5/2001 2:31:22 PM)
 * @return java.lang.Boolean
 */
public java.lang.Boolean getAutoGenerated() {
	return autoGenerated;
}
/**
 * Insert the method's description here.
 * Creation date: (09/07/2001 14:55:11)
 * @return it.cnr.jada.util.action.SimpleDetailCRUDController
 */
public FatturaAttivaRigaCRUDController getDettaglio() {

	return dettaglio;
}
/**
 * Insert the method's description here.
 * Creation date: (5/2/2002 4:51:58 PM)
 */
public it.cnr.jada.bulk.PrimaryKeyHashMap getDocumentiContabiliModificati() {
	
	return documentiContabiliModificati;
}
/**
 * Insert the method's description here.
 * Creation date: (12/17/2001 10:41:37 AM)
 * @return it.cnr.jada.util.action.SimpleDetailCRUDController
 */
public Obbligazione_scadenzarioBulk getObbligazione_scadenziario_corrente() {
	return null;
}
public OggettoBulk initializeModelForEdit(ActionContext context,OggettoBulk bulk) throws BusinessProcessException {

	setDocumentiContabiliModificati(null);
	return super.initializeModelForEdit(context,bulk);
}
/**
 * Insert the method's description here.
 * Creation date: (11/5/2001 2:31:22 PM)
 * @return java.lang.Boolean
 */
public boolean isAutoGenerated() {
	return autoGenerated.booleanValue();
}
/**
 * Insert the method's description here.
 * Creation date: (5/2/2002 4:58:24 PM)
 */
public boolean isDocumentoContabileModificato(it.cnr.contab.doccont00.core.bulk.IScadenzaDocumentoContabileBulk scadenza) {

	if (scadenza == null || getDocumentiContabiliModificati() == null)
		return false;
	return getDocumentiContabiliModificati().get(scadenza) != null;
}
public boolean isInventariaButtonEnabled() {
	
	return	getModel() != null &&
			!getDettaglio().getDetails().isEmpty();
}
public boolean isInventariaButtonHidden() {
	
	return true;//isSearching();
}
public boolean isNewButtonHidden() {
	return true;
}
/**
 * Insert the method's description here.
 * Creation date: (5/2/2002 4:51:58 PM)
 */
public void removeFromDocumentiContabiliModificati(it.cnr.contab.doccont00.core.bulk.IScadenzaDocumentoContabileBulk scadenza) {

	if (scadenza == null || getDocumentiContabiliModificati() == null)
		return;
	if (getDocumentiContabiliModificati().containsKey(scadenza))
		getDocumentiContabiliModificati().remove(scadenza);
}
/**
 * Insert the method's description here.
 * Creation date: (09/07/2001 14:55:11)
 * @return it.cnr.jada.util.action.SimpleDetailCRUDController
 */
public Object replaceObject(Object obj) {

	if (getModel() != null && obj != null) {
		Fattura_passiva_rigaIBulk riga = (Fattura_passiva_rigaIBulk)obj;
		
		Nota_di_debitoBulk ndc = (Nota_di_debitoBulk)getModel();
		if (ndc.getFattura_passiva_obbligazioniHash() != null) {
			Obbligazione_scadenzarioBulk obbl = ndc.getFattura_passiva_obbligazioniHash().getKey(riga.getObbligazione_scadenziario());
			if (obbl != null)
				riga.setObbligazione_scadenziario(obbl);
			return riga;
		}
	}
	return obj;
}
public void salvaRiportandoAvanti(ActionContext context)
	throws ValidationException,BusinessProcessException {

	completeSearchTools(context,this);
	validate(context);
	saveChildren(context);

	update(context);
	if (getMessage() == null)
		setMessage("Salvataggio e riporto all'esercizio successivo eseguito in modo corretto.");
}
public void save(it.cnr.jada.action.ActionContext context)
	throws it.cnr.jada.bulk.ValidationException,it.cnr.jada.action.BusinessProcessException {
	
	completeSearchTools(context,this);
	validate(context);
	saveChildren(context);
	
	if(isInserting()) {
		create(context);
		setMessage("Creazione eseguita in modo corretto.");
	} else if (isEditing()) {
		update(context);
		setMessage("Salvataggio eseguito in modo corretto.");
	}
}
/**
 * Insert the method's description here.
 * Creation date: (11/5/2001 2:31:22 PM)
 * @param newAutoGenereted java.lang.Boolean
 */
public void setAutoGenerated(java.lang.Boolean newAutoGenerated) {
	autoGenerated = newAutoGenerated;
}
/**
 * Insert the method's description here.
 * Creation date: (5/2/2002 4:51:58 PM)
 */
public void setDocumentiContabiliModificati(it.cnr.jada.bulk.PrimaryKeyHashMap aMap) {
	
	documentiContabiliModificati = aMap;
}
public void writeFPInventarioToolbar(javax.servlet.jsp.JspWriter writer) throws java.io.IOException,javax.servlet.ServletException {

	if (!isSearching() && !isDeleting()) {
		openToolbar(writer);
		it.cnr.jada.util.jsp.JSPUtils.toolbar(writer,createFPInventarioToolbar(),this, this.getParentRoot().isBootstrap());
		closeToolbar(writer);
	}
}
public void writeToolbar(javax.servlet.jsp.JspWriter writer) throws java.io.IOException,javax.servlet.ServletException {

	super.writeToolbar(writer);
	//writeFPInventarioToolbar(writer);
}
}
