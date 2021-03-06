package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import model.Asiakas;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public Asiakkaat() {
        super();
        System.out.println("Asiakkaat.Asiakkaat()");
    }

	// GET   /asiakkaat/{hakusana} 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doGet()");
		
		String pathInfo = request.getPathInfo();	
		System.out.println("polku: "+pathInfo);	
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		String strJSON = "";
		if(pathInfo == null) {
			asiakkaat = dao.listaaKaikki();
			System.out.println("PathInfo oli tyhj�, haetaan kaikki: " + asiakkaat);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		} else if (pathInfo.indexOf("haeyksi") !=-1) { // Jos polku sis�lt�� merkkijonon "haeyksi", suoritetaan t�m�
			String asiakas_id = pathInfo.replace("/haeyksi/", "");
			Asiakas asiakas = dao.etsiAsiakas(asiakas_id);
			
			if (asiakas == null) {
				strJSON = "{}";
			} else {
				JSONObject JSON = new JSONObject();
				JSON.put("asiakas_id", asiakas.getAsiakas_id());
				JSON.put("etunimi", asiakas.getEtunimi());
				JSON.put("sukunimi", asiakas.getSukunimi());
				JSON.put("puhelin", asiakas.getPuhelin());
				JSON.put("sahkoposti", asiakas.getSahkoposti());
				strJSON = JSON.toString();
			}
		} else {
			String hakusana = pathInfo.replace("/", "");
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		}
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPost()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSahkoposti(jsonObj.getString("sahkoposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.lisaaAsiakas(asiakas)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}	
	}
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");	
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		String asiakas_id = jsonObj.getString("asiakas_id");
		Asiakas asiakas = new Asiakas();
		
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSahkoposti(jsonObj.getString("sahkoposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.muutaAsiakas(asiakas, asiakas_id)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}	
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doDelete()");
		String pathInfo = request.getPathInfo();	
		System.out.println("polku: "+pathInfo);	
		String poistettavaAsiakas="";
		if(pathInfo!=null) {		
			poistettavaAsiakas = pathInfo.replace("/", "");
		}
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		if(dao.poistaAsiakas(poistettavaAsiakas)) {
			out.println("{\"response\":1}");
		} else {
			out.println("{\"response\":0}");
		}	
	}
}
