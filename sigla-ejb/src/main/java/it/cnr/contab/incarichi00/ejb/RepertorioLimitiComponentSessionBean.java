package it.cnr.contab.incarichi00.ejb;

import javax.annotation.PostConstruct;
import javax.ejb.Stateless;

import it.cnr.contab.incarichi00.comp.RepertorioLimitiComponent;

/**
 * Bean implementation class for Enterprise Bean: CNRINCARICHI00_EJB_RepertorioLimitiComponentSession
 */
@Stateless(name="CNRINCARICHI00_EJB_RepertorioLimitiComponentSession")
public class RepertorioLimitiComponentSessionBean extends it.cnr.jada.ejb.CRUDComponentSessionBean implements RepertorioLimitiComponentSession {
	@PostConstruct
	public void ejbCreate() {
		componentObj = new it.cnr.contab.incarichi00.comp.RepertorioLimitiComponent();
	}
	public static it.cnr.jada.ejb.CRUDComponentSessionBean newInstance() throws javax.ejb.EJBException {
		return new RepertorioLimitiComponentSessionBean();
	}
	public it.cnr.contab.incarichi00.bulk.Repertorio_limitiBulk getRepertorioLimiti(it.cnr.jada.UserContext param0,int param1,java.lang.String param2,java.lang.String param3,java.lang.String param4) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
		pre_component_invocation(param0,componentObj);
		try {
			it.cnr.contab.incarichi00.bulk.Repertorio_limitiBulk result = ((RepertorioLimitiComponent)componentObj).getRepertorioLimiti(param0,param1,param2,param3,param4);
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
	public it.cnr.contab.incarichi00.bulk.Repertorio_limitiBulk aggiornaRepertorioLimiti(it.cnr.jada.UserContext param0,int param1,java.lang.String param2,java.lang.String param3,java.lang.String param4,java.math.BigDecimal param5) throws it.cnr.jada.comp.ComponentException,javax.ejb.EJBException {
		pre_component_invocation(param0,componentObj);
		try {
			it.cnr.contab.incarichi00.bulk.Repertorio_limitiBulk result = ((RepertorioLimitiComponent)componentObj).aggiornaRepertorioLimiti(param0,param1,param2,param3,param4,param5);
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
}