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

package it.cnr.contab.util;

/**
 * Insert the type's description here.
 * Creation date: (10/10/2002 16:32:06)
 * @author: CNRADM
 */
public class PositivePercentFormat extends PercentFormat {
/**
 * PositivePercentFormat constructor comment.
 */
public PositivePercentFormat() {
	super();
}
public Object parseObject(String source) throws java.text.ParseException {
	java.math.BigDecimal percent = (java.math.BigDecimal)super.parseObject(source);
	if (percent == null) return null;
	if (percent.signum() < 0)
		throw new it.cnr.jada.bulk.ValidationParseException("Sono ammesse solo percentuali positive",0);
	return percent;
}
}
