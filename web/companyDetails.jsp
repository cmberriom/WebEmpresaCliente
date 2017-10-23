<%-- 
    Document   : companyDetails
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
    <style>
    .center {
        margin: auto;
        width: 80%;
    }
    </style>
</head>
<html>
    <body>
        <jsp:include page="/header.jsp">
            <jsp:param name="title" value="Detalles de la empresa"/>
        </jsp:include>
        <br /><br /><br /><br /><br />
        <p>
            <a href="EmpresaController?action=listCompanies" class="w3-btn w3-red w3-xlarge">
                <i class="w3-margin-left fa fa-angle-double-left">                    
                </i>
            Volver
            </a>
        </p>
        <button onclick="toggleTab('Form1')" class="w3-button w3-block w3-red w3-left-align">Información de la empresa
            <i class="w3-margin-left fa fa-angle-down"></i>
        </button>
        <form class="w3-container w3-card-4 w3-light-grey w3-text-red w3-margin w3-tiny" id="Form1">
            <h2 class="w3-center">Información de la empresa</h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-address-book-o"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="CompanyNIT" type="text" placeholder="NIT" value="${company.getNit()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-institution"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="CompanyName" type="text" placeholder="Nombre" value="${company.getNombre()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-home"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="CompanyAddress" type="text" placeholder="Dirección" value="${company.getDireccion()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-phone"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="CompanyPhone" type="text" placeholder="Teléfono"value="${company.getTelefono()}" disabled>
                </div>
            </div>
        </form>
        <button onclick="toggleTab('Form2')" class="w3-button w3-block w3-red w3-left-align">Lista de empleados
            <i class="w3-margin-left fa fa-angle-down"></i>
        </button>
        <form class="w3-container w3-light-grey w3-text-red w3-margin" id="Form2">
            <h2 class="w3-center">Lista de empleados</h2>    
            <c:if test="${outMessage != ''}">
                <p class="w3-center">${outMessage}</p>
            </c:if>            
            <br />  
            <div class="w3-row w3-left-align center">
                <div class="w3-col">
                    <a href="EmpleadoController?action=createEmployeeForm&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Crear empleado</a>
                    <a href="EmpleadoController?action=raiseSalaries&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-black w3-padding-large w3-large w3-margin-top w3-left-align">Aumentar salarios</a>
                </div>
            </div>              
            <br />  
            <div class="w3-row w3-center center">
                <div class="w3-col s6 w3-red w3-center l8"><p>Empleado</p></div>
                <div class="w3-col s6 w3-red w3-center l2"><p>Acciones</p></div>
            </div>            
            <c:forEach items="${employees}" var="employee">
                <div class="w3-row w3-center center">
                    <div class="w3-col s6 w3-white w3-center l8"><p>${employee.getCedula()} ${employee.getNombre()} ${employee.getApellidos()}</p></div>
                    <div class="w3-col s6 w3-white w3-center l2">
                        <div class="w3-col">
                            <a href="EmpleadoController?action=employeeDetails&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>"  class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-search">
                                </i>
                            </a>
                            <a href="EmpleadoController?action=editEmployee&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-refresh">
                                </i>
                            </a>
                            <a href="#" onclick="document.getElementById('confirmDelete${employee.getCedula()}').style.display='block'" class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-trash">
                                </i>
                            </a>
                        </div>
                    </div>
                </div>            
                <div id="confirmDelete${employee.getCedula()}" class="w3-modal w3-center">
                    <div class="w3-modal-content w3-animate-opacity w3-card-4">
                      <header class="w3-container w3-red"> 
                        <span onclick="document.getElementById('confirmDelete${employee.getCedula()}').style.display='none'" 
                        class="w3-button w3-display-topright">&times;</span>
                        <h2>¿Desea eliminar el empleado seleccionado?</h2>
                      </header>
                      <div class="w3-container">
                        <a href="EmpleadoController?action=deleteEmployee&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-center">Aceptar</a>
                        <a href="#" onclick="document.getElementById('confirmDelete${employee.getCedula()}').style.display='none'" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-center">Cancelar</a>
                      </div>
                    </div>
                </div>
            </c:forEach>
        </form>
        <jsp:include page="/footer.jsp" />
        <script>
        function toggleTab(id) {
            var x = document.getElementById(id);
            if (x.style.display === 'none') {
                x.style.display = 'block';
            } else {
                x.style.display = 'none';
            }
        }
        </script>
    </body>    
</html>
