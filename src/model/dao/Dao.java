package model.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Asiakas;

public class Dao {
	private Connection con=null;
	private ResultSet rs = null;
	private PreparedStatement stmtPrep=null; 
	private String sql;
	private String db ="Myynti.sqlite";
	
	private Connection yhdista(){
    	Connection con = null;    	
    	String path = System.getProperty("catalina.base");    	
    	path = path.substring(0, path.indexOf(".metadata")).replace("\\", "/");
    	String url = "jdbc:sqlite:"+path+db;    	
    	try {	       
    		Class.forName("org.sqlite.JDBC");
	        con = DriverManager.getConnection(url);	
	        System.out.println("Yhteys kantaan avattu");
	     }catch (Exception e){	
	    	 System.out.println("Kantayhteyden avaus epäonnistui");
	        e.printStackTrace();	         
	     }
	     return con;
	}
	
	public ArrayList<Asiakas> listaaKaikki(){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat"; 		
		try {
			con=yhdista();
			if(con!=null){ //jos yhteys onnistui
				stmtPrep = con.prepareStatement(sql);        		
        		rs = stmtPrep.executeQuery();   
				if(rs!=null){ //jos kysely onnistui									
					while(rs.next()){
						Asiakas asiakas = new Asiakas();
						asiakas.setAsiakas_id(rs.getInt(1));
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));
						asiakas.setSahkoposti(rs.getString(5));
						asiakkaat.add(asiakas);
						}					
				}				
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return asiakkaat;
	}
	
	public ArrayList<Asiakas> listaaKaikki(String hakusana){
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "SELECT * FROM asiakkaat WHERE asiakas_id LIKE ? or etunimi LIKE ? or sukunimi LIKE ? or sposti LIKE ? or puhelin LIKE ?";		
		try {
			con=yhdista();
			if(con!=null){ //jos yhteys onnistui
				stmtPrep = con.prepareStatement(sql);  
				stmtPrep.setString(1, "%" + hakusana + "%");
				stmtPrep.setString(2, "%" + hakusana + "%");   
				stmtPrep.setString(3, "%" + hakusana + "%");
				stmtPrep.setString(4, "%" + hakusana + "%");
				stmtPrep.setString(5, "%" + hakusana + "%"); 
        		rs = stmtPrep.executeQuery();   
				if(rs!=null){ //jos kysely onnistui							
					while(rs.next()){
						Asiakas asiakas = new Asiakas();
						asiakas.setAsiakas_id(rs.getInt(1));
						asiakas.setEtunimi(rs.getString(2));
						asiakas.setSukunimi(rs.getString(3));
						asiakas.setPuhelin(rs.getString(4));
						asiakas.setSahkoposti(rs.getString(5));
						asiakkaat.add(asiakas);
					}						
				}
				con.close();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return asiakkaat;
	}

	public boolean lisaaAsiakas(Asiakas asiakas){
		boolean returnvalue=true;
		ArrayList<Asiakas> asiakkaat = new ArrayList<Asiakas>();
		sql = "INSERT INTO asiakkaat VALUES(?,?,?,?,?)";       
		try {
			con=yhdista();
				stmtPrep = con.prepareStatement(sql);        		
        		stmtPrep.setString(1, null);
        		stmtPrep.setString(2, asiakas.getEtunimi());
        		stmtPrep.setString(3, asiakas.getSukunimi());
        		stmtPrep.setString(4, asiakas.getPuhelin());
        		stmtPrep.setString(5, asiakas.getSahkoposti());
        		stmtPrep.executeUpdate();
    		con.close();				
		} catch (Exception e) {
			e.printStackTrace();
			returnvalue = false;
		}		
		return returnvalue;
	}
	
	public boolean muutaAsiakas(Asiakas asiakas, String asiakas_id) {
		boolean paluuarvo = true;
		System.out.println("MuutaAsiakas()");
		sql="UPDATE asiakkaat SET etunimi=?, sukunimi=?, puhelin=?, sposti=? WHERE asiakas_id=?";
		
		try {
			con = yhdista();
				stmtPrep = con.prepareStatement(sql);
	    		stmtPrep.setString(1, asiakas.getEtunimi());
	    		stmtPrep.setString(2, asiakas.getSukunimi());
	    		stmtPrep.setString(3, asiakas.getPuhelin());
	    		stmtPrep.setString(4, asiakas.getSahkoposti());
	    		stmtPrep.setString(5, asiakas_id);
	    		stmtPrep.executeUpdate();
		con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			paluuarvo = false;
		}
		return paluuarvo;
	}
	
	public boolean poistaAsiakas(String asiakas_id) {
		boolean paluuArvo=true;
		sql="DELETE FROM asiakkaat WHERE asiakas_id=?";
		try {
			con = yhdista();
			stmtPrep=con.prepareStatement(sql);
			stmtPrep.setString(1,  asiakas_id);
			stmtPrep.executeUpdate();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluuArvo = false;
		}
		return paluuArvo;
	}
	
	public Asiakas etsiAsiakas(String asiakas_id) {
		Asiakas asiakas = null;
		sql = "SELECT * FROM asiakkaat WHERE asiakas_id=?";
		
		try {
			con = yhdista();
			if (con!=null) {
				stmtPrep = con.prepareStatement(sql);
				stmtPrep.setString(1, asiakas_id);
				rs = stmtPrep.executeQuery();
				
				if (rs.isBeforeFirst()) {
					rs.next();
					asiakas = new Asiakas();
					asiakas.setAsiakas_id(rs.getInt(1));
					asiakas.setEtunimi(rs.getString(2));
					asiakas.setSukunimi(rs.getString(3));
					asiakas.setPuhelin(rs.getString(4));
					asiakas.setSahkoposti(rs.getString(5));
				}
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return asiakas;
	}
	
	public boolean poistaKaikkiAsiakkaat (String pwd) {
		boolean paluuarvo = true;
		if (pwd!="nimda") {
			return false;
		}
		sql="DELETE FROM autot";
		
		try {
			con = yhdista();
				stmtPrep=con.prepareStatement(sql);
				stmtPrep.executeQuery();
				con.close();
		} catch (Exception e) {
			e.printStackTrace();
			paluuarvo = false;
		}
		return paluuarvo;
	}
}

