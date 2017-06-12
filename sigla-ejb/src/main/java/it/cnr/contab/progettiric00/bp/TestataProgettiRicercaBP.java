package it.cnr.contab.progettiric00.bp;

import java.rmi.RemoteException;

import javax.servlet.http.HttpSession;

import it.cnr.contab.config00.blob.bulk.PostItBulk;
import it.cnr.contab.config00.bulk.Parametri_cnrBulk;
import it.cnr.contab.config00.bulk.Parametri_enteBulk;
import it.cnr.contab.progettiric00.core.bulk.ProgettoBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_finanziatoreBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_partner_esternoBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_piano_economicoBulk;
import it.cnr.contab.progettiric00.core.bulk.Progetto_uoBulk;
import it.cnr.contab.progettiric00.ejb.ProgettoRicercaComponentSession;
import it.cnr.contab.utenze00.bp.CNRUserContext;
import it.cnr.contab.util.Utility;
import it.cnr.jada.action.ActionContext;
import it.cnr.jada.action.BusinessProcessException;
import it.cnr.jada.action.Config;
import it.cnr.jada.action.HttpActionContext;
import it.cnr.jada.bulk.BulkInfo;
import it.cnr.jada.bulk.OggettoBulk;
import it.cnr.jada.bulk.ValidationException;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.util.RemoteBulkTree;
import it.cnr.jada.util.RemoteIterator;
import it.cnr.jada.util.action.SimpleDetailCRUDController;


public class TestataProgettiRicercaBP extends it.cnr.jada.util.action.SimpleCRUDBP implements IProgettoBP{
	private boolean flNuovoPdg = false;
	private boolean flInformix = false;
	private boolean flPrgPianoEconomico = false;

	private SimpleDetailCRUDController crudDettagli = new SimpleDetailCRUDController( "Dettagli", Progetto_uoBulk.class, "dettagli", this) {
		public void validateForDelete(ActionContext context, OggettoBulk detail)
			throws ValidationException
		{
			validaUO(context, detail);
		}
	};
	private SimpleDetailCRUDController crudDettagliFinanziatori = new SimpleDetailCRUDController( "DettagliFinanziatori", Progetto_finanziatoreBulk.class, "dettagliFinanziatori", this);
	private SimpleDetailCRUDController crudDettagliPartner_esterni = new SimpleDetailCRUDController( "DettagliPartner_esterni", Progetto_partner_esternoBulk.class, "dettagliPartner_esterni", this);
	private SimpleDetailCRUDController crudDettagliPostIt = new SimpleDetailCRUDController( "DettagliPostIt", PostItBulk.class, "dettagliPostIt", this);
	private SimpleDetailCRUDController crudPianoEconomico = new SimpleDetailCRUDController( "PianoEconomico", Progetto_piano_economicoBulk.class, "dettagliPianoEconomico", this){
		public void validateForDelete(ActionContext context, OggettoBulk detail) throws ValidationException
		{
			try {
				((ProgettoRicercaComponentSession)createComponentSession()).validaCancellazionePianoEconomicoAssociato(
					context.getUserContext(),
					(ProgettoBulk)getParentModel(),
					detail);
			} catch (ComponentException e) {
				throw new ValidationException(e.getMessage());
			} catch (RemoteException e) {
				throw new ValidationException(e.getMessage());
			} catch (BusinessProcessException e) {
				throw new ValidationException(e.getMessage());
			}
		}
	};


	/**
	 * TestataProgettiRicercaBP constructor comment.
	 */
	public TestataProgettiRicercaBP() {
		super();
	}
	/**
	 * TestataProgettiRicercaBP constructor comment.
	 * @param function java.lang.String
	 */
	public TestataProgettiRicercaBP(String function) {
		super(function);
	}
	
	@Override
	protected void init(Config config, ActionContext actioncontext) throws BusinessProcessException {
		try {
			Parametri_cnrBulk parCnr = Utility.createParametriCnrComponentSession().getParametriCnr(actioncontext.getUserContext(), CNRUserContext.getEsercizio(actioncontext.getUserContext())); 
			setFlNuovoPdg(parCnr.getFl_nuovo_pdg().booleanValue());
			Parametri_enteBulk parEnte = Utility.createParametriEnteComponentSession().getParametriEnte(actioncontext.getUserContext());
			setFlInformix(parEnte.getFl_informix().booleanValue());
			setFlPrgPianoEconomico(parEnte.getFl_prg_pianoeco().booleanValue());
		}catch(Throwable e) {
			throw new BusinessProcessException(e);
		}
		super.init(config, actioncontext);
	}
	public BulkInfo getBulkInfo()
	{
		BulkInfo infoBulk = super.getBulkInfo();
		if (!this.isFlNuovoPdg())
			infoBulk.setShortDescription("Commesse");
		else
			infoBulk.setShortDescription(ProgettoBulk.LABEL_AREA_PROGETTUALE);
		return infoBulk;
	}
		public final it.cnr.jada.util.action.SimpleDetailCRUDController getCrudDettagli() {
			return crudDettagli;
		}
		
		public final it.cnr.jada.util.action.SimpleDetailCRUDController getCrudDettagliFinanziatori() {
			return crudDettagliFinanziatori;
		}
	/**
		 * Returns the crudDettagliPartner_esterni.
		 * @return SimpleDetailCRUDController
		 */
		public final it.cnr.jada.util.action.SimpleDetailCRUDController getCrudDettagliPartner_esterni() {
			return crudDettagliPartner_esterni;
		}
		
		 /**
		 * Returns the crudDettagliPostIt.
		 * @return SimpleDetailCRUDController
		 */
		public final it.cnr.jada.util.action.SimpleDetailCRUDController getCrudDettagliPostIt() {
			return crudDettagliPostIt;
		}		
	protected void resetTabs(it.cnr.jada.action.ActionContext context) {
		setTab("tab","tabTestata");
	}
	/**
	 * E' stata generata la richiesta di cercare il Progetto che sar� nodo padre del Progetto
	 *	che si sta creando.
	 *  Il metodo restituisce un Iteratore che permette di navigare tra i Progetti passando
	 *	da un livello ai suoi nodi figli e viceversa. Il metodo isLeaf, permette di definire un 
	 *	"livello foglia", il livello, cio�, che non ha nodi sotto di esso.
	 *
	 * @param context la <code>ActionContext</code> che ha generato la richiesta
	 *
	 * @return <code>RemoteBulkTree</code> l'albero richiesto
	**/
	public RemoteBulkTree getProgettiTree(ActionContext context) throws it.cnr.jada.comp.ComponentException{
	  return
		new RemoteBulkTree() {
		  public RemoteIterator getChildren(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return it.cnr.jada.util.ejb.EJBCommonServices.openRemoteIterator(context,((ProgettoRicercaComponentSession)createComponentSession()).getChildren(context.getUserContext(),bulk));
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
	
		  }
		  public OggettoBulk getParent(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).getParent(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		  
	
		  public boolean isLeaf(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).isLeaf(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		};
	}
	/**
	 * E' stata generata la richiesta di cercare il Progetto che sar� nodo padre del Progetto
	 *	che si sta creando.
	 *  Il metodo restituisce un Iteratore che permette di navigare tra i Progetti passando
	 *	da un livello ai suoi nodi figli e viceversa. Il metodo isLeaf, permette di definire un 
	 *	"livello foglia", il livello, cio�, che non ha nodi sotto di esso.
	 *
	 * @param context la <code>ActionContext</code> che ha generato la richiesta
	 *
	 * @return <code>RemoteBulkTree</code> l'albero richiesto
	**/
	public RemoteBulkTree getProgetti_sipTree(ActionContext context) throws it.cnr.jada.comp.ComponentException{
	  return
		new RemoteBulkTree() {
		  public RemoteIterator getChildren(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return it.cnr.jada.util.ejb.EJBCommonServices.openRemoteIterator(context,((ProgettoRicercaComponentSession)createComponentSession()).getChildrenForSip(context.getUserContext(),bulk));
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
	
		  }
		  public OggettoBulk getParent(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).getParentForSip(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		  
	
		  public boolean isLeaf(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).isLeafForSip(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		};
	}
	
	/**
	 * E' stata generata la richiesta di cercare il Progetto che sar� nodo padre del Progetto
	 *	che si sta creando.
	 *  Il metodo restituisce un Iteratore che permette di navigare tra i Progetti passando
	 *	da un livello ai suoi nodi figli e viceversa. Il metodo isLeaf, permette di definire un 
	 *	"livello foglia", il livello, cio�, che non ha nodi sotto di esso.
	 *
	 * @param context la <code>ActionContext</code> che ha generato la richiesta
	 *
	 * @return <code>RemoteBulkTree</code> l'albero richiesto
	**/
	public RemoteBulkTree getProgettiTreeWorkpackage(ActionContext context) throws it.cnr.jada.comp.ComponentException{
	  return
		new RemoteBulkTree() {
		  public RemoteIterator getChildren(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return it.cnr.jada.util.ejb.EJBCommonServices.openRemoteIterator(context,((ProgettoRicercaComponentSession)createComponentSession()).getChildrenWorkpackage(context.getUserContext(),bulk));
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
	
		  }
		  public OggettoBulk getParent(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).getParent(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		  
	
		  public boolean isLeaf(ActionContext context, OggettoBulk bulk) throws java.rmi.RemoteException {
			try{
			  return ((ProgettoRicercaComponentSession)createComponentSession()).isLeaf(context.getUserContext(),bulk);
			}catch(it.cnr.jada.comp.ComponentException ex){
				throw new java.rmi.RemoteException("Component Exception",ex);
			}catch(it.cnr.jada.action.BusinessProcessException ex){
				throw new java.rmi.RemoteException("BusinessProcess Exception",ex);
			}
		  }
		};
	}
	/* 
	 * Necessario per la creazione di una form con enctype di tipo "multipart/form-data"
	 * Sovrascrive quello presente nelle superclassi
	 * 
	*/
	
	public void openForm(javax.servlet.jsp.PageContext context,String action,String target) throws java.io.IOException,javax.servlet.ServletException {
	
			openForm(context,action,target,"multipart/form-data");
		
	}
	
	/*
	 * Utilizzato per la gestione del bottone di attivazione del PostIt
	 * Sovrascrive il metodo si SimpleCRUDBP
	 * */
	public boolean isActive(OggettoBulk bulk,int sel) {
	  if (bulk instanceof ProgettoBulk)	
	    try
	    {
	        return ((PostItBulk) ((ProgettoBulk)bulk).getDettagliPostIt().get(sel)).isROpostit();
	    }
	    catch (RuntimeException e)
	    {
	    	if (sel==0)
			return false;
	        else
	        e.printStackTrace();
	    }
		return false;
	}
	/*
	 * Utilizzato per la gestione del titolo
	 * Sovrascrive il metodo si CRUDBP
	 * */
	public String getFormTitle()
	{
		StringBuffer stringbuffer = new StringBuffer();
		if (isFlNuovoPdg())
			stringbuffer = stringbuffer.append(ProgettoBulk.LABEL_PROGETTO);
		else
			stringbuffer = stringbuffer.append("Commesse");
	
		stringbuffer.append(" - ");
		switch(getStatus())
		{
		case 1: // '\001'
			stringbuffer.append("Inserimento");
			break;
	
		case 2: // '\002'
			stringbuffer.append("Modifica");
			break;
	
		case 0: // '\0'
			stringbuffer.append("Ricerca");
			break;
	
		case 5: // '\005'
			stringbuffer.append("Visualizza");
			break;
		}
		return stringbuffer.toString();
	}
	public String getSearchResultColumnSet() {
	
		return "filtro_ricerca_commesse";
	}
	
	public int getLivelloProgetto() {
		return ProgettoBulk.LIVELLO_PROGETTO_SECONDO.intValue();
	}
	
	public void validaUO(ActionContext context, it.cnr.jada.bulk.OggettoBulk detail) throws ValidationException {
		try {
			// controllo viene effettuato solo per i moduli attivit�
			if ((this.isFlNuovoPdg() && getLivelloProgetto()==ProgettoBulk.LIVELLO_PROGETTO_SECONDO.intValue()) ||
				(!this.isFlNuovoPdg() && getLivelloProgetto()==ProgettoBulk.LIVELLO_PROGETTO_TERZO.intValue()))
				((ProgettoRicercaComponentSession)createComponentSession()).validaCancellazioneUoAssociata(
					context.getUserContext(),
					(ProgettoBulk)getModel(),
					detail);
		} catch (ComponentException e) {
			throw new ValidationException(e.getMessage());
		} catch (RemoteException e) {
			throw new ValidationException(e.getMessage());
		} catch (BusinessProcessException e) {
			throw new ValidationException(e.getMessage());
		}
	}
	
	public boolean isFlNuovoPdg() {
		return flNuovoPdg;
	}
	
	private void setFlNuovoPdg(boolean flNuovoPdg) {
		this.flNuovoPdg = flNuovoPdg;
	}
	
	public boolean isFlInformix() {
		return flInformix;
	}
	
	public void setFlInformix(boolean flInformix) {
		this.flInformix = flInformix;
	}
	
	public boolean isFlPrgPianoEconomico() {
		return flPrgPianoEconomico;
	}
	
	public void setFlPrgPianoEconomico(boolean flPrgPianoEconomico) {
		this.flPrgPianoEconomico = flPrgPianoEconomico;
	}
	
	@Override
	public void basicEdit(ActionContext actioncontext, OggettoBulk oggettobulk, boolean flag)
			throws BusinessProcessException {
		super.basicEdit(actioncontext, oggettobulk, flag);
		if (!((ProgettoBulk)oggettobulk).getCd_unita_organizzativa().equals(CNRUserContext.getCd_unita_organizzativa(actioncontext.getUserContext())))
			this.setStatus(VIEW);
		
	}
	
	public String[][] getTabs(HttpSession session) {
		String uo = CNRUserContext.getCd_unita_organizzativa(HttpActionContext.getUserContext(session));
	
	    if (this.isFlNuovoPdg() && this.getModel()!=null && 
	    	((ProgettoBulk)this.getModel()).getCd_unita_organizzativa()!=null &&
	    	((ProgettoBulk)this.getModel()).getCd_unita_organizzativa().equals(uo)) {
	    	if (this.isFlPrgPianoEconomico() && ((ProgettoBulk)this.getModel()).getFl_piano_economico()) {
		    	return new String[][] {
		               { "tabTestata","Testata","/progettiric00/progetto_ricerca_testata_commesse.jsp" },
		               { "tabDettagli","UO partecipanti","/progettiric00/progetto_ricerca_dettagli.jsp" },
		               { "tabPianoEconomico","Piano Economico","/progettiric00/progetto_piano_economico.jsp" }};
	    	} else {
		    	return new String[][] {
	               { "tabTestata","Testata","/progettiric00/progetto_ricerca_testata_commesse.jsp" },
	               { "tabDettagli","UO partecipanti","/progettiric00/progetto_ricerca_dettagli.jsp" }};
	    	}
	    } else {
	  	   return new String[][] {
	               { "tabTestata","Testata","/progettiric00/progetto_ricerca_testata_commesse.jsp" }};//,
	               //{ "tabDettagli","UO partecipanti","/progettiric00/progetto_ricerca_dettagli.jsp" },
	               //{ "tabDettagliPartner_esterni","Partner esterni","/progettiric00/progetto_ricerca_dettagliPartner_esterni.jsp" },
	               //{ "tabDettagliPostIt","Post-It","/config00/dettagliPostIt.jsp" },
	               //{ "tabSpeseCostiFigurativi","Spese/Costi Figurativi","/progettiric00/spese_costi_figurativi.jsp" },
	               //{ "tabRisorseResiduePresunte","Risorse Residue Presunte","/progettiric00/risorse_residue_presunte.jsp" }};
	    } 
	}

	@Override
	public OggettoBulk initializeModelForInsert(ActionContext actioncontext, OggettoBulk oggettobulk)
			throws BusinessProcessException {
		if (this.isFlNuovoPdg()) {
			ProgettoBulk progettopadre = new ProgettoBulk();
			progettopadre.setLivello(1);
			((ProgettoBulk)oggettobulk).setProgettopadre(progettopadre);
			((ProgettoBulk)oggettobulk).setLivello(2);
		}
		return super.initializeModelForInsert(actioncontext, oggettobulk);
	}
	public String getLabelCd_progetto_padre() {
		if (this.isFlNuovoPdg())
			return ProgettoBulk.LABEL_AREA_PROGETTUALE;
		return ProgettoBulk.LABEL_COMMESSA;
	}
	
	public SimpleDetailCRUDController getCrudPianoEconomico() {
		return crudPianoEconomico;
	}
}
