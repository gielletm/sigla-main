package it.cnr.contab.config00.latt.bulk;

import it.cnr.contab.config00.blob.bulk.PostItBulk;
import it.cnr.contab.config00.sto.bulk.CdsBulk;
import it.cnr.contab.config00.sto.bulk.DipartimentoBulk;
import it.cnr.contab.config00.sto.bulk.Tipo_unita_organizzativaHome;
import it.cnr.contab.progettiric00.core.bulk.Progetto_sipBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_sipHome;
import it.cnr.contab.utenze00.bp.CNRUserContext;
import it.cnr.contab.util.Utility;
import it.cnr.jada.UserContext;
import it.cnr.jada.bulk.BulkHome;
import it.cnr.jada.bulk.BusyResourceException;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.bulk.OutdatedResourceException;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.persistency.IntrospectionException;
import it.cnr.jada.persistency.ObjectNotFoundException;
import it.cnr.jada.persistency.PersistencyException;
import it.cnr.jada.persistency.Persistent;
import it.cnr.jada.persistency.sql.ApplicationPersistencyException;
import it.cnr.jada.persistency.sql.CompoundFindClause;
import it.cnr.jada.persistency.sql.LoggableStatement;
import it.cnr.jada.persistency.sql.PersistentHome;
import it.cnr.jada.persistency.sql.SQLBuilder;

import java.rmi.RemoteException;

import javax.ejb.EJBException;

public class WorkpackageHome extends BulkHome {
/**
 * Costrutture linea di attivit� Home
 *
 * @param conn connessione db
 */
public WorkpackageHome(java.sql.Connection conn) {
	super(WorkpackageBulk.class,conn);
}
/**
 * Costrutture linea di attivit� Home
 *
 * @param conn connessione db
 * @param persistentCache cache modelli
 */
public WorkpackageHome(java.sql.Connection conn,it.cnr.jada.persistency.PersistentCache persistentCache) {
	super(WorkpackageBulk.class,conn,persistentCache);
}
/**
 * Cancella un oggetto persistente dalla base dati.
 * Se la linea di attivit� � comune, non � possibile cancellarla
 */
@Override
public void delete(Persistent persistent, UserContext userContext) throws PersistencyException {
	if (((WorkpackageBulk)persistent).getTipo_linea_attivita().getTi_tipo_la().equals(Tipo_linea_attivitaBulk.COMUNE))
	 throw new ApplicationPersistencyException("I GAE comuni non sono cancellabili!",persistent);	
	super.delete(persistent, userContext);
}
public void initializePrimaryKeyForInsert(it.cnr.jada.UserContext userContext,OggettoBulk bulk) throws PersistencyException,it.cnr.jada.comp.ComponentException {
	try {
		WorkpackageBulk linea_attivita = (WorkpackageBulk)bulk;
		linea_attivita.setFl_limite_ass_obblig(Boolean.TRUE);
		if (!Tipo_linea_attivitaBulk.COMUNE.equals(linea_attivita.getTipo_linea_attivita().getTi_tipo_la())) {
			it.cnr.contab.config00.ejb.Lunghezza_chiaviComponentSession lunghezzaChiavi = (it.cnr.contab.config00.ejb.Lunghezza_chiaviComponentSession)it.cnr.jada.util.ejb.EJBCommonServices.createEJB("CNRCONFIG00_EJB_Lunghezza_chiaviComponentSession",it.cnr.contab.config00.ejb.Lunghezza_chiaviComponentSession.class);
			
			String aSuffix = linea_attivita.getTipo_linea_attivita().getTi_tipo_la();
			
			if (linea_attivita.getCd_linea_attivita() == null) {
				SQLBuilder sql = createSQLBuilder();

	// La gestione user delle linee di attivit� � limitata a quelle proprie.
	// Tali linee hanno una numerazione del tipo PXX..XX dove XX..XX � il progressivo
	// Devono essere inoltre gestite le linee di attivit� di tipo SISTEMA SXX..XX dove XX..XX � il progressivo
		
				sql.setHeader("SELECT MAX(CD_LINEA_ATTIVITA)");
				sql.addClause("AND","cd_centro_responsabilita",sql.EQUALS,linea_attivita.getCentro_responsabilita().getCd_centro_responsabilita());
				sql.addClause("AND","cd_linea_attivita",sql.LIKE,aSuffix+"%");
				LoggableStatement stm = sql.prepareStatement(getConnection());
				try {
					java.sql.ResultSet rs = stm.executeQuery();
					if (rs.next())
						linea_attivita.setCd_linea_attivita(rs.getString(1));
					try{rs.close();}catch( java.sql.SQLException e ){};
				} finally {
					try{stm.close();}catch( java.sql.SQLException e ){};
				}
				if (linea_attivita.getCd_linea_attivita() == null ||
					linea_attivita.getCd_linea_attivita().trim().length() == 0)
					linea_attivita.setCd_linea_attivita("1");
				else {
					findAndLock(linea_attivita);
					linea_attivita.setCd_linea_attivita(String.valueOf(Long.parseLong(linea_attivita.getCd_linea_attivita().replace(aSuffix.charAt(0),'0'))+1).replace('0',aSuffix.charAt(0)));
				}
			}
			linea_attivita.setCd_linea_attivita(lunghezzaChiavi.formatLinea_attivitaKey(userContext,linea_attivita.getCd_linea_attivita().replace(aSuffix.charAt(0),'0')));
			linea_attivita.setCd_linea_attivita(aSuffix+linea_attivita.getCd_linea_attivita().substring(1,linea_attivita.getCd_linea_attivita().length()));
			/*Se la linea di attivit� del PostIt � vuota la valorizzo*/
			for(int i = 0; linea_attivita.getDettagliPostIt().size() > i; i++) 
			{
			  if ((((PostItBulk)(linea_attivita.getDettagliPostIt().get(i))).getCd_linea_attivita()==null) ||
				 (((PostItBulk)(linea_attivita.getDettagliPostIt().get(i))).getCd_linea_attivita().compareTo(linea_attivita.getCd_linea_attivita())!=0))
			  {
				((PostItBulk)(linea_attivita.getDettagliPostIt().get(i))).setCd_linea_attivita(linea_attivita.getCd_linea_attivita());
			  }

			}
		}
	} catch(javax.ejb.EJBException e) {
		throw new it.cnr.jada.comp.ComponentException(e);
	} catch(java.rmi.RemoteException e) {
		throw new it.cnr.jada.comp.ComponentException(e);
	} catch(OutdatedResourceException e) {
		throw new it.cnr.jada.comp.ComponentException(e);
	} catch(BusyResourceException e) {
		throw new it.cnr.jada.comp.ComponentException(e);
	} catch(NumberFormatException e) {
		throw new it.cnr.jada.comp.ApplicationException("Non � possibile fornire una numerazione automatica perch� esisitono codici assegnati manualmente non numerici",e);
	}catch(java.sql.SQLException e) {
		throw new PersistencyException(e);
	}
}
public java.util.Collection findDettagliPostIt(WorkpackageBulk testata) throws IntrospectionException, PersistencyException {
	PersistentHome dettHome = getHomeCache().getHome(PostItBulk.class);
	SQLBuilder sql = dettHome.createSQLBuilder();
	sql.addClause("AND","cd_centro_responsabilita",SQLBuilder.EQUALS,testata.getCd_centro_responsabilita());
	sql.addClause("AND","cd_linea_attivita",SQLBuilder.EQUALS,testata.getCd_linea_attivita());
	return dettHome.fetchAll(sql);
}
public java.util.Collection findDettagliEsercizio(WorkpackageBulk testata) throws IntrospectionException, PersistencyException {
	PersistentHome dettHome = getHomeCache().getHome(Ass_linea_attivita_esercizioBulk.class);
	SQLBuilder sql = dettHome.createSQLBuilder();
	sql.addClause("AND","cd_centro_responsabilita",SQLBuilder.EQUALS,testata.getCd_centro_responsabilita());
	sql.addClause("AND","cd_linea_attivita",SQLBuilder.EQUALS,testata.getCd_linea_attivita());
	return dettHome.fetchAll(sql);
}
public DipartimentoBulk findDipartimento( UserContext userContext, WorkpackageBulk linea )  throws it.cnr.jada.comp.ComponentException, PersistencyException  
{
	linea = (WorkpackageBulk)getHomeCache().getHome(WorkpackageBulk.class).findByPrimaryKey(linea);
	Progetto_sipHome prgHome = (Progetto_sipHome)getHomeCache().getHome(Progetto_sipBulk.class);
	Progetto_sipBulk modulo = new Progetto_sipBulk();
	modulo.setPg_progetto(linea.getProgetto().getPg_progetto());
	modulo = (Progetto_sipBulk)prgHome.findByPrimaryKey(userContext, modulo); 
	return prgHome.findDipartimento(userContext, modulo); 
}
	@Override
	public void handleObjectNotFoundException(ObjectNotFoundException objectnotfoundexception) throws ObjectNotFoundException {
	}
	public SQLBuilder selectCofogByClause(it.cnr.jada.UserContext userContext, WorkpackageBulk linea,CofogHome home,CofogBulk bulk,CompoundFindClause clauses) throws ComponentException, EJBException, RemoteException {
		
		CdsBulk cds = Utility.createParametriEnteComponentSession().getCds(userContext,CNRUserContext.getCd_cds(userContext));
		PersistentHome dettHome = getHomeCache().getHome(CofogBulk.class);
		SQLBuilder sql = dettHome.createSQLBuilder();
		sql.addTableToHeader("PARAMETRI_CNR"); 
		sql.addClause( clauses );
		sql.addSQLClause("AND","PARAMETRI_CNR.ESERCIZIO",SQLBuilder.EQUALS,CNRUserContext.getEsercizio(userContext));
		sql.addSQLJoin("COFOG.NR_LIVELLO","PARAMETRI_CNR.LIVELLO_PDG_COFOG");
		if(cds.getCd_tipo_unita().compareTo(Tipo_unita_organizzativaHome.TIPO_UO_SAC)==0){
			sql.openParenthesis("AND");
		 	sql.addSQLClause("AND", "COFOG.FL_ACCENTRATO", sql.EQUALS, "Y");
			sql.addSQLClause("OR", "COFOG.FL_DECENTRATO", sql.EQUALS, "Y");
			sql.closeParenthesis();
		}
		else{
			sql.addSQLClause("AND", "COFOG.FL_DECENTRATO", sql.EQUALS, "Y");
		}
		sql.openParenthesis("AND");
		sql.addSQLClause("AND", "COFOG.DT_CANCELLAZIONE", sql.ISNULL, null);
		sql.addSQLClause("OR","COFOG.DT_CANCELLAZIONE",sql.GREATER,it.cnr.jada.util.ejb.EJBCommonServices.getServerDate());
		sql.closeParenthesis(); 
		return sql;
	}
}
