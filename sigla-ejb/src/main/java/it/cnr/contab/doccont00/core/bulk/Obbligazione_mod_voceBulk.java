/*
* Created by Generator 1.0
* Date 23/06/2006
*/
package it.cnr.contab.doccont00.core.bulk;

import it.cnr.contab.config00.latt.bulk.WorkpackageBulk;
import it.cnr.contab.config00.pdcfin.bulk.IVoceBilancioBulk;

public class Obbligazione_mod_voceBulk extends Obbligazione_mod_voceBase {

	private Obbligazione_modificaBulk obbligazione_modifica = new Obbligazione_modificaBulk();
	private IVoceBilancioBulk voce;
	private WorkpackageBulk linea_attivita = new WorkpackageBulk();
	
	public Obbligazione_mod_voceBulk() {
		super();
	}
	
	public Obbligazione_mod_voceBulk(java.lang.String cd_cds, java.lang.Integer esercizio, java.lang.Long pg_modifica, java.lang.String ti_appartenenza, java.lang.String ti_gestione, java.lang.String cd_voce, java.lang.String cd_centro_responsabilita, java.lang.String cd_linea_attivita) {
		super(cd_cds, esercizio, pg_modifica, ti_appartenenza, ti_gestione, cd_voce, cd_centro_responsabilita, cd_linea_attivita);
	}

	public Obbligazione_modificaBulk getObbligazione_modifica() {
		return obbligazione_modifica;
	}
	
	public void setObbligazione_modifica(Obbligazione_modificaBulk obbligazione_modifica) {
		this.obbligazione_modifica = obbligazione_modifica;
	}
	
	public IVoceBilancioBulk getVoce() {
		return voce;
	}

	public void setVoce(IVoceBilancioBulk voce) {
		this.voce = voce;
	}

	public WorkpackageBulk getLinea_attivita() {
		return linea_attivita;
	}
	
	public void setLinea_attivita(WorkpackageBulk linea_attivita) {
		this.linea_attivita = linea_attivita;
	}

	public java.lang.String getCd_cds() {
		Obbligazione_modificaBulk obbligazione_modifica = this.getObbligazione_modifica();
		if (obbligazione_modifica == null)
			return null;
		it.cnr.contab.config00.sto.bulk.CdsBulk cds = obbligazione_modifica.getCds();
		if (cds == null)
			return null;
		return cds.getCd_unita_organizzativa();
	}

	public void setCd_cds(String cd_cds) {
		getObbligazione_modifica().setCd_cds(cd_cds);
	}

	public java.lang.Integer getEsercizio() {
		Obbligazione_modificaBulk obbligazione_modifica = this.getObbligazione_modifica();
		if (obbligazione_modifica == null)
			return null;
		return obbligazione_modifica.getEsercizio();
	}

	public void setEsercizio(Integer esercizio) {
		getObbligazione_modifica().setEsercizio(esercizio);
	}

	public Long getPg_modifica() {
		Obbligazione_modificaBulk obbligazione_modifica = this.getObbligazione_modifica();
		if (obbligazione_modifica == null)
			return null;
		return obbligazione_modifica.getPg_modifica();
	}

	public void setPg_modifica(Long pg_modifica) {
		getObbligazione_modifica().setPg_modifica(pg_modifica);
	}

	public String getCd_centro_responsabilita() {
		WorkpackageBulk linea_attivita = this.getLinea_attivita();
		if (linea_attivita == null)
			return null;
		return linea_attivita.getCd_centro_responsabilita();
	}	

	public void setCd_centro_responsabilita(String cd_centro_responsabilita) {
		getLinea_attivita().setCd_centro_responsabilita(cd_centro_responsabilita);
	}	

	public String getCd_linea_attivita() {
		WorkpackageBulk linea_attivita = this.getLinea_attivita();
		if (linea_attivita == null)
			return null;
		return linea_attivita.getCd_linea_attivita();
	}
	
	public void setCd_linea_attivita(String cd_linea_attivita) {
		getLinea_attivita().setCd_linea_attivita(cd_linea_attivita);
	}
}