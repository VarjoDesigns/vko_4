package model;

public class Asiakas {
	private int asiakas_id;
	private String etunimi, sukunimi,  puhelin, sahkoposti;

	
	public Asiakas() {
		super();
	}


	public Asiakas(int asiakas_id, String etunimi, String sukunimi, String puhelin, String sahkoposti) {
		super();
		this.asiakas_id = asiakas_id;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.puhelin = puhelin;
		this.sahkoposti = sahkoposti;
	}

	public int getAsiakas_id() {
		return asiakas_id;
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


	public String getSahkoposti() {
		return sahkoposti;
	}


	public void setAsiakas_id(int asiakas_id) {
		this.asiakas_id = asiakas_id;
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


	public void setSahkoposti(String sahkoposti) {
		this.sahkoposti = sahkoposti;
	}


	@Override
	public String toString() {
		return "Asiakas [asiakas_id=" + asiakas_id + ", etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", puhelin="
				+ puhelin + ", sahkoposti=" + sahkoposti + "]";
	}
	
}