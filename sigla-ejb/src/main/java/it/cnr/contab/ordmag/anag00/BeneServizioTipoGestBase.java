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

/*
 * Created by BulkGenerator 2.0 [07/12/2009]
 * Date 26/04/2017
 */
package it.cnr.contab.ordmag.anag00;
import it.cnr.jada.persistency.Keyed;
public class BeneServizioTipoGestBase extends BeneServizioTipoGestKey implements Keyed {
//    TIPO_GESTIONE VARCHAR(3) NOT NULL
	private java.lang.String tipoGestione;
 
//    DT_FIN_VALIDITA TIMESTAMP(7)
	private java.sql.Timestamp dtFinValidita;
 
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Table name: BENE_SERVIZIO_TIPO_GEST
	 **/
	public BeneServizioTipoGestBase() {
		super();
	}
	public BeneServizioTipoGestBase(java.lang.String cdCds, java.lang.String cdMagazzino, java.lang.String cdBeneServizio, java.sql.Timestamp dtIniValidita) {
		super(cdCds, cdMagazzino, cdBeneServizio, dtIniValidita);
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [tipoGestione]
	 **/
	public java.lang.String getTipoGestione() {
		return tipoGestione;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [tipoGestione]
	 **/
	public void setTipoGestione(java.lang.String tipoGestione)  {
		this.tipoGestione=tipoGestione;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [dtFinValidita]
	 **/
	public java.sql.Timestamp getDtFinValidita() {
		return dtFinValidita;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [dtFinValidita]
	 **/
	public void setDtFinValidita(java.sql.Timestamp dtFinValidita)  {
		this.dtFinValidita=dtFinValidita;
	}
}