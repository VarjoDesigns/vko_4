<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script> -->
<script src="scripts/main.js"></script>
<title>Lis�� asiakas</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

</head>
<body>
<h3 class="welcome container">Asiakkaan lis��minen</h3>

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
		<label for="sahkoposti">S�hk�posti:</label>
		<input type="text" id="sahkoposti" name="sahkoposti" class="form-control">
	</div>
	
	<div class="form-group">
		<input type="button" id="tallenna" name="nappi" value="Lis�� asiakas" onclick="lisaaTiedot()" class="btn btn-outline-primary">
		<a href="listaaAsiakkaat.jsp" type="button" id="peruuta" class="btn btn-outline-danger">Peruuta</a>
	</div>
</form>
 
<span id="ilmo"></span>

<script>
function enterLahettaa(event){ // Mahdollistaa Enter-n�pp�imell� hakemisen
	if(event.keyCode==13){
		haeTiedot();
	}
}

document.getElementById("etunimi").focus();

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
	
	fetch("asiakkaat",{//L�hetet��n kutsu backendiin
	      method: 'POST',
	      body:formJsonStr
	    })
	.then( function (response) {//Odotetaan vastausta ja muutetaan JSON-vastaus objektiksi		
		return response.json()
	})
	.then( function (responseJson) {//Otetaan vastaan objekti responseJson-parametriss�	
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakkaa lis��minen ep�onnistui";
    	}else if(vastaus==1){	        	
    		document.getElementById("ilmo").innerHTML= "Asiakkaa lis��minen onnistui";			      	
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

/* // Jquery versio


// Ajetaan ensimm�isen� sivun ladatessa

$(document).ready(function(){
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
				minlength: "Liian lyhyt! Merkkej� oltava 3-100",
				maxlength: "Liian pitk�! Merkkej� oltava 3-100"
			},
			sukunimi: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt! Merkkej� oltava 3-100",
				maxlength: "Liian pitk�! Merkkej� oltava 3-100"
			},
			puhelin: {
				required: "Pakollinen tieto",
				minlength: "Liian lyhyt! Merkkej� oltava 3-100",
				maxlength: "Liian pitk�! Merkkej� oltava 3-100"
			},
			sahkoposti: {
				required: "Pakollinen tieto",
				email: "Oltava s�hk�postiosoite"
			},
		},
		submitHandler: function(form) {
			lisaaTiedot();
		}
	}); 
	$("etunimi").focus();
});

function formDataJsonStr(formArray) {
	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return JSON.stringify(returnArray);
}

function lisaaTiedot(){
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	console.log(formJsonStr);
	
	$.ajax({
		url:"asiakkaat", 
		data:formJsonStr, 
		type:"POST", 
		dataType:"json", 
		success:function(result) { 
			
        if(result.response==0){
        	$("#ilmo").html("Asiakkaan lis��minen ep�onnistui");
        }else if(result.response==1){			
        	$("#etunimi, #sukunimi, #puhelin, #sposti").val("");
        	$("#ilmo").html("Asiakkaan lis��minen onnistui");
		}
    }});	
} */
</script>
</body>
</html>