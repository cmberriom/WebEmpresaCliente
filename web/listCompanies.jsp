<%-- 
    Document   : listCompanies
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
            <jsp:param name="title" value="Lista de empresas"/>
        </jsp:include>
        <br /><br /><br /><br /><br />
        <form class="w3-container w3-light-grey w3-text-red w3-margin">
            <h2 class="w3-center">Empresas registradas</h2>                
            <br />  
            <div class="w3-row w3-left-align center">
                <div class="w3-col">
                    <a href="createCompany.jsp" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Crear empresa</a>
                </div>
            </div>              
            <br />  
            <div class="w3-row w3-center center">
                <div class="w3-col s6 w3-red w3-center l8"><p>Empresa</p></div>
                <div class="w3-col s6 w3-red w3-center l2"><p>Acciones</p></div>
            </div>            
            <c:forEach items="${companies}" var="company">
                <div class="w3-row w3-center center">
                    <div class="w3-col s6 w3-white w3-center l8"><p>${company.getNit()} ${company.getNombre()}</p></div>
                    <div class="w3-col s6 w3-white w3-center l2">
                        <div class="w3-col">
                            <a href="EmpresaController?action=companyDetails&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-search">
                                </i>
                            </a>
                            <a href="EmpresaController?action=editCompany&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-refresh">
                                </i>
                            </a>
                            <a href="#" onclick="document.getElementById('confirmDelete${company.getNit()}').style.display='block'" class="w3-button w3-red w3-medium w3-margin-top"> 
                                <i class="fa fa-trash">
                                </i>
                            </a>
                        </div>
                    </div>
                </div>            
                <div id="confirmDelete${company.getNit()}" class="w3-modal w3-center">
                    <div class="w3-modal-content w3-animate-opacity w3-card-4">
                      <header class="w3-container w3-red"> 
                        <span onclick="document.getElementById('confirmDelete${company.getNit()}').style.display='none'" 
                        class="w3-button w3-display-topright">&times;</span>
                        <h2>¿Desea eliminar la empresa seleccionada?</h2>
                      </header>
                      <div class="w3-container">
                        <a href="EmpresaController?action=deleteCompany&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-center">Aceptar</a>
                        <a href="#" onclick="document.getElementById('confirmDelete${company.getNit()}').style.display='none'" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-center">Cancelar</a>
                      </div>
                    </div>
                </div>
            </c:forEach>
        </form>
        <jsp:include page="/footer.jsp" />
    </body>    
</html>
