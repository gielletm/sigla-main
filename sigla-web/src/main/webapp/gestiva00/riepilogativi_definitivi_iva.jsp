<!-- 
 ?ResourceName "riepilogativi_definitivi_iva.jsp"
 ?ResourceTimestamp "09/08/01 16.54.00"
 ?ResourceEdition "1.0"
-->

<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.util.jsp.*,
		it.cnr.jada.action.*,
		java.util.*,
		it.cnr.jada.util.action.*,
		it.cnr.contab.gestiva00.bp.*"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<% JSPUtils.printBaseUrl(pageContext); %>
<script language="JavaScript" src="scripts/util.js"></script>
<script language="javascript" src="scripts/css.js"></script>
<title>Riepilogativi definitivi IVA</title>
</head>
<body class="Form">

<% RiepilogativiDefinitiviIvaBP bp = (RiepilogativiDefinitiviIvaBP)BusinessProcess.getBusinessProcess(request);
	 bp.openFormWindow(pageContext); %>

	<div class="Group card" style="width:100%">
		<table width="100%">
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"tipoSezionaleFlag");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"tipoSezionaleFlag",false,null,"onChange=\"submitForm('doOnTipoChange')\"");%>
				</td>
			</tr>     	
			<tr>     	
		     	<td>
			   		<% bp.getController().writeFormLabel(out, "sezionaliFlagsRadioGroup");%>
		      	</td>      	
		     	<td colspan="3">
			   		<% bp.getController().writeFormInput(out, null, "sezionaliFlagsRadioGroup", false, null, "onClick=\"submitForm('doOnSezionaliFlagsChange')\"");%>
		      	</td>
		     	<td width="100">&nbsp;</td>
		      	<td>
		      		<table>
					      <tr>     	
					   	 </tr>
					      <tr>     	
					   	 </tr>
		      		</table>
		      	</td>
	      </tr>
		  <tr>
<%it.cnr.contab.gestiva00.core.bulk.Riepilogativi_definitivi_ivaVBulk riepilogativo = 
(it.cnr.contab.gestiva00.core.bulk.Riepilogativi_definitivi_ivaVBulk) bp.getModel();
 if (riepilogativo.getSezionaliFlag()==null || riepilogativo.getSezionaliFlag().equals(riepilogativo.SEZIONALI_FLAGS_SEZ)){    %>
				<td>
					<% bp.getController().writeFormLabel(out,"tipo_sezionale");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"tipo_sezionale",false,null,"onChange=\"submitForm('doOnTipoSezionaleChange')\"");%>
				</td>
<%}%>
			</tr>
			<br>
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"mese");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"mese",false,null,"onChange=\"submitForm('doOnMeseChange')\"");%>
				</td>
			</tr>
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"data_da");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"data_da",false,null,"");%>
				</td>
				<td>
					<% bp.getController().writeFormLabel(out,"data_a");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"data_a",false,null,"");%>
				</td>
			</tr>			
			<tr>
				<% bp.getController().writeFormField(out,"pageNumber");%>
			</tr>
		</table>
	</div>
    <div class="GroupLabel text-primary h3">Stampe gi?? eseguite</div>
	<div class="Group card" style="width:100%">
		<% bp.getRegistri_stampati().writeHTMLTable(pageContext,"default",false,false,false,"100%","200px"); %>
	</div>

<%	bp.closeFormWindow(pageContext); %>
</body>
</html>