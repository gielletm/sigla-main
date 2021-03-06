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

package it.cnr.contab.doccont00.core.bulk;

import it.cnr.contab.config00.pdcfin.bulk.*;
import it.cnr.jada.bulk.*;
import it.cnr.jada.persistency.sql.*;
/**
 * Insert the type's description here.
 * Creation date: (18/06/2003 11.48.15)
 * @author: Simonetta Costa
 */
public class ImpegnoResiduoHome extends ObbligazioneHome {
/**
 * ImpegnoPGiroResiduoHome constructor comment.
 * @param conn java.sql.Connection
 */
public ImpegnoResiduoHome(java.sql.Connection conn) {
	super(ImpegnoResiduoBulk.class, conn);
}
/**
 * ImpegnoPGiroResiduoHome constructor comment.
 * @param conn java.sql.Connection
 * @param persistentCache it.cnr.jada.persistency.PersistentCache
 */
public ImpegnoResiduoHome(java.sql.Connection conn, it.cnr.jada.persistency.PersistentCache persistentCache) {
	super(ImpegnoResiduoBulk.class, conn, persistentCache);
}
public SQLBuilder createSQLBuilder() {
	SQLBuilder sql = super.createSQLBuilder();
	sql.addClause( "AND", "fl_pgiro", sql.EQUALS, new Boolean(false));
	sql.addClause( "AND", "cd_tipo_documento_cont", sql.EQUALS, Numerazione_doc_contBulk.TIPO_IMP_RES );
	return sql;
}
/**
 * Metodo per cercare la voce del piano dei conti 
 *
 * @param bulk <code>ObbligazioneBulk</code> il contesto (obbligazione) in cui viene fatta la ricerca dell'elemento voce
 * @param home istanza di <code>Elemento_voceHome</code>
 * @param bulkClause <code>OggettoBulk</code> elemento voce su cui viene fatta la ricerca
 * @param clause <code>CompoundFindClause</code> le clausole della selezione
 *
 * @return sql il risultato della selezione
 *
 */
public SQLBuilder selectVoceByClause( ImpegnoResiduoBulk bulk, Voce_fHome home,OggettoBulk bulkClause,CompoundFindClause clause) throws java.lang.reflect.InvocationTargetException,IllegalAccessException, it.cnr.jada.persistency.PersistencyException 
{
	SQLBuilder sql = getHomeCache().getHome( Voce_fBulk.class, "V_VOCE_F_PARTITA_GIRO").createSQLBuilder();
	sql.addClause( clause );
	sql.addSQLClause("AND", "esercizio", SQLBuilder.EQUALS, bulk.getEsercizio() );		
	sql.addSQLClause("AND", "ti_appartenenza", SQLBuilder.EQUALS, Elemento_voceHome.APPARTENENZA_CNR );
	sql.addSQLClause("AND", "ti_gestione", SQLBuilder.EQUALS, Elemento_voceHome.GESTIONE_SPESE );
	sql.addSQLClause("AND", "fl_partita_giro", SQLBuilder.EQUALS, "N" );
	sql.addSQLClause("AND", "fl_mastrino", SQLBuilder.EQUALS, "Y" );		
	return sql;
		
}
}
