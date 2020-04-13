package model;

public class Asiakas {
	private String etunimi, sukunimi,  puhelin, sposti, sahkoposti;

	
	public Asiakas() {
		super();
	}


	public Asiakas(String etunimi, String sukunimi, String puhelin, String sposti, String sahkoposti) {
		super();
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.sposti = sposti;
		this.sahkoposti = sahkoposti;
	}


	public String getEtunimi() {
		return etunimi;
	}


	public String getSukunimi() {
		return sukunimi;
	}


	public String getPuhelin() {
		return puhelin;
	}


	public String getSposti() {
		return sposti;
	}


	public String getSahkoposti() {
		return sahkoposti;
	}


	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}


	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}


	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}


	public void setSposti(String sposti) {
		this.sposti = sposti;
	}


	public void setSahkoposti(String sahkoposti) {
		this.sahkoposti = sahkoposti;
	}


	@Override
	public String toString() {
		return "Asiakkaat [etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin=" + puhelin + ", sposti="
				+ sposti + ", sahkoposti=" + sahkoposti + "]";
	}
	
}