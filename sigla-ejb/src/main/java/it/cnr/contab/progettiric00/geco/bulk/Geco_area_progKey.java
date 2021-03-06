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
 * Created by Aurelio's BulkGenerator 1.0
 * Date 27/11/2006
 */
package it.cnr.contab.progettiric00.geco.bulk;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.persistency.KeyedPersistent;
public class Geco_area_progKey extends OggettoBulk implements KeyedPersistent {
	private static final long serialVersionUID = 1L;

	private java.lang.Long id_area;
	private java.lang.Long esercizio;
	private java.lang.String fase;
	public Geco_area_progKey() {
		super();
	}
	public Geco_area_progKey(java.lang.Long id_area, java.lang.Long esercizio, java.lang.String fase) {
		super();
		this.id_area=id_area;
		this.esercizio=esercizio;
		this.fase=fase;
	}
	public boolean equalsByPrimaryKey(Object o) {
		if (this== o) return true;
		if (!(o instanceof Geco_area_progKey)) return false;
		Geco_area_progKey k = (Geco_area_progKey) o;
		if (!compareKey(getId_area(), k.getId_area())) return false;
		if (!compareKey(getEsercizio(), k.getEsercizio())) return false;
		if (!compareKey(getFase(), k.getFase())) return false;
		return true;
	}
	public int primaryKeyHashCode() {
		int i = 0;
		i = i + calculateKeyHashCode(getId_area());
		i = i + calculateKeyHashCode(getEsercizio());
		i = i + calculateKeyHashCode(getFase());
		return i;
	}
	public void setId_area(java.lang.Long id_area)  {
		this.id_area=id_area;
	}
	public java.lang.Long getId_area() {
		return id_area;
	}
	public void setEsercizio(java.lang.Long esercizio)  {
		this.esercizio=esercizio;
	}
	public java.lang.Long getEsercizio() {
		return esercizio;
	}
	public void setFase(java.lang.String fase)  {
		this.fase=fase;
	}
	public java.lang.String getFase() {
		return fase;
	}
}