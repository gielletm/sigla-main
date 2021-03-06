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

package it.cnr.contab.anagraf00.core.bulk;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

public class TerzoKey extends OggettoBulk implements KeyedPersistent {
	// CD_TERZO DECIMAL(8,0) NOT NULL (PK)
	private java.lang.Integer cd_terzo;

public TerzoKey() {
	super();
}
public TerzoKey(java.lang.Integer cd_terzo) {
	this.cd_terzo = cd_terzo;
}
public boolean equalsByPrimaryKey(Object o) {
	if (this == o) return true;
	if (!(o instanceof TerzoKey)) return false;
	TerzoKey k = (TerzoKey)o;
	if(!compareKey(getCd_terzo(),k.getCd_terzo())) return false;
	return true;
}
/* 
 * Getter dell'attributo cd_terzo
 */
public java.lang.Integer getCd_terzo() {
	return cd_terzo;
}
public int primaryKeyHashCode() {
	return
		calculateKeyHashCode(getCd_terzo());
}
/* 
 * Setter dell'attributo cd_terzo
 */
public void setCd_terzo(java.lang.Integer cd_terzo) {
	this.cd_terzo = cd_terzo;
}
}
