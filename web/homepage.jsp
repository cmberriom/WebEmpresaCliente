<%-- 
    Document   : homepage
    Created on : 11/04/2017, 05:19:58 PM
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
</head>
<html>
    <!-- Header -->
    <header class="w3-container w3-red w3-center" style="padding:128px 16px">
      <h1 class="w3-margin w3-jumbo">GESTIÓN DE EMPLEADOS</h1>
      <p class="w3-xlarge">La máxima experiencia en gestión de empresas</p>
      <a href="EmpresaController?action=listCompanies" class="w3-button w3-black w3-padding-large w3-large w3-margin-top">Continuar</a>
    </header>
    <jsp:include page="/footer.jsp" />
</html>
