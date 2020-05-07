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
	<input type="button" id="uusiAsiakas" value="Uusi asiakas" class="btn btn-outline-success" style="margin-bottom: 20px;">
</form>
<table id="listaus" class="container table table-striped">
	<thead>
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sähköposti</th>
			<th></th>
		</tr>		
	</thead>
	<tbody>
		
	</tbody>
</table>
<script>
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
        	htmlStr+="<td><button class='btn btn-danger' onclick=poista(" + field.asiakas_id + ") >Poista</button></td>"; 
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
</script>
</body>
</html>