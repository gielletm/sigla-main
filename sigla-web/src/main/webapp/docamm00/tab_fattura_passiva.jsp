﻿<%@ page pageEncoding="UTF-8"
	import="it.cnr.jada.util.jsp.*,
		it.cnr.jada.action.*,
		java.util.*,
		it.cnr.jada.util.jsp.Button,
		it.cnr.jada.util.action.*,
		it.cnr.contab.docamm00.tabrif.bulk.*,
		it.cnr.contab.docamm00.docs.bulk.*,
		it.cnr.contab.docamm00.bp.*"
%>
<% CRUDFatturaPassivaBP bp = (CRUDFatturaPassivaBP)BusinessProcess.getBusinessProcess(request);
	Fattura_passivaBulk fatturaPassiva = (Fattura_passivaBulk)bp.getModel();
	boolean roOnAutoGen = false;
	if (bp instanceof IDocumentoAmministrativoBP)
		roOnAutoGen = ((IDocumentoAmministrativoBP)bp).isAutoGenerated();
	boolean roForSplit = fatturaPassiva!=null && !fatturaPassiva.isToBeCreated() && 
			             fatturaPassiva.getFl_split_payment()!=null && fatturaPassiva.getFl_split_payment();
%>
   <div class="Group card">
	<table>
	  <% if (fatturaPassiva.isCongelata() && !bp.isSearching()) { %>	
	      <tr>
			<span class="FormLabel" style="color:red">
				Il documento è stato CONGELATO!
			</span>
	      </tr>
	  <% } %>
	  <% if (fatturaPassiva.isRiportataInScrivania() && !bp.isSearching()) { %>	
	      <tr>
			<span class="FormLabel" style="color:red">
				<%=fatturaPassiva.getRiportataKeys().get(fatturaPassiva.getRiportataInScrivania()) %>
			</span>
	      </tr>
	  <% } %>
	  <tr>      	
      	<% bp.getController().writeFormField(out,"pg_fattura_passiva");%>      
      	<% bp.getController().writeFormField(out,"esercizio");%>
      </tr>
      <tr>
		<td>
			<% bp.getController().writeFormLabel(out,"dt_registrazione");%>			  
		</td>
		<td>
			<% bp.getController().writeFormInput(out,null,"dt_registrazione",false,null,"");%>
			<% bp.getController().writeFormField(out,"progr_univoco"); %>
		</td>
	</tr>      
    <tr>  
			<% bp.getController().writeFormField(out,"data_protocollo"); %>
       		<% bp.getController().writeFormField(out,"numero_protocollo"); %>
      </tr>  
        <tr>  
			<% bp.getController().writeFormField(out,"identificativoSdi"); %>
       		<% bp.getController().writeFormField(out,"progressivo"); %>
      </tr>     
      <tr>      	
      	<% bp.getController().writeFormField(out,"protocollo_iva");%>
       	<% bp.getController().writeFormField(out,"protocollo_iva_generale");%>
      </tr>
	<%	boolean isInSpesaMode = (bp instanceof CRUDFatturaPassivaIBP && ((CRUDFatturaPassivaIBP)bp).isSpesaBP()) ? true : false;
		if (bp.isSearching()) { %>
	      <tr>      	
	     	<td>
	      		<% bp.getController().writeFormLabel(out,"stato_cofiForSearch");%>
	      	</td>      	
	     	<td>
	      		<% bp.getController().writeFormInput(out,null,"stato_cofiForSearch",roOnAutoGen || isInSpesaMode,null,""); %>
	      	</td>
	     	<td>
	      		<% bp.getController().writeFormLabel(out,"ti_associato_manrevForSearch");%>
	      	</td>      	
	     	<td>
	      		<%  bp.getController().writeFormInput(out,null,"ti_associato_manrevForSearch", roOnAutoGen,null,""); %>
	      	</td>
	      </tr>
	      <tr>
	     	<td>
      			<% bp.getController().writeFormLabel(out,"fl_liquidazione_differita");%>
      			<% bp.getController().writeFormInput(out,null,"fl_liquidazione_differita",roOnAutoGen,null,"");%>
      		</td>
      		<td>
      			<% bp.getController().writeFormLabel(out,"stato_liquidazione");%>
      			<% bp.getController().writeFormInput(out,null,"stato_liquidazione", isInSpesaMode,null,"onChange=\"submitForm('doOnStatoLiquidazioneChange')\"");%>
      		</td>
      		<td> 
      			<% bp.getController().writeFormLabel(out,"causale");%>
      			<% bp.getController().writeFormInput(out,null,"causale",isInSpesaMode,null,"onChange=\"submitForm('doOnCausaleChange')\"");%>
      		</td>
      	  </tr>	
	      <%	if (bp instanceof CRUDFatturaPassivaIBP) { %>
				      <tr>      	
				     	<td>
				      		<% bp.getController().writeFormLabel(out,"stato_pagamento_fondo_ecoForSearch");%>
				      	</td>      	
				     	<td>
				      		<%  bp.getController().writeFormInput(out,null,"stato_pagamento_fondo_ecoForSearch",roOnAutoGen|| isInSpesaMode,null,""); %>
				      	</td>
				      </tr>
	      <% } %>
	<%} else { %>
	      <tr>      	 
	      	<% bp.getController().writeFormField(out,"stato_cofi"); %>
	      	<% bp.getController().writeFormField(out,"ti_associato_manrev"); %>
	      </tr>
	      <tr>  
	      	<% bp.getController().writeFormField(out,"fl_fattura_compenso"); %>
	      	<td  colspan="2">
      			<% bp.getController().writeFormLabel(out,"fl_liquidazione_differita");%>
      			<% bp.getController().writeFormInput(out,null,"fl_liquidazione_differita",roOnAutoGen,null,"onClick=\"submitForm('doOnLiquidazioneDifferitaChange')\"");%>
      		</td>
	      </tr>
	      <tr>      	
	     	<td>
	      		<% bp.getController().writeFormLabel(out,"stato_pagamento_fondo_eco");%>
	      	</td>      	
	     	<td>
	      		<% bp.getController().writeFormInput(out,null,"stato_pagamento_fondo_eco",roOnAutoGen,null,"onChange=\"submitForm('doOnStatoFondoEconChange')\"");%>
	      	</td>
	      	<% if (bp instanceof CRUDFatturaPassivaIBP && ((Fattura_passiva_IBulk)bp.getModel()).isByFondoEconomale()) {
		      		bp.getController().writeFormField(out,"dt_pagamento_fondo_eco");
		    } %>
	      </tr>
	      <tr>
            <td>
                <% bp.getController().writeFormLabel(out,"stato_liquidazione");%>
            </td>
            <td>
                <% bp.getController().writeFormInput(out,null,"stato_liquidazione",false,null,"onChange=\"submitForm('doOnStatoLiquidazioneChange')\"");%>
            </td>
            <td>
                <% bp.getController().writeFormLabel(out,"causale");%>
             </td>
             <td>
                <% bp.getController().writeFormInput(out,null,"causale",false,null,"onChange=\"submitForm('doOnCausaleChange')\"");%>
            </td>
	      </tr>
	<% } %>
    </table>
   </div>

    <div class="Group card">
  	<table>
		<tr>
			<% if (!bp.isSearching()) { %>
		     	<td>
		      		<% bp.getController().writeFormLabel(out,"ti_istituz_commerc");%>
		      	</td>      	
		     	<td colspan="10">
		      		<% bp.getController().writeFormInput(out,null,"ti_istituz_commerc",roOnAutoGen||roForSplit,null,"onChange=\"submitForm('doOnIstituzionaleCommercialeChange')\"");%>
		      	</td>
			<% } else { %>
		     	<td>
		      		<% bp.getController().writeFormLabel(out,"ti_istituz_commercSearch");%>
		      	</td>      	
		     	<td colspan="10">
		      		<% bp.getController().writeFormInput(out,null,"ti_istituz_commercSearch",roOnAutoGen||roForSplit,null,"onChange=\"submitForm('doOnIstituzionaleCommercialeChange')\"");%>
		      	</td>
			<% } %>
      </tr>

	  <% if (bp.isSearching()) { %>
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
					   		<% bp.getController().writeFormField(out,"fl_spedizioniere");%>
					      </tr>
					      <tr>     	
					   		<% bp.getController().writeFormField(out,"fl_bolla_doganale");%>
					      </tr>
		      		</table>
		      	</td>
	      </tr>
		<% } else { %>
	      <tr>     	
	     	<td>
	      		<% bp.getController().writeFormLabel(out,"fl_intra_ue");%>
	      	</td>      	
	     	<td>
	      		<% bp.getController().writeFormInput(out,null,"fl_intra_ue",roOnAutoGen,null,"");%>
	      	</td>      	
	     	<td width="100">&nbsp;</td>
	     	<td>
	      		<% bp.getController().writeFormLabel(out,"fl_extra_ue");%>
	      	</td>      	
	     	<td>
	      		<% bp.getController().writeFormInput(out,null,"fl_extra_ue",roOnAutoGen,null,"");%>
	      	</td>      	
	     	<td width="100">&nbsp;</td>
	     	<td>
	     	<% bp.getController().writeFormLabel(out,"fl_spedizioniere");%>
	     	</td>      	
	     	<td>
	   		<% bp.getController().writeFormInput(out,null,"fl_spedizioniere",fatturaPassiva.getFl_merce_intra_ue(),null,"");%>
	   		</td>
			<td width="100">&nbsp;</td>
	      	<td>
	      		<% bp.getController().writeFormLabel(out,"fl_split_payment");%>
	      	</td>      	
	     	<td>
	     		<% bp.getController().writeFormInput(out,"fl_split_payment");%>
	     	</td>
	      </tr>
	      <tr>     	
	      	<td>
	      		<% bp.getController().writeFormLabel(out,"fl_san_marino_con_iva");%>
	      	</td>      	
	     	<td>
	     		<% bp.getController().writeFormInput(out,null,"fl_san_marino_con_iva",roOnAutoGen,null,"");%>
	     	</td>
	     	<td width="100">&nbsp;</td>
	      	<td>
	      		<% bp.getController().writeFormLabel(out,"fl_san_marino_senza_iva");%>
	      	</td>      	
	     	<td>
	     		<% bp.getController().writeFormInput(out,null,"fl_san_marino_senza_iva",roOnAutoGen,null,"");%>
	     	</td>
     		<td width="100">&nbsp;</td>
	     	<td>
		     	<% bp.getController().writeFormLabel(out,"fl_bolla_doganale");%>
	     	</td>      	
	     	<td>
	   			<% bp.getController().writeFormInput(out,null,"fl_bolla_doganale",fatturaPassiva.getFl_merce_intra_ue(),null,"");%>
			</td>
			<% if (bp.isAttivoOrdini()) { %>
			    <td width="100">&nbsp;</td>
                <td>
                    <% bp.getController().writeFormLabel(out,"flDaOrdini");%>
                </td>
                <td>
                    <% bp.getController().writeFormInput(out,"flDaOrdini");%>
                </td>
            <% } %>
	      </tr>
	     <% } %>
      <tr>     	
      	<td>
      		<% bp.getController().writeFormLabel(out,"fl_autofattura");%>
      	</td>      	
     	<td>
     		<% bp.getController().writeFormInput(out,null,"fl_autofattura",roOnAutoGen,null,"");%>
     	</td>
    	<% 
    			if((fatturaPassiva.isCommerciale() && fatturaPassiva.getTi_bene_servizio() != null && 
    					Bene_servizioBulk.BENE.equalsIgnoreCase(fatturaPassiva.getTi_bene_servizio()) && fatturaPassiva.getFl_intra_ue() )) { %>
		<td width="10">&nbsp;</td>
		<td>		
      		<% bp.getController().writeFormLabel(out,"fl_merce_extra_ue");%>
      	</td>      	
     	<td>
     		<% bp.getController().writeFormInput(out,null,"fl_merce_extra_ue",roOnAutoGen,null,"");%>
     	</td>	
     	 <% } %>
     	 <% 
    			if((fatturaPassiva.getTi_bene_servizio() != null && 
    					Bene_servizioBulk.BENE.equalsIgnoreCase(fatturaPassiva.getTi_bene_servizio()) && fatturaPassiva.getFl_extra_ue() )) { %>
		<td width="10">&nbsp;</td>
		<td>		
      		<% bp.getController().writeFormLabel(out,"fl_merce_intra_ue");%>
      	</td>      	
     	<td>
     		<% bp.getController().writeFormInput(out,null,"fl_merce_intra_ue",roOnAutoGen,null,"");%>
     	</td>	
     	 <% } %>
      </tr>
      
	<% if (fatturaPassiva instanceof Fattura_passiva_IBulk &&
			(fatturaPassiva.isBollaDoganale() || fatturaPassiva.isSpedizioniere())) { %>
		<tr>    
			<td>
				<% bp.getController().writeFormLabel(out,"pg_fattura_estera");%>
			</td>
			<td colspan="10">
				<% bp.getController().writeFormInput(out, null, "pg_fattura_estera", roOnAutoGen, null, "");%>
				<% bp.getController().writeFormInput(out, null, "fatturaEstera", roOnAutoGen, null, "");%>
				<% Button.write(
						out,
						bp.getParentRoot().isBootstrap() ? "fa fa-folder-open faa-passing" : "img/open16.gif",
						bp.getParentRoot().isBootstrap() ? "fa fa-folder-open" : "img/open16.gif",
						null,
						"submitForm('doApriFatturaEstera()')",
						"btn animated-hover",
						"Apri fattura estera",
						bp.isEditing() && (!bp.isDeleting() || !bp.isModelVoided()), bp.getParentRoot().isBootstrap()); %>
			</td>
		</tr>
	<% } %>
	  <% if ((fatturaPassiva.getFl_extra_ue() != null && fatturaPassiva.getFl_extra_ue().booleanValue()) ||
		  		(fatturaPassiva.getFl_intra_ue() != null && fatturaPassiva.getFl_intra_ue().booleanValue()) ||
		  		(fatturaPassiva.getFl_san_marino_senza_iva() != null && fatturaPassiva.getFl_san_marino_senza_iva().booleanValue())
		  	) { 
		  	if (bp.isSearching()) { %>
		      <tr>     	
		      	<td>
		      		<% bp.getController().writeFormLabel(out,"ti_bene_servizioForSearch");%>
		      	</td>      	
		     	<td colspan="10">
		     		<% bp.getController().writeFormInput(out,null,"ti_bene_servizioForSearch",roOnAutoGen,null,"onChange=\"submitForm('doOnTiBeneServizioChange')\"");%>
		     	</td>
		      </tr>
		    <% } else { %>
		      <tr>     	
		      	<td>
		      		<% bp.getController().writeFormLabel(out,"ti_bene_servizio");%>
		      	</td>      	
		     	<td colspan="10">
		     		<% bp.getController().writeFormInput(out,null,"ti_bene_servizio",roOnAutoGen,null,"onChange=\"submitForm('doOnTiBeneServizioChange')\"");%>
		     	</td>
		      </tr>
	  <% 	}
	  	  } %>
      
      <tr>
      	<td>
      		<% bp.getController().writeFormLabel(out,"sezionale");%>
      	</td>      	
     	<td colspan="10">
     		<% bp.getController().writeFormInput(out,null,"sezionale",roOnAutoGen,null,"");%>
     	</td>
      </tr>
     </table>
    </div>

     <div class="Group card">
     <table>
      <tr>      	
      	<% bp.getController().writeFormField(out,"nr_fattura_fornitore");%>     	
      </tr>
      <tr>      	
			<td>
				<% bp.getController().writeFormLabel(out,"ds_fattura_passiva");%>
			</td>      	
			<td colspan="4">
				<% bp.getController().writeFormInput(out,"ds_fattura_passiva");%>
			</td>
      </tr>      	
      <tr>      	
			<td>
				<% bp.getController().writeFormLabel(out,"dt_fattura_fornitore");%>			  
			</td>
			<td>
				<% bp.getController().writeFormInput(out,null,"dt_fattura_fornitore",false,null,"");%>
			</td>
			<td/>
			<td>
				<% bp.getController().writeFormLabel(out,"dt_scadenza");%>			  
			</td>
			<td>
				<% bp.getController().writeFormInput(out,null,"dt_scadenza",false,null,"");%>
			</td>
      </tr>
      <tr>
			<% bp.getController().writeFormField(out,"esercizio_fattura_fornitore");%>
      </tr>      	
      <tr>      	
			<td>
				<% bp.getController().writeFormLabel(out,"dt_da_competenza_coge");%>			  
			</td>
			<td>
				<% bp.getController().writeFormInput(out,null,"dt_da_competenza_coge",false,null,"");%>
			</td>
			<td/>
			<td>
				<% bp.getController().writeFormLabel(out,"dt_a_competenza_coge");%>			  
			</td>
			<td>
				<% bp.getController().writeFormInput(out,null,"dt_a_competenza_coge",false,null,"");%>
			</td>
      </tr>
      <tr>
			<td colspan="6">
				<br>
			</td>
      </tr>      	
      <tr>
			<td>
				<% bp.getController().writeFormLabel(out,"im_totale_fattura");%>
			</td>      	
			<td>
				<% bp.getController().writeFormInput(out,null,"im_totale_fattura",false,null,"");%>
			</td>
			<td/>
			<% bp.getController().writeFormField(out,"im_importo_totale_fattura_fornitore_euro");%>			  
      </tr>      
    </table>
   </div>
    <div class="Group card">
    <table>
       <tr>
			<td>
				<% bp.getController().writeFormLabel(out,"valuta");%>
			</td>
			<% if (bp.isSearching()) { %>
				<td>
					<% bp.getController().writeFormInput(out,null,"valutaForSearch",roOnAutoGen,null,"onChange=\"submitForm('doSelezionaValuta')\"");%>
				</td>
			<% } else { %>
				<td>
					<% bp.getController().writeFormInput(out,null,"valuta",roOnAutoGen,null,"onChange=\"submitForm('doSelezionaValuta')\"");%>
				</td>
				<td>
					<% bp.getController().writeFormLabel(out,"cambio");%>
				</td>
				<td>
					<% bp.getController().writeFormInput(out,null,"cambio",roOnAutoGen,null,"");%>
				</td>
			<% } %>
      </tr>
    </table>
    </div>