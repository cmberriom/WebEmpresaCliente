<%-- 
    Document   : editCompany
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
        <jsp:param name="title" value="Editar empresa"/>
    </jsp:include>
    <br /><br /><br /><br /><br />
    <body>
        <p>
            <a href="EmpresaController?action=listCompanies" class="w3-btn w3-red w3-xlarge">
                <i class="w3-margin-left fa fa-angle-double-left">                    
                </i>
            Volver
            </a>
        </p>
        <form method="POST" action="EmpresaController" class="w3-container w3-card-4 w3-light-grey w3-text-red w3-margin">
            <h2 class="w3-center">Ingrese la información actualizada de la empresa</h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-address-book-o"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="NITText" type="text" placeholder="NIT" value="${company.getNit()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-institution"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Name" type="text" placeholder="Nombre" value="${company.getNombre()}">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-home"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Address" type="text" placeholder="Dirección" value="${company.getDireccion()}">
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-phone"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Phone" type="text" placeholder="Teléfono"value="${company.getTelefono()}">
                </div>
            </div>
        <input type='hidden' id='CompanyNIT' name='CompanyNIT' value="${company.getNit()}"/>
        <input type='hidden' id='action' name='action' value='updateCompany'/>
        <button class="w3-button w3-block w3-section w3-red w3-ripple w3-padding">Finalizar edición</button>
        </form>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
