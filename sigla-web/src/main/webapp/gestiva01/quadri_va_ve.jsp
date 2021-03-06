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
<title>Tabella riepilogativa quadri VA - VE</title>
</head>
<body class="Form">

<% QuadriVaVeBP bp = (QuadriVaVeBP)BusinessProcess.getBusinessProcess(request);
	 bp.openFormWindow(pageContext); %>

	<div class="Group" style="width:100%">
		<table width="100%">
			<tr>
				<td>
					<div class="Group" style="width:100%">
						<div class="GroupLabel">Elenco</div>
						<% bp.getElenco().writeHTMLTable(pageContext,"elenco_va_ve",false,false,false,"100%","200px"); %>
					</div>
				</td>
			</tr>			
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"importo"); %>
					<% bp.getController().writeFormInput(out,null,"importo",false,null,""); %>
				</td>
			</tr>
			<tr>
				<td>
					<div class="Group" style="width:100%">
						<div class="GroupLabel">Elenco secondario</div>
						<% bp.getElencoSecondario().writeHTMLTable(pageContext,"elenco_sec_va_ve",false,false,false,"100%","200px"); %>
					</div>
				</td>
			</tr>			
			<tr>
				<td>
					<% bp.getController().writeFormLabel(out,"pageNumber"); %>
					<% bp.getController().writeFormInput(out,null,"pageNumber",false,null,""); %>
				</td>
			</tr>
		</table>
	</div>

<%	bp.closeFormWindow(pageContext); %>
</body>
</html>