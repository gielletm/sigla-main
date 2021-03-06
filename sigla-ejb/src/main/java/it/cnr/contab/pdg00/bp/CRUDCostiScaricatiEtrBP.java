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

package it.cnr.contab.pdg00.bp;
/**
 * Business Process per la gestione dei Costi scaricati verso altro CDR
 */

public class CRUDCostiScaricatiEtrBP extends CRUDCostiScaricatiBP {
public CRUDCostiScaricatiEtrBP() {
	super();
}

public CRUDCostiScaricatiEtrBP(String function) {
	super(function);
}

public CRUDCostiScaricatiEtrBP(String function, it.cnr.contab.config00.sto.bulk.CdrBulk cdr) {
	super(function, cdr);
}

protected void init(it.cnr.jada.action.Config config,it.cnr.jada.action.ActionContext context) throws it.cnr.jada.action.BusinessProcessException {
	super.init(config,context);
	setColumns(getBulkInfo().getColumnFieldPropertyDictionary("costiScaricati"));
}
}