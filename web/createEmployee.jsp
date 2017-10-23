<%-- 
    Document   : createEmployee
    Created on : 11/04/2017, 06:52:15 PM
    Author     : CATASTOR
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
    <title>Gestión de empleados</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
    body,h1,h2,h3,h4,h5,h6 {font-family: "Lato", sans-serif}
    .w3-bar,h1,button {font-family: "Montserrat", sans-serif}
    .fa-anchor,.fa-coffee {font-size:200px}
    </style>
</head>
<html>
    <jsp:include page="/header.jsp">
        <jsp:param name="title" value="Crear empleado"/>
    </jsp:include>
    <br /><br /><br /><br /><br />
    <body>
        <p>
            <a href="EmpresaController?action=companyDetails&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-btn w3-red w3-xlarge">
                <i class="w3-margin-left fa fa-angle-double-left">                    
                </i>
            Volver
            </a>
        </p>
        <form method="POST" action="EmpleadoController" class="w3-container w3-card-4 w3-light-grey w3-text-red w3-margin">
            <h2 class="w3-center">Ingrese la información del empleado nuevo</h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-address-card"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="Identification" type="number" placeholder="Cédula" required>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-child"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="Name" type="text" placeholder="Nombre">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-child"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="LastName" type="text" placeholder="Apellidos">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-money"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Salary" type="number" placeholder="Salario">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-group"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" list="JobsList" id="Job" name="Job" placeholder="Cargo" onchange="enableJobFields()" required>
                    <datalist id="JobsList">
                        <option value="Desarrollador">
                        <option value="Gerente">
                        <option value="Recepcionista">
                    </datalist>
                </div>
            </div>
            <div class="w3-row w3-section" id="DivDesarrollador1" style="display:none;">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-drivers-license"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="ProfCard" type="text" placeholder="Tarjeta Profesional" display="none">
                </div>
            </div>
            <div class="w3-row w3-section" id="DivDesarrollador2" style="display:none;">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-briefcase"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Level" type="text" placeholder="Nivel" display="none">
                </div>
            </div>
            <div class="w3-row w3-section" id="DivGerente" style="display:none;">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-graduation-cap"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Title" type="text" placeholder="Título" display="none">
                </div>
            </div>
            <div class="w3-row w3-section" id="DivRecepcionista" style="display:none;">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-institution"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="ExpYears" type="number" placeholder="Años de experiencia" display="none">
                </div>
            </div>
            <input type='hidden' id='action' name='action' value='createEmployee'/>
            <input type='hidden' id='CompanyNIT' name='CompanyNIT' value="${company.getNit()}"/>
            <button class="w3-button w3-block w3-section w3-red w3-ripple w3-padding">Crear</button>
        </form>
        <script>
        function enableJobFields() {
            var x = document.getElementById('Job');
            if (x.value === 'Desarrollador'){
                document.getElementById('DivDesarrollador1').style.display = 'block';
                document.getElementById('DivDesarrollador2').style.display = 'block';
                document.getElementById('DivGerente').style.display = 'none';
                document.getElementById('DivRecepcionista').style.display = 'none';
            }else if (x.value === 'Gerente'){
                document.getElementById('DivDesarrollador1').style.display = 'none';
                document.getElementById('DivDesarrollador2').style.display = 'none';
                document.getElementById('DivGerente').style.display = 'block';
                document.getElementById('DivRecepcionista').style.display = 'none';                
            }else if (x.value === 'Recepcionista'){
                document.getElementById('DivDesarrollador1').style.display = 'none';
                document.getElementById('DivDesarrollador2').style.display = 'none';
                document.getElementById('DivGerente').style.display = 'none';
                document.getElementById('DivRecepcionista').style.display = 'block';                  
            }
        }
        </script>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
