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

package it.cnr.contab.docamm00.comp;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import it.cnr.contab.docamm00.docs.bulk.Fattura_attivaBulk;
import it.cnr.contab.docamm00.ejb.FatturaAttivaSingolaComponentSession;
import it.cnr.jada.UserContext;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.persistency.PersistencyException;
import it.cnr.jada.util.SendMail;
import it.cnr.jada.util.ejb.EJBCommonServices;

import javax.xml.datatype.XMLGregorianCalendar;

public class FatturaElettronicaAttivaComponent extends it.cnr.jada.comp.CRUDComponent 
	implements Cloneable,Serializable {
	private static final long serialVersionUID = 1L;

	public  FatturaElettronicaAttivaComponent(){
    }
	
	public Fattura_attivaBulk aggiornaFatturaRicevutaConsegnaInvioSDI(UserContext userContext, Fattura_attivaBulk fatturaAttiva, String codiceSdi, XMLGregorianCalendar dataConsegnaSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaRicevutaConsegnaInvioSDI(userContext, fatturaAttiva, codiceSdi, dataConsegnaSdi);
	}
	public Fattura_attivaBulk aggiornaFatturaRifiutataDestinatarioSDI(UserContext userContext, Fattura_attivaBulk fattura, String noteSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaRifiutataDestinatarioSDI(userContext, fattura, noteSdi);
	}

	public Fattura_attivaBulk aggiornaFatturaScartoSDI(UserContext userContext, Fattura_attivaBulk fattura, String codiceInvioSdi, String noteSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaScartoSDI(userContext, fattura, codiceInvioSdi, noteSdi);
	}
	
	public Fattura_attivaBulk aggiornaFatturaMancataConsegnaInvioSDI(UserContext userContext, Fattura_attivaBulk fatturaAttiva, String codiceSdi, String noteInvioSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaMancataConsegnaInvioSDI(userContext, fatturaAttiva, codiceSdi, noteInvioSdi);
	}
	
	public Fattura_attivaBulk aggiornaFatturaDecorrenzaTerminiSDI(UserContext userContext, Fattura_attivaBulk fattura, String noteSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaDecorrenzaTerminiSDI(userContext, fattura, noteSdi);
	}
	
	public Fattura_attivaBulk aggiornaFatturaTrasmissioneNonRecapitataSDI(UserContext userContext, Fattura_attivaBulk fattura, String codiceSdi, String noteInvioSdi) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaTrasmissioneNonRecapitataSDI(userContext, fattura, codiceSdi, noteInvioSdi);
	}
	
	public Fattura_attivaBulk aggiornaFatturaEsitoAccettatoSDI(UserContext userContext, Fattura_attivaBulk fattura) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaEsitoAccettatoSDI(userContext, fattura);
	}

	public Fattura_attivaBulk aggiornaFatturaConsegnaSDI(UserContext userContext, Fattura_attivaBulk fattura, Date dataConsegna) throws PersistencyException, ComponentException,java.rmi.RemoteException{
		return recuperoComponentFatturaAttiva().aggiornaFatturaConsegnaSDI(userContext, fattura, dataConsegna);
	}
	
	public void gestioneInvioMailNonRecapitabilita(UserContext userContext, Fattura_attivaBulk fattura) throws PersistencyException, ComponentException,java.rmi.RemoteException{
	    	if (fattura != null){
	    		String eMail = recuperoComponentFatturaAttiva().recuperoEmailUtente(userContext, fattura);
				String msg = "Si comunica che SDI non ha potuto recapitare al cliente la fattura "+fattura.getCd_uo_origine()+"-"+fattura.getEsercizio()+"-"+fattura.getPg_fattura_attiva()+". Provvedere ad avvisare il cliente che la fattura elettronica si trova nella sua area riservata del sito WEB dell'agenzia delle entrate.";
				String subject = "Avviso di Fattura Attiva non recapitabile";
				if (eMail != null){
					List<String> lista = new ArrayList<>();
					lista.add(eMail);
					SendMail.sendMail(subject, msg, lista);
				} else {
					SendMail.sendErrorMail(subject, msg);
				}
	    	}
	}
	
	
	private FatturaAttivaSingolaComponentSession recuperoComponentFatturaAttiva() {
		FatturaAttivaSingolaComponentSession componentFatturaAttiva = (FatturaAttivaSingolaComponentSession) EJBCommonServices.createEJB("CNRDOCAMM00_EJB_FatturaAttivaSingolaComponentSession");
		return componentFatturaAttiva;
	}
}