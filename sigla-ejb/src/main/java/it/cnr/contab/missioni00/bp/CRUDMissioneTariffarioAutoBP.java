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

package it.cnr.contab.missioni00.bp;

import it.cnr.contab.missioni00.tabrif.bulk.*;
import it.cnr.contab.docamm00.tabrif.bulk.*;
import it.cnr.contab.compensi00.docs.bulk.CompensoBulk;
import it.cnr.jada.action.*;
import it.cnr.jada.bulk.*;
/**
 * CRUD per la tabella TariffariAuto
 * Creation date: (20/11/2001 15.55.08)
 * @author: Vincenzo Bisquadro
 */
public class CRUDMissioneTariffarioAutoBP extends it.cnr.jada.util.action.SimpleCRUDBP {
/**
 * Costruttore standard di CRUDMissioneTariffarioAutoBP
 */
public CRUDMissioneTariffarioAutoBP() {
	super();
}
/**
 * Costruttore di CRUDMissioneTariffarioAutoBP cui viene passato in ingresso:
 * 		function
 *
 * @param function java.lang.String
 */
public CRUDMissioneTariffarioAutoBP(String function) {
	super(function);
}
/**
 * Non devo poter modificare un record che abbia data fine validita
 * inferiore alla data odierna oppure un record con data cancellazione valorizzata
 *
 * Posso modificare tutti i record che hanno data fine validita
 * maggiore o uguale della data odierna e data cancellazione nulla
 *
*/
public void basicEdit(ActionContext context, OggettoBulk bulk, boolean doInitializeForEdit) throws it.cnr.jada.action.BusinessProcessException {

	super.basicEdit(context, bulk, doInitializeForEdit);
		
	if (!isViewing()){
		Missione_tariffario_autoBulk tariffario = (Missione_tariffario_autoBulk) getModel();
		if(tariffario.getDt_cancellazione() != null){
			setStatus(VIEW);
 		    setMessage("Codice tariffario " + tariffario.getCd_tariffa_auto() + " cancellato!");
		}else if(tariffario.getDataFineValidita()!=null && tariffario.getDataFineValidita().compareTo(CompensoBulk.getDataOdierna())<=0){
			setStatus(VIEW);
		}
	}
}
}
