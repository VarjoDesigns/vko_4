<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
<title>Listaa asiakkaat</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>

<body>
<h3 class="welcome container">Asiakaslista</h3>
<form class="container">
	<div class="form-group">
	<label>Hakusana:</label>
	<input type="text" id="hakusana" class="form-control col-4">
	</div>
	<input type="button" id="hae" value="Hae" class="btn btn-outline-primary" style="margin-bottom: 20px;" onclick="haeTiedot()">
	<a href="lisaaAsiakas.jsp" id="uusiAsiakas" class="btn btn-outline-success" style="margin-bottom: 20px;">Uusi asiakas</a>
	<table id="listaus" class="container table table-striped">
		<thead>
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sähköposti</th>
				<th></th>
				<th></th>
			</tr>		
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
</form>
<script>
haeTiedot();
document.getElementById("hakusana").focus(); // Kursori valmiina hakemaan sivua avatessa

function enterLahettaa(event){ // Mahdollistaa Enter-näppäimellä hakemisen
	if(event.keyCode==13){
		haeTiedot();
	}
}

function haeTiedot() {  
	document.getElementById("tbody").innerHTML = "";
	fetch("asiakkaat/" + document.getElementById("hakusana").value, {
		method: 'GET'
	})
		.then(function (response) {
			return response.json();
		})
		.then(function (responseJson) {
			var asiakkaat = responseJson.asiakkaat;
			var htmlStr = "";
			
			for (var i = 0; i < asiakkaat.length; i++) {
				htmlStr+="<tr>";
				htmlStr+="<td>" + asiakkaat[i].etunimi + "</td>";
				htmlStr+="<td>" + asiakkaat[i].sukunimi + "</td>";
				htmlStr+="<td>" + asiakkaat[i].puhelin + "</td>";
				htmlStr+="<td>" + asiakkaat[i].sahkoposti + "</td>";
				htmlStr+="<td><a class='btn btn-outline-primary' href='muutaasiakas.jsp?asiakas_id="+ asiakkaat[i].asiakas_id +"'>Muuta</a></td>"; 
	        	htmlStr+="<td><button class='btn btn-outline-danger' onclick=poista(" + asiakkaat[i].asiakas_id + ") >Poista</button></td>";
	        	htmlStr+="</tr>";
			}
			document.getElementById("tbody").innerHTML = htmlStr;
		}) 
}

function poista(asiakas_id) {
	if(confirm("Poista asiakas " + asiakas_id + "?")){
		fetch("asiakkaat/" + asiakas_id, { 
			method: 'DELETE'
		})
		.then(function (response) {
			return response.json()
		})
		.then(function (responseJson) {
			var vastaus = responseJson.response;
			if(vastaus==0) {
				document.getElementById("ilmo").innerHTML = "Asiakkaan poisto epäonnistui.";
			} else if (vastaus==1) {
				document.getElementById("ilmo").innerHTML = "Asiakkaan " + sahkoposti + "poisto onnistui.";
				haeTiedot();
			}
			setTimeout(function() { document.getElementById("ilmo").innerHTML=""; } , 5000);
		})
	}
}

/* Ohessa Jquery metodi saman asian tekemiseen. Huom, avaa Jquery import dokun alusta

$(document).ready(function(){	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ //Enteriä painettu, ajetaan haku
			  haeTiedot();
		  }
	});	
	$("#hae").click(function(){	
		haeTiedot();
	});
	
	$("#uusiAsiakas").click(function(){	
		document.location="lisaaAsiakas.jsp";
	});
	
	$("#hakusana").focus();//viedään kursori hakusana-kenttään sivun latauksen yhteydessä
	haeTiedot();
});
function haeTiedot(){	
	$("#listaus tbody").empty();
	$.getJSON({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){	
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>"; 
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sahkoposti+"</td>";
        	htmlStr+="<td><a class='btn btn-outline-primary' href='muutaasiakas.jsp?asiakas_id="+ field.asiakas_id +"'>Muuta</a></td>"; 
        	htmlStr+="<td><button class='btn btn-outline-danger' onclick=poista(" + field.asiakas_id + ") >Poista</button></td>"; 
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});	
}

function poista(asiakas_id){
	if(confirm("Haluatko varmasti poistaa asiakkaan " + asiakas_id + "?")){
	console.log(asiakas_id);
		$.ajax({url:"asiakkaat/" + asiakas_id, type:"DELETE", dataType:"json", success:function(result) {
			if(result.response==0){
				$("#ilmo").html("Asiakkaan poistaminen epäonnistui.");
			} else if (result.response==1) {
				$("#rivi_" + asiakas_id);
				alert("Asiakkaan " + asiakas_id + "poistaminen onnistui.");
				haeTiedot();
			}
		}});
	}
}

*/
</script>
</body>
</html>