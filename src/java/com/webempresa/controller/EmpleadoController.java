/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.webempresa.controller;

import java.util.List;
import com.webempresa.model.Desarrollador;
import com.webempresa.model.Empleado;
import com.webempresa.model.Gerente;
import com.webempresa.model.Recepcionista;
import com.webempresa.webservicesempleado.EmpleadoWebService;
import com.webempresa.webservicesempleado.EmpleadoWebService_Service;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CATASTOR
 */
@WebServlet(name = "EmpleadoController", urlPatterns = {"/EmpleadoController"})
public class EmpleadoController extends HttpServlet {

    
    private static final String createEmployee = "/createEmployee.jsp";    
    private static final String editEmployee = "/editEmployee.jsp";      
    private static final String companyDetails = "/companyDetails.jsp";   
    private static final String employeeDetails = "/employeeDetails.jsp"; 
    private final String jobDesarrollador = "Desarrollador";
    private final String jobGerente = "Gerente";
    private final String jobRecepcionista = "Recepcionista"; 
    private final EmpleadoWebService_Service service;
    private final EmpleadoWebService port; 
    
    public EmpleadoController() {
        super();
        service = new EmpleadoWebService_Service();
        port = service.getEmpleadoWebServicePort();   
    } 
    
    
    public void createEmployee(HttpServletRequest request) throws ParseException{
        
        try {     
            Empleado empleado = this.generateEmployeeByType(request);   
            empleado.setActivo(false);
            empleado.setExperiencia(50);   
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.createEmployee(empleadoWS);
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void updateEmployee(HttpServletRequest request){
        
        try {   
            Empleado empleado = this.generateEmployeeByType(request); 
            empleado.setActivo(Boolean.parseBoolean(request.getParameter("Active")));
            empleado.setExperiencia(Double.parseDouble(request.getParameter("Experience")));
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
      
    public void deleteEmployee(HttpServletRequest request){
        
        try {   
            Empleado empleado = this.findEmployee(request);    
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.deleteEmployee(empleadoWS);    
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }  
    
    
    public void deleteAllEmployees(String query){
        
        try {              
            port.deleteAllEmployees(query);  
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
    
    public Empleado findEmployee(HttpServletRequest request){
        
        Empleado empleado;
        
        try {   
            empleado = this.setEmpleado(port.findEmployee(request.getParameter("Identification"))); 
                        
            return empleado;   
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
                
        return null;
    } 
    
    public ArrayList<Empleado> listEmployees(String query){
        
        ArrayList<Empleado> listEmpleados = new ArrayList<>();
        List<com.webempresa.webservicesempleado.Empleado> listEmpleadosWS = new ArrayList<>();
        
        try {
            
            listEmpleadosWS = port.listEmployees(query);
            
            
            for (com.webempresa.webservicesempleado.Empleado empleadoWS : listEmpleadosWS) {                
                Empleado empleado = this.setEmpleado(empleadoWS);
                listEmpleados.add(empleado);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return listEmpleados;
    }
    
    public Empleado generateEmployeeByType(HttpServletRequest request) throws ParseException{
        
        Empleado empleado = null;
        try {   
            switch (request.getParameter("Job")){
                case jobDesarrollador:
                    empleado = new Desarrollador(Long.parseLong(request.getParameter("Identification")), request.getParameter("CompanyNIT"),
                                                Boolean.parseBoolean(request.getParameter("Active")), request.getParameter("Job"),
                                                request.getParameter("ProfCard"), request.getParameter("Level"));
                    break;
                case jobGerente:
                    empleado = new Gerente(Long.parseLong(request.getParameter("Identification")), request.getParameter("CompanyNIT"),
                                                Boolean.parseBoolean(request.getParameter("Active")), request.getParameter("Job"),
                                                request.getParameter("Title"));
                    break;
                case jobRecepcionista:
                    empleado = new Recepcionista(Long.parseLong(request.getParameter("Identification")), request.getParameter("CompanyNIT"),
                                                Boolean.parseBoolean(request.getParameter("Active")), request.getParameter("Job"),
                                                (request.getParameter("ExpYears")) != null ? Long.parseLong(request.getParameter("ExpYears")) : 0);
                    break;
                default:
                    empleado = null;
                    break;
            }            
            
            if (empleado != null){            
                empleado.setNombre(request.getParameter("Name"));
                empleado.setApellidos(request.getParameter("LastName"));
                empleado.setSalario(Double.parseDouble(request.getParameter("Salary")));              
            }   
            
        } catch (NumberFormatException ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
                
        return empleado;
    }
    
    public Empleado setEmpleado (com.webempresa.webservicesempleado.Empleado _empleado)
    {
        Empleado empleado = null;
        
        if (null != _empleado.getJob())switch (_empleado.getJob()) {
            case "Desarrollador":
                empleado = new Desarrollador(_empleado.getCedula(), _empleado.getCompanyNIT(), _empleado.isActivo(), _empleado.getJob(), ((com.webempresa.webservicesempleado.Desarrollador) _empleado).getTarjetaProfesional(), ((com.webempresa.webservicesempleado.Desarrollador) _empleado).getNivel());
                break;
            case "Gerente":
                empleado = new Gerente(_empleado.getCedula(), _empleado.getCompanyNIT(), _empleado.isActivo(), _empleado.getJob(), ((com.webempresa.webservicesempleado.Gerente) _empleado).getTitulo());
                break;
            case "Recepcionista":
                empleado = new Recepcionista(_empleado.getCedula(), _empleado.getCompanyNIT(), _empleado.isActivo(), _empleado.getJob(), ((com.webempresa.webservicesempleado.Recepcionista) _empleado).getAniosExperiencia());
                break;
            default:
                break;
        }        
        
        if (empleado != null){            
            empleado.setNombre(_empleado.getNombre());
            empleado.setApellidos(_empleado.getApellidos());
            empleado.setExperiencia(_empleado.getExperiencia());  
            empleado.setSalario(_empleado.getSalario());                     
        }   
        
        return empleado;
    }
    
    public com.webempresa.webservicesempleado.Empleado setEmpleadoWS (Empleado _empleado)
    {
        com.webempresa.webservicesempleado.Empleado empleado = null;
        
        if (null != _empleado.getJob())switch (_empleado.getJob()) {
            case "Desarrollador":
                empleado = new com.webempresa.webservicesempleado.Desarrollador();
                ((com.webempresa.webservicesempleado.Desarrollador) empleado).setTarjetaProfesional(((Desarrollador) _empleado).getTarjetaProfesional());
                ((com.webempresa.webservicesempleado.Desarrollador) empleado).setNivel(((Desarrollador) _empleado).getNivel());
                break;
            case "Gerente":
                empleado = new com.webempresa.webservicesempleado.Gerente();
                ((com.webempresa.webservicesempleado.Gerente) empleado).setTitulo(((Gerente) _empleado).getTitulo());
                break;
            case "Recepcionista":
                empleado = new com.webempresa.webservicesempleado.Recepcionista();
                ((com.webempresa.webservicesempleado.Recepcionista) empleado).setAniosExperiencia(((Recepcionista) _empleado).getAniosExperiencia());
                break;
            default:
                break;
        }
        
        if (empleado != null){      
            empleado.setNombre(_empleado.getNombre());
            empleado.setApellidos(_empleado.getApellidos());
            empleado.setExperiencia(_empleado.getExperiencia());  
            empleado.setSalario(_empleado.getSalario());  
            empleado.setCedula(_empleado.getCedula());
            empleado.setCompanyNIT(_empleado.getCompanyNIT());
            empleado.setActivo(_empleado.getActivo());
            empleado.setJob(_empleado.getJob());                         
        }           
        
        return empleado;
    }
    
    public String raiseSalaries(HttpServletRequest request){
        
        String outMessage = "";        
        
        try {   
            ArrayList<Empleado> listEmpleados = this.listEmployees(request.getParameter("CompanyNIT"));
            
            for (Empleado empleado : listEmpleados) {
                    empleado.setSalario(empleado.getSalario() + (empleado.getSalario() * 0.05)); 
                    com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
                    port.updateEmployee(empleadoWS);     
		}
             
            outMessage = "Salarios actualizados";
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeEnterWork(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);   
            outMessage = empleado.ingresarTrabajo();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeExitWork(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);   
            outMessage = empleado.salirTrabajo();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeDoWork(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);   
            outMessage = empleado.trabajar();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeTraining(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);   
            outMessage = empleado.capacitacion();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeDevelopmentMeeting(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);   
            outMessage = ((Desarrollador) empleado).reunionDesarrollo();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeAssignTasks(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request);
            outMessage = ((Gerente) empleado).asignarTareas();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String employeeAnswerPhone(HttpServletRequest request){
        
        String outMessage = "";
        
        try {   
            Empleado empleado = this.findEmployee(request); 
            outMessage = ((Recepcionista) empleado).contestarTelefono();
            com.webempresa.webservicesempleado.Empleado empleadoWS = this.setEmpleadoWS(empleado);            
            port.updateEmployee(empleadoWS);       
            
        } catch (Exception ex) {
            Logger.getLogger(EmpresaController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return outMessage;
    } 
    
    public String manageRequest(HttpServletRequest request) throws ParseException{
    
        EmpresaController empresaController = new EmpresaController();
        String action = request.getParameter("action");
        String forward = "";
        String outMessage = "";
                 
        if (action.equalsIgnoreCase("createEmployeeForm")){ 
            forward = createEmployee;     
            request.setAttribute("company", empresaController.findCompany(request));            
        }           
        else if (action.equalsIgnoreCase("createEmployee")){   
            this.createEmployee(request);
            forward = companyDetails;        
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employees", this.listEmployees(request.getParameter("CompanyNIT")));         
        }           
        else if (action.equalsIgnoreCase("employeeDetails")){
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request)); 
        }            
        else if (action.equalsIgnoreCase("editEmployee")){
            forward = editEmployee;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request)); 
        }                
        else if (action.equalsIgnoreCase("updateEmployee")){
            this.updateEmployee(request);
            forward = companyDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employees", this.listEmployees(request.getParameter("CompanyNIT")));  
        }       
        else if (action.equalsIgnoreCase("deleteEmployee")){
            this.deleteEmployee(request);
            forward = companyDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employees", this.listEmployees(request.getParameter("CompanyNIT")));   
        }       
        else if (action.equalsIgnoreCase("raiseSalaries")){
            outMessage = this.raiseSalaries(request);
            forward = companyDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employees", this.listEmployees(request.getParameter("CompanyNIT")));     
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeEnterWork")){
            outMessage = this.employeeEnterWork(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request)); 
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeExitWork")){
            outMessage = this.employeeExitWork(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request)); 
            request.setAttribute("outMessage", outMessage); 
        }  
        else if (action.equalsIgnoreCase("employeeDoWork")){
            outMessage = this.employeeDoWork(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request));  
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeTraining")){
            outMessage = this.employeeTraining(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request));  
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeDevelopmentMeeting")){
            outMessage = this.employeeDevelopmentMeeting(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request));  
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeAssignTasks")){
            outMessage = this.employeeAssignTasks(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request));  
            request.setAttribute("outMessage", outMessage);
        }  
        else if (action.equalsIgnoreCase("employeeAnswerPhone")){
            outMessage = this.employeeAnswerPhone(request);
            forward = employeeDetails;
            request.setAttribute("company", empresaController.findCompany(request));  
            request.setAttribute("employee", this.findEmployee(request));  
            request.setAttribute("outMessage", outMessage);
        }  
        return forward;
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EmpleadoController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EmpleadoController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        try {
            String forward;
            forward = this.manageRequest(request);
            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EmpleadoController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                
        try {
            String forward;
            forward = this.manageRequest(request);
            RequestDispatcher view = request.getRequestDispatcher(forward);
            view.forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(EmpleadoController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
