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
 * Created on Nov 9, 2005
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
package it.cnr.contab.prevent01.consultazioni.action;


import it.cnr.contab.prevent01.consultazioni.bp.ConsPDGGAreaSpeBP;
import it.cnr.contab.prevent01.consultazioni.bp.ConsPDGGIstBP;
import it.cnr.contab.prevent01.consultazioni.bp.ConsVarPDGGIstBP;
import it.cnr.contab.prevent01.consultazioni.bp.ConsVarPDGGIstEtrBP;
import it.cnr.contab.prevent01.consultazioni.bp.ConsVarPDGGIstSpeBP;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.action.Forward;
import it.cnr.jada.util.action.ConsultazioniAction;


public class ConsVarPDGGIstAction extends ConsultazioniAction {
	private static final long serialVersionUID = 1L;

	public Forward doConsulta(ActionContext context, String livelloDestinazione) {
		try {
			ConsVarPDGGIstBP bp = (ConsVarPDGGIstBP)context.getBusinessProcess();
			bp.setSelection(context);
			long selectElements = bp.getSelection().size();

			if (selectElements == 0)
				selectElements = Integer.valueOf(bp.getSelection().getFocus()).compareTo(-1);
			
			if (selectElements == 0) {
				bp.setMessage("Non ?? stata selezionata nessuna riga.");
				return context.findDefaultForward();
			}

			ConsVarPDGGIstBP consultazioneBP = null;
			context.closeBusinessProcess(bp);
			if (bp instanceof ConsVarPDGGIstSpeBP) 
				consultazioneBP = (ConsVarPDGGIstSpeBP)context.createBusinessProcess("ConsVarPDGGIstSpeBP");
			else
				consultazioneBP = (ConsVarPDGGIstEtrBP)context.createBusinessProcess("ConsVarPDGGIstEtrBP");
			
			consultazioneBP.initVariabili(context, bp.getPathConsultazione(), livelloDestinazione);
			if ((bp.getElementsCount()!=selectElements)||!(bp.getBaseclause().toString().equals(consultazioneBP.getBaseclause().toString()))||bp.getFindclause()!=null)
				consultazioneBP.addToBaseclause(bp.getSelezione(context));
			if (consultazioneBP instanceof ConsVarPDGGIstSpeBP)
				consultazioneBP.setIterator(context,consultazioneBP.createVarPDGGAreaComponentSession().findConsultazioneSpe(context.getUserContext(),bp.getPathDestinazione(livelloDestinazione),livelloDestinazione,consultazioneBP.getBaseclause(),null));			
			else
				consultazioneBP.setIterator(context,consultazioneBP.createVarPDGGAreaComponentSession().findConsultazioneEtr(context.getUserContext(),bp.getPathDestinazione(livelloDestinazione),livelloDestinazione,consultazioneBP.getBaseclause(),null));			
			
			return context.addBusinessProcess(consultazioneBP);
		} catch(Throwable e) {
			return handleException(context,e);
		}
	}

	public Forward doConsultaCdr(ActionContext context) {
		return doConsulta(context, ConsPDGGIstBP.LIVELLO_CDR);
	}
	public Forward doConsultaModulo(ActionContext context) {
		return doConsulta(context, ConsPDGGIstBP.LIVELLO_MOD);
	}
	public Forward doConsultaLivello1(ActionContext context) {
		return doConsulta(context, ConsPDGGIstBP.LIVELLO_LIV1);
	}
	public Forward doConsultaLivello2(ActionContext context) {
		return doConsulta(context, ConsPDGGIstBP.LIVELLO_LIV2);
	}
	public Forward doConsultaLivello3(ActionContext context) {
			return doConsulta(context, ConsPDGGIstBP.LIVELLO_LIV3);
		}
	public Forward doConsultaLinea(ActionContext context) {
		return doConsulta(context, ConsPDGGAreaSpeBP.LIVELLO_LIN);
	}
	public Forward doConsultaVoce(ActionContext context) {
		return doConsulta(context, ConsPDGGAreaSpeBP.LIVELLO_VOC);
	}
	public Forward doConsultaDettagli(ActionContext context) {
		return doConsulta(context, ConsPDGGIstBP.LIVELLO_DET);
	}
	public Forward doCloseForm(ActionContext context) throws BusinessProcessException {
		Forward appoForward = super.doCloseForm(context);
		if (context.getBusinessProcess() instanceof ConsPDGGIstBP) {
			ConsPDGGIstBP bp = (ConsPDGGIstBP)context.getBusinessProcess();
			bp.setTitle();
		}
		return appoForward;
	}
}