package it.cnr.contab.compensi00.tabrif.bulk;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

public class Tipo_prestazione_compensoBase extends Tipo_prestazione_compensoKey implements Keyed {

	// DS_TI_PRESTAZIONE VARCHAR(200) NOT NULL
	private java.lang.String ds_ti_prestazione;

	// FL_INCARICO CHAR(1) NOT NULL
	private java.lang.Boolean fl_incarico;
	
	// FL_CONTRATTO CHAR(1) NOT NULL
	private java.lang.Boolean fl_contratto;

	// FL_CONTROLLO_FONDI CHAR(1) NOT NULL
	private java.lang.Boolean fl_controllo_fondi;	
	

public Tipo_prestazione_compensoBase() {
	super();
}
public Tipo_prestazione_compensoBase(java.lang.String cd_ti_prestazione) {
	super(cd_ti_prestazione);
}
/* 
 * Getter dell'attributo ds_ti_prestazione
 */
public java.lang.String getDs_ti_prestazione() {
	return ds_ti_prestazione;
}	
public java.lang.Boolean getFl_incarico() {
	return fl_incarico;
}
public void setDs_ti_prestazione(java.lang.String ds_ti_prestazione) {
	this.ds_ti_prestazione = ds_ti_prestazione;
}
public void setFl_incarico(java.lang.Boolean fl_incarico) {
	this.fl_incarico = fl_incarico;
}
public java.lang.Boolean getFl_contratto() {
	return fl_contratto;
}
public void setFl_contratto(java.lang.Boolean fl_contratto) {
	this.fl_contratto = fl_contratto;
}
public java.lang.Boolean getFl_controllo_fondi() {
	return fl_controllo_fondi;
}
public void setFl_controllo_fondi(java.lang.Boolean fl_controllo_fondi) {
	this.fl_controllo_fondi = fl_controllo_fondi;
}

}
