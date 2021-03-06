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

package it.cnr.contab.config00.pdcep.bulk;

import it.cnr.contab.config00.pdcfin.bulk.*;
import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;
import it.cnr.jada.util.*;

/**
 * Questa classe eredita le caratteristiche della classe <code>Ass_ev_voceepBulk</code>,
 * che contiene le variabili e i metodi comuni a tutte le sue sottoclassi.
 * In particolare, si tratta di un'associazione tra capitolo di entrata del Cnr e conto
 * economico patrimoniale di ricavo.
 */
public class Ass_cap_entrata_Cnr_conto_econom_ricavoBulk extends Ass_ev_voceepBulk {

public Ass_cap_entrata_Cnr_conto_econom_ricavoBulk() {
	super();

	setTi_appartenenza(Elemento_voceHome.APPARTENENZA_CNR);
	setTi_gestione(Elemento_voceHome.GESTIONE_ENTRATE);
	// elemento_voce.setTi_appartenenza( Elemento_voceHome.APPARTENENZA_CNR );
	// elemento_voce.setTi_gestione( Elemento_voceHome.GESTIONE_ENTRATE );
}
public Ass_cap_entrata_Cnr_conto_econom_ricavoBulk(java.lang.String cd_elemento_voce,java.lang.String cd_voce_ep,java.lang.Integer esercizio,java.lang.String ti_appartenenza,java.lang.String ti_gestione) {
	super(cd_elemento_voce,cd_voce_ep,esercizio,ti_appartenenza,ti_gestione);
}
/**
 * Metodo con cui si verifica la validit?? di alcuni campi, mediante un 
 * controllo sintattico o contestuale.
 */
public void validate() throws ValidationException 
{
	super.validate();
	
	if ( elemento_voce == null || elemento_voce.getCd_elemento_voce() == null ||  elemento_voce.getCd_elemento_voce().equals("") )
		throw new ValidationException( "Il codice del CAPITOLO ENTRATA CNR ?? obbligatorio." );
	if ( voce_ep == null || voce_ep.getCd_voce_ep() == null || voce_ep.getCd_voce_ep().equals(""))
		throw new ValidationException( "Il codice del CONTO EP RICAVO ?? obbligatorio." );		
}
}
