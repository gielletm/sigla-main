/*
 * Created by BulkGenerator 2.0 [07/12/2009]
 * Date 03/06/2021
 */
package it.cnr.contab.incarichi00.bulk;

public class ScadenzarioDottoratiRataBulk extends ScadenzarioDottoratiRataBase {
	/**
	 * [SCADENZARIO_DOTTORATI ]
	 **/
	private ScadenzarioDottoratiBulk scadenzarioDottorati =  new ScadenzarioDottoratiBulk();
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Table name: SCADENZARIO_DOTTORATI_RATA
	 **/
	public ScadenzarioDottoratiRataBulk() {
		super();
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Table name: SCADENZARIO_DOTTORATI_RATA
	 **/
	public ScadenzarioDottoratiRataBulk(Long id) {
		super(id);
	}
	public ScadenzarioDottoratiBulk getScadenzarioDottorati() {
		return scadenzarioDottorati;
	}
	public void setScadenzarioDottorati(ScadenzarioDottoratiBulk scadenzarioDottorati)  {
		this.scadenzarioDottorati=scadenzarioDottorati;
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Restituisce il valore di: [Identificativo scadenzario dottorati.]
	 **/
	public Long getIdScadenzarioDottorati() {
		ScadenzarioDottoratiBulk scadenzarioDottorati = this.getScadenzarioDottorati();
		if (scadenzarioDottorati == null)
			return null;
		return getScadenzarioDottorati().getId();
	}
	/**
	 * Created by BulkGenerator 2.0 [07/12/2009]
	 * Setta il valore di: [Identificativo scadenzario dottorati.]
	 **/
	public void setIdScadenzarioDottorati(Long idScadenzarioDottorati)  {
		this.getScadenzarioDottorati().setId(idScadenzarioDottorati);
	}
}