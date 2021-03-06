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

package it.cnr.contab.inventario00.tabrif.bulk;

import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.*;
import it.cnr.jada.persistency.beans.*;
import it.cnr.jada.persistency.sql.*;

public class Id_inventarioKey extends OggettoBulk implements KeyedPersistent {
	// PG_INVENTARIO DECIMAL(10,0) NOT NULL (PK)
	private java.lang.Long pg_inventario;

public Id_inventarioKey() {
	super();
}
public Id_inventarioKey(java.lang.Long pg_inventario) {
	super();
	this.pg_inventario = pg_inventario;
}
public boolean equals(Object o) {
	if (this == o) return true;
	if (!(o instanceof Id_inventarioKey)) return false;
	Id_inventarioKey k = (Id_inventarioKey)o;
	if(!compareKey(getPg_inventario(),k.getPg_inventario())) return false;
	return true;
}
public boolean equalsByPrimaryKey(Object o) {
	if (this == o) return true;
	if (!(o instanceof Id_inventarioKey)) return false;
	Id_inventarioKey k = (Id_inventarioKey)o;
	if(!compareKey(getPg_inventario(),k.getPg_inventario())) return false;
	return true;
}
/* 
 * Getter dell'attributo pg_inventario
 */
public java.lang.Long getPg_inventario() {
	return pg_inventario;
}
public int hashCode() {
	return
		calculateKeyHashCode(getPg_inventario());
}
public int primaryKeyHashCode() {
	return
		calculateKeyHashCode(getPg_inventario());
}
/* 
 * Setter dell'attributo pg_inventario
 */
public void setPg_inventario(java.lang.Long pg_inventario) {
	this.pg_inventario = pg_inventario;
}
}
