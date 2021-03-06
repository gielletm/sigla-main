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

package it.cnr.contab.progettiric00.tabrif.bulk;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

public class Tipo_progettoBase extends Tipo_progettoKey implements Keyed {
	// DS_TIPO_PROGETTO VARCHAR(100) NOT NULL
	private java.lang.String ds_tipo_progetto;

public Tipo_progettoBase() {
	super();
}
public Tipo_progettoBase(java.lang.String cd_tipo_progetto) {
	super(cd_tipo_progetto);
}
/* 
 * Getter dell'attributo ds_tipo_progetto
 */
public java.lang.String getDs_tipo_progetto() {
	return ds_tipo_progetto;
}
/* 
 * Setter dell'attributo ds_tipo_progetto
 */
public void setDs_tipo_progetto(java.lang.String ds_tipo_progetto) {
	this.ds_tipo_progetto = ds_tipo_progetto;
}
}
