package it.cnr.contab.doccont00.ejb;
import java.rmi.RemoteException;
import java.sql.Date;
import java.text.ParseException;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;

import it.cnr.contab.docamm00.comp.FatturaAttivaSingolaComponent;
import it.cnr.contab.doccont00.comp.MandatoComponent;
import it.cnr.contab.doccont00.comp.ReversaleComponent;
import it.cnr.jada.UserContext;
import it.cnr.jada.comp.ComponentException;
import it.cnr.jada.persistency.PersistencyException;
@Stateless(name="CNRDOCCONT00_EJB_ReversaleComponentSession")
public class ReversaleComponentSessionBean extends it.cnr.jada.ejb.CRUDComponentSessionBean implements ReversaleComponentSession {
@PostConstruct
	public void ejbCreate() {
	componentObj = new it.cnr.contab.doccont00.comp.ReversaleComponent();
}
public static it.cnr.jada.ejb.CRUDComponentSessionBean newInstance() throws javax.ejb.EJBException {
	return new ReversaleComponentSessionBean();
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk aggiungiDocAttivi(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1,java.util.List param2) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).aggiungiDocAttivi(param0,param1,param2);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public boolean isChiudibileReversaleProvvisoria(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException, it.cnr.jada.persistency.PersistencyException, it.cnr.jada.persistency.IntrospectionException {
	pre_component_invocation(param0,componentObj);
	try {
		boolean result = ((ReversaleComponent)componentObj).isChiudibileReversaleProvvisoria(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public boolean isRevProvvLiquidCoriCentroAperta(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException, it.cnr.jada.persistency.PersistencyException, it.cnr.jada.persistency.IntrospectionException {
	pre_component_invocation(param0,componentObj);
	try {
		boolean result = ((ReversaleComponent)componentObj).isRevProvvLiquidCoriCentroAperta(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk annullaReversale(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).annullaReversale(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk annullaReversale(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1,boolean param2) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).annullaReversale(param0,param1,param2);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public void annullaReversaleDiIncassoIVA(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		((ReversaleComponent)componentObj).annullaReversaleDiIncassoIVA(param0,param1);
		component_invocation_succes(param0,componentObj);
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public void annullaReversaleDiRegolarizzazione(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		((ReversaleComponent)componentObj).annullaReversaleDiRegolarizzazione(param0,param1);
		component_invocation_succes(param0,componentObj);
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public void annullaReversaleDiTrasferimento(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		((ReversaleComponent)componentObj).annullaReversaleDiTrasferimento(param0,param1);
		component_invocation_succes(param0,componentObj);
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.jada.util.RemoteIterator cercaSospesi(it.cnr.jada.UserContext param0,it.cnr.jada.persistency.sql.CompoundFindClause param1,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param2) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.jada.util.RemoteIterator result = ((ReversaleComponent)componentObj).cercaSospesi(param0,param1,param2);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk creaReversaleDiIncassoIVA(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.MandatoBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).creaReversaleDiIncassoIVA(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk creaReversaleDiRegolarizzazione(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.MandatoBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).creaReversaleDiRegolarizzazione(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk creaReversaleDiTrasferimento(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.MandatoAccreditamentoBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).creaReversaleDiTrasferimento(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.jada.bulk.OggettoBulk inizializzaBulkPerStampa(it.cnr.jada.UserContext param0,it.cnr.jada.bulk.OggettoBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.jada.bulk.OggettoBulk result = ((ReversaleComponent)componentObj).inizializzaBulkPerStampa(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk listaDocAttivi(it.cnr.jada.UserContext param0,it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).listaDocAttivi(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.jada.bulk.OggettoBulk stampaConBulk(it.cnr.jada.UserContext param0,it.cnr.jada.bulk.OggettoBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.jada.bulk.OggettoBulk result = ((ReversaleComponent)componentObj).stampaConBulk(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public java.lang.Boolean isCollegamentoSiopeCompleto (it.cnr.jada.UserContext param0, it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		java.lang.Boolean result = ((ReversaleComponent)componentObj).isCollegamentoSiopeCompleto(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
public it.cnr.contab.doccont00.core.bulk.ReversaleBulk setCodiciSIOPECollegabili (it.cnr.jada.UserContext param0, it.cnr.contab.doccont00.core.bulk.ReversaleBulk param1) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
	pre_component_invocation(param0,componentObj);
	try {
		it.cnr.contab.doccont00.core.bulk.ReversaleBulk result = ((ReversaleComponent)componentObj).setCodiciSIOPECollegabili(param0,param1);
		component_invocation_succes(param0,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(param0,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(param0,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(param0,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(param0,componentObj,e);
	}
}
//public  String lanciaStampa( it.cnr.jada.UserContext userContext, String cds, Integer esercizio , Long pgReversale) throws PersistencyException, ComponentException, RemoteException{
//	pre_component_invocation(userContext,componentObj);
//	try {
//		String result=((ReversaleComponent)componentObj).lanciaStampa(userContext,cds,esercizio,pgReversale);
//		component_invocation_succes(userContext,componentObj);
//		return result;
//	} catch(it.cnr.jada.comp.NoRollbackException e) {
//		component_invocation_succes(userContext,componentObj);
//		throw e;
//	} catch(it.cnr.jada.comp.ComponentException e) {
//		component_invocation_failure(userContext,componentObj);
//		throw e;
//	} catch(RuntimeException e) {
//		throw uncaughtRuntimeException(userContext,componentObj,e);
//	} catch(Error e) {
//		throw uncaughtError(userContext,componentObj,e);
//	}
//}
public  byte[] lanciaStampa( it.cnr.jada.UserContext userContext, String cds, Integer esercizio , Long pgReversale) throws PersistencyException, ComponentException, RemoteException, ParseException{
	pre_component_invocation(userContext,componentObj);
	try {
		byte[] result=((ReversaleComponent)componentObj).lanciaStampa(userContext,cds,esercizio,pgReversale);
		component_invocation_succes(userContext,componentObj);
		return result;
	} catch(it.cnr.jada.comp.NoRollbackException e) {
		component_invocation_succes(userContext,componentObj);
		throw e;
	} catch(it.cnr.jada.comp.ComponentException e) {
		component_invocation_failure(userContext,componentObj);
		throw e;
	} catch(RuntimeException e) {
		throw uncaughtRuntimeException(userContext,componentObj,e);
	} catch(Error e) {
		throw uncaughtError(userContext,componentObj,e);
	}
}
}
