package test;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;

import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;

import model.Asiakas;
import model.dao.Dao;

@TestMethodOrder(OrderAnnotation.class)
class JUnit_testaa_asiakkaat {
	
	@Test
	@Order(1)
	public void testPoistaKaikkiAsiakkaat() {
		// Poistetaan kaikki asiakkaat
		Dao dao = new Dao();
		dao.poistaKaikkiAsiakkaat("");
		
		ArrayList<Asiakas> asiakkaat = dao.listaaKaikki();
		assertEquals(0, asiakkaat.size());
	}
	
	@Test
	@Order(2)
	public void testLisaaAsiakas() {
		Dao dao = new Dao();
		Asiakas asiakas_1 = new Asiakas("Matti", "Mallikas", "0501231231", "matti.mallikas@esimerkki.fi");
		Asiakas asiakas_2 = new Asiakas("Meiju", "Metkukas", "0501234567", "meiju.metkukas@esimerkki.fi");
		Asiakas asiakas_3 = new Asiakas("Liisa", "Esimerkki", "0501231222", "liisa.esimerkki@esimerkki.fi");
		Asiakas asiakas_4 = new Asiakas("Essi", "Esmes", "0501231331", "essi.esmes@example.fi");
		Asiakas asiakas_5 = new Asiakas("Kaapo", "Kamala", "0501231331", "kaapo.kamala@example.fi");
		assertEquals(true, dao.lisaaAsiakas(asiakas_1));
		assertEquals(true, dao.lisaaAsiakas(asiakas_2));
		assertEquals(true, dao.lisaaAsiakas(asiakas_3));
		assertEquals(true, dao.lisaaAsiakas(asiakas_4));
		assertEquals(true, dao.lisaaAsiakas(asiakas_5));
	}

}
