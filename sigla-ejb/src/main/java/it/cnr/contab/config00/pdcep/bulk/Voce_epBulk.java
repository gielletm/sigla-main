package it.cnr.contab.config00.pdcep.bulk;

import java.util.*;

import it.cnr.contab.config00.pdcep.cla.bulk.V_classificazione_voci_epBulk;
import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;
import it.cnr.jada.util.*;

/**
 * Classe che eredita le caratteristiche della superclasse <code>OggettoBulk<code>.
 * Contiene tutte le variabili e i metodi che sono comuni alle sue sottoclassi.
 * Gestisce i dati relativi alla tabella Voce_ep.
 */
public class Voce_epBulk extends Voce_epBase {
	static private java.util.Hashtable riepiloga_a_Keys;
	final static public java.util.Hashtable natura_voce_Keys;
	static private java.util.Hashtable ti_sezione_Keys;
	static private java.util.Hashtable conto_speciale_Keys;
	private java.util.Hashtable ti_voce_ep_Keys;
	private it.cnr.jada.util.OrderedHashtable gruppiKeys;
	static private java.util.Hashtable fl_a_pareggio_Keys;
	static
	{
		natura_voce_Keys = new Hashtable();
		natura_voce_Keys.put("EPC", "EPC - Economico Pluriennale Costo");
		natura_voce_Keys.put("EPR", "EPR - Economico Pluriennale Ricavo");
		natura_voce_Keys.put("EEC", "EEC - Economico d'Esercizio Costo");
		natura_voce_Keys.put("EER", "EER - Economico d'Esercizio Ricavo");
		natura_voce_Keys.put("NUA", "NUA - Numerario Attivit�");
		natura_voce_Keys.put("NUP", "NUP - Numerario Passivit�");
		natura_voce_Keys.put("CDO", "CDO - Conto d'Ordine");
		natura_voce_Keys.put("CDC", "CDC - Conto di Capitale");
	}	
	private V_classificazione_voci_epBulk v_classificazione_voci_ep;

public Voce_epBulk() {
	super();
}
public Voce_epBulk(java.lang.String cd_voce_ep,java.lang.Integer esercizio) {
	super(cd_voce_ep,esercizio);
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>conto_speciale_Keys</code>
 * di tipo <code>Hashtable</code>.
 * In particolare, questo metodo carica in una Hashtable l'elenco dei possibili valori 
 * che pu� assumere un conto speciale.
 * @return java.util.Hashtable conto_speciale_Keys I valori del conto speciale.
 */
public java.util.Hashtable getConto_speciale_Keys() {
		Hashtable conto_speciale_Keys = new java.util.Hashtable();
		
		conto_speciale_Keys.put("RDE", "RDE - Risultato di Esercizio");
		conto_speciale_Keys.put("CSE", "CSE - Conto Sintetico Economico");
		conto_speciale_Keys.put("SPF", "SPF - Stato Patrimoniale Finale");
		conto_speciale_Keys.put("SPI", "SPI - Stato Patrimoniale Iniziale");
		conto_speciale_Keys.put("CAS", "CAS - Cassa");
		conto_speciale_Keys.put("BAN", "BAN - Banca");
		conto_speciale_Keys.put("ARR", "ARR - Arrotondamento");
		conto_speciale_Keys.put("PLU", "PLU - Plusvalenza");
		conto_speciale_Keys.put("MIN", "MIN - Minusvalenza");
		conto_speciale_Keys.put("IVA", "IVA - Per conti IVA a Credito o a Debito");
	return conto_speciale_Keys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>fl_a_pareggio_Keys</code>
 * di tipo <code>Hashtable</code>.
 * In particolare, questo metodo carica in una Hashtable l'elenco dei possibili valori 
 * che pu� assumere il flag <code>fl_a_pareggio</code>.
 * @return java.util.Hashtable fl_a_pareggio_Keys I valori del flag <code>fl_a_pareggio</code>.
 */
public java.util.Hashtable getFl_a_pareggio_Keys() {
		Hashtable fl_a_pareggio_Keys = new Hashtable();
		
		fl_a_pareggio_Keys.put(new Boolean(true), "Y");
		fl_a_pareggio_Keys.put(new Boolean(false), "N");
	return fl_a_pareggio_Keys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>gruppiKeys</code>
 * di tipo <code>Hashtable</code>.
 * @return java.util.Hashtable gruppiKeys
 */
public OrderedHashtable getGruppiKeys() {
	return gruppiKeys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>natura_voce_Keys</code>
 * di tipo <code>Hashtable</code>.
 * In particolare, questo metodo carica in una Hashtable l'elenco dei possibili valori
 * che pu� assumere la natura.
 * @return java.util.Hashtable natura_voce_Keys I valori della natura.
 */
public java.util.Hashtable getNatura_voce_Keys() 
{
	return natura_voce_Keys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>riepiloga_a_Keys</code>
 * di tipo <code>Hashtable</code>.
 * In particolare, questo metodo carica in una Hashtable l'elenco dei possibili valori 
 * che pu� assumere il campo <code>riepiloga_a</code>.
 * @return java.util.Hashtable riepiloga_a_Keys I valori del campo <code>riepiloga_a</code>.
 */
public java.util.Hashtable getRiepiloga_a_Keys() {
		Hashtable riepiloga_a_Keys = new java.util.Hashtable();
		
		riepiloga_a_Keys.put("CEC", "CEC - Conto Economico");
		riepiloga_a_Keys.put("SPA", "SPA - Stato Patrimoniale");
	return riepiloga_a_Keys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>ti_sezione_Keys</code>
 * di tipo <code>Hashtable</code>.
 * In particolare, questo metodo  carica in una Hashtable l'elenco delle tipologie
 * di Sezione.
 * @return java.util.Hashtable ti_sezione_Keys I valori della tipologia di Sezione.
 */
public java.util.Hashtable getTi_sezione_Keys() {
		Hashtable ti_sezione_Keys = new java.util.Hashtable();
		
		ti_sezione_Keys.put("D", "Dare");
		ti_sezione_Keys.put("A", "Avere"); 
		ti_sezione_Keys.put("B", "Bifase");
	return ti_sezione_Keys;
}
/**
 * Metodo con cui si ottiene il valore della variabile <code>ti_voce_ep_Keys</code>
 * di tipo <code>Hashtable</code>.
 * @return java.util.Hashtable ti_voce_ep_Keys
 */
public java.util.Hashtable getTi_voce_ep_Keys() {
	return ti_voce_ep_Keys;
}
/**
 * Metodo con cui si definisce il valore della variabile <code>gruppiKeys</code>
 * di tipo <code>OrderedHashtable</code>.
 * @param newGruppiKeys OrderedHashtable
 */
public void setGruppiKeys(OrderedHashtable newGruppiKeys) {
	gruppiKeys = newGruppiKeys;
}
/**
 * Metodo con cui si definisce il valore della variabile <code>ti_voce_ep_Keys</code>
 * di tipo <code>Hashtable</code>.
 * @param newTi_voce_ep_Keys java.util.Hashtable
 */
public void setTi_voce_ep_Keys(java.util.Hashtable newTi_voce_ep_Keys) {
	ti_voce_ep_Keys = newTi_voce_ep_Keys;
}
/**
 * Metodo con cui si verifica la validit� di alcuni campi, mediante un 
 * controllo sintattico o contestuale.
 */
public void validate() throws ValidationException {
	super.validate();
		
	// controllo su campo ESERCIZIO vale per entrambi i tipi (Capoconto,Conto)
			if ( getEsercizio() == null )
				throw new ValidationException( "Il campo ESERCIZIO � obbligatorio." );
			if ( getEsercizio().toString().length() != 4 )
				throw new ValidationException( "Il campo ESERCIZIO deve essere di quattro cifre." );
}
public V_classificazione_voci_epBulk getV_classificazione_voci_ep() {
	return v_classificazione_voci_ep;
}
public void setV_classificazione_voci_ep(
		V_classificazione_voci_epBulk v_classificazione_voci_ep) {
	this.v_classificazione_voci_ep = v_classificazione_voci_ep;
}
public java.lang.Integer getId_classificazione() {
	if (getV_classificazione_voci_ep() == null)
		return null;
	return getV_classificazione_voci_ep().getId_classificazione();
}

public void setId_classificazione(java.lang.Integer v_id_classificazione) {
	getV_classificazione_voci_ep().setId_classificazione(v_id_classificazione);
}
}
