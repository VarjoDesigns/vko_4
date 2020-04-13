<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Listaa asiakkaat</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">


</head>
<body>
<h3 class="welcome container">Asiakas listaus</h3>
<form class="container">
	<div class="form-group">
	<label>Hakusana:</label>
	<input type="text" id="hakusana" class="form-control col-4">
	</div>
	<input type="button" id="hae" value="Hae" class="btn btn-outline-primary" style="margin-bottom: 20px;">
</form>
<table id="listaus" class="container table table-striped">
	<thead>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Sposti</th>
			<th>Puhelin</th>
		</tr>		
	</thead>
	<tbody>
		
	</tbody>
</table>
<script>

// Ajetaan ensimmäisenä sivun ladatessa
$(document).ready(function(){
	
	$.ajax({
		url:"asiakkaat", 
		type:"GET", 
		dataType:"json", 
		success:function(result) { // Palauttaa tiedot JSON-objektina "result" kohtaan
			$.each(result.asiakkaat, function(i, field){
				var htmlStr;
	        	htmlStr+="<tr>"; 
	        	htmlStr+="<td>"+field.etunimi+"</td>";
	        	htmlStr+="<td>"+field.sukunimi+"</td>";
	        	htmlStr+="<td>"+field.puhelin+"</td>";
	        	htmlStr+="<td>"+field.sposti+"</td>";       	
	        	htmlStr+="</tr>";
	        	$("#listaus tbody").append(htmlStr);
			});
		}});
	
	// Viedään kursorin fokus hakukenttään
	$("#hakusana").focus();
	
	// Jos painetaan Enter, haetaan tiedot
	$(document.body).on("keydown", function(event){
		  if(event.which==13){ 
			  haeAsiakkaat();
		  }
	});
	
	
	// Käyttäjän painaessa "hae" nappia,suoritetaan "haeAsiakkaat" funktio
	
	$("#hae").click(function(){	
		haeAsiakkaat();
	}); 
});

function haeAsiakkaat(){
	
	// Tyhjennetään tiedot jottei tule tuplana
	$("#listaus tbody").empty();
	
	$.ajax({
		url:"asiakkaat", 
		data:{
			hakusana: $("#hakusana").val()}, 
		success:function(result){	
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>"; 
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";       	
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });
    }});
};
</script>
</body>
</html>