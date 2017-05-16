<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clases.Empleados" %>   
<%@ page import = "clases.Metodos" %>  
<%@ page import = "java.sql.*" %>  
<%@ page import = "java.util.*" %>  
<%@ page import = "clases.Validar" %>  


<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<link rel="stylesheet" href="css/datepicker.css" type="text/css" />

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/calendario.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script>
$(document).ready(function(){

	   var d= parseInt(document.getElementById("dias").value);

	   if(d==0){
	        $("#boton1").hide();
	        }
	    
	   var cont=0;
	    
	       $("#boton1").click(function(){
	    
	      var x=document.getElementById("fecha").value;

	      var z=document.createElement("TR");
          z.setAttribute("name","texto"+cont);
          z.setAttribute("id","texto"+cont);
            var terx = document.createTextNode(x);
              z.appendChild(terx);
          document.getElementById("p1").appendChild(z);
          
         var a = document.createElement("SELECT");
           a.setAttribute("id", "mySelect"+cont);
           a.setAttribute("name", "mySelect"+cont);
           document.getElementById("texto"+cont).appendChild(a);

	        var tipo = document.createElement("option");
	          tipo.setAttribute("value", "Seleccionar tipo");
	          var t4 = document.createTextNode("Seleccionar tipo");
	          tipo.appendChild(t4);
	          document.getElementById("mySelect"+cont).appendChild(tipo);
	        
	         var ent = document.createElement("option");
	          ent.setAttribute("value", "Jornada completa");
	          var t1 = document.createTextNode("Jornada completa");
	          ent.appendChild(t1);
	          document.getElementById("mySelect"+cont).appendChild(ent);

	        var med = document.createElement("option");
	          med.setAttribute("value", "Jornada parcial");
	          var t2 = document.createTextNode("Jornada parcial");
	          med.appendChild(t2);
	          document.getElementById("mySelect"+cont).appendChild(med);

	        var tarde = document.createElement("option");
	          tarde.setAttribute("value", "Mañana/Tarde");
	          var t3 = document.createTextNode("Mañana/Tarde");
	          tarde.appendChild(t3);
	          document.getElementById("mySelect"+cont).appendChild(tarde);
	          document.getElementById("mySelect"+cont).addEventListener('change', function() {

	              if(document.getElementById("mySelect"+cont).value=="Jornada completa"){
	               d=d-1;
	               document.getElementById("dias").value=d;
	                }
	                
	              else if(document.getElementById("mySelect"+cont).value=="Jornada parcial"){                
	                    d=d-0.5;
	                    document.getElementById("dias").value=d;
	                    }
	                
	              else if(document.getElementById("mySelect"+cont).value=="Mañana/Tarde"){
	                    d=d-0.3;
	                    document.getElementById("dias").value=d;
	                    }
	                if(d==0){
	                    $("#boton1").hide();
	                    }
	                  cont++;        
	         });  
	       });        
	  });


</script>
</head>
<body>
<h1>Ficha Usuario</h1>
<form name = "formc" action= "Controlador2" method="post">
<table>
<tbody>
<jsp:useBean id="user1" class= "clases.Empleados" scope="request"></jsp:useBean>
<tr>
<td align="right" valign="top"><b>Nombre</b></td>
<td><input type="text" readonly size="10" name="nombre" value = "<%=Metodos.consultaBD(request.getParameter("clave")).getNombre()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Apellido1</b></td>
<td><input type="text" readonly size="30" name="apellido1" value = "<%=Metodos.consultaBD(request.getParameter("clave")).getApellido1()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Apellido2</b></td>
<td><input type="text" readonly size="30" name="apellido2" value = "<%=Metodos.consultaBD(request.getParameter("clave")).getApellido2()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>DNI</b></td>
<td><input type="text" readonly size="30" name="dni" value = "<%=Metodos.consultaBD(request.getParameter("clave")).getDni()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Fecha de inicio</b></td>
<td><input type="text" readonly size="10" name="fecha_inicio" value = "<%=Metodos.consultaBD( request.getParameter("clave")).getFecha_inicio()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Departamento</b></td>
<td><input type="text" readonly size="30" name="departamento" value = "<%=Metodos.consultaBD(request.getParameter("clave")).getDepartamento()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Horario</b></td>
<td><input type="text" readonly size="30" name="horario" value = "<%=Metodos.consultaBD( request.getParameter("clave")).getHorario()%>"></td>
</tr>
<tr>
<td align="right" valign="top"><b>Jornada</b></td>
<td><input type="text" readonly size="30" name="jornada" value = "<%=Metodos.consultaBD( request.getParameter("clave")).getJornada()%>"></td>
</tr>

</tbody>
</table>

<br>
<a href = "servletVerSolicitudes?dni=<%=Metodos.consultaBD(request.getParameter("clave")).getDni()%>"> Ver días solicitados</a>

<%
ArrayList<Validar> listaSolicitadas;
listaSolicitadas = (ArrayList<Validar>)request.getAttribute("listaSolicitadas");
if(listaSolicitadas == null) {
	listaSolicitadas = new ArrayList<Validar>();
}
%>


<%if(!listaSolicitadas.isEmpty()) {
   Iterator<Validar> it2 = listaSolicitadas.iterator();
%> 
<table id="tabla">
<tr>
     <td>Fecha solicitada</td>
     <td>Tipo</td>
     <td>Comentario</td>
     <td>Estado</td>
</tr>
<% while(it2.hasNext()) {
  Validar val = new Validar();
  val = it2.next();
%>
<tr>
     <td><input type="text" name="fechas_solicitadas" readonly value = "<%=val.getFecha_solicitada()%>" ></td>
     <td><input type="text" name="tipo" readonly value = "<%=val.getTipo()%>"></td>
     <td><textarea name="comentarios" readonly rows="1" cols="30"><%=val.getComentario()%> </textarea></td>
     <td><input type="text" name="estado" readonly value = "<%=val.getEstado()%>"></td>
</tr>
<%}%>
</table>
<%}%>


<h3 id="prueba">Solicitar días de vacaciones</h3>

<%
if(Metodos.consultaBD(request.getParameter("clave")).getDias_disponibles()==0.0){
	Metodos.calculoDias();
	Metodos.agregarDias();
}

%>

<strong>Días disponibles</strong> <input type="text" readonly id="dias" name="dias" value="<%=Metodos.consultaBD(request.getParameter("clave")).getDias_disponibles()%>">

<p>
					
	<input type="date" id="fecha" name="fecha" value="2017-05-10" />
					
	<input type="button" id="boton1" value="Agregar"/>
					
</p>

<table id="p1">

</table>


<p>
 <select name="validador" id="validador" size="1">
<option value="1" Selected>Seleccionar validador</option>
<option value="Ana Martínez Sans">Ana Martínez Sans</option>
<option value="Paschal Chukwudum Ogbogu" >Paschal Chukwudum Ogbogu</option>
<option value="Francisco Núñez Rambaúd" >Francisco Núñez Rambaúd</option>
</select>
</p>


<p>Comentarios</p>
<p><textarea name="comentarios" rows="3" cols="30"></textarea>
</p>


<input type="submit" value="Solicitar">
</form>
</body>
</html>