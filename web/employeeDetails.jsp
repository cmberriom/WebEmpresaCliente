<%-- 
    Document   : employeeDetails
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
    .switch {
    position: relative;
    display: inline-block;
    width: 60px;
    height: 34px;
    }

    .switch input {display:none;}

    .slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    -webkit-transition: .4s;
    transition: .4s;
    }

    .slider:before {
    position: absolute;
    content: "";
    height: 26px;
    width: 26px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    -webkit-transition: .4s;
    transition: .4s;
    }

    input:checked + .slider {
    background-color: #f44336;
    }

    input:focus + .slider {
    box-shadow: 0 0 1px #2196F3;
    }

    input:checked + .slider:before {
    -webkit-transform: translateX(26px);
    -ms-transform: translateX(26px);
    transform: translateX(26px);
    }

    /* Rounded sliders */
    .slider.round {
    border-radius: 34px;
    }

    .slider.round:before {
    border-radius: 50%;
    }
    
    </style>
</head>
<html>
    <jsp:include page="/header.jsp">
        <jsp:param name="title" value="Información de empleado"/>
    </jsp:include>
    <br /><br /><br /><br /><br />
    <body onload="move()">
        <p>
            <a href="EmpresaController?action=companyDetails&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-btn w3-red w3-xlarge">
                <i class="w3-margin-left fa fa-angle-double-left">                    
                </i>
            Volver
            </a>
        </p>
        <form method="POST" action="EmpleadoController" class="w3-container w3-card-4 w3-light-grey w3-text-red w3-margin">
            <h2 class="w3-center">Detalles del empleado</h2>
            <c:if test="${outMessage != ''}">
                <p class="w3-center">${outMessage}</p>
            </c:if>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-address-card"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="IdentificationText" type="number" placeholder="Cédula" value="${employee.getCedula()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-child"></i></div>
                <div class="w3-rest">
                  <input class="w3-input w3-border" name="Name" type="text" placeholder="Nombre" value="${employee.getNombre()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-child"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="LastName" type="text" placeholder="Apellidos" value="${employee.getApellidos()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-money"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" name="Salary" type="number" placeholder="Salario" value="${employee.getSalario()}" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col w3-tiny" style="width:50px">Activo(a)</div>
                <c:if test="${employee.getActivo() == 'true'}">
                    <div class="w3-rest">
                        <label class="switch">
                            <input type="checkbox" checked disabled>
                            <div class="slider round"></div>
                        </label>
                    </div>
                </c:if>
                <c:if test="${employee.getActivo() == 'false'}">
                    <div class="w3-rest">
                        <label class="switch">
                            <input type="checkbox" disabled>
                            <div class="slider round"></div>
                        </label>
                    </div>
                </c:if>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-arrow-circle-up"></i></div>
                <div class="w3-light-grey w3-right w3-xlarge w3-round-xlarge" style="width:96.5%">
                    <div id="ExperienceBar" class="w3-container w3-red w3-center w3-round-xlarge" style="width:10%">${employee.getExperiencia()}</div>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-group"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" list="JobsList" name="JobText" placeholder="Cargo" onchange="enableJobFields()" value="${employee.getJob()}" disabled>
                    <datalist id="JobsList">
                        <option value="Desarrollador">
                        <option value="Gerente">
                        <option value="Recepcionista">
                    </datalist>
                </div>
            </div>
            <c:if test="${employee.getJob() == 'Desarrollador'}">
                <div class="w3-row w3-section" id="DivDesarrollador1">
                    <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-drivers-license"></i></div>
                    <div class="w3-rest">
                        <input class="w3-input w3-border" name="ProfCard" type="text" placeholder="Tarjeta Profesional" display="none" value="${employee.getTarjetaProfesional()}" disabled>
                    </div>
                </div>
                <div class="w3-row w3-section" id="DivDesarrollador2">
                    <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-briefcase"></i></div>
                    <div class="w3-rest">
                        <input class="w3-input w3-border" name="Level" type="text" placeholder="Nivel" display="none" value="${employee.getNivel()}" disabled>
                    </div>
                </div>
            </c:if>
            <c:if test="${employee.getJob() == 'Gerente'}">
                <div class="w3-row w3-section" id="DivGerente">
                    <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-graduation-cap"></i></div>
                    <div class="w3-rest">
                        <input class="w3-input w3-border" name="Title" type="text" placeholder="Título" display="none" value="${employee.getTitulo()}" disabled>
                    </div>
                </div>
            </c:if>
            <c:if test="${employee.getJob() == 'Recepcionista'}">
                <div class="w3-row w3-section" id="DivRecepcionista">
                    <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-institution"></i></div>
                    <div class="w3-rest">
                        <input class="w3-input w3-border" name="ExpYears" type="number" placeholder="Años de experiencia" display="none" value="${employee.getAniosExperiencia()}" disabled>
                    </div>
                </div>
            </c:if>
            <input type='hidden' id='action' name='action' value='updateEmployee'/>
            <input type='hidden' id='Identification' name='Identification' value="${employee.getCedula()}"/>
            <input type='hidden' id='Experience' name='Experience' value="${employee.getExperiencia()}"/>
            <input type='hidden' id='CompanyNIT' name='CompanyNIT' value="${company.getNit()}"/>
            <div class="w3-row w3-left-align center">
                <div class="w3-col w3-center">
                    <a href="EmpleadoController?action=employeeEnterWork&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Entrar a trabajar</a>
                    <a href="EmpleadoController?action=employeeDoWork&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Trabajar</a>
                    <a href="EmpleadoController?action=employeeTraining&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Capacitarse</a>
                    <a href="EmpleadoController?action=employeeExitWork&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-red w3-padding-large w3-large w3-margin-top w3-left-align">Salir del trabajo</a>
                    <c:if test="${employee.getJob() == 'Desarrollador'}">
                        <a href="EmpleadoController?action=employeeDevelopmentMeeting&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-black w3-padding-large w3-large w3-margin-top w3-left-align">Reunión de desarrollo</a>
                    </c:if>
                    <c:if test="${employee.getJob() == 'Gerente'}">
                        <a href="EmpleadoController?action=employeeAssignTasks&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-black w3-padding-large w3-large w3-margin-top w3-left-align">Asignar tareas</a>
                    </c:if>
                    <c:if test="${employee.getJob() == 'Recepcionista'}">
                        <a href="EmpleadoController?action=employeeAnswerPhone&Identification=<c:out value="${employee.getCedula()}"/>&CompanyNIT=<c:out value="${company.getNit()}"/>" class="w3-button w3-black w3-padding-large w3-large w3-margin-top w3-left-align">Contestar teléfono</a>
                    </c:if>
                </div>
            </div>   
        </form>
    </body>
    <script>
function move() {
    var elem = document.getElementById("ExperienceBar");  
    var widthmax = document.getElementById("Experience").value;
    var width = 20;
    var id = setInterval(frame, 1);
    
    function frame() {
        if (width >= widthmax) {
            clearInterval(id);
        } else {
            width+= 0.1; 
            var n = width.toFixed(2);
            elem.style.width = width + '%'; 
            elem.innerHTML = 'Experiencia: ' + n  + '%';
        }
    }
}
</script>
    <jsp:include page="/footer.jsp" />
</html>
