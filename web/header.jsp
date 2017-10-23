<%-- 
    Document   : header
    Created on : 11/04/2017, 05:19:58 PM
    Author     : CATASTOR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="w3-top">
    <div class="w3-bar w3-red w3-card-2 w3-left-align w3-large">
      <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-red" href="javascript:void(0);" onclick="myFunction()" title="Toggle Navigation Menu"><i class="fa fa-bars"></i></a>
      <a href="homepage.jsp" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Home</a>
      <a href="EmpresaController?action=listCompanies" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white">Mis empresas</a>
    </div>
    <div class="w3-container w3-red">
        <h1>${param.title}</h1>
    </div>
</div>
