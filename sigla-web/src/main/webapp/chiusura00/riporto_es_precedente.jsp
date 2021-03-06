<!-- 
 ?ResourceName ""
 ?ResourceTimestamp ""
 ?ResourceEdition ""
-->

<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.util.jsp.*,
		it.cnr.jada.action.*,
		it.cnr.jada.bulk.*,
		it.cnr.jada.util.action.*,
		it.cnr.contab.chiusura00.bp.*,
		it.cnr.contab.chiusura00.bulk.*"		
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<script language="JavaScript" src="scripts/util.js"></script>
<% JSPUtils.printBaseUrl(pageContext);%>
</head>
<script language="javascript" src="scripts/css.js"></script>

<% RiportoEsPrecedenteBP bp = (RiportoEsPrecedenteBP)BusinessProcess.getBusinessProcess(request); %>
<% V_obb_acc_xxxBulk modello = (V_obb_acc_xxxBulk) bp.getModel(); %>

<title>Riporto ad esercizio precedente di documenti contabili</title>

<body class="Form">

<% bp.openFormWindow(pageContext); %>
	<br>
	<br>
	<br>
	<br>
	<div class="Group">		
	<table align="center" class="Panel">
	   <% if ( !modello.isEnteInScrivania() ) { %>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "fl_ente"); %></td>		
		   <td><% bp.getController().writeFormInput(out,"default","fl_ente",false,null,"onclick=\"submitForm('doDefault')\""); %></td>

		</tr>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "ti_gestione"); %></td>		
		   <td><% bp.getController().writeFormInput( out, "ti_gestione"); %></td>		
		</tr>
	   <% } else {} %>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "pg_doc_da"); %></td>		
		   <td><% bp.getController().writeFormInput( out, "pg_doc_da");
		          bp.getController().writeFormLabel( out, "pg_doc_a");
		          bp.getController().writeFormInput( out, "pg_doc_a");%></td>
		</tr>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "cd_elemento_voce"); %></td>		
		   <td><% bp.getController().writeFormInput( out, "cd_elemento_voce");
		          bp.getController().writeFormInput( out, "ds_elemento_voce");
		          bp.getController().writeFormInput( out, "find_elemento_voce");%></td>
		</tr>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "cd_voce"); %></td>		
		   <td><% bp.getController().writeFormInput( out, null, "cd_voce", modello.isROCd_voce(), null, null); %></td>
		</tr>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "cd_terzo"); %></td>		
		   <td><% bp.getController().writeFormInput( out, "cd_terzo");
		          bp.getController().writeFormInput( out, "ds_terzo");
		          bp.getController().writeFormInput( out, "find_terzo");%></td>
		</tr>
		<tr>
		   <td><% bp.getController().writeFormLabel( out, "im_acc_obb"); %></td>		
		   <td><% bp.getController().writeFormInput( out, "im_acc_obb"); %></td>		
		</tr>
	</table>
	</div>				
	<table align="center" class="Panel">	
		<tr>
			<td align="center">
				<% JSPUtils.button(out,bp.encodePath("img/find24.gif"),bp.encodePath("Ricerca"), "javascript:submitForm('doCercaDocDaRiportare')",null, bp.getParentRoot().isBootstrap()); %>
			</td>		
		</tr>
	</table>


<%bp.closeFormWindow(pageContext); %>
</body>
</html>