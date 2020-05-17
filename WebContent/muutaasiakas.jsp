<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
-->
<script src="scripts/main.js"></script>
<title>Muuta asiakas</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body>
<h3 class="welcome container">Asiakkaan muuttaminen</h3>

<form id="tiedot" class="container">
	<div class="form-group">
		<label for="etunimi">Etunimi:</label>
		<input type="text" id="etunimi" name="etunimi" class="form-control">
	</div>
	
	<div class="form-group">
		<label for="sukunimi">Sukunimi:</label>
		<input type="text" id="sukunimi" name="sukunimi" class="form-control">
	</div>
	
	<div class="form-group">
		<label for="puhelin">Puhelinnumero:</label>
		<input type="text" id="puhelin" name="puhelin" class="form-control">
	</div>
	
	<div class="form-group">
		<label for="sahkoposti">Sähköposti:</label>
		<input type="text" id="sahkoposti" name="sahkoposti" class="form-control">
	</div>
	
	<div class="form-group">
		<input type="hidden" id="asiakas_id" name="asiakas_id">
		<input type="button" id="tallenna" value="Päivitä tiedot" onclick="lisaaTiedot()" class="btn btn-outline-primary">
		<a href="listaaAsiakkaat.jsp" type="button" id="peruuta" class="btn btn-outline-danger">Peruuta</a>
	</div>
</form>
 
<span id="ilmo"></span>

<script>

function enterLahettaa(event){ // Mahdollistaa Enter-näppäimellä hakemisen
	if(event.keyCode==13){
		haeTiedot();
	}
}

var asiakas_id = requestURLParam("asiakas_id");

function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

fetch("asiakkaat/haeyksi/" + asiakas_id, {
	method: 'GET'
	})
	.then(function (response) {
		return response.json()
	})
	.then(function (responseJson) {
		console.log(responseJson);
		document.getElementById("etunimi").value = responseJson.etunimi;
		document.getElementById("sukunimi").value = responseJson.sukunimi;
		document.getElementById("puhelin").value = responseJson.puhelin;
		document.getElementById("sahkoposti").value = responseJson.sahkoposti;
		document.getElementById("asiakas_id").value = responseJson.asiakas_id;
	})
	
function lisaaTiedot() {
	console.log("haeTiedot()");
	var ilmo = "";
	if(document.getElementById("etunimi").value.length<3){
		ilmo = "Virheellinen etunimi!";
	}
	if(document.getElementById("sukunimi").value.length<3){
		ilmo = "Virheellinen sukunimi!";
	}
	if(document.getElementById("puhelin").value.length<3){
		ilmo = "Virheellinen puhelinnumero!";
	}
	if(document.getElementById("sahkoposti").value.length<3){
		ilmo = "Virheellinen sahkoposti!";
	}
	
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML = ilmo;
		setTimeout(function(){document.getElementById("ilmo").innerHTML; }, 3000);
		return;
	}

	var formJsonStr=formDataJsonStr(document.getElementById("tiedot")); 
	
	fetch("asiakkaat",{//Lähetetään kutsu backendiin
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi		
		return response.json()
	})
	.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametrissä	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen epäonnistui";
    	}else if(vastaus==1){	        	
    		document.getElementById("ilmo").innerHTML= "Asiakkaan lisääminen onnistui";			      	
		}
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});
	document.getElementById("tiedot").reset();
}

function formDataJsonStr(formArray) {
	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return JSON.stringify(returnArray);
}
/* 
// Ajetaan ensimmäisenä sivun ladatessa
$(document).ready(function(){
	var url_id = requestURLParam("asiakas_id");
	$.getJSON({url:"asiakkaat/haeyksi/" + url_id, type:"GET", dataType:"json", success:function(result) {
		$("#asiakas_id").val(result.asiakas_id);
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sahkoposti").val(result.sahkoposti);
	}});
	
	$("#tiedot").validate({	
		rules: {
			etunimi: {
				required: true,
				minlength: 3,
				maxlength: 100
			},
			sukunimi: {
				required: true,
				minlength: 3,
				maxlength: 100
			},
			puhelin: {
				required: true,
				minlength: 3,
				maxlength: 25
			},
			sahkoposti: {
				required: true,
				email: true
			},
		},
		messages: {
			etunimi: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt! Merkkejä oltava 3-100",
				maxlength: "Liian pitkä! Merkkejä oltava 3-100"
			},
			sukunimi: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt! Merkkejä oltava 3-100",
				maxlength: "Liian pitkä! Merkkejä oltava 3-100"
			},
			puhelin: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt! Merkkejä oltava 3-100",
				maxlength: "Liian pitkä! Merkkejä oltava 3-100"
			},
			sahkoposti: {
				required: "Pakollinen tieto",
				email: "Oltava sähköpostiosoite"
			},
		},
		submitHandler: function(form) {
			paivitaTiedot();
		}
	}); 
	$("etunimi").focus();
});

function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

function formDataJsonStr(formArray) {
	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return JSON.stringify(returnArray);
}

function paivitaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log(formJsonStr);
	
	$.ajax({
		url:"asiakkaat", 
		data:formJsonStr, 
		type:"PUT", 
		dataType:"json", 
		success:function(result) { 
			
        if(result.response==0){
        	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui");
        }else if(result.response==1){			
        	$("#ilmo").html("Asiakkaan päivittäminen onnistui");
        	$("#etunimi, #sukunimi, #puhelin, #sahkoposti").val("");
		}
    }});	
}
*/
</script>
</body>
</html>