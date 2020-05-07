<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Lisää asiakas</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">



</head>
<body>
<h3 class="welcome container">Asiakkaan lisääminen</h3>

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
		<input type="submit" id="tallenna" value="Lisää asiakas" class="btn btn-outline-primary">
		<a href="listaaAsiakkaat.jsp" type="button" id="peruuta" class="btn btn-outline-danger">Peruuta</a>
	</div>
</form>
 
<span id="ilmo"></span>

<script>

// Ajetaan ensimmäisenä sivun ladatessa
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
        	$("#ilmo").html("Asiakkaan lisääminen epäonnistui");
        }else if(result==1){			
        	$("#ilmo").html("Asiakkaan lisääminen onnistui");
        	$("#etunimi, #sukunimi, #puhelin, #sposti").val("");
		}
    }});	
}
</script>
</body>
</html>